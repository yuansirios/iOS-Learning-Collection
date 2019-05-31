//
//  Visitor.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ElementA.h"
#import "ElementB.h"
#import "VisitorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Visitor : NSObject <VisitorProtocol>

@end

NS_ASSUME_NONNULL_END
