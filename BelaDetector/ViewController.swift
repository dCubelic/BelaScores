//
//  ViewController.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 03/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var resPixBuf: CVPixelBuffer?
    var currentTrumpSuit: BelaSuit?
    
    var testSet: Set<Int> = Set() {
        didSet {
            print(testSet.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let model = Bela()
        
        let image = UIImage(named: "bela")!
        let pixelBuffer = buffer(from: image)!
        
        let startTime = CACurrentMediaTime()
        
        CVPixelBufferCreate(nil, Bela.width, Bela.height,
                            kCVPixelFormatType_32BGRA, nil,
                            &resPixBuf)
        
        guard let resizedPixelBuffer = resPixBuf else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let sx = CGFloat(Bela.width) / CGFloat(CVPixelBufferGetWidth(pixelBuffer))
        let sy = CGFloat(Bela.height) / CGFloat(CVPixelBufferGetHeight(pixelBuffer))
        let scaleTransform = CGAffineTransform(scaleX: sx, y: sy)
        let scaledImage = ciImage.transformed(by: scaleTransform)
        CIContext().render(scaledImage, to: resizedPixelBuffer)
        
        let predictions = model.predict(image: resizedPixelBuffer)
        var cardSet: Set<BelaCard> = Set()
        
        for prediction in predictions {
            print(prediction.card, prediction.card.points(trumpSuit: .hearts), prediction.confidence)
            cardSet.insert(prediction.card)
        }
        
        testSet.insert(2)
        testSet.insert(5)
        testSet.insert(6)
        testSet.insert(2)
        
        for card in cardSet {
            
        }
        
        let elapsed = CACurrentMediaTime() - startTime
        print(elapsed)
    }


}

