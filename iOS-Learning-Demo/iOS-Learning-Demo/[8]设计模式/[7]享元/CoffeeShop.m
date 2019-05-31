//
//  CoffeeShop.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/30.
//  Copyright © 2019 yuan. All rights reserved.
//
/*
 享元模式使用共享物件，用来尽可能减少内存使用量以及分享资讯给尽可能多的相似物件；
 它适合用于只是因重复而导致使用无法令人接受的大量内存的大量物件。
 通常物件中的部分状态是可以分享。
 常见做法是把它们放在外部数据结构，当需要使用时再将它们传递给享元。
 */

#import "CoffeeShop.h"
#import "CoffeeFlavor.h"
#import "Menu.h"

@interface CoffeeShop ()

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, CoffeeFlavor *>  *orders;
@property (nonatomic, strong) Menu *menu;

@end

@implementation CoffeeShop

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.orders = [NSMutableDictionary dictionary];
        self.menu   = [[Menu alloc] init];
    }
    
    return self;
}

- (void)takeOrder:(NSString *)flavor table:(int)table {
    
    [self.orders setObject:[self.menu lookupWithFlavor:flavor]
                    forKey:@(table)];
}

- (void)serve {
    
    NSArray *allKeys = self.orders.allKeys;
    
    for (id key in allKeys) {
        
        NSLog(@"[%@] Serving %@ to table %@", [self.orders objectForKey:key], [self.orders objectForKey:key].flavor, key);
    }
}

@end
