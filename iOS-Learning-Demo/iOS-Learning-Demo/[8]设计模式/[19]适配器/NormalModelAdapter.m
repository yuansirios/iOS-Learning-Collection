//
//  NormalModelAdapter.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "NormalModelAdapter.h"
#import "NormalModel.h"

@implementation NormalModelAdapter

- (NSString *)name {
    
    NormalModel *model = self.data;
    return model.name;
}

- (UIColor *)lineColor {
    
    NormalModel *model = self.data;
    return model.lineColor;
}

- (NSString *)phoneNumber {
    
    NormalModel *model = self.data;
    return model.phoneNumber;
}

@end
