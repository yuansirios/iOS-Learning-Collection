//
//  GamePlay+More.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "GamePlay+More.h"

@implementation GamePlay (More)

- (void)cheat {
    [self up];
    [self down];
    [self up];
    [self down];
    [self left];
    [self right];
    [self left];
    [self right];
    [self commandA];
    [self commandB];
    [self commandA];
    [self commandB];
}

- (NSInteger)lives {
    return 12;
}

@end
