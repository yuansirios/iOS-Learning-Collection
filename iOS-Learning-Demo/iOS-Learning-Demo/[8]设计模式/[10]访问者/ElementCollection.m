//
//  ElementCollection.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ElementCollection.h"
#import "ElementProtocol.h"

@interface ElementCollection ()

@property (nonatomic, strong) NSMutableDictionary  *elementsDictionary;

@end

@implementation ElementCollection

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.elementsDictionary = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)addElement:(id <ElementProtocol>)element withKey:(NSString *)key {
    
    NSParameterAssert(element);
    NSParameterAssert(key);
    
    [self.elementsDictionary setObject:element forKey:key];
}

- (NSArray *)allKeys {
    
    return self.elementsDictionary.allKeys;
}

- (id <ElementProtocol>)elementWithKey:(NSString *)key {
    
    NSParameterAssert(key);
    
    return [self.elementsDictionary objectForKey:key];
}

@end
