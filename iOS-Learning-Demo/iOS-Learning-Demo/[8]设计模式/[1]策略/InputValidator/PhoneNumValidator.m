//
//  PhoneNumValidator.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "PhoneNumValidator.h"

@implementation PhoneNumValidator

- (BOOL)validateInput:(UITextField *)input{
    if (input.text.length == 0) {
        self.errorMessage = @"请输入手机号";
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if([emailTest evaluateWithObject:input.text]){
        return YES;
    }else{
        self.errorMessage = @"手机号格式不正确";
        return NO;
    }
}

@end
