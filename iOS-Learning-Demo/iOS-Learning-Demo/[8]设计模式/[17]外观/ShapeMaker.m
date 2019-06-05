//
//  ShapeMaker.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ShapeMaker.h"

@implementation ShapeMaker

+ (void)drawCircleAndRectangle {
    
    Shape *circle    = [Circle new];
    Shape *rectangle = [Rectangle new];
    
    [circle draw];
    [rectangle draw];
    NSLog(@"\n");
}

+ (void)drawCircleAndSquare {
    
    Shape *circle    = [Circle new];
    Shape *square    = [Square new];
    
    [circle draw];
    [square draw];
    NSLog(@"\n");
}

+ (void)drawAll {
    
    Shape *circle    = [Circle new];
    Shape *rectangle = [Rectangle new];
    Shape *square    = [Square new];
    
    [circle draw];
    [rectangle draw];
    [square draw];
    NSLog(@"\n");
}

@end
