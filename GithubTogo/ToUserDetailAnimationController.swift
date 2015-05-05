//
//  ToUserDetailAnimationController.swift
//  GithubTogo
//
//  Created by Jisoo Hong on 2015. 5. 4..
//  Copyright (c) 2015년 JHK. All rights reserved.
//

import UIKit

class ToUserDetailAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  let animationDuration = 0.5
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return self.animationDuration
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UserViewController
    let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! UserDetailViewController
    let containerView = transitionContext.containerView()
    
    toVC.view.alpha = 0
    containerView.addSubview(toVC.view)
    
    let selectedIndexPath = fromVC.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
    let userCell = fromVC.collectionView.cellForItemAtIndexPath(selectedIndexPath) as! UserCell
    let snapShot = userCell.imageView.snapshotViewAfterScreenUpdates(false)
    userCell.hidden = true
    snapShot.frame = containerView.convertRect(userCell.imageView.frame, fromCoordinateSpace: userCell.imageView.superview!)
    containerView.addSubview(snapShot)
    toVC.view.layoutIfNeeded()
    
    let frame = containerView.convertRect(toVC.imageView.frame, fromView: toVC.view)
    toVC.imageView.hidden = true
    
    
    UIView.animateWithDuration(animationDuration, animations: { () -> Void in
      toVC.view.alpha = 1
      snapShot.frame = frame
      
      }) { (finished) -> Void in
        if finished {
          toVC.imageView.hidden = false
          snapShot.removeFromSuperview()
          userCell.hidden = false
          transitionContext.completeTransition(true)
        } else {
          transitionContext.completeTransition(false)
        }
    }
  }
}
