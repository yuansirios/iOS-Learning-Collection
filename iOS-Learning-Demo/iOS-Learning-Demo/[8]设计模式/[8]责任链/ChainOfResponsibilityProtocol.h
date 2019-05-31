//
//  ChainOfResponsibilityProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ChainOfResponsibilityProtocol <NSObject>

/**
 *  设置接替对象
 *
 *  @param successor 接替对象
 */
- (void)setSuccessor:(id <ChainOfResponsibilityProtocol>)successor;

/**
 *  返回接替对象
 *
 *  @return 接替对象
 */
- (id <ChainOfResponsibilityProtocol>)successor;

/**
 *  处理请求
 *
 *  @param request 请求
 */
- (void)handlerRequest:(id)request;

@end

NS_ASSUME_NONNULL_END
