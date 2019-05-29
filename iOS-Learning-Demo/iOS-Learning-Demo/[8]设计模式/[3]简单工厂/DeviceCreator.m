//
//  DeviceCreator.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "DeviceCreator.h"
#import "iPhoneDevice.h"
#import "AndroidDevice.h"
#import "WindowsDevice.h"

@implementation DeviceCreator

+ (BaseDevice *)deviceCreatorWithDeviceType:(DeviceType)deviceType {
    
    if (deviceType == kiPhone) {
        
        return [iPhoneDevice new];
        
    } else if (deviceType == kAndroid) {
        
        return [AndroidDevice new];
        
    } else if (deviceType == kWindows) {
        
        return [WindowsDevice new];
        
    } else {
        
        return [BaseDevice new];
    }
}

@end
