//
//  QIUPresentationController.m
//  scorpion
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.sui.me. All rights reserved.
//

#import "QIUPresentationController.h"

@interface QIUPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation QIUPresentationController

- (void)presentationTransitionWillBegin {
    [self.containerView addSubview:self.dimmingView];
    self.dimmingView.frame = self.containerView.bounds;
    self.dimmingView.alpha = 0;
    [self.presentingViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.4;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (!completed) {   //如果没有完成 dismiss 操作, 那么复原回去
        [UIView animateWithDuration:0.1 animations:^{
            self.dimmingView.alpha = 0.4;
        } completion:nil];
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.dimmingView removeFromSuperview];
    }
}

#pragma mark - <Accessors>

- (UIView *)dimmingView {
    if (_dimmingView == nil) {
        _dimmingView = [[UIView alloc] init];
        _dimmingView.backgroundColor = [UIColor blackColor];
    }
    return _dimmingView;
}


@end
