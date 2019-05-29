//
//  DeviceCreator.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//
/*
 1. 工厂类以及其实例化出来的子类都不是抽象类,所以称之为简单工厂(制造者与产品都是具体的实现类)
 2. 简单工厂灵活性较差,但其简单直白的特性,适用于层级结构简单的场景
 */

#import "YSBaseModel.h"
#import "BaseDevice.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    kAndroid,
    kiPhone,
    kWindows,
} DeviceType;

@interface DeviceCreator : YSBaseModel

/**
 *  根据标签创建手机
 *
 *  @param deviceType 手机标签
 *
 *  @return 对应的手机
 */
+ (BaseDevice *)deviceCreatorWithDeviceType:(DeviceType)deviceType;

@end

NS_ASSUME_NONNULL_END
