//
//  YSCheckLockStatus.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/5.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSCheckLockStatus.h"

@implementation YSCheckLockStatus

- (void)applicationProtectedDataWillBecomeUnavailable{
    NSLog(@"<<<<<<<<<< 锁屏 >>>>>>>>>>");
}

- (void)applicationProtectedDataDidBecomeAvailable{
    NSLog(@"<<<<<<<<<< 解锁 >>>>>>>>>>");
}

- (void)registerforDeviceLockNotif{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationProtectedDataDidBecomeAvailable) name:UIApplicationProtectedDataDidBecomeAvailable object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationProtectedDataWillBecomeUnavailable) name:UIApplicationProtectedDataWillBecomeUnavailable object:nil];
}

@end
