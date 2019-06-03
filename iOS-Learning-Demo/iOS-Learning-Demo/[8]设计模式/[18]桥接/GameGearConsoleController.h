//
//  GameGearConsoleController.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ConsoleController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameGearConsoleController : ConsoleController

- (void)up;
- (void)down;
- (void)left;
- (void)right;

- (void)select;
- (void)start;

@end

NS_ASSUME_NONNULL_END
