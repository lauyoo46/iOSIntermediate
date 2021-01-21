//
//  RotateTransitionAnimator.swift
//  NavTransition
//
//  Created by Laurentiu Ile on 21/01/2021.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit

class RotateTransitionAnimator: NSObject {
    
    let duration = 0.5
    var isPresenting = false
    
}

extension RotateTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
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
        
        let rotateOut = CGAffineTransform(rotationAngle: -90 * CGFloat.pi / 180)
        
        
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        
        toView.transform = rotateOut
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: [],
                       animations: {
            if self.isPresenting {
                fromView.transform = rotateOut
                fromView.alpha = 0
                toView.transform = CGAffineTransform.identity
                toView.alpha = 1.0
            } else {
                fromView.alpha = 0
                fromView.transform = rotateOut
                toView.alpha = 1.0
                toView.transform = CGAffineTransform.identity
            }
        }, completion: { finished in
            transitionContext.completeTransition(true)
        })
    }
}

extension RotateTransitionAnimator: UIViewControllerTransitioningDelegate {
    
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
