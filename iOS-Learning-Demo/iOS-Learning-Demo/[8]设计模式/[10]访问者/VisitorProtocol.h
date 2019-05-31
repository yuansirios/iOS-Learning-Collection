//
//  VisitorProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElementProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VisitorProtocol <NSObject>

- (void)visitElement:(id <ElementProtocol>)element;

@end

NS_ASSUME_NONNULL_END
