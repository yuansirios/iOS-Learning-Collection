//
//  LinkedMap.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/4.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "LinkedMap.h"

@implementation LinkedNode

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
    LinkedNode *newNode = [[LinkedNode allocWithZone:zone] init];
    newNode.key = self.key;
    newNode.value = self.value;
    newNode.prev = self.prev;
    newNode.next = self.next;
    return newNode;
}

@end

@interface LinkedMap ()

@property (nonatomic, strong) LinkedNode *headNode;
@property (nonatomic, strong) LinkedNode *tailNode;
@property (nonatomic, strong) NSMutableDictionary *innerMap;

@end

@implementation LinkedMap

- (instancetype)init
{
    self = [super init];
    if (self) {
        _innerMap = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - public
- (void)insertNodeAtHead:(LinkedNode *)node
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
        _headNode.prev = node;
        _headNode = node;
    } else {
        _headNode = _tailNode = node;
    }
}

- (void)insertNode:(LinkedNode *)node
{
    if (!node || node.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:node]) {
        return;
    }
    
    if (!_headNode && !_tailNode) {
        _headNode = _tailNode = node;
        return;
    }
    
    _innerMap[node.key] = node;
    
    _tailNode.next = node;
    node.prev = _tailNode;
    _tailNode = node;
}

- (void)insertNode:(LinkedNode *)newNode beforeNodeForKey:(NSString *)key
{
    if (key.length == 0 || !newNode || newNode.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:newNode]) {
        return;
    }
    
    if (!_headNode && !_tailNode) {
        _headNode = _tailNode = newNode;
        return;
    }
    
    LinkedNode *node = _innerMap[key];
    if (node) {
        _innerMap[newNode.key] = newNode;
        if (node.prev) {
            node.prev.next = newNode;
            newNode.prev = node.prev;
        } else {
            _headNode = newNode;
        }
        node.prev = newNode;
        newNode.next = node;
    } else {
        [self insertNode:newNode]; //insert to tail
    }
    
}

- (void)insertNode:(LinkedNode *)newNode afterNodeForKey:(NSString *)key
{
    if (key.length == 0 || !newNode || newNode.key.length == 0) {
        return;
    }
    
    if ([self isNodeExists:newNode]) {
        return;
    }
    
    if (!_headNode && !_tailNode) {
        _headNode = _tailNode = newNode;
        return;
    }
    
    LinkedNode *node = _innerMap[key];
    if (node) {
        _innerMap[newNode.key] = newNode;
        if (node.next) {
            newNode.next = node.next;
            node.next.prev = newNode;
        } else {
            _tailNode = newNode;
        }
        newNode.prev = node;
        node.next = newNode;
    } else {
        [self insertNode:newNode]; //insert to tail
    }
}

- (void)bringNodeToHead:(LinkedNode *)node
{
    if (!node) {
        return;
    }
    if (!_headNode && !_tailNode) {
        _headNode = _tailNode = node;
        return;
    }
    
    if ([_headNode isEqual:node]) {
        return;
    }
    
    if ([_tailNode isEqual:node]) {
        _tailNode = node.prev;
        _tailNode.next = nil;
    } else {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }
    
    _headNode.prev = node;
    node.next = _headNode;
    node.prev = nil;
    _headNode = node;
}

- (void)removeNodeForKey:(NSString *)key
{
    if (key.length == 0) {
        return;
    }
    
    LinkedNode *node = _innerMap[key];
    if (!node) {
        return;
    }
    
    [_innerMap removeObjectForKey:key];
    
    if ([_headNode isEqual:node]) {
        _headNode = node.next;
    } else if ([_tailNode isEqual:node]) {
        _tailNode = node.prev;
    }
    
    node.prev.next = node.next;
    node.next.prev = node.prev;
    
}

- (void)removeTailNode
{
    if (!_tailNode || _tailNode.key.length == 0) {
        return;
    }
    
    [_innerMap removeObjectForKey:_tailNode.key];
    if (_headNode == _tailNode) {
        _headNode = _tailNode = nil;
        return;
    }
    
    _tailNode = _tailNode.prev;
    _tailNode.next = nil;
}

- (LinkedNode *)nodeForKey:(NSString *)key
{
    if (key.length == 0) {
        return nil;
    }
    LinkedNode *node = _innerMap[key];
    return node;
}

- (LinkedNode *)headNode
{
    return _headNode;
}

- (LinkedNode *)tailNode
{
    return _tailNode;
}

- (void)readAllNode
{
    LinkedNode *node = _headNode;
    while (node) {
        NSLog(@"node key -- %@, node value -- %@", node.key, node.value);
        node = node.next;
    }
}

- (NSInteger)length
{
    NSInteger _len = 0;
    for (LinkedNode *node = _headNode; node; node = node.next) {
        _len ++;
    }
    return _len;
}

- (BOOL)isEmpty
{
    return _headNode == nil;
}

#pragma mark - private
- (BOOL)isNodeExists:(LinkedNode *)node
{
    LinkedNode *tmpNode = _headNode;
    while (tmpNode) {
        if ([tmpNode isEqual:node]) {
            return YES;
        }
        tmpNode = tmpNode.next;
    }
    return false;
}
@end
