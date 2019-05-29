//
//  InputValidator.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InputValidator : YSBaseModel

/**
 错误信息
 */
@property (nonatomic,copy) NSString *errorMessage;

/**
 抽象策略
 @param input 当前输入textField
 @return 输入验证是否合法
 */
- (BOOL)validateInput:(UITextField *)input;

@end

NS_ASSUME_NONNULL_END
