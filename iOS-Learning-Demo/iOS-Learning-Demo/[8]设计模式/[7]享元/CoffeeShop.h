//
//  CoffeeShop.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/30.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoffeeShop : NSObject

/**
 *  接收订单
 *
 *  @param flavor 咖啡味道
 *  @param table  桌子
 */
- (void)takeOrder:(NSString *)flavor table:(int)table;

/**
 *  开始服务
 */
- (void)serve;

@end

NS_ASSUME_NONNULL_END
