//
//  ViewModelProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)initialize;

@end
