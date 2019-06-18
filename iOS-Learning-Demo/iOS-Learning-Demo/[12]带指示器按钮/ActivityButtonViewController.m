//
//  ActivityButtonViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/18.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ActivityButtonViewController.h"
#import "YSActivityButton.h"

@interface ActivityButtonViewController ()

@property (nonatomic,strong) YSActivityButton *activityButton;

@end

@implementation ActivityButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.activityButton];
}

- (void)confirm{
    [self.activityButton startAnimation];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:2];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityButton stopAnimation];
        });
    });
}

- (YSActivityButton *)activityButton{
    if (!_activityButton) {
        
        YSActivityButton *btn = [[YSActivityButton alloc]initWithFrame:CGRectMake(24, 50, self.view.width - 24*2, 50)];
        btn.backgroundColor = UIColor.redColor;
        btn.layer.cornerRadius = btn.height/2;
        [btn setTitle:@"确 认" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        _activityButton = btn;
    }
    return _activityButton;
}

@end
