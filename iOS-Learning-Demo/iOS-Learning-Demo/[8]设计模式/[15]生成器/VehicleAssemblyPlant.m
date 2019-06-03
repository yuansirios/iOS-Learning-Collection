//
//  VehicleAssemblyPlant.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "VehicleAssemblyPlant.h"

@implementation VehicleAssemblyPlant

+ (VehicleBuilder *)vehicleAssembly:(VehicleBuilder *)vehicleBuilder {
    
    [vehicleBuilder buildVehicleChassis];
    [vehicleBuilder buildVehicleDoors];
    [vehicleBuilder buildVehicleEngine];
    [vehicleBuilder buildVehicleWheels];
    
    return vehicleBuilder;
}

@end
