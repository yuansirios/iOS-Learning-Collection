//
//  GameGearConsoleController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "GameGearConsoleController.h"

@interface GameGearConsoleController ()

@end

@implementation GameGearConsoleController

- (void)up {
    
    [super excuteCommand:kConsoleCommandUp];
}

- (void)down {
    
    [super excuteCommand:kConsoleCommandDown];
}

- (void)left {
    
    [super excuteCommand:kConsoleCommandLeft];
}

- (void)right {
    
    [super excuteCommand:kConsoleCommandRight];
}

- (void)select {
    
    [super excuteCommand:kConsoleCommandSelect];
}

- (void)start {
    
    [super excuteCommand:kConsoleCommandStart];
}

@end
