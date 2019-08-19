//
//  YSImagePickLargeCell.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/4/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSImagePickLargeCell.h"

@implementation YSImagePickLargeCell

- (void)setupViews{
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.failView];
    [self.contentView addSubview:self.removeButton];
    
    self.imageView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 5, 5, 5));
    
    self.failView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 5, 5, 5));
    
    self.removeButton.sd_layout
    .topSpaceToView(self.contentView, -1)
    .rightSpaceToView(self.contentView,-1)
    .widthIs(24)
    .heightIs(24);
}

#pragma mark - *********** Private ***********

- (void)setInfoModel:(YSImagePickInfo *)infoModel{
    _infoModel = infoModel;
    if (infoModel.selectImage) {
        self.removeButton.hidden = NO;
        self.imageView.image = infoModel.selectImage;
        
    }else{
        self.removeButton.hidden = YES;
        self.imageView.image = infoModel.normalImage;
    }
    
    if (infoModel.isUploadFailer) {
        self.failView.hidden = NO;
    }else{
        self.failView.hidden = YES;
    }
}

- (void)removeImage{
    if (_removeBlock) {
        _removeBlock();
    }
}

#pragma mark - *********** lazy ***********

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.contentMode = UIViewContentModeRedraw;
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 6;
    }
    return _imageView;
}

- (UIButton *)removeButton{
    if (!_removeButton) {
        _removeButton = UIButton.new;
        [_removeButton setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_removeButton addTarget:self action:@selector(removeImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeButton;
}

- (UIView *)failView{
    if (!_failView) {
        _failView = UIView.new;
        _failView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:.4];
        _failView.tag = 10000;
        _failView.userInteractionEnabled = NO;
        _failView.layer.masksToBounds = YES;
        _failView.layer.cornerRadius = 6;
        
        UIImageView *icon = UIImageView.new;
        icon.image = [UIImage imageNamed:@"提交失败"];
        [_failView addSubview:icon];
        
        icon.sd_layout
        .widthIs(20)
        .heightIs(20)
        .centerYEqualToView(_failView)
        .centerXEqualToView(_failView);
    }
    return _failView;
}

@end
