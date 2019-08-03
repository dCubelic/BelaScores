//
//  CardInfoView.swift
//  BelaDetector
//
//  Created by Dominik Cubelic on 03/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class CardInfoView: UIView {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var suitImageView: UIImageView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        _ = loadViewFromNib()
        
    }
    
    func setup(for card: BelaCard) {
        valueLabel.text = card.value.string
        suitImageView.image = UIImage(named: card.suit.imageName)
    }
}

extension UIView {
    
    func loadViewFromNib() -> UIView? {
        backgroundColor = .clear
        
        let type = Swift.type(of: self)
        let bundle = Bundle(for: type)
        if let view = bundle.loadNibNamed(String(describing: type), owner: self, options: nil)?.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            addSubview(view)
            
            return view
        }
        
        return nil
    }
    
}
