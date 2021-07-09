//
//  UIImage+SVGManager.h
//  iOS-Learning-Demo
//
//  Created by yuan xiaodong on 2020/11/26.
//  Copyright © 2020 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SVGManager)

/// 单纯加载svg图片
/// @param name 图片名
/// @param imgv 显示的UIImageView
+ (UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv;

/// 加载svg图片，用16进制色值修改颜色
/// @param name 图片名
/// @param imgv 显示的UIImageView
/// @param color 色值对象
+ (UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
