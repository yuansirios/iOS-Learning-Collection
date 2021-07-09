//
//  NSObject+YSLeaksTest.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/11/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "NSObject+YSSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject (YSSwizzling)

- (void)willDealloc{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            NSLog(@"⚠️内存泄漏啦^^ --- %@",strongSelf);
        }
    });
}

+ (void)swizzleSEL:(SEL)originSEL withSEL:(SEL)swizzlingSEL{
    Class class = [self class];
    Method originMethod = class_getInstanceMethod(class, originSEL);
    Method currentMethod = class_getInstanceMethod(class, swizzlingSEL);
    
    BOOL didAddMethod = class_addMethod(class, originSEL, method_getImplementation(currentMethod), method_getTypeEncoding(currentMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzlingSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, currentMethod);
    }
}

@end
