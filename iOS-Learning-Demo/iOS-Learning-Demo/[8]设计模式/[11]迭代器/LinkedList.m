//
//  LinkedList.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "LinkedList.h"

@interface LinkedList ()

/**
 *  头结点
 */
@property (nonatomic, strong, readwrite) Node      *headNode;

/**
 *  节点的数量
 */
@property (nonatomic, assign, readwrite) NSInteger  numberOfNodes;

@end

@implementation LinkedList

- (void)addItem:(id)item {
    
    if (self.headNode == nil) {
        
        self.headNode = [[Node alloc] initWithItem:item];
        
    } else {
        
        [self addItem:item node:self.headNode];
    }
    
    self.numberOfNodes++;
}

- (id <IteratorProtocol>)createIterator {
    
    return [[LinkedListIterator alloc] initWithLinkedList:self];
}

#pragma mark - Private Methods
- (void)addItem:(id)item node:(Node *)node {
    
    if (node.nextNode == nil) {
        
        node.nextNode = [[Node alloc] initWithItem:item];
        
    } else {
        
        [self addItem:item node:node.nextNode];
    }
}

@end
