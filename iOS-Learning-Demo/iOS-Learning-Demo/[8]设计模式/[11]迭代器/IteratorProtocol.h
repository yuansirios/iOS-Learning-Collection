//
//  IteratorProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IteratorProtocol <NSObject>

/**
 *  下一个对象
 *
 *  @return 对象
 */
- (id)next;

/**
 *  是否存在下一个对象
 *
 *  @return 对象
 */
- (BOOL)hasNext;

/**
 *  内容
 *
 *  @return 返回内容
 */
- (id)item;

@end

NS_ASSUME_NONNULL_END
