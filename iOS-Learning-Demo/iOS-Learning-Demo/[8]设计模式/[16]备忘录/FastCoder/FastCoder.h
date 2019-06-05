//
//  FastCoder.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const FastCodingException;

@interface NSObject (FastCoding)

+ (NSArray *)fastCodingKeys;
- (id)awakeAfterFastCoding;
- (Class)classForFastCoding;
- (BOOL)preferFastCoding;

@end


@interface FastCoder : NSObject

+ (id)objectWithData:(NSData *)data;
+ (id)propertyListWithData:(NSData *)data;
+ (NSData *)dataWithRootObject:(id)object;

@end

NS_ASSUME_NONNULL_END
