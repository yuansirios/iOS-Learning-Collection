//
//  UINavigationController+YSLeaksTest.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/11/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "UINavigationController+YSLeaksTest.h"
#import "NSObject+YSSwizzling.h"

@implementation UINavigationController (YSLeaksTest)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(popViewControllerAnimated:) withSEL:@selector(ys_popViewControllerAnimated:)];
    });
}

- (UIViewController *)ys_popViewControllerAnimated:(BOOL)animated{
    UIViewController *popVC = [self ys_popViewControllerAnimated:animated];
    extern const char *YSVCFLAG;
    objc_setAssociatedObject(popVC, YSVCFLAG, @(YES), OBJC_ASSOCIATION_ASSIGN);
    return popVC;
}

@end
