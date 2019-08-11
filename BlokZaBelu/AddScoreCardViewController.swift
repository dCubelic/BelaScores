//
//  AddScoreViewController.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

class AddScoreCardViewController: CardViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    init() {
        super.init(nibName: nil, bundle: nil)
        
        let vc = UIStoryboard.main.instantiateViewController(ofType: AddScoreViewController.self)
        addChild(vc)
        contentView = vc.view
        vc.didMove(toParent: self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
