//
//  TextFieldMediator.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextFieldMediator : NSObject <UITextFieldDelegate>

@property (nonatomic, weak) UITextField  *textField_1;
@property (nonatomic, weak) UITextField  *textField_2;
@property (nonatomic, weak) UITextField  *textField_3;

@end

NS_ASSUME_NONNULL_END
