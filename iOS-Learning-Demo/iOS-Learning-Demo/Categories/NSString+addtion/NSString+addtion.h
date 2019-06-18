//
//  NSString+addtion.h
//  Demo
//
//  Created by yuan on 2018/12/13.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (addtion)

#pragma mark - *********** Drawing ***********

- (CGSize)ys_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)ys_widthForFont:(UIFont *)font;

- (CGFloat)ys_heightForFont:(UIFont *)font width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
