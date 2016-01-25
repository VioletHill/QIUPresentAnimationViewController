//
//  SecondViewController.m
//  UIPresentationControllerDemo
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.qiufeng.me. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

- (IBAction)dismissButtonTouchUpInside:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
