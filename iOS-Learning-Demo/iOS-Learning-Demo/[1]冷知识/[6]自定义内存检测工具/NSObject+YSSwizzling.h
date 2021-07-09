//
//  NSObject+YSLeaksTest.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/11/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YSSwizzling)

- (void)willDealloc;

+ (void)swizzleSEL:(SEL)originSEL withSEL:(SEL)swizzlingSEL;

@end

NS_ASSUME_NONNULL_END
