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

@property (nonatomic, strong) NSLayoutConstraint *topConstraint;

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
    
    UIView *superView = [transitionContext containerView];
    [superView addSubview:toView];
    
    toView.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[toView]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:@{@"topGuide": @(self.topGuide)} views:NSDictionaryOfVariableBindings(toView)]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:toView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeHeight multiplier:1 constant:-self.topGuide]];
    self.topConstraint = [NSLayoutConstraint constraintWithItem:toView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:CGRectGetHeight(superView.bounds)];
    [superView addConstraint:self.topConstraint];
    [superView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = CGAffineTransformMakeScale(self.scale, self.scale);
        self.topConstraint.constant = self.topGuide;
        [superView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
