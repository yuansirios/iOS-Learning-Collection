//
//  NCProxy.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/30.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "NCProxy.h"

@interface NCProxy ()

@property (nonatomic,strong)NSObject *object;

@end

@implementation NCProxy

- (id)transformToObject:(NSObject *)object
{
    self.object = object;
    return self.object;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *methodSignature;
    
    if (self.object) {
        methodSignature = [self.object methodSignatureForSelector:sel];
        
    }else{
        
        methodSignature = [super methodSignatureForSelector:sel];
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if (self.object) {
        [invocation setTarget:self.object];
        
        [invocation invoke];
    }
}

@end
