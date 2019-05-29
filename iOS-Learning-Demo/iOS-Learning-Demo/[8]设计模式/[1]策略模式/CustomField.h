//
//  CustomField.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputValidator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomField : UITextField

/**
 初始化textField

 @param inputValidator 验证策略 是对象的一部分，修改的是对象的内容
 @return 示例对象
 */
- (instancetype)initWithFrame:(CGRect)frame withInputValidator:(InputValidator *)inputValidator;

- (BOOL)validate;

@end

NS_ASSUME_NONNULL_END
