//
//  AbstractProxy.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/30.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <objc/runtime.h>
#import "AbstractProxy.h"
#import "AbstractExcute.h"

@implementation AbstractProxy

- (instancetype)initWithCustomer:(id)customer {
    
    self.customer = customer;
    return self;
}

#pragma mark - NSProxy

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if ([self.customer respondsToSelector:aSelector]) {
        
        return [self.customer methodSignatureForSelector:aSelector];
        
    } else {
        
        AbstractExcute *excute = [AbstractExcute shareInstance];
        return [excute methodSignatureForSelector:NSSelectorFromString(@"nullExcute:")];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    SEL selector = [invocation selector];
    if ([self.customer respondsToSelector:selector]) {
        
        [invocation setTarget:self.customer];
        [invocation invoke];
        
    } else {
        
        NSString *selectorString = NSStringFromSelector(invocation.selector);
        
        invocation.selector    = NSSelectorFromString(@"nullExcute:");
        AbstractExcute *excute = [AbstractExcute shareInstance];
        [invocation setTarget:excute];
        
        const char *className      = class_getName([self class]);
        NSArray    *classNameArray = nil;
        if (self.customer) {
            
            classNameArray = @[[NSString stringWithUTF8String:className], selectorString, @""];
            
        } else {
            
            classNameArray = @[[NSString stringWithUTF8String:className], selectorString];
        }
        
        [invocation setArgument:&classNameArray atIndex:2];
        [invocation invoke];
    }
}

@end
