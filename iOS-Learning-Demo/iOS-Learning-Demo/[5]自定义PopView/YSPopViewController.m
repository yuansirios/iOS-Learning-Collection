//
//  YSPopViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/3/13.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSPopViewController.h"
#import "YSPopView.h"

@interface YSPopViewController()

@property (nonatomic,strong) YSPopView *popView;

@end

@implementation YSPopViewController

#pragma mark - *********** initViews ***********

- (void)addSubviews{
    self.title = @"YSPopView示例";
    
    UIButton *btn = UIButton.new;
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showPopView) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 200, 50);
    btn.backgroundColor = UIColorRandom;
    btn.center = self.view.center;
    [self.view addSubview:btn];
}

- (void)showPopView{
    [self.popView showInView:self.view];
}

#pragma mark - *********** lazy ***********

- (YSPopView *)popView{
    if (!_popView) {
        _popView = [[YSPopView alloc]initWithFrame:self.view.bounds];
        [_popView setDidShowBlock:^{
            NSLog(@"弹窗出现");
        }];
        
        [_popView setDidDismissBlock:^{
            NSLog(@"弹窗消失");
        }];
    }
    return _popView;
}

@end
