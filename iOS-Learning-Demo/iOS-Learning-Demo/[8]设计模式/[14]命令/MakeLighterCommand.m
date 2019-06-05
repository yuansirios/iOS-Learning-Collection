//
//  MakeLighterCommand.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "MakeLighterCommand.h"

@interface MakeLighterCommand ()

@property (nonatomic, weak) Receiver *receiver;
@property (nonatomic)       CGFloat   parameter;

@end

@implementation MakeLighterCommand

- (id)initWithReceiver:(Receiver*)receiver parameter:(CGFloat)parameter {
    
    self = [super init];
    
    if (self) {
        
        _receiver  = receiver;
        _parameter = parameter;
    }
    
    return self;
}

- (void)execute {
    
    [self.receiver makeViewLighter:self.parameter];
}

@end
