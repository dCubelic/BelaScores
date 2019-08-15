//
//  AppDelegate.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 15/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol DimmingViewDelegate: AnyObject {
    func dimmingViewDidReceiveTap(_ dimmingView: DimmingView)
}

class DimmingView: UIView {

    weak var delegate: DimmingViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        alpha = 0.0
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(tapGesture:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTapGesture(tapGesture: UITapGestureRecognizer) {
        delegate?.dimmingViewDidReceiveTap(self)
    }
    
}
