//
//  Model.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "Model.h"

@implementation Model

- (id)currentState {
    
    return @{@"name" : self.name == nil ? @""  : self.name,
             @"age"  : self.age  == nil ? @(0) : self.age};
}

- (void)recoverFromState:(id)state {
    
    NSDictionary *obj = state;
    
    self.name = obj[@"name"];
    self.age  = obj[@"age"];
}

@end
