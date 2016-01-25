//
//  FirstViewController.m
//  UIPresentationControllerDemo
//
//  Created by QiuFeng on 1/25/16.
//  Copyright © 2016 www.qiufeng.me. All rights reserved.
//

#import "FirstViewController.h"
#import "QIUPresentKit.h"

@implementation FirstViewController

- (IBAction)composeBarButtonItemTouchUpInside:(UIBarButtonItem *)sender {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    QIUPresentViewController *nextController = [[QIUPresentViewController alloc] initWithViewController:controller];
    [self presentViewController:nextController animated:YES completion:nil];
}

@end
