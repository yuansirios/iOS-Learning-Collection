//
//  YSButton.h
//  YSButton_Example
//
//  Created by yuan on 2018/10/18.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    YSButtonImageStyle_Left     = 1 << 0,
    YSButtonImageStyle_Right    = 1 << 1,
    YSButtonImageStyle_Top      = 1 << 2,
    YSButtonImageStyle_Bottom   = 1 << 3,
} YSButtonImageStyle;

@interface YSButton : UIButton

/**
 创建button
 
 @param buttonType button的类型
 @param space 图片距离button的边距，如果图片比较大的，此时有效果；
 如果图片比较小，没有效果，默认居中；
 @param padding 文字和图片间距
 @param type 类型
 @return button
 */
+ (id)buttonWithType:(UIButtonType)buttonType
           withSpace:(CGFloat)space
         withPadding:(CGFloat)padding
            withType:(YSButtonImageStyle)type;

@end

NS_ASSUME_NONNULL_END
