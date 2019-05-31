//
//  ElementA.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElementProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ElementA : NSObject <ElementProtocol>

/**
 *  元素A特有的操作
 */
- (void)elementASpecialOperationA;

@end

NS_ASSUME_NONNULL_END
