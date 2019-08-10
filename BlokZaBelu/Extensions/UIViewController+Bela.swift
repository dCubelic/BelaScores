//
//  UIViewController+Bela.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 10/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addCardViewController<T: CardViewController>(ofType type: T.Type) {
        let cardViewController = T()
        
        addChild(cardViewController)
        view.addSubview(cardViewController.view)
        
        cardViewController.view.translatesAutoresizingMaskIntoConstraints = false
        cardViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        cardViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        cardViewController.view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        cardViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        cardViewController.didMove(toParent: self)
    }
}
