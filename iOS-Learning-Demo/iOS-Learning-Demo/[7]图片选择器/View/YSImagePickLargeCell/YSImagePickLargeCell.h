//
//  YSImagePickLargeCell.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/4/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSImagePickModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^YSImagePickLargeCellRemoveBlock)(void);

@interface YSImagePickLargeCell : YSBaseCollectionViewCell

@property (nonatomic,copy) YSImagePickLargeCellRemoveBlock removeBlock;

@property (nonatomic,strong) YSImagePickInfo *infoModel;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIButton *removeButton;

@property (nonatomic,strong) UIView *failView;

@end

NS_ASSUME_NONNULL_END
