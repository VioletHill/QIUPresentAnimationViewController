//
//  QIUDismissAnimtaion.m
//  scorpion
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.sui.me. All rights reserved.
//

#import "QIUDismissAnimtaion.h"

@interface QIUDismissAnimtaion ()

@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation QIUDismissAnimtaion

- (instancetype)initWithDuration:(NSTimeInterval)duration {
    if (self = [super init]) {
        self.duration = duration;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.transform = CGAffineTransformIdentity;
        CGRect finalframe = fromViewController.view.frame;
        finalframe.origin.y = [transitionContext containerView].bounds.size.height;
        fromViewController.view.frame = finalframe;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
