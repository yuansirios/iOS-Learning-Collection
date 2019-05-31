//
//  ElementProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol VisitorProtocol;

NS_ASSUME_NONNULL_BEGIN

@protocol ElementProtocol <NSObject>

/**
 *  接收访问者
 *
 *  @param visitor 访问者对象
 */
- (void)accept:(id <VisitorProtocol>)visitor;

/**
 *  元素公共的操作
 */
- (void)operation;

@end

NS_ASSUME_NONNULL_END
