//
//  GameBoyConsoleController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "GameBoyConsoleController.h"

@interface GameBoyConsoleController ()

@end

@implementation GameBoyConsoleController

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

- (void)action1 {
    
    [super excuteCommand:kConsoleCommandAction1];
}

- (void)action2 {
    
    [super excuteCommand:kConsoleCommandAction2];
}

@end
