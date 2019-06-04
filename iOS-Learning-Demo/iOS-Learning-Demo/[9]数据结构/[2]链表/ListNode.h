//
//  ListNode.h
//  iOSTests
//
//  Created by yuan on 2019/1/25.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListNode : NSObject

/**
 添加节点
 @param p 节点指针
 @param value 节点值
 @return 头结点, 其中头结点 value 为 0
 */
+ (ListNode *)addNode:(ListNode *)p andVlaue:(id)value;

/**
 遍历单链表
 @param head 头节点
 */
+ (NSArray *)getLinkList:(ListNode *)head;

/**
 单链表逆置
 @param head 头节点
 */

+ (ListNode *)reverseList:(ListNode *)head;

@end

NS_ASSUME_NONNULL_END
