//
//  UIImage+SVGManager.m
//  iOS-Learning-Demo
//
//  Created by yuan xiaodong on 2020/11/26.
//  Copyright © 2020 yuan. All rights reserved.
//

#import "UIImage+SVGManager.h"
#import "SVGKit.h"
#import "SVGKImage.h"

@implementation UIImage (SVGManager)

+ (UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv{
    return [UIImage name:name imgv:imgv];
}

+ (UIImage *)svgImageNamed:(NSString *)name imgv:(UIImageView *)imgv color:(UIColor *)color{
    return [UIImage name:name imgv:imgv tintColor:color];
}

#pragma mark - 加载svg图片统一调用此方法

+ (UIImage *)name:(NSString *)name imgv:(UIImageView *)imgv{
    SVGKImage *svgImage = [SVGKImage imageNamed:name];
    return svgImage.UIImage;
}

#pragma mark - 修改颜色统一调用此方法

+ (UIImage *)name:(NSString *)name imgv:(UIImageView *)imgv tintColor:(UIColor *)tintColor{
    
    UIImage *svgImage = [UIImage name:name imgv:imgv];
    
    CGRect rect = CGRectMake(0, 0, svgImage.size.width, svgImage.size.height);
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(svgImage.CGImage);
    BOOL opaque = alphaInfo == (kCGImageAlphaNoneSkipLast | kCGImageAlphaNoneSkipFirst | kCGImageAlphaNone);
    UIGraphicsBeginImageContextWithOptions(svgImage.size, opaque, svgImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, svgImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextClipToMask(context, rect, svgImage.CGImage);
    
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
