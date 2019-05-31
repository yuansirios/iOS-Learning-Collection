//
//  Node.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)initWithItem:(id)item {
    
    self = [super init];
    
    if (self) {
        
        self.item = item;
    }
    
    return self;
}

@end
