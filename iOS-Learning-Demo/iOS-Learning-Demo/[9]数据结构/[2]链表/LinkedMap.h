//
//  LinkedMap.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/4.
//  Copyright © 2019 yuan. All rights reserved.
//  双向链表

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkedNode : NSObject <NSCopying>

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) LinkedNode *prev;
@property (nonatomic, strong) LinkedNode *next;

- (instancetype)initWithKey:(NSString *)key
                      value:(NSString *)value;

+ (instancetype)nodeWithKey:(NSString *)key
                      value:(NSString *)value;

@end

@interface LinkedMap : NSObject

- (void)insertNodeAtHead:(LinkedNode *)node;
- (void)insertNode:(LinkedNode *)node;
- (void)insertNode:(LinkedNode *)newNode beforeNodeForKey:(NSString *)key;
- (void)insertNode:(LinkedNode *)newNode afterNodeForKey:(NSString *)key;
- (void)bringNodeToHead:(LinkedNode *)node;

- (void)readAllNode;
- (void)removeNodeForKey:(NSString *)key;
- (void)removeTailNode;

- (NSInteger)length;
- (BOOL)isEmpty;

- (LinkedNode *)nodeForKey:(NSString *)key;
- (LinkedNode *)headNode;
- (LinkedNode *)tailNode;

@end

NS_ASSUME_NONNULL_END
