//
//  TransitionManager.swift
//  Tracks
//
//  Created by Mikhail Chukhvantsev on 03.08.2020.
//  Copyright © 2020 Mikhail Chukhvantsev. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var popStyle: Bool = false
    var presenting: Bool = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if popStyle {
            animatePop(using: transitionContext)
            return
        }
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!

        let finalFrame = transitionContext.finalFrame(for: toViewController)

        let frameOffset = finalFrame.offsetBy(dx: finalFrame.width, dy: 0)
        toViewController.view.frame = frameOffset

        transitionContext.containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromViewController.view.frame = finalFrame.offsetBy(dx: -finalFrame.width, dy: 0)
                toViewController.view.frame = finalFrame
        }, completion: {_ in
                transitionContext.completeTransition(true)
        })
    }
    
    func animatePop(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let finalFrame = transitionContext.initialFrame(for: fromViewController)
        
        let fOffPop = finalFrame.offsetBy(dx: finalFrame.width, dy: 0)
        
        transitionContext.containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromViewController.view.frame = fOffPop
                fromViewController.view.alpha = 0
        }, completion: {_ in
                transitionContext.completeTransition(true)
        })
    }
    
}
