//
//  Bela.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 03/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit
import CoreML

class Bela {
    static let width = 608
    static let height = 608
    
    private let confidenceThreshold: Float = 0.8
    
    private let model = BelaDetector()
    
    func predict(image: CVPixelBuffer) -> [BelaPrediction] {
        guard let prediction = try? model.prediction(input_1: image) else { return [] }
        
        return computeBoundigBoxes(features: [prediction.conv2d_13, prediction.conv2d_10])
    }
    
    private func computeBoundigBoxes(features: [MLMultiArray]) -> [BelaPrediction] {
        var predictions: [BelaPrediction] = []
        
        let blockSize: Float = 32
        let boxesPerCell = 3
        let numClasses = 32
        
        var gridHeight = [19, 38, 76]
        var gridWidth = [19, 38, 76]
        
        var featurePointer = UnsafeMutablePointer<Double>(OpaquePointer(features[0].dataPointer))
        var channelStride = features[0].strides[0].intValue
        var yStride = features[0].strides[1].intValue
        var xStride = features[0].strides[2].intValue
        
        func offset(_ channel: Int, _ x: Int, _ y: Int) -> Int {
            return channel*channelStride + y*yStride + x*xStride
        }
        
        for i in 0..<2 {
            featurePointer = UnsafeMutablePointer<Double>(OpaquePointer(features[i].dataPointer))
            channelStride = features[i].strides[0].intValue
            yStride = features[i].strides[1].intValue
            xStride = features[i].strides[2].intValue
            for cy in 0..<gridHeight[i] {
                for cx in 0..<gridWidth[i] {
                    for b in 0..<boxesPerCell {
                        let channel = b * (numClasses + 5)
                        
//                        let tx = Float(featurePointer[offset(channel, cx, cy)])
//                        let ty = Float(featurePointer[offset(channel + 1, cx, cy)])
//                        let tw = Float(featurePointer[offset(channel + 2, cx, cy)])
//                        let th = Float(featurePointer[offset(channel + 3, cx, cy)])
                        let tc = Float(featurePointer[offset(channel + 4, cx, cy)])
                        
//                        let scale = powf(2.0, Float(i))
//                        let x = (Float(cx) * blockSize + sigmoid(tx))/scale
//                        let y = (Float(cy) * blockSize + sigmoid(ty))/scale
//
//                        let w = exp(tw) * anchors[i][2*b]
//                        let h = exp(th) * anchors[i][2*b + 1]
                        
                        let confidence = sigmoid(tc)
                        
                        var classes = [Float](repeating: 0, count: numClasses)
                        for c in 0..<numClasses {
                            classes[c] = Float(featurePointer[offset(channel + 5 + c, cx, cy)])
                        }
                        classes = softmax(classes)
                        
                        let (detectedClass, bestClassScore) = classes.argmax()
                        
                        let confidenceInClass = bestClassScore * confidence
                        
                        if confidenceInClass > confidenceThreshold {
//                            let rect = CGRect(x: CGFloat(x - w/2), y: CGFloat(y - h/2), width: CGFloat(w), height: CGFloat(h))
                            
                            let prediction = BelaPrediction(classIndex: detectedClass, confidence: confidenceInClass)
                            predictions.append(prediction)
                        }
                    }
                }
            }
        }
        
        return predictions
    }
}
