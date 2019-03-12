//
//  YSBaseViewController+Navgation.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YSBaseViewController (Navgation)

- (void)setLeftBarButtonWithTitle:(NSString * _Nullable )title;

- (void)setRightBarButtonWithTitle:(NSString *)title;

- (void)setRightBarButtonWithImg:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
