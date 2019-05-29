//
//  DecoratorGamePlay.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DecoratorGamePlay : YSBaseModel

@property (nonatomic) NSInteger coin;

- (void)up;
- (void)down;
- (void)left;
- (void)right;
- (void)select;
- (void)start;
- (void)commandA;
- (void)commandB;

#pragma mark - 以下为装饰对象新添加的功能

/**
 *  剩余几条命
 */
@property (nonatomic, readonly) NSInteger  lives;

/**
 *  作弊 (上下上下左右左右ABAB)
 */
- (void)cheat;

@end

NS_ASSUME_NONNULL_END
