//
//  ConsoleController.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseViewController.h"
#import "ConsoleEmulator.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConsoleController : YSBaseViewController

/**
 *  抽象模拟器
 */
@property (nonatomic, strong) ConsoleEmulator  *emulator;

/**
 *  执行指令
 *
 *  @param command 指令
 */
- (void)excuteCommand:(ConsoleCommand)command;

@end

NS_ASSUME_NONNULL_END
