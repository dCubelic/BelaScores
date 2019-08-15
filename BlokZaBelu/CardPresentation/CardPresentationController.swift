//
//  AppDelegate.swift
//  BlokZaBelu
//
//  Created by Dominik Cubelic on 15/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import UIKit

protocol CardPresentationControllerDelegate: class {
    func cardPresentationControllerDidReceiveTapOnDimmingView(_ cardPresentationController: CardPresentationController, dimmingView: DimmingView)
}

class CardPresentationController: UIPresentationController {
    
    private var dimmingView: DimmingView?
    
    weak var presentationDelegate: CardPresentationControllerDelegate?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard var bounds = containerView?.bounds else { return CGRect.zero }

        bounds.origin = CGPoint(x: 0, y: bounds.height - 400)
        bounds.size.height = 400
        
        return bounds
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }

        let dimmingView = DimmingView(frame: containerView.bounds)
        dimmingView.delegate = self
        
        containerView.insertSubview(dimmingView, at: 0)
        
        if let transitionCoordinator = presentedViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { _ in
                dimmingView.alpha = 1
            }, completion: nil)
        } else {
            dimmingView.alpha = 1
        }
        
        self.dimmingView = dimmingView
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView?.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentedViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: { _ in
                self.dimmingView?.alpha = 0
            }, completion: nil)
        } else {
            self.dimmingView?.alpha = 0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView?.removeFromSuperview()
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedViewController.view.frame = frameOfPresentedViewInContainerView
    }
    
}

extension CardPresentationController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
}

extension CardPresentationController: DimmingViewDelegate {
    
    func dimmingViewDidReceiveTap(_ dimmingView: DimmingView) {
        presentationDelegate?.cardPresentationControllerDidReceiveTapOnDimmingView(self, dimmingView: dimmingView)
    }
    
}
