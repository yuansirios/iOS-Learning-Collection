//
//  IconButtonViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/8/16.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "IconButtonViewController.h"
#import "YSButton.h"

@interface IconButtonViewController ()

@end

@implementation IconButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [self createAddButton:@"我的图标在左边"];
    btn.frame = CGRectMake(50, 80, btn.width, 50);
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.redColor;
    [self.view addSubview:btn];
    
    UIButton *btn1 = [self createAddButton:@"我的图标在右边"];
    btn1.frame = CGRectMake(50, btn.bottom + 40, 200, 50);
    [btn1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.redColor;
    [self.view addSubview:btn1];
    
    float space = 12;
    float iconW = 20;
    
    UIButton *btn2 = [YSButton buttonWithType:UIButtonTypeCustom withSpace:space withPadding:0 withType:YSButtonImageStyle_Top];
    [btn2 setImage:createImageWithColor(UIColor.greenColor, iconW, iconW) forState:UIControlStateNormal];
    [btn2 setTitle:@"我的图标在上边" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(50, btn1.bottom + 40, 200, 80);
    [btn2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn2.backgroundColor = UIColor.redColor;
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [YSButton buttonWithType:UIButtonTypeCustom withSpace:space withPadding:0 withType:YSButtonImageStyle_Bottom];
    [btn3 setImage:createImageWithColor(UIColor.greenColor, iconW, iconW) forState:UIControlStateNormal];
    [btn3 setTitle:@"我的图标在下边" forState:UIControlStateNormal];
    btn3.frame = CGRectMake(50, btn2.bottom + 40, 200, 80);
    [btn3 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn3.backgroundColor = UIColor.redColor;
    [self.view addSubview:btn3];
}

- (UIButton *)createAddButton:(NSString *)title{
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    float space = 12;
    float iconW = 20;
    
    UIButton *btn = [YSButton buttonWithType:UIButtonTypeCustom withSpace:space withPadding:0 withType:YSButtonImageStyle_Left];
    [btn setImage:createImageWithColor(UIColor.greenColor, iconW, iconW) forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn.titleLabel setFont:font];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    float btnW = titleSize.width + space + 10*2 + iconW;
    btn.width = btnW;
    
    return btn;
}

@end
