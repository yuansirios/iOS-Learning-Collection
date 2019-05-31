//
//  ElementB.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ElementB.h"
#import "VisitorProtocol.h"

@implementation ElementB

- (void)accept:(id <VisitorProtocol>)visitor {
    
    [visitor visitElement:self];
}

- (void)operation {
    
    NSLog(@"Element_B operation start.");
}

- (void)elementBSpecialOperationB {
    
    NSLog(@"Element_B special operation.");
}

@end
