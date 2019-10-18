//
//  YSProtocol.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/10/18.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSImagePickModel.h"

typedef void(^YSImageCellAddItemBlock)(YSImagePickModel *pickModel,NSInteger index);
typedef void(^YSImageCellRemoveItemBlock)(YSImagePickInfo *pickInfo,NSInteger index);
