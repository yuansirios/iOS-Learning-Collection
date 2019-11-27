//
//  UIViewController+YSLeaksTest.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/11/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "UIViewController+YSLeaksTest.h"
#import "NSObject+YSSwizzling.h"

const char *YSVCFLAG = "YSVCFLAG";

@implementation UIViewController (YSLeaksTest)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(viewWillAppear:) withSEL:@selector(ys_viewWillAppear:)];
        [self swizzleSEL:@selector(viewWillDisappear:) withSEL:@selector(ys_viewWillDisappear:)];
    });
}

- (void)ys_viewWillAppear:(BOOL)animate{
    [self ys_viewWillAppear:animate];
    objc_setAssociatedObject(self, YSVCFLAG, @(NO), OBJC_ASSOCIATION_ASSIGN);
}

- (void)ys_viewWillDisappear:(BOOL)animate{
    [self ys_viewWillDisappear:animate];
    if ([objc_getAssociatedObject(self, YSVCFLAG) boolValue]) {
        [self willDealloc];
    }
}

@end
