//
//  YSRotateViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/22.
//  Copyright © 2019 yuan. All rights reserved.
//  此方案只对presentViewController生效

#import "YSRotateViewController.h"

@implementation YSRotateViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"方案二";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.greenColor;
    [btn addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.sd_layout.topSpaceToView(self.view, 40).leftSpaceToView(self.view, 40).widthIs(100).heightIs(50);
}

- (void)backEvent{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - *********** 旋转设置 ***********

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

//刚开始的方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}

@end
