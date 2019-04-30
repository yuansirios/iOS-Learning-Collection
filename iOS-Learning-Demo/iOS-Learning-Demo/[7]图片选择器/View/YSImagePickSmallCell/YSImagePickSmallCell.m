//
//  YSImagePickSmallCell.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/4/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSImagePickSmallCell.h"

@interface YSImagePickSmallCell(){
    
}

@property (nonatomic,strong) UIView *takePhotoView;

@end

@implementation YSImagePickSmallCell

- (void)setupViews{
    [super setupViews];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 6;
    self.contentView.backgroundColor = UIColor_9B;
    [self.contentView addSubview:self.takePhotoView];
    self.takePhotoView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark - *********** Private ***********

- (void)setInfoModel:(YSImagePickInfo *)infoModel{
    [super setInfoModel:infoModel];
    
    if (infoModel.isFirst) {
        self.imageView.hidden = YES;
        self.removeButton.hidden = YES;
        self.takePhotoView.hidden = NO;
    }else{
        self.imageView.hidden = NO;
        self.takePhotoView.hidden = YES;
        if (infoModel.selectImage) {
            self.removeButton.hidden = NO;
            self.imageView.image = infoModel.selectImage;
        }else{
            self.takePhotoView.hidden = NO;
            self.removeButton.hidden = YES;
            self.imageView.image = infoModel.normalImage;
        }
    }
    
    UILabel *lable = [self.takePhotoView viewWithTag:1000];
    lable.text = infoModel.desc;
}

- (void)removeImage{
    if (_smallRemoveBlock) {
        _smallRemoveBlock(self.infoModel);
    }
}

#pragma mark - *********** Lazy ***********

- (UIView *)takePhotoView{
    if (!_takePhotoView) {
        _takePhotoView = UIView.new;
        {
            UIImageView *img = UIImageView.new;
            img.image = [UIImage imageNamed:@"相机"];
            [_takePhotoView addSubview:img];
            
            img.sd_layout.widthIs(38)
            .heightIs(30)
            .centerXEqualToView(_takePhotoView)
            .centerYEqualToView(_takePhotoView).offset(-10);
        }
        {
            UILabel *label = UILabel.new;
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = UIColor.whiteColor;
            label.tag = 1000;
            label.textAlignment = NSTextAlignmentCenter;
            [_takePhotoView addSubview:label];
            
            label.sd_layout.widthIs(self.contentView.width_sd)
            .heightIs(30)
            .centerXEqualToView(_takePhotoView)
            .centerYEqualToView(_takePhotoView).offset(20);
        }
    }
    return _takePhotoView;
}

@end
