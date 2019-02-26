//
//  SDTabelViewCell.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/26.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "SDTabelViewCell.h"

@interface SDTabelViewCell()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation SDTabelViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.contentView, 20)
    .widthRatioToView(self.contentView, .5)
    .autoHeightRatio(0);
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self.titleLabel setText:title];
    [self setupAutoHeightWithBottomView:self.titleLabel bottomMargin:20];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        [_titleLabel setFont:[UIFont systemFontOfSize:20]];
        _titleLabel.backgroundColor = randomColor;
    }
    return _titleLabel;
}

@end
