//
//  PwdInputViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan xiaodong on 2020/12/31.
//  Copyright © 2020 yuan. All rights reserved.
//

#import "PwdInputViewController.h"

@interface PwdInputViewController ()

@property (nonatomic, strong) UITextField *nameField;

@property (nonatomic, strong) UITextField *pwdField;

@end

@implementation PwdInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iOS 14密码输入九宫格问题";
    [self.view addSubview:self.nameField];
    [self.view addSubview:self.pwdField];
}

- (void)dismiss{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

- (UITextField *)nameField{
    if (!_nameField){
        UITextField *field = UITextField.new;
        field.backgroundColor = UIColor.greenColor;
        field.frame = CGRectMake(50, 100, 200, 50);
        field.placeholder = @"请输入昵称";
        _nameField = field;
    }
    return _nameField;
}

- (UITextField *)pwdField{
    if (!_pwdField){
        UITextField *field = UITextField.new;
        field.backgroundColor = UIColor.greenColor;
        field.frame = CGRectMake(50, self.nameField.bottom + 20, 200, 50);
        field.placeholder = @"请输入密码";
        field.secureTextEntry = YES;
        _pwdField = field;
    }
    return _pwdField;
}

@end
