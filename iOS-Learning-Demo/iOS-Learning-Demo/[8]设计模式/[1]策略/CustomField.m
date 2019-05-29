//
//  CustomField.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "CustomField.h"

@interface CustomField ()

@property (nonatomic, strong) InputValidator  *inputValidator;

@end

@implementation CustomField

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame withInputValidator:(InputValidator *)inputValidator {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
        
        // 持有inputValidator
        self.inputValidator = inputValidator;
    }
    
    return self;
}

- (void)setup {
    
    UIView *leftView       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, self.frame.size.height)];
    self.leftView          = leftView;
    self.leftViewMode      = UITextFieldViewModeAlways;
    
    self.font = [UIFont fontWithName:@"Avenir-Book" size:12.f];
    
    self.layer.borderWidth = 0.5f;
}

- (BOOL)validate {
    return [self.inputValidator validateInput:self];
}

@end
