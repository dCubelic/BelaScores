//
//  ViewController.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 03/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit
import CoreMedia

public class BelaDetectorViewController: UIViewController {
    
    @IBOutlet private weak var videoPreview: UIView!
    @IBOutlet private weak var detectedCardsView: DetectedCardsView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var plusTenButton: UIButton!
    
    private var resizedPixelBufffer: CVPixelBuffer?
    private let ciContext = CIContext()
    private let videoCapture = VideoCapture()
    private let semaphore = DispatchSemaphore(value: 2)
    private let detectorModel = BelaModel()
    private var cardSet: Set<BelaCard> = Set()
    private var resilienceArray = ResilienceArray<BelaCard>(size: 10)
    private var trumpSuitPicker: TrumpSuitPickerViewController?
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public static func instantiateFromStoryboard() -> BelaDetectorViewController {
        return UIStoryboard(name: "Main", bundle: Bundle.frameworkBundle).instantiateInitialViewController() as! BelaDetectorViewController
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
        resetButton.layer.cornerRadius = resetButton.frame.height / 2
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
        plusTenButton.layer.cornerRadius = plusTenButton.frame.height / 2
        
        setupCamera()
        
        detectedCardsView.delegate = self
        detectedCardsView.set(trumpSuit: .spades)
        
        showTrumpSuitPicker()
    }
    
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        resizePreviewLayer()
    }
    
    private func setupCamera() {
        CVPixelBufferCreate(nil, BelaModel.width, BelaModel.height, kCVPixelFormatType_32BGRA, nil, &resizedPixelBufffer)
        
        videoCapture.delegate = self
        videoCapture.fps = 50
        videoCapture.setup(sessionPreset: .hd1280x720) { (success) in
            if success {
                if let previewLayer = self.videoCapture.previewLayer {
                    self.videoPreview.layer.addSublayer(previewLayer)
                    self.resizePreviewLayer()
                }
                
                self.videoCapture.start()
            }
        }
    }
    
    private func resizePreviewLayer() {
        videoCapture.previewLayer?.frame = videoPreview.bounds
    }
    
    private func predict(pixelBuffer: CVPixelBuffer) {
        guard let resizedPixelBuffer = resizedPixelBufffer else { return }
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let sx = CGFloat(BelaModel.width) / CGFloat(CVPixelBufferGetWidth(pixelBuffer))
        let sy = CGFloat(BelaModel.height) / CGFloat(CVPixelBufferGetHeight(pixelBuffer))
        let scaleTransform = CGAffineTransform(scaleX: sx, y: sy)
        let scaledImage = ciImage.transformed(by: scaleTransform)
        
        ciContext.render(scaledImage, to: resizedPixelBuffer)
        
        let predictions = detectorModel.predict(image: resizedPixelBuffer)

        resilienceArray.add(items: predictions.map { $0.card })

        for prediction in predictions {
            if resilienceArray.numberOfOccurences(item: prediction.card) >= 5   { // ako je dobro prepoznata
                let (inserted, _) = cardSet.insert(prediction.card)
                if inserted { // ako je prvi put videna
                    detectedCardsView.add(card: prediction.card)
                }
            }
        }
        
        semaphore.signal()
    }
    
    private func calculateScore(cards: Set<BelaCard>, trumpSuit: BelaSuit) -> Int {
        var score = 0
        for card in cards {
            score += card.points(trumpSuit: trumpSuit)
        }
        return score
    }

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetAction(_ sender: Any) {
        cardSet.removeAll(keepingCapacity: true)
        plusTenButton.setTitle("+10", for: .normal)
        detectedCardsView.reset()
        showTrumpSuitPicker()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        
    }
    
    @IBAction func plusTenAction(_ sender: Any) {
        detectedCardsView.plusTen.toggle()
        plusTenButton.setTitle(detectedCardsView.plusTen ? "-10" : "+10", for: .normal)
    }
    
}

extension BelaDetectorViewController: VideoCaptureDelegate {
    func videoCapture(_ capture: VideoCapture, didCaptureVideoFrame pixelBuffer: CVPixelBuffer?, timestamp: CMTime) {
        guard let pixelBuffer = pixelBuffer else { return }
        
        semaphore.wait()
        
        DispatchQueue.global().async {
            self.predict(pixelBuffer: pixelBuffer)
        }
    }
}

extension BelaDetectorViewController: DetectedCardsViewDelegate {
    private func removeTrumpSuitPicker() {
        trumpSuitPicker?.view.removeFromSuperview()
        trumpSuitPicker?.removeFromParent()
        trumpSuitPicker?.didMove(toParent: nil)
        
        trumpSuitPicker = nil
    }
    
    private func showTrumpSuitPicker() {
        guard trumpSuitPicker == nil else { return }
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.frameworkBundle).instantiateViewController(withIdentifier: "TrumpSuitPickerViewController") as! TrumpSuitPickerViewController
        vc.delegate = self
        trumpSuitPicker = vc
        
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
    func detectedCardsViewDidRequestTrumpSuitChange(_ detectedCardsView: DetectedCardsView) {
        if trumpSuitPicker != nil {
            removeTrumpSuitPicker()
            return
        }
        
        showTrumpSuitPicker()
    }
    
    func detectedCardsViewDidRemoveCard(_ card: BelaCard) {
        cardSet.remove(card)
    }
}

extension BelaDetectorViewController: TrumpSuitPickerViewControllerDelegate {
    func trumpSuitPickerViewControllerDidChoose(trumpSuitPickerViewController: TrumpSuitPickerViewController, trumpSuit: BelaSuit) {
        detectedCardsView.set(trumpSuit: trumpSuit)

        removeTrumpSuitPicker()
    }
}
