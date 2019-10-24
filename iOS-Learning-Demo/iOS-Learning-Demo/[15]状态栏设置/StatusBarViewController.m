//
//  StatusBarViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/10/24.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "StatusBarViewController.h"

@interface StatusBarViewController ()

@end

@implementation StatusBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 90,[UIScreen mainScreen].bounds.size.width-100, 100)];
    [button setTitle:@"状态栏的显示与隐藏" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor brownColor]];
    [button addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button.frame)+10, [UIScreen mainScreen].bounds.size.width-100, 100)];
    [button2 setBackgroundColor:[UIColor purpleColor]];
    [button2 setTitle:@"状态栏白色模式" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(button2.frame)+10, [UIScreen mainScreen].bounds.size.width-100, 100)];
    [button3 setBackgroundColor:[UIColor purpleColor]];
    [button3 setTitle:@"状态栏黑色模式" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
}

- (void)click1{
    self.statusHiden = !self.statusHiden;
}

- (void)click2{
    self.barStyle = UIStatusBarStyleLightContent;
}

- (void)click3{
    self.barStyle = UIStatusBarStyleDefault;
}

@end
