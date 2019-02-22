//
//  YSVedioViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/21.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSVedioViewController.h"

@interface YSVedioViewController ()

@end

@implementation YSVedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"方案一";
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self changeRotate:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self changeRotate:NO];
    
}

/*
 *iOS中可以直接调用对象的消息方式有两种
 *以下方式是KVO的变相实现，有兴趣可以尝试下
 *原理都是操作UIDevice的orientation属性，达到旋转
 
 *1.performSelector:withObject;
 
 *2.NSInvocation
 
 if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = UIInterfaceOrientationPortrait;
    if (change) {
        val = UIInterfaceOrientationLandscapeRight;
    }
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
 }*/

- (void)changeRotate:(BOOL)change{
    
    /*
     *采用KVO字段控制旋转
     */
    
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    
    if (change) {
        orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
    }
    
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

#pragma mark - *********** 旋转设置 ***********

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
