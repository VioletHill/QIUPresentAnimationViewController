//
//  QIUPresentViewController.m
//  scorpion
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.sui.me. All rights reserved.
//

#import "QIUPresentViewController.h"

#import "QIUPresentationController.h"
#import "QIUPresentingAnimation.h"
#import "QIUDismissAnimtaion.h"
#import "QIUPercenDrivenIneractiveTransition.h"

@interface QIUPresentViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIViewController *subViewController;
@property (nonatomic, strong) UIViewController *fromViewController;
@property (nonatomic, strong) QIUPercenDrivenIneractiveTransition *percentDrivenInteractiveTransition;

@property (nonatomic, assign) BOOL isInteracting;
@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation QIUPresentViewController

- (instancetype)initWithViewController:(UIViewController *)viewController {
    if (self = [super init]) {
        self.subViewController = viewController;
        [self addChildViewController:self.subViewController];
        
        UIView *subview = self.subViewController.view;
        [self.view addSubview:self.subViewController.view];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[subview]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(subview)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[subview]-0-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(subview)]];
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [subview addGestureRecognizer:gesture];
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        [self setDefaultParams];
    }
    return self;
}

- (void)setDefaultParams {
    self.topGuide = 80;
    self.scale = 0.90;
    self.showDuration = 0.3;
    self.dismissDuration = 0.3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Accessors

- (QIUPercenDrivenIneractiveTransition *)percentDrivenInteractiveTransition {
    if (_percentDrivenInteractiveTransition == nil) {
        _percentDrivenInteractiveTransition = [[QIUPercenDrivenIneractiveTransition alloc] initWithTopGuide:self.topGuide transformScale:self.scale duration:self.showDuration];
    }
    return _percentDrivenInteractiveTransition;
}

#pragma mark - Gesture

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    CGPoint touchPoinst = [panGesture translationInView:panGesture.view.superview];
    CGFloat percentComplete = (touchPoinst.y - self.startPoint.y) / CGRectGetHeight(panGesture.view.bounds);
    percentComplete = MAX(0, percentComplete);
    percentComplete = MIN(1, percentComplete);
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            self.isInteracting = YES;
            self.startPoint = touchPoinst;
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.percentDrivenInteractiveTransition updateInteractiveTransition:percentComplete];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            self.isInteracting = NO;
            if (percentComplete > 0.4) {
                [self.percentDrivenInteractiveTransition finishInteractiveTransition];
            } else {
                [self.percentDrivenInteractiveTransition cancelInteractiveTransition];
            }
        }
        default:
            break;
    }
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    QIUPresentationController *controller = [[QIUPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return controller;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[QIUDismissAnimtaion alloc] initWithDuration:self.dismissDuration];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.fromViewController = presenting;
    return [[QIUPresentingAnimation alloc] initWithTopGuide:self.topGuide scale:self.scale duration:self.showDuration];
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.isInteracting ? self.percentDrivenInteractiveTransition : nil;
}

#pragma mark - <Rotate>

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.fromViewController.view.bounds = CGRectMake(0, 0, size.width, size.height);
    }];
}

@end
