//
//  ShapeMaker.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"

#import "Circle.h"
#import "Rectangle.h"
#import "Square.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShapeMaker : NSObject

+ (void)drawCircleAndRectangle;
+ (void)drawCircleAndSquare;
+ (void)drawAll;

@end

NS_ASSUME_NONNULL_END
