//
//  YSBaseViewController+Navgation.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseViewController+Navgation.h"

@implementation YSBaseViewController (Navgation)

- (void)setLeftBarButtonWithTitle:(NSString * _Nonnull )title{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 60, 44);
    [backBtn setTitle:title == nil?nil:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, IS_IOS_VERSION_11?4:8, 0, 0);
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)setRightBarButtonWithTitle:(NSString *)title{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [rightBtn setTitle:title forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(onRight) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, IS_IOS_VERSION_11?4:8);
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)setRightBarButtonWithImg:(UIImage *)image{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [rightBtn setImage:image forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(onRight) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, IS_IOS_VERSION_11?4:8);
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)onBack{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)onRight
{
    
}

@end
