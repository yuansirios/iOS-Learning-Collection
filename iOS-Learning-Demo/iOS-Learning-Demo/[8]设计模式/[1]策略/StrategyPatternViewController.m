//
//  StrategyPatternViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//
/*
 1. 把解决相同问题的算法抽象成策略(相同问题指的是输入参数相同,但根据算法不同输出参数会有差异)
 2. 策略被封装在对象之中(是对象内容的一部分),策略改变的是对象的内容.
 如果从外部扩展了对象的行为,就不叫策略模式,而是装饰模式.
 3. 策略模式可以简化复杂的判断逻辑(if - else)
 4. 如果对面向对象基本原理以及设计模式基本原理不熟悉,本教程会变得难以理解.
 */

#import "StrategyPatternViewController.h"
#import "CustomField.h"
#import "EmailValidator.h"
#import "PhoneNumValidator.h"

@interface StrategyPatternViewController ()<UITextFieldDelegate>{
    CustomField *_emailField;
    CustomField *_phoneField;
}

@end

@implementation StrategyPatternViewController

- (void)addSubviews {
    [super addSubviews];
    
    self.title = @"策略模式";
    
    CustomField *emailField = [[CustomField alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH - 20*2, 40) withInputValidator:EmailValidator.new];
    emailField.placeholder = @"请输入邮箱";
    emailField.delegate = self;
    _emailField = emailField;
    
    CustomField *phoneField = [[CustomField alloc]initWithFrame:CGRectMake(20, emailField.bottom + 20, SCREEN_WIDTH - 20*2, 40) withInputValidator:PhoneNumValidator.new];
    phoneField.placeholder = @"请输入手机号";
    phoneField.delegate = self;
    _phoneField = phoneField;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, phoneField.bottom + 20, phoneField.width, 40)];
    btn.backgroundColor = UIColorRandom;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(makeValidate) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:emailField];
    [self.view addSubview:phoneField];
    [self.view addSubview:btn];
}

- (void)makeValidate{
    [self.view endEditing:YES];
    
    if (_emailField.validate == NO) {
        [[[UIAlertView alloc]initWithTitle:@"验证失败" message:_emailField.inputValidator.errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
    } else if (_phoneField.validate == NO) {
        [[[UIAlertView alloc]initWithTitle:@"验证失败" message:_phoneField.inputValidator.errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
    } else {
        
    }
}

@end
