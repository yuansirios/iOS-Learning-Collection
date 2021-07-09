//
//  NSObject+CrashHandle.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/11/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "NSObject+CrashHandle.h"

@implementation NSObject (CrashHandle)

//未处理的消息
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"⚠️%@类-%@方法未实现",NSStringFromClass([anInvocation.target class]),NSStringFromSelector(anInvocation.selector));
}

//未处理的消息
+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"⚠️%@类+%@方法未实现",anInvocation.target,NSStringFromSelector(anInvocation.selector));
}

@end
