//
//  NCProxy.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/30.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NCProxy : NSProxy

- (id)transformToObject:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END
