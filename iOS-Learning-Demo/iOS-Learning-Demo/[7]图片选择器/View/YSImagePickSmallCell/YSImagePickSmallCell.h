//
//  YSImagePickSmallCell.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/4/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSImagePickLargeCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^YSImagePickSmallCellRemoveBlock)(YSImagePickInfo *info);

@interface YSImagePickSmallCell : YSImagePickLargeCell

@property (nonatomic,copy) YSImagePickSmallCellRemoveBlock smallRemoveBlock;

@end

NS_ASSUME_NONNULL_END
