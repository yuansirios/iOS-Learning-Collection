//
//  ConcreteProxy.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/30.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "AbstractProxy.h"
#import "MessageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConcreteProxy : AbstractProxy<MessageProtocol>

@end

NS_ASSUME_NONNULL_END
