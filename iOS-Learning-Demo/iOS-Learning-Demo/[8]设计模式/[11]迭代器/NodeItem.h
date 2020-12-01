//
//  NodeItem.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NodeItem : NSObject

/**
 *  下一个节点
 */
@property (nonatomic, strong) NodeItem *nextNode;

/**
 *  节点里面的内容
 */
@property (nonatomic, strong) id    item;

/**
 *  初始化节点
 *
 *  @param item 节点携带的内容
 *
 *  @return 节点
 */
- (instancetype)initWithItem:(id)item;

@end

NS_ASSUME_NONNULL_END
