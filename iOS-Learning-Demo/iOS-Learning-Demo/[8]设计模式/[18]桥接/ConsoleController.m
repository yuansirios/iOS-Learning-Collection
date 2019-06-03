//
//  ConsoleController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ConsoleController.h"

@interface ConsoleController ()

@end

@implementation ConsoleController

- (void)excuteCommand:(ConsoleCommand)command {
    
    [_emulator loadInstructionsForCommand:command];
    [_emulator excuteInstructions];
}

@end
