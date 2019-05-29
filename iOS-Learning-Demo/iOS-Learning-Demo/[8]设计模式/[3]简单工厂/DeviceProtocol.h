//
//  DeviceProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DeviceProtocol <NSObject>

/**
 *  打电话
 */
- (void)phoneCall;

/**
 *  系统信息
 *
 *  @return 返回系统描述信息
 */
- (NSString *)systemInfomation;

@end

NS_ASSUME_NONNULL_END
