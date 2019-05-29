//
//  EmailValidator.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "EmailValidator.h"

@implementation EmailValidator

- (BOOL)validateInput:(UITextField *)input{
    if (input.text.length == 0) {
        self.errorMessage = @"请输入邮箱";
        return NO;
    }
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if([emailTest evaluateWithObject:input.text]){
        return YES;
    }else{
        self.errorMessage = @"邮箱格式不正确";
        return NO;
    }
}

@end
