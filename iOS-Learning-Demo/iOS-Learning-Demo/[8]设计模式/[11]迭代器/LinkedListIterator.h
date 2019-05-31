//
//  LinkedListIterator.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IteratorProtocol.h"
@class LinkedList;

NS_ASSUME_NONNULL_BEGIN

@interface LinkedListIterator : NSObject <IteratorProtocol>

/**
 *  由链表进行初始化
 *
 *  @param linkedList 链表对象
 *
 *  @return 迭代器工具
 */
- (id)initWithLinkedList:(LinkedList *)linkedList;

@end

NS_ASSUME_NONNULL_END
