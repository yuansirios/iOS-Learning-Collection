//
//  SubscriptionServiceCenter.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "SubscriptionServiceCenter.h"

static  NSMutableDictionary  *_subscriptionNumberDictionary = nil;

@implementation SubscriptionServiceCenter

#pragma mark - 初始化
+ (void)initialize {
    
    if (self == [SubscriptionServiceCenter class]) {
        
        _subscriptionNumberDictionary = [NSMutableDictionary dictionary];
    }
}

+ (void)createSubscriptionNumber:(NSString *)subscriptionNumber {
    
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    
    if (hashTable == nil) {
        hashTable = [NSHashTable weakObjectsHashTable];
        [_subscriptionNumberDictionary setObject:hashTable forKey:subscriptionNumber];
    }
}

+ (void)removeSubscriptionNumber:(NSString *)subscriptionNumber {
    
    NSParameterAssert(subscriptionNumber);
    
    if ([self existSubscriptionNumber:subscriptionNumber]) {
        
        [_subscriptionNumberDictionary removeObjectForKey:subscriptionNumber];
    }
}

+ (void)removeCustomer:(id <SubscriptionServiceCenterProtocol>)customer fromSubscriptionNumber:(NSString *)subscriptionNumber {
    
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    
    if (hashTable && customer) {
        [hashTable removeObject:customer];
    }
}

+ (void)sendMessage:(id)message toSubscriptionNumber:(NSString *)subscriptionNumber {
    
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    
    if (hashTable) {
        
        NSEnumerator *enumerator = [hashTable objectEnumerator];
        
        id <SubscriptionServiceCenterProtocol> customer = nil;
        while (customer = [enumerator nextObject]) {
            
            if ([customer respondsToSelector:@selector(subscriptionMessage:subscriptionNumber:)]) {
                [customer subscriptionMessage:message subscriptionNumber:subscriptionNumber];
            }
        }
    }
}

+ (void)addCustomer:(id)customer withSubscriptionNumber:(NSString *)subscriptionNumber {
    
    NSParameterAssert(customer);
    NSParameterAssert(subscriptionNumber);
    
    NSHashTable *hashTable = [self existSubscriptionNumber:subscriptionNumber];
    [hashTable addObject:customer];
}


#pragma mark - 私有方法
+ (NSHashTable *)existSubscriptionNumber:(NSString *)subscriptionNumber {
    
    return [_subscriptionNumberDictionary objectForKey:subscriptionNumber];
}

@end
