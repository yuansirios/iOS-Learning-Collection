//
//  ControllerProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewModelProtocol;

@protocol ControllerProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <ViewModelProtocol>)viewModel;
/*
 * 初始化UI控件
 */
- (void)addSubviews;
/*
 * 初始化RAC
 */
- (void)racViewModel;
/*
 * 初始化导航栏
 */
- (void)layoutNavigation;

@end
