//
//  QIUPresentViewController.h
//  scorpion
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.sui.me. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QIUPresentViewController : UIViewController

- (instancetype)initWithViewController:(UIViewController *)viewController;

@property (nonatomic, assign) CGFloat topGuide;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) NSTimeInterval showDuration;
@property (nonatomic, assign) NSTimeInterval dismissDuration;

@end

NS_ASSUME_NONNULL_END