//
//  YSBaseViewController.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/22.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerProtocol.h"

#define YSTitleKey   @"title"
#define YSEventKey   @"event"

NS_ASSUME_NONNULL_BEGIN

@interface YSBaseViewController : UIViewController<ControllerProtocol>

//状态栏
@property(nonatomic,assign) BOOL statusHiden;
//状态栏样式
@property(nonatomic,assign) NSInteger barStyle;

#pragma mark - *********** 是否开启手势返回 ***********

- (void)openGestureRecongnizer:(BOOL)isOpen;

@end

NS_ASSUME_NONNULL_END
