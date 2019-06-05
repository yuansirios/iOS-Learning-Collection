//
//  MementoCenterProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MementoCenterProtocol <NSObject>

@required
/**
 *  生成当前状态对象值
 *
 *  @return 对象值
 */
- (id)currentState;

/**
 *  恢复到指定的状态
 *
 *  @param state 状态
 */
- (void)recoverFromState:(id)state;

@end

NS_ASSUME_NONNULL_END
