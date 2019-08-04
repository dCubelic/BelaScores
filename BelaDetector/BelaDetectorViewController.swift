//
//  ViewController.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 03/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit
import CoreMedia

class BelaDetectorViewController: UIViewController {
    
    @IBOutlet private weak var videoPreview: UIView!
    @IBOutlet private weak var detectedCardsView: DetectedCardsView!
    
    private var resizedPixelBufffer: CVPixelBuffer?
    private let ciContext = CIContext()
    private let videoCapture = VideoCapture()
    private let semaphore = DispatchSemaphore(value: 2)
    private let detectorModel = Bela()
    private var cardSet: Set<BelaCard> = Set()
    private var resilienceArray = ResilienceArray<BelaCard>(size: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
        detectedCardsView.set(trumpSuit: .spades)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        resizePreviewLayer()
    }
    
    private func setupCamera() {
        CVPixelBufferCreate(nil, Bela.width, Bela.height, kCVPixelFormatType_32BGRA, nil, &resizedPixelBufffer)
        
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
        let sx = CGFloat(Bela.width) / CGFloat(CVPixelBufferGetWidth(pixelBuffer))
        let sy = CGFloat(Bela.height) / CGFloat(CVPixelBufferGetHeight(pixelBuffer))
        let scaleTransform = CGAffineTransform(scaleX: sx, y: sy)
        let scaledImage = ciImage.transformed(by: scaleTransform)
        
        ciContext.render(scaledImage, to: resizedPixelBuffer)
        
        let predictions = detectorModel.predict(image: resizedPixelBuffer)

        resilienceArray.add(items: predictions.map { $0.card })

        for prediction in predictions {
            if resilienceArray.numberOfOccurences(item: prediction.card) >= 5 { // ako je dobro prepoznata
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

