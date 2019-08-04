//
//  ViewController.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 03/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit
import CoreMedia

class ViewController: UIViewController {
    
    @IBOutlet weak var videoPreview: UIView!
    @IBOutlet weak var cardInfoView: CardInfoView!
    
    var resPixBuf: CVPixelBuffer?
    var currentTrumpSuit: BelaSuit?
    
    let ciContext = CIContext()
    let videoCapture = VideoCapture()
    let semaphore = DispatchSemaphore(value: 2)
    let model = Bela()
    var cardSet: Set<BelaCard> = Set()
    var resilienceArray = ResilienceArray(size: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CVPixelBufferCreate(nil, Bela.width, Bela.height,
                            kCVPixelFormatType_32BGRA, nil,
                            &resPixBuf)
        
        setupCamera()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        resizePreviewLayer()
    }
    
    func predict(pixelBuffer: CVPixelBuffer) {
//        let startTime = CACurrentMediaTime()

        guard let resizedPixelBuffer = resPixBuf else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let sx = CGFloat(Bela.width) / CGFloat(CVPixelBufferGetWidth(pixelBuffer))
        let sy = CGFloat(Bela.height) / CGFloat(CVPixelBufferGetHeight(pixelBuffer))
        let scaleTransform = CGAffineTransform(scaleX: sx, y: sy)
        let scaledImage = ciImage.transformed(by: scaleTransform)
        ciContext.render(scaledImage, to: resizedPixelBuffer)
        
        let predictions = model.predict(image: resizedPixelBuffer)

        resilienceArray.add(item: predictions)

        for prediction in predictions {
            if resilienceArray.numberOfOccurences(card: prediction.card) >= 5 { // ako je dobro prepoznata
                DispatchQueue.main.async {
                    self.cardInfoView.setup(for: prediction.card)
                }
                let (inserted, _) = cardSet.insert(prediction.card)
                if inserted { // ako je prvi put videna
                    print(prediction.card, prediction.confidence)
                    print(calculateScore(cards: cardSet, trumpSuit: .clubs))
                }
            }
        }
        
        semaphore.signal()
    }
    
    func calculateScore(cards: Set<BelaCard>, trumpSuit: BelaSuit) -> Int {
        var score = 0
        for card in cards {
            score += card.points(trumpSuit: trumpSuit)
        }
        return score
    }

    func setupCamera() {
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
    
    func resizePreviewLayer() {
        videoCapture.previewLayer?.frame = videoPreview.bounds
    }

}

extension ViewController: VideoCaptureDelegate {
    func videoCapture(_ capture: VideoCapture, didCaptureVideoFrame pixelBuffer: CVPixelBuffer?, timestamp: CMTime) {
        guard let pixelBuffer = pixelBuffer else { return }
        
        semaphore.wait()
        
        DispatchQueue.global().async {
            self.predict(pixelBuffer: pixelBuffer)
        }
    }
}

