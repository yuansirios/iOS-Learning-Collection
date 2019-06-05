//
//  ListNode.m
//  iOSTests
//
//  Created by yuan on 2019/1/25.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ListNode.h"

@interface ListNode(){
    id val;
    ListNode *next;
}

@end

@implementation ListNode


+ (ListNode *)addNode:(ListNode *)p andVlaue:(id)value
{
    if (p == nil) {
        p = [[ListNode alloc]init];
        p->val = value;
        p->next = nil;
    }else{
        p->next = [ListNode addNode:p->next andVlaue:value];
    }
    
    return p;
}


+ (NSArray *)getLinkList:(ListNode *)head {
    ListNode *current = head;
    if (current->next == nil) {
        NSLog (@"链表为空!");
        return nil;
    }
    
    NSMutableArray *valArr = @[].mutableCopy;
    [valArr addObject:current->val];
    
    while ( current->next != nil ) {
        [valArr addObject:current->next->val];
        if (current->next->next == nil) {
            return valArr.copy;
            break;
        }
        current = current->next;
    }
    
    return nil;
}

+ (ListNode *)reverseList:(ListNode *)head{
    ListNode *tempHead = head;
    ListNode *next = NULL;
    ListNode *pre = NULL;
    while (tempHead) {
        if (tempHead == head) {
            next = tempHead->next;
            tempHead ->next = NULL;
            pre = tempHead;
        } else {
            next = tempHead->next;
            tempHead -> next = pre;
            pre = tempHead;
        }
        tempHead = next;
    }
    return pre;
}

@end
