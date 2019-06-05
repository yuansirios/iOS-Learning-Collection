//
//  VehicleBuilderProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VehicleBuilderProtocol <NSObject>

@required
/**
 *  制造汽车底盘
 */
- (void)buildVehicleChassis;

/**
 *  制造汽车引擎
 */
- (void)buildVehicleEngine;

/**
 *  制造汽车轮子
 */
- (void)buildVehicleWheels;

/**
 *  制造汽车车门
 */
- (void)buildVehicleDoors;

@end

NS_ASSUME_NONNULL_END
