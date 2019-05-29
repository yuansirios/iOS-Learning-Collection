//
//  YSImagePickModel.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/4/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    YSImagePickType_large   = 1 << 0,
    YSImagePickType_small   = 1 << 1,
} YSImagePickType;

@interface YSImagePickInfo : YSBaseModel

@property (nonatomic,copy) UIImage *normalImage;            // 默认图片 image
@property (nonatomic,copy,nullable) UIImage *selectImage;   // 选择的图片 image
@property (nonatomic,copy) NSString *desc;                  // 描述

@property (nonatomic,assign) BOOL isFirst;                  // 第一个按钮
@property (nonatomic,assign) BOOL isUploadFailer;           // 是否上传成功

@end

@interface YSImagePickModel : YSBaseModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) YSImagePickType type; // 显示样式
@property (nonatomic,assign) BOOL onlyTakePhoto;   // 只允许拍照
@property (nonatomic,assign) BOOL canSelectMore;     // 允许多张
@property (nonatomic,strong) NSMutableArray <YSImagePickInfo *> *dataArray;

@end

NS_ASSUME_NONNULL_END
