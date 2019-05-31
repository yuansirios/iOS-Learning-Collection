//
//  ElementA.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ElementA.h"
#import "VisitorProtocol.h"

@implementation ElementA

- (void)accept:(id <VisitorProtocol>)visitor {
    
    [visitor visitElement:self];
}

- (void)operation {
    
    NSLog(@"Element_A operation start.");
}

- (void)elementASpecialOperationA {
    
    NSLog(@"Element_A special operation.");
}

@end
