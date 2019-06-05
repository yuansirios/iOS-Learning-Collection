//
//  Receiver.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Receiver : NSObject {
    
    CGFloat _hue;
    CGFloat _saturation;
    CGFloat _brightness;
    CGFloat _alpha;
}

@property (nonatomic, weak) UIView  *colorView;

/**
 *  让接收指令的view颜色变淡
 *
 *  @param quantity 数量
 */
- (void)makeViewLighter:(CGFloat)quantity;

/**
 *  让接收指令的view颜色变身
 *
 *  @param quantity 数量
 */
- (void)makeViewDarker:(CGFloat)quantity;

@end

NS_ASSUME_NONNULL_END
