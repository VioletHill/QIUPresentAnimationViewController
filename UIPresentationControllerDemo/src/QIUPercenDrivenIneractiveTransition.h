//
//  QIUPercenDrivenIneractiveTransition.h
//  scorpion
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.sui.me. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QIUPercenDrivenIneractiveTransition : UIPercentDrivenInteractiveTransition

- (instancetype)initWithTopGuide:(CGFloat)topGuide transformScale:(CGFloat)scale;

@end

NS_ASSUME_NONNULL_END
