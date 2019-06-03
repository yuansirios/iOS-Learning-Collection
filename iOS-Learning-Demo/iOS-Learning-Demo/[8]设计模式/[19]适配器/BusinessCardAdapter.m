//
//  BusinessCardAdapter.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "BusinessCardAdapter.h"

@implementation BusinessCardAdapter

- (instancetype)initWithData:(id)data {
    
    if (self = [super init]) {
        
        self.data = data;
    }
    
    return self;
}

- (NSString *)name {
    
    return nil;
}

- (UIColor *)lineColor {
    
    return nil;
}

- (NSString *)phoneNumber {
    
    return nil;
}

@end
