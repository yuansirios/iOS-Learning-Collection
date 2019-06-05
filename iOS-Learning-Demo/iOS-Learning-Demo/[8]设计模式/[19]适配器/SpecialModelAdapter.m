//
//  SpecialModelAdapter.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "SpecialModelAdapter.h"
#import "SpecialModel.h"

@implementation SpecialModelAdapter

- (NSString *)name {
    
    SpecialModel *model = self.data;
    return model.name;
}

- (UIColor *)lineColor {
    
    SpecialModel *model = self.data;
    
    UIColor *color = nil;
    
    if ([model.colorString isEqualToString:@"red"]) {
        
        color = [UIColor redColor];
        
    } else if ([model.colorString isEqualToString:@"green"]) {
        
        color = [UIColor greenColor];
        
    } else {
        
        color = [UIColor blackColor];
        
    }
    
    return color;
}

- (NSString *)phoneNumber {
    
    SpecialModel *model = self.data;
    return model.phoneNumber;
}

@end
