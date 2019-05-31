//
//  GameProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GameProtocol <NSObject>

@required

/**
 *  设置玩家个数
 *
 *  @param count 数目
 */
- (void)setPlayerCount:(int)count;

/**
 *  返回玩家数目
 *
 *  @return 玩家数目
 */
- (int)playerCount;

/**
 *  初始化游戏
 */
- (void)initializeGame;

/**
 *  开始游戏
 */
- (void)makePlay;

/**
 *  结束游戏
 */
- (void)endOfGame;

@end

NS_ASSUME_NONNULL_END
