//
//  YSBaseModel.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseModel.h"
#include <objc/runtime.h>

@implementation YSBaseModel

- (NSString *)debugDescription{
    return [self description];
}

- (NSString *)description{
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSNumber class]] || [self isKindOfClass:[NSString class]])
    {
        return self.debugDescription;
    }
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";
        [dictionary setObject:value forKey:name];
    }
    free(properties);
    return [NSString stringWithFormat:@"<%@: %p> -- %@", [self class], self, dictionary];
}

- (void)dealloc{
    NSLog(@"YSBaseModel -- %@ -- 正常销毁",NSStringFromClass([self class]));
}

@end
