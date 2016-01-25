//
//  QIUPercenDrivenIneractiveTransition.m
//  scorpion
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.sui.me. All rights reserved.
//

#import "QIUPercenDrivenIneractiveTransition.h"

@interface QIUPercenDrivenIneractiveTransition ()

@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation QIUPercenDrivenIneractiveTransition

- (void)updateView:(CGFloat)percentComplete {
    UIViewController *fromViewController =  [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9 + 0.1 *percentComplete, 0.9 + 0.1 * percentComplete);
    CGRect finalFrame = [self.transitionContext containerView].bounds;
    finalFrame.size.height = CGRectGetHeight(finalFrame) - 100;
    finalFrame.origin.y = 100 + percentComplete * CGRectGetHeight(finalFrame);
    fromViewController.view.frame = finalFrame;
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    [super updateInteractiveTransition:percentComplete];
    [self updateView:percentComplete];
}

- (void)finishInteractiveTransition {
    [UIView animateWithDuration:0.4 * (1 - self.percentComplete) animations:^{
        [self updateView:1];
    } completion:^(BOOL finished) {
        [super finishInteractiveTransition];
        [self.transitionContext completeTransition:YES];
    }];
}

- (void)cancelInteractiveTransition {
    [UIView animateWithDuration:0.4 * self.percentComplete animations:^{
        [self updateView:0];
    } completion:^(BOOL finished) {
        [super cancelInteractiveTransition];
        [self.transitionContext completeTransition:NO];
    }];
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
}

@end
