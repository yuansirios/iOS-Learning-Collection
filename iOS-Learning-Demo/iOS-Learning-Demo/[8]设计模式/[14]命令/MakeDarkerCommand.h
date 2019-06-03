//
//  MakeDarkerCommand.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandProtocol.h"
#import "Receiver.h"

NS_ASSUME_NONNULL_BEGIN

@interface MakeDarkerCommand : NSObject <CommandProtocol>

- (id)initWithReceiver:(Receiver*)receiver parameter:(CGFloat)parameter;

@end

NS_ASSUME_NONNULL_END
