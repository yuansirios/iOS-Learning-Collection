//
//  YSBaseView.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseView.h"

@implementation YSBaseView

- (instancetype)init{
    if (self = [super init]) {
        [self racViewModel];
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<ViewModelProtocol>)viewModel{
    if (self = [super init]) {
        [self racViewModel];
        [self setupViews];
    }
    return self;
}

- (void)bindViewModel{}

- (void)setupViews{}

- (void)dealloc{
    NSLog(@"YSBaseView -- %@ -- 正常销毁",NSStringFromClass([self class]));
}

@end
