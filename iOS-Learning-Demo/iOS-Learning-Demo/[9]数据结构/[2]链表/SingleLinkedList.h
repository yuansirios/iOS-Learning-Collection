//
//  SingleLinkedList.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/4.
//  Copyright © 2019 yuan. All rights reserved.
//  单向链表

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleLinkedListNode : NSObject <NSCopying>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) SingleLinkedListNode *next;

- (instancetype)initWithKey:(NSString *)key
                      value:(NSString *)value;

+ (instancetype)nodeWithKey:(NSString *)key
                      value:(NSString *)value;

@end

@interface SingleLinkedList : NSObject

- (void)insertNode:(SingleLinkedListNode *)node;
- (void)insertNodeAtHead:(SingleLinkedListNode *)node;
- (void)insertNode:(SingleLinkedListNode *)newNode beforeNodeForKey:(NSString *)key;
- (void)insertNode:(SingleLinkedListNode *)newNode afterNodeForKey:(NSString *)key;

- (void)bringNodeToHead:(SingleLinkedListNode *)node;

- (void)removeNode:(SingleLinkedListNode *)node;

- (SingleLinkedListNode *)nodeForKey:(NSString *)key;
- (SingleLinkedListNode *)headNode;
- (SingleLinkedListNode *)lastNode;

- (void)reverse;
- (NSInteger)length;
- (BOOL)isEmpty;

+ (NSArray *)getLinkList:(SingleLinkedListNode *)head;
+ (SingleLinkedListNode *)reverseList:(SingleLinkedListNode *)head;

@end

NS_ASSUME_NONNULL_END
