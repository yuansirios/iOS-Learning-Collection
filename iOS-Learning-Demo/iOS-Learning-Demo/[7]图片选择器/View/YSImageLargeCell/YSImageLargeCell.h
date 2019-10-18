//
//  YSImageLargeCell.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/10/17.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseTableViewCell.h"
#import "YSImagePickModel.h"
#import "YSProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YSImageLargeCell : YSBaseTableViewCell

@property (nonatomic,strong) YSImagePickModel *pickModel;

@property (nonatomic,copy) YSImageCellAddItemBlock addItemBlock;
@property (nonatomic,copy) YSImageCellRemoveItemBlock removeItemBlock;

@end

NS_ASSUME_NONNULL_END
