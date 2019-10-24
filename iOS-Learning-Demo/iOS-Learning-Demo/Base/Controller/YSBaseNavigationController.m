//
//  YSBaseNavigationController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/22.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseNavigationController.h"

@interface YSBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation YSBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.delegate = self;
    }
    
    [self.navigationBar setBackgroundImage:createImageWithColor(UIColor.whiteColor, self.view.width, 40) forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.translucent = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        //界面少于2个或对显示的是rootcontroller（主要指显示首页）时，没有手势
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)shouldAutorotate{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

#pragma mark - *********** 状态栏 ***********
- (UIStatusBarStyle)preferredStatusBarStyle{
     return self.barStyle;
}

- (void)setBarStyle:(NSInteger)barStyle{
    _barStyle = barStyle;
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
}

@end
