//
//  TransitioningDelegate.swift
//  MCFeed
//
//  Created by Matias Roldan on 30/7/17.
//  Copyright © 2017 Matias Roldan. All rights reserved.
//  roldanmatias@gmail.com

import UIKit

class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var openingFrame: CGRect?
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let presentationAnimator = PresentationAnimator()
        presentationAnimator.openingFrame = openingFrame!
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let dismissAnimator = DismissalAnimator()
        dismissAnimator.openingFrame = openingFrame!
        return dismissAnimator
    }
}
