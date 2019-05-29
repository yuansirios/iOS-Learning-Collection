//
//  GamePlay.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GamePlay : YSBaseModel

/**
 *  游戏币的数量
 */
@property (nonatomic) NSInteger coin;

/**
 *  上下左右的操作
 */
- (void)up;
- (void)down;
- (void)left;
- (void)right;

/**
 *  选择与开始的操作
 */
- (void)select;
- (void)start;

/**
 *  按钮 A + B 的操作
 */
- (void)commandA;
- (void)commandB;

@end

NS_ASSUME_NONNULL_END
