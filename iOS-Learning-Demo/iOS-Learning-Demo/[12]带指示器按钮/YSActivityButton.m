//
//  YSActivityButton.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/18.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSActivityButton.h"

@interface YSActivityButton()

@property (nonatomic,strong) UILabel *nTitleLabel;

@property(nonatomic,strong)  UIActivityIndicatorView *indicator;

@end

@implementation YSActivityButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _nTitleLabel = [[UILabel alloc] initWithFrame:self.titleLabel.frame];
        _nTitleLabel.textAlignment = NSTextAlignmentCenter;
        _nTitleLabel.backgroundColor = [UIColor greenColor];
        
        [self.titleLabel addSubview:_nTitleLabel];
        [self.titleLabel addSubview:self.indicator];
        
        [self.titleLabel addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
        [self.titleLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self.titleLabel addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark - *********** Event ***********

- (void)startAnimation{
    self.userInteractionEnabled = NO;
    [self.indicator startAnimating];
}

- (void)stopAnimation{
    self.userInteractionEnabled = YES;
    [self.indicator stopAnimating];
}

#pragma mark - *********** KVO ***********

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    
    if ([keyPath isEqualToString:@"text"]) {
        [_nTitleLabel setText:change[NSKeyValueChangeNewKey]];
    }else if ([keyPath isEqualToString:@"textColor"]){
        [_nTitleLabel setTextColor:change[NSKeyValueChangeNewKey]];
    }else if ([keyPath isEqualToString:@"font"]){
        [_nTitleLabel setFont:change[NSKeyValueChangeNewKey]];
    }
    _indicator.right = (_nTitleLabel.left - 12);
}

- (UIActivityIndicatorView *)indicator{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator.frame = CGRectMake(0, 0, 20, 20);
        CGAffineTransform transform = CGAffineTransformMakeScale(.8f, .8f);
        _indicator.transform = transform;
    }
    return _indicator;
}

@end
