//
//  SlideRightTransitionAnimator.swift
//  NavTransition
//
//  Created by Laurentiu Ile on 21/01/2021.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit

class SlideRightTransitionAnimator: NSObject {
    
    let duration = 0.5
    var isPresenting = false
    
}

extension SlideRightTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        
        let container = transitionContext.containerView
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        
        if isPresenting {
            toView.transform = offScreenLeft
        }
        
        if isPresenting {
            container.addSubview(fromView)
            container.addSubview(toView)
        } else {
            container.addSubview(toView)
            container.addSubview(fromView)
        }
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: [],
                       animations: {
                        
            if self.isPresenting {
                toView.transform = CGAffineTransform.identity
            } else {
                fromView.transform = offScreenLeft
            }
                        
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}

extension SlideRightTransitionAnimator: UIViewControllerTransitioningDelegate {
    
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
