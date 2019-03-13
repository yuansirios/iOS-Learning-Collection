//
//  YSBasePopView.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/3/13.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBasePopView.h"

@interface YSBasePopView()

@property (nonatomic,strong) UIView *backMaskView;
@property (nonatomic,strong) UIView *contentView;

@end

@implementation YSBasePopView

#define UIColorPopBG [UIColorFromRGB(0x1F2E4A) colorWithAlphaComponent:.6]

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backMaskView];
        
        [self addContentView];
        
        self.hidden = YES;
    }
    return self;
}

#pragma mark - *********** event ***********

- (void)addContentView{
    [self addSubview:self.contentView];
}

#pragma mark - *********** show & dismiss ***********

- (void)showInView:(UIView *)view{
    [view addSubview:self];
    self.contentView.top = self.height;
    self.hidden = NO;
    [UIView animateWithDuration:.3 animations:^{
        self.backMaskView.alpha = 1;
        self.contentView.top = self.height - self.contentView.height;
    } completion:^(BOOL finished) {
        if (self.didShowBlock) {
            self.didShowBlock();
        }
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:.3 animations:^{
        self.backMaskView.alpha = 0;
        self.contentView.top = self.height;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (self.didDismissBlock) {
            self.didDismissBlock();
        }
    }];
}

#pragma mark - *********** lazy ***********

- (UIView *)backMaskView{
    if (!_backMaskView) {
        _backMaskView = UIView.new;
        _backMaskView.frame = self.bounds;
        _backMaskView.backgroundColor = UIColorPopBG;
        _backMaskView.alpha = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [_backMaskView addGestureRecognizer:tap];
    }
    return _backMaskView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 200)];
        _contentView.backgroundColor = UIColor.whiteColor;
        
        UILabel *label = UILabel.new;
        label.text = @"我是一个PopView \n自定义需要重写addContentView方法";
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [label sizeToFit];
        label.center = _contentView.center;
        [_contentView addSubview:label];
    }
    return _contentView;
}

@end
