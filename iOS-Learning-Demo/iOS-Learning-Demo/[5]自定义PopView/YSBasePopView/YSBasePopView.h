//
//  YSBasePopView.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/3/13.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^YSPopViewDidShowBlock)(void);
typedef void(^YSPopViewDidDismissBlock)(void);

@interface YSBasePopView : YSBaseView

@property (nonatomic,copy) YSPopViewDidShowBlock didShowBlock;
@property (nonatomic,copy) YSPopViewDidDismissBlock didDismissBlock;

- (void)addContentView;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
