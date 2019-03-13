//
//  YSPopView.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/3/13.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSPopView.h"

@interface YSPopView()

@property (nonatomic,strong) UIScrollView *contentView;

@end

@implementation YSPopView

- (void)addContentView {
    [self addSubview:self.contentView];
}

#pragma mark - *********** lazy ***********

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = UIScrollView.new;
        _contentView.backgroundColor = UIColor.whiteColor;
        _contentView.frame = CGRectMake(0, 300, self.width, 300);
        
        for (int i = 0; i < 10; i++) {
            UIView *view = UIView.new;
            [view setFrame:CGRectMake(0, i * 50, _contentView.width, 50)];
            view.backgroundColor = randomColor;
            [_contentView addSubview:view];
        }
        
        [_contentView setContentSize:CGSizeMake(_contentView.width, 50*10)];
    }
    return _contentView;
}

@end
