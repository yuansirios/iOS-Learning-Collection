//
//  YSBaseViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/22.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseViewController.h"
#import "YSBaseNavigationController.h"
#import "YSBaseViewController+Navgation.h"

@interface YSBaseViewController ()

@end

@implementation YSBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    YSBaseViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController layoutNavigation];
        [viewController addSubviews];
        [viewController racViewModel];
    }];
    return viewController;
}

- (instancetype)initWithViewModel:(id <ViewModelProtocol>)viewModel{
    if (self = [super init]) {
    }
    return self;
}

- (void)addSubviews{
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)racViewModel{}

- (void)layoutNavigation{
    [self setLeftBarButtonWithTitle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.view.backgroundColor = UIColor.whiteColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"当前控制器 ---   %@  --- ",NSStringFromClass([self class]));
    });
}

- (void)dealloc{
    NSLog(@"VC -- %@ -- 正常销毁",NSStringFromClass([self class]));
}

#pragma mark - *********** 是否开启手势返回 ***********

- (void)openGestureRecongnizer:(BOOL)isOpen{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = isOpen;
    }
}

#pragma mark - *********** 旋转设置 ***********

//支持旋转
- (BOOL)shouldAutorotate{
    return YES;
}

//默认只需要支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - *********** 状态栏显示处理 ***********

- (BOOL)prefersStatusBarHidden{
    return self.statusHiden;
}

- (void)setStatusHiden:(BOOL)statusHiden{
    _statusHiden = statusHiden;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
     return self.barStyle;
}

- (void)setBarStyle:(NSInteger)barStyle{
    _barStyle = barStyle;
    
    YSBaseNavigationController *nv = (YSBaseNavigationController *)self.navigationController;
    if (nv) {
        nv.barStyle = barStyle;
    }else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}


@end
