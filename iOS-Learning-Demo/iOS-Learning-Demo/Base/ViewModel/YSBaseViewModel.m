//
//  YSBaseViewModel.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseViewModel.h"

@implementation YSBaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    YSBaseViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    if (self = [super init]) {
    }
    return self;
}

- (void)initialize{
    
}

@end
