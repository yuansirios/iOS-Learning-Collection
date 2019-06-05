//
//  ConsoleEmulator.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    
    kConsoleCommandUp,
    kConsoleCommandDown,
    kConsoleCommandLeft,
    kConsoleCommandRight,
    
    kConsoleCommandSelect,
    kConsoleCommandStart,
    
    kConsoleCommandAction1,
    kConsoleCommandAction2,
    
} ConsoleCommand;

@interface ConsoleEmulator : NSObject

/**
 *  加载指令
 *
 *  @param command 指令
 */
- (void)loadInstructionsForCommand:(ConsoleCommand)command;

/**
 *  执行指令
 */
- (void)excuteInstructions;

@end

NS_ASSUME_NONNULL_END
