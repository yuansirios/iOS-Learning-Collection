//
//  CommandProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CommandProtocol <NSObject>

@required
/**
 *  执行指令
 */
- (void)execute;

@end

NS_ASSUME_NONNULL_END
