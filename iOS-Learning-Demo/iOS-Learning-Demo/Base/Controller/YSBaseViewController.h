//
//  YSBaseViewController.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/22.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YSBaseViewController : UIViewController<ControllerProtocol>

#pragma mark - *********** 是否开启手势返回 ***********

- (void)openGestureRecongnizer:(BOOL)isOpen;

@end

NS_ASSUME_NONNULL_END
