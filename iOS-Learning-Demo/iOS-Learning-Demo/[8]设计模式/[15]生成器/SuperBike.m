//
//  SuperBike.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "SuperBike.h"

@implementation SuperBike

- (void)buildVehicleChassis {
    
    [self.vehicleInfo setObject:@"SuperBike" forKey:@"Chassis"];
}

- (void)buildVehicleEngine {
    
    [self.vehicleInfo setObject:@"SuperBike" forKey:@"Engine"];
}

- (void)buildVehicleWheels {
    
    [self.vehicleInfo setObject:@"SuperBike" forKey:@"Wheels"];
}

- (void)buildVehicleDoors {
    
    [self.vehicleInfo setObject:@"SuperBike" forKey:@"Doors"];
}

@end
