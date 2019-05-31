//
//  LinkedList.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"
#import "IteratorProtocol.h"
#import "LinkedListIterator.h"

NS_ASSUME_NONNULL_BEGIN

@interface LinkedList : NSObject

/**
 *  头结点
 */
@property (nonatomic, strong, readonly) Node      *headNode;

/**
 *  节点的数目
 */
@property (nonatomic, assign, readonly) NSInteger  numberOfNodes;

/**
 *  添加数据
 *
 *  @param item 数据
 */
- (void)addItem:(id)item;

/**
 *  创建迭代器对象
 *
 *  @return 迭代器对象
 */
- (id <IteratorProtocol>)createIterator;

@end

NS_ASSUME_NONNULL_END
