//
//  VehicleBuilder.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleBuilderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VehicleBuilder : NSObject <VehicleBuilderProtocol>

/**
 *  车辆信息
 */
@property (nonatomic, strong) NSMutableDictionary *vehicleInfo;

@end

NS_ASSUME_NONNULL_END
