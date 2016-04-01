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

@property (nonatomic, assign) CGFloat topGuide;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign, readwrite) NSTimeInterval animationDuration;

@end

@implementation QIUPercenDrivenIneractiveTransition

- (instancetype)initWithTopGuide:(CGFloat)topGuide transformScale:(CGFloat)scale duration:(NSTimeInterval)duration {
    if (self = [super init]) {
        self.topGuide = topGuide;
        self.scale = scale;
        self.animationDuration = duration;
    }
    return self;
}

- (void)updateView:(CGFloat)percentComplete {
    UIViewController *fromViewController =  [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.scale + (1 - self.scale) * percentComplete, self.scale + (1 - self.scale) * percentComplete);
    CGRect finalFrame = [self.transitionContext containerView].bounds;
    finalFrame.size.height = CGRectGetHeight(finalFrame) - self.topGuide;
    finalFrame.origin.y = self.topGuide + percentComplete * CGRectGetHeight(finalFrame);
    fromViewController.view.frame = finalFrame;
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    [super updateInteractiveTransition:percentComplete];
    [self updateView:percentComplete];
}

- (void)finishInteractiveTransition {
    [UIView animateWithDuration:self.animationDuration * (1 - self.percentComplete) animations:^{
        [self updateView:1];
    } completion:^(BOOL finished) {
        [super finishInteractiveTransition];
        [self.transitionContext completeTransition:YES];
    }];
}

- (void)cancelInteractiveTransition {
    [UIView animateWithDuration:self.animationDuration * self.percentComplete animations:^{
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
