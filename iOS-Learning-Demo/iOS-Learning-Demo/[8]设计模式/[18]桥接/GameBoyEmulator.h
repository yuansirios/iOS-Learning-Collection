//
//  GameBoyEmulator.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ConsoleEmulator.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameBoyEmulator : ConsoleEmulator

- (void)loadInstructionsForCommand:(ConsoleCommand)command;
- (void)excuteInstructions;

@end

NS_ASSUME_NONNULL_END
