//
//  AbstractProxy.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/30.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AbstractProxy : NSProxy

/**
 *  被代理对象
 */
@property (nonatomic, weak) id  customer;

/**
 *  代理客户
 *
 *  @param customer 实现了某种协议的客户
 *
 *  @return 代理对象
 */
- (instancetype)initWithCustomer:(id)customer;


@end

NS_ASSUME_NONNULL_END
