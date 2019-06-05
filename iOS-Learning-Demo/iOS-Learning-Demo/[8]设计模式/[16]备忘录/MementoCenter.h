//
//  MementoCenter.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MementoCenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MementoCenter : NSObject

/**
 *  存储备忘录对象
 *
 *  @param mementoObject 备忘录对象
 *  @param key           标记对象的键值
 */
+ (void)saveMementoObject:(id <MementoCenterProtocol>)mementoObject withKey:(NSString *)key;

/**
 *  获取备忘录对象
 *
 *  @param key 标记对象的键值
 *
 *  @return 备忘录对象
 */
+ (id)mementoObjectWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
