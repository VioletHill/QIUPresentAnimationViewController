//
//  QIUPresentingAnimation.m
//  scorpion
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.sui.me. All rights reserved.
//

#import "QIUPresentingAnimation.h"

@interface QIUPresentingAnimation ()

@property (nonatomic, assign) CGFloat topGuide;
@property (nonatomic, assign) CGFloat scale;

@end

@implementation QIUPresentingAnimation

- (instancetype)initWithTopGuide:(CGFloat)topGuide scale:(CGFloat)scale {
    if (self = [super init]) {
        self.topGuide = topGuide;
        self.scale = scale;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect toFrame = [transitionContext containerView].bounds;
    toFrame.size.height = toView.frame.size.height - self.topGuide;
    toFrame.origin.y = [transitionContext containerView].bounds.size.height;
    toView.frame = toFrame;
    
    [[transitionContext containerView] addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = CGAffineTransformMakeScale(self.scale, self.scale);
        CGRect finalFrame = toFrame;
        finalFrame.origin.y  = self.topGuide;
        toView.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
