//
//  QIUPresentingAnimation.m
//  scorpion
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.sui.me. All rights reserved.
//

#import "QIUPresentingAnimation.h"

@implementation QIUPresentingAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect toFrame = [transitionContext containerView].bounds;
    toFrame.size.height = toView.frame.size.height - 100;
    toFrame.origin.y = [transitionContext containerView].bounds.size.height;
    toView.frame = toFrame;
    
    [[transitionContext containerView] addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.90, 0.90);
        CGRect finalFrame = toFrame;
        finalFrame.origin.y  = 100;
        toView.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
