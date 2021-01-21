//
//  SlideDownTransitionAnimator.swift
//  NavTransition
//
//  Created by Laurentiu Ile on 21/01/2021.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit

class SlideDownTransitionAnimator: NSObject {
    
    let duration = 0.5
    var isPresenting = false
    
}

extension SlideDownTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey .from) else {
            return
        }
        
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        
        let container = transitionContext.containerView
        let offScreenUp = CGAffineTransform(translationX: 0, y: -container.frame.height)
        let offScreenDown = CGAffineTransform(translationX: 0, y: container.frame.height)
        
        if isPresenting {
            toView.transform = offScreenUp
        }
        
        container.addSubview(fromView)
        container.addSubview(toView)
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8 ,
                       initialSpringVelocity: 0.8,
                       options: [],
                       animations: {
            
            if self.isPresenting {
                fromView.transform = offScreenDown
                fromView.alpha = 0.5
                toView.transform = CGAffineTransform.identity
            } else {
                fromView.transform = offScreenUp
                fromView.alpha = 1.0
                toView.transform = CGAffineTransform.identity
                toView.alpha = 1.0
            }
            
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}

extension SlideDownTransitionAnimator: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}
