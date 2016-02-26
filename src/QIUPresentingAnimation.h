//
//  QIUPresentingAnimation.h
//  scorpion
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.sui.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QIUPresentingAnimation : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTopGuide:(CGFloat)topGuide scale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
