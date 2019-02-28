//
//  ViewProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewModelProtocol;

@protocol ViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id<ViewModelProtocol>)viewModel;
/**
 * 初始化UI控件
 */
- (void)setupViews;
/**
 * 初始化RAC
 */
- (void)racViewModel;

@end
