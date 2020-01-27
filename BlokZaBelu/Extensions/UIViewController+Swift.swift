//
//  UIViewController+Swift.swift
//  BlokZaBelu
//
//  Created by dominik on 26/01/2020.
//  Copyright © 2020 Dominik Cubelic. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentCard(viewController: UIViewController, cardPresentationControllerDelegate: CardPresentationControllerDelegate) {
        let presentationController = CardPresentationController(presentedViewController: viewController, presenting: self)
        presentationController.presentationDelegate = cardPresentationControllerDelegate
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = presentationController
        
        present(viewController, animated: true, completion: nil)
    }
    
}
