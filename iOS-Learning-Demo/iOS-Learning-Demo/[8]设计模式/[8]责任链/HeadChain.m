//
//  HeadChain.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "HeadChain.h"

@interface HeadChain ()

@property (nonatomic, weak) id <ChainOfResponsibilityProtocol> nextSuccessor;

@end

@implementation HeadChain

- (void)setSuccessor:(id <ChainOfResponsibilityProtocol>)successor {
    
    self.nextSuccessor = successor;
}

- (id <ChainOfResponsibilityProtocol>)successor {
    
    return self.nextSuccessor;
}

- (void)handlerRequest:(id)request {
    
    [self.successor handlerRequest:request];
}

@end
