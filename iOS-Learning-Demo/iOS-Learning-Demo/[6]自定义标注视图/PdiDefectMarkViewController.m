//
//  PdiDefectMarkViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/4/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "PdiDefectMarkViewController.h"
#import "PdiDefectMarkView.h"

@interface PdiDefectMarkViewController ()

@property (nonatomic,strong) PdiDefectMarkView *defectMarkView;

@property (nonatomic,strong) UIButton *screenShotBtn;

@end

@implementation PdiDefectMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"外观缺陷标注";
    [self.view addSubview:self.defectMarkView];
    [self.view addSubview:self.screenShotBtn];
}

- (void)screenShot{
    NSLog(@"%@",self.defectMarkView.screenShot);
}

#pragma mark - *********** lazy ***********

- (PdiDefectMarkView *)defectMarkView{
    if (!_defectMarkView) {
        _defectMarkView = PdiDefectMarkView.new;
        _defectMarkView.center = self.view.center;
    }
    return _defectMarkView;
}

- (UIButton *)screenShotBtn{
    if (!_screenShotBtn) {
        _screenShotBtn = UIButton.new;
        _screenShotBtn.backgroundColor = UIColorRandom;
        [_screenShotBtn setTitle:@"截图" forState:UIControlStateNormal];
        [_screenShotBtn addTarget:self action:@selector(screenShot) forControlEvents:UIControlEventTouchUpInside];
        _screenShotBtn.frame = CGRectMake(self.defectMarkView.left, self.defectMarkView.top - 20 - 50, 100, 50);
    }
    return _screenShotBtn;
}

@end
