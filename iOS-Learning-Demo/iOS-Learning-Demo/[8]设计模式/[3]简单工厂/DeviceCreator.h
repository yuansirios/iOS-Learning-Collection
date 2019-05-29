//
//  DeviceCreator.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

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
