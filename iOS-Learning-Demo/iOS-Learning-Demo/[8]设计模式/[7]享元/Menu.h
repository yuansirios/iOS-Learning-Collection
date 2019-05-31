//
//  Menu.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/30.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoffeeFlavor.h"

NS_ASSUME_NONNULL_BEGIN

@interface Menu : NSObject

/**
 *  获取指定味道的咖啡（如果没有则创建）
 *
 *  @param flavor 味道
 *
 *  @return 指定味道的咖啡
 */
- (CoffeeFlavor *)lookupWithFlavor:(NSString *)flavor;

@end

NS_ASSUME_NONNULL_END
