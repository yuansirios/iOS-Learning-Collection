//
//  MakeDarkerCommand.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "MakeDarkerCommand.h"

@interface MakeDarkerCommand ()

@property (nonatomic, weak) Receiver *receiver;
@property (nonatomic)       CGFloat   parameter;

@end

@implementation MakeDarkerCommand

- (id)initWithReceiver:(Receiver*)receiver parameter:(CGFloat)parameter {
    
    self = [super init];
    
    if (self) {
        
        _receiver  = receiver;
        _parameter = parameter;
    }
    
    return self;
}

- (void)execute {
    
    [self.receiver makeViewDarker:self.parameter];
}

@end
