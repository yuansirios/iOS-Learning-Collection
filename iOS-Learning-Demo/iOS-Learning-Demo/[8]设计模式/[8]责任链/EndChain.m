//
//  EndChain.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "EndChain.h"

@interface EndChain ()

@property (nonatomic, weak) id <ChainOfResponsibilityProtocol> nextSuccessor;

@end

@implementation EndChain

- (void)setSuccessor:(id <ChainOfResponsibilityProtocol>)successor {
    
    self.nextSuccessor = successor;
}

- (id <ChainOfResponsibilityProtocol>)successor {
    
    return self.nextSuccessor;
}

- (void)handlerRequest:(id)request {
    
    NSLog(@"此任务没有责任链可以处理");
}
@end
