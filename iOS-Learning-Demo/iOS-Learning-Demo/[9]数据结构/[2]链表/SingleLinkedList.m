//
//  SingleLinkedList.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/4.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "SingleLinkedList.h"

@implementation SingleLinkedListNode

- (instancetype)initWithKey:(NSString *)key
                      value:(NSString *)value
{
    if (self = [super init]) {
        _key = key;
        _value = value;
    }
    return self;
}

+ (instancetype)nodeWithKey:(NSString *)key
                      value:(NSString *)value
{
    return [[[self class] alloc] initWithKey:key value:value];
}

#pragma mark - NSCopying
- (id)copyWithZone:(nullable NSZone *)zone
{
    SingleLinkedListNode *newNode = [[SingleLinkedListNode allocWithZone:zone] init];
    newNode.key = self.key;
    newNode.value = self.value;
    newNode.next = self.next;
    return newNode;
}

@end

@interface SingleLinkedList ()

@property (nonatomic, strong) SingleLinkedListNode *headNode;
@property (nonatomic, strong) NSMutableDictionary *innerMap;

@end

@implementation SingleLinkedList

- (instancetype)init
{
    self = [super init];
    if (self) {
        _innerMap = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - public
- (void)insertNodeAtHead:(SingleLinkedListNode *)node
{
    if (!node || node.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:node]) {
        return;
    }
    
    _innerMap[node.key] = node;
    if (_headNode) {
        node.next = _headNode;
        _headNode = node;
    } else {
        _headNode = node;
    }
}

- (void)insertNode:(SingleLinkedListNode *)node
{
    if (!node || node.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:node]) {
        return;
    }
    
    _innerMap[node.key] = node;
    
    if (!_headNode) {
        _headNode = node;
        return;
    }
    SingleLinkedListNode *lastNode = [self lastNode];
    lastNode.next = node;
}

- (void)insertNode:(SingleLinkedListNode *)newNode beforeNodeForKey:(NSString *)key
{
    if (key.length == 0 || !newNode || newNode.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:newNode]) {
        return;
    }
    
    if (!_headNode) {
        _headNode = newNode;
        return;
    }
    
    SingleLinkedList *node = _innerMap[key];
    if (node) {
        _innerMap[newNode.key] = newNode;
        SingleLinkedListNode *aheadNode = [self nodeBeforeNode:node];
        if (aheadNode) {
            aheadNode.next = newNode;
            newNode.next = node;
        } else {
            _headNode = newNode;
            newNode.next = node;
        }
        
    } else {
        [self insertNode:newNode]; //insert to tail
    }
}

- (void)insertNode:(SingleLinkedListNode *)newNode afterNodeForKey:(NSString *)key
{
    if (key.length == 0 || !newNode || newNode.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:newNode]) {
        return;
    }
    
    if (!_headNode) {
        _headNode = newNode;
        return;
    }
    
    SingleLinkedListNode *node = _innerMap[key];
    if (node) {
        _innerMap[newNode.key] = newNode;
        newNode.next = node.next;
        node.next = newNode;
    } else {
        [self insertNode:newNode]; //insert to tail
    }
}

- (void)removeNode:(SingleLinkedListNode *)node
{
    if (!node || node.key.length == 0) {
        return;
    }
    [_innerMap removeObjectForKey:node.key];
    
    if (node.next) {
        node.key = node.next.key;
        node.value = node.next.value;
        node.next = node.next.next;
    } else {
        SingleLinkedListNode *aheadNode = [self nodeBeforeNode:node];
        aheadNode.next = nil;
    }
}

- (void)bringNodeToHead:(SingleLinkedListNode *)node
{
    if (!node || !_headNode) {
        return;
    }
    
    if ([node isEqual:_headNode]) {
        return;
    }
    
    SingleLinkedListNode *aheadNode = [self nodeBeforeNode:node];
    aheadNode.next = node.next;
    node.next = _headNode;
    _headNode = node;
}

- (SingleLinkedListNode *)nodeForKey:(NSString *)key
{
    if (key.length == 0) {
        return nil;
    }
    SingleLinkedListNode *node = _innerMap[key];
    return node;
}

- (SingleLinkedListNode *)headNode
{
    return _headNode;
}

- (SingleLinkedListNode *)lastNode
{
    SingleLinkedListNode *last = _headNode;
    while (last.next) {
        last = last.next;
    }
    return last;
}

- (void)reverse
{
    SingleLinkedListNode *prev = nil;
    SingleLinkedListNode *current = _headNode;
    SingleLinkedListNode *next = nil;
    
    while (current) {
        next = current.next;
        current.next = prev;
        prev = current;
        current = next;
    }
    
    _headNode = prev;
}

+ (SingleLinkedListNode *)reverseList:(SingleLinkedListNode *)head{
    SingleLinkedListNode *tempHead = head;
    SingleLinkedListNode *next = NULL;
    SingleLinkedListNode *pre = NULL;
    while (tempHead) {
        if (tempHead == head) {
            next = tempHead.next;
            tempHead.next = NULL;
            pre = tempHead;
        } else {
            next = tempHead.next;
            tempHead.next = pre;
            pre = tempHead;
        }
        tempHead = next;
    }
    return pre;
}

+ (NSArray *)getLinkList:(SingleLinkedListNode *)head {
    SingleLinkedListNode *current = head;
    if (current.next == nil) {
        NSLog (@"链表为空!");
        return nil;
    }
    
    NSMutableArray *valArr = @[].mutableCopy;
    [valArr addObject:current.value];
    
    while ( current.next != nil ) {
        [valArr addObject:current.next.value];
        if (current.next.next == nil) {
            return valArr.copy;
            break;
        }
        current = current.next;
    }
    return nil;
}

- (NSInteger)length
{
    NSInteger _len = 0;
    for (SingleLinkedListNode *node = _headNode; node; node = node.next) {
        _len ++;
    }
    return _len;
}

- (BOOL)isEmpty
{
    return _headNode == nil;
}

#pragma mark - private
- (SingleLinkedListNode *)nodeBeforeNode:(SingleLinkedListNode *)node
{
    SingleLinkedListNode *targetNode = nil;
    SingleLinkedListNode *tmpNode = _headNode;
    while (tmpNode) {
        if ([tmpNode.next isEqual:node]) {
            targetNode = tmpNode;
            break;
        } else {
            tmpNode = tmpNode.next;
        }
    }
    return targetNode;
}

- (BOOL)isNodeExists:(SingleLinkedListNode *)node
{
    SingleLinkedListNode *tmpNode = _headNode;
    while (tmpNode) {
        if ([tmpNode isEqual:node]) {
            return YES;
        }
        tmpNode = tmpNode.next;
    }
    return false;
}

@end
