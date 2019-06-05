//
//  Invoker.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Invoker : NSObject

/**
 *  单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/**
 *  添加并执行
 *
 *  @param command 命令
 */
- (void)addAndExecute:(id <CommandProtocol>)command;

@end

NS_ASSUME_NONNULL_END
