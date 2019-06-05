//
//  GameBoyConsoleController.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ConsoleController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameBoyConsoleController : ConsoleController

- (void)up;
- (void)down;
- (void)left;
- (void)right;

- (void)select;
- (void)start;

- (void)action1;
- (void)action2;

@end

NS_ASSUME_NONNULL_END
