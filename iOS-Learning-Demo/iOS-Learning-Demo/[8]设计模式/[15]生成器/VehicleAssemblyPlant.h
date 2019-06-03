//
//  VehicleAssemblyPlant.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleBuilder.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  车辆装配工厂
 */
@interface VehicleAssemblyPlant : NSObject

/**
 *  组装车辆
 *
 *  @param vehicleBuilder 组装方案
 *
 *  @return 组装好的车辆
 */
+ (VehicleBuilder *)vehicleAssembly:(VehicleBuilder *)vehicleBuilder;

@end

NS_ASSUME_NONNULL_END
