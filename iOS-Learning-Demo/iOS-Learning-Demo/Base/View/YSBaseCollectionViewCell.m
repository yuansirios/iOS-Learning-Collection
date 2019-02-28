//
//  YSBaseCollectionViewCell.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseCollectionViewCell.h"

@implementation YSBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setupViews];
    }
    return self;
}

- (void)setupViews{}

- (void)dealloc{
    NSLog(@"YSBaseCollectionViewCell -- %@ -- 正常销毁",NSStringFromClass([self class]));
}

@end
