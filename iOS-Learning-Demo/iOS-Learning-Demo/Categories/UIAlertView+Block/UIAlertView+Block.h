//
//  UIAlertView+Block.h
//  VehicleService
//
//  Created by yuan on 2019/4/4.
//  Copyright © 2019 xince. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UIAlertViewBlock)(UIAlertView *alertView,NSInteger buttonIndex);

@interface UIAlertView (Block)

- (void)showWithBlock:(UIAlertViewBlock)block;

@end

NS_ASSUME_NONNULL_END
