//
//  BrandingFactory.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//
/*
 1. 抽象工厂指的是提供一个创建一系列相关或者相互依赖对象的接口,而无需指定它们具体的类
 2. 如果多个类有相同的行为,但实际实现不同,则可能需要某种抽象类型作为其父类被继承,
 抽象类型定义了所有相关具体类将共有的共同行为
 */

#import "YSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BrandingFactory : YSBaseModel

/**
 *  抽象工厂方法
 *
 *  @return 具体的工厂
 */
+ (BrandingFactory *)factory;

/**
 *  该工厂生产的brandedView(由具体工厂构造)
 *
 *  @return 生产好的brandedView
 */
- (UIView *)brandedView;

/**
 *  该工厂生产的brandedMainButton(由具体工厂构造)
 *
 *  @return 生产好的brandedMainButton
 */
- (UIButton *)brandedMainButton;

@end

NS_ASSUME_NONNULL_END
