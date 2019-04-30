//
//  YSImagePicker.h
//  Demo
//
//  Created by yuan on 2018/12/19.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSImagePicker : NSObject

@property (nonatomic,weak) UIViewController *controller;

+ (instancetype)shareManager;

- (void)takePhoto:(void (^)(UIImage *img))imgBlock;
#pragma mark -- 打开相册
- (void)openAlbum:(NSInteger)maxImagesCount block:(void (^)(NSArray<UIImage *> *imgArray))imgBlock;
@end

NS_ASSUME_NONNULL_END
