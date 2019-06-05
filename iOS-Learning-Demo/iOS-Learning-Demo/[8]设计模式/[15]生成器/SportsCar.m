//
//  SportsCar.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "SportsCar.h"

@implementation SportsCar

- (void)buildVehicleChassis {
    
    [self.vehicleInfo setObject:@"SportsCar" forKey:@"Chassis"];
}

- (void)buildVehicleEngine {
    
    [self.vehicleInfo setObject:@"SportsCar" forKey:@"Engine"];
}

- (void)buildVehicleWheels {
    
    [self.vehicleInfo setObject:@"SportsCar" forKey:@"Wheels"];
}

- (void)buildVehicleDoors {
    
    [self.vehicleInfo setObject:@"SportsCar" forKey:@"Doors"];
}

@end
