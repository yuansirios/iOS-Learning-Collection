//
//  YSActivityButton.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/18.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSActivityButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame;

- (void)startAnimation;

- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
