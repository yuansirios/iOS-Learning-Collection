//
//  EmailChain.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "EmailChain.h"

#import "RegExCategories.h"

@interface EmailChain ()

@property (nonatomic, weak) id <ChainOfResponsibilityProtocol> nextSuccessor;

@end

@implementation EmailChain

- (void)setSuccessor:(id <ChainOfResponsibilityProtocol>)successor {
    
    self.nextSuccessor = successor;
}

- (id <ChainOfResponsibilityProtocol>)successor {
    
    return self.nextSuccessor;
}

- (void)handlerRequest:(id)request {
    
    NSString *string = request;
    
    if ([string isKindOfClass:[NSString class]] && string.length) {
        
        // 匹配邮箱
        BOOL isMatch = [string isMatch:RX(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")];
        
        if (isMatch) {
            
            NSLog(@"%@ 是邮箱", string);
            
        } else {
            
            [self.successor handlerRequest:request];
        }
    }
}

@end
