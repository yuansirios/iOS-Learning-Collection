//
//  ElementCollection.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ElementProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface ElementCollection : NSObject

/**
 *  添加元素
 *
 *  @param element 元素
 *  @param key     元素的键值
 */
- (void)addElement:(id <ElementProtocol>)element withKey:(NSString *)key;

/**
 *  获取所有元素的键值
 *
 *  @return 所有元素的键值
 */
- (NSArray *)allKeys;

/**
 *  根据元素键值获取元素
 *
 *  @param key 元素的键值
 *
 *  @return 元素
 */
- (id <ElementProtocol>)elementWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
