//
//  KTTransitionAnimator.swift
//  KaranThukral
//
//  Created by Karan Thukral on 2015-04-15.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

import UIKit

class KTTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate {
	
	weak var transitionContext: UIViewControllerContextTransitioning?
	var interactionController: UIPercentDrivenInteractiveTransition?
	@IBOutlet weak var navigationController: UINavigationController?
	var panGesture: UIPanGestureRecognizer?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		panGesture = UIPanGestureRecognizer(target: self, action: Selector("panned:"))
		self.navigationController!.view.addGestureRecognizer(panGesture!)
	}
	
	// MARK: UINavigationControllerDelegate
	
	func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self
	}
	
	// MARK: UIViewControllerAnimatedTransitioning
 
	func navigationController(navigationController: UINavigationController,
		interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
			return self.interactionController
	}
	
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
		return 0.5
	}
	
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		self.transitionContext = transitionContext
		
		var containerView = transitionContext.containerView()
		var fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) as UIView!
		var toView = transitionContext.viewForKey(UITransitionContextToViewKey) as UIView!
		
		containerView.addSubview(toView)
		let offScreenBottom = CGAffineTransformMakeTranslation(0, containerView.frame.height)
		let offScreenTop = CGAffineTransformMakeTranslation(0, -containerView.frame.height)
		
		toView.transform = offScreenBottom
		let duration = self.transitionDuration(transitionContext)
		
		UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: nil, animations: {
			
			fromView.transform = offScreenTop
			toView.transform = CGAffineTransformIdentity
			
			}, completion: { finished in
				transitionContext.completeTransition(!self.transitionContext!.transitionWasCancelled())
		})
		
	}
	
	func animationEnded(transitionCompleted: Bool) {
		if (transitionCompleted) {
			self.navigationController?.delegate = nil
			self.navigationController?.view.removeGestureRecognizer(panGesture!)
		}
	}
	
	override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
		self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
	}
	
	// MARK: Interactive Animation
	
	func panned(gestureRecognizer: UIPanGestureRecognizer) {
		switch gestureRecognizer.state {
		case .Began:
			self.interactionController = UIPercentDrivenInteractiveTransition()
			self.navigationController?.topViewController.performSegueWithIdentifier("PushSegue", sender: nil)
			
		case .Changed:
			var translation = gestureRecognizer.translationInView(self.navigationController!.view)
			var completionProgress = -translation.y/(CGRectGetHeight(self.navigationController!.view.bounds)*2)
			self.interactionController?.updateInteractiveTransition(completionProgress)
			
		case .Ended:
			var translation = gestureRecognizer.translationInView(self.navigationController!.view)
			if (-translation.y/CGRectGetHeight(self.navigationController!.view.bounds) > 0.25) {
				self.interactionController?.finishInteractiveTransition()
			} else {
				self.interactionController?.completionSpeed = 0.25
				self.interactionController?.cancelInteractiveTransition()
			}
			self.interactionController = nil
			
		default:
			self.interactionController?.cancelInteractiveTransition()
			self.interactionController = nil
		}
	}
}
