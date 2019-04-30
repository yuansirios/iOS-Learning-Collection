//
//  YSImagePicker.m
//  Demo
//
//  Created by yuan on 2018/12/19.
//  Copyright © 2018年 yuansirios. All rights reserved.
//

#import "YSImagePicker.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <TZImagePickerController/TZImagePickerController.h>

typedef void(^takePhotoBlock)(UIImage *img);

@interface YSImagePicker()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,TZImagePickerControllerDelegate>{
    takePhotoBlock _takePhotoBlock;
}

@end

@implementation YSImagePicker

static YSImagePicker *_instance;

+ (instancetype)shareManager{
    return [[self alloc]init];
}

- (void)dealloc{
    NSLog(@"YSImagePicker 释放了");
}

- (BOOL)takePhotoAuth{
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return NO;
    }else{
        return YES;
    }
}

// 打开相机
- (void)takePhoto:(void (^)(UIImage *img))imgBlock{
    _takePhotoBlock = imgBlock;
    if ([self takePhotoAuth]){
        // 用户开放相机权限后 判断相机是否可用
        BOOL useable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (!useable) {
            NSLog(@"相机不可用");
            if (imgBlock) {
                imgBlock(createImageWithColor(UIColorRandom, 50, 50));
            }
            return;
        }
        UIImagePickerController *photoPicker = [UIImagePickerController new];
        photoPicker.delegate = self;
        photoPicker.allowsEditing = NO;
        photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.controller presentViewController:photoPicker animated:YES completion:nil];
    }else{
        [self guideUserOpenAuth];
    }
}
//打开相册
- (void)openAlbum:(NSInteger)maxImagesCount block:(void (^)(NSArray<UIImage *> *imgArray))imgBlock{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxImagesCount delegate:self];
    [self.controller presentViewController:imagePickerVc animated:YES completion:nil];
    @weakify(self)
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        @strongify(self)
        NSLog(@"photos -- %@",photos);
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        if (photos.count > 0) {
            for (int i=0; i<photos.count; i++) {
                UIImage *photoImage = photos[i];
                if (photoImage != nil) {
                    [tempArray addObject:[self compressPictureWith:photoImage]];
                }
            }
            if (imgBlock) {
                imgBlock(tempArray);
            }
        }
    }];
}
- (void)guideUserOpenAuth{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请打开相机访问权限" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {

            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alertC addAction:alertA];
    [alertC addAction:act];
    [self.controller presentViewController:alertC animated:YES completion:nil];
    if(_takePhotoBlock)_takePhotoBlock(nil);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    UIImage * image;
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        // 压缩图片
        image = [self compressPictureWith:image];
    }
    
    [self.controller dismissViewControllerAnimated:YES completion:nil];
    
    if (_takePhotoBlock) {
        _takePhotoBlock(image);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    _takePhotoBlock(nil);
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

// 压缩图片
- (UIImage *)compressPictureWith:(UIImage *)originnalImage{
    CGFloat ruleWidth = 600;
    if (originnalImage.size.width < ruleWidth) {
        return originnalImage;
    }
    
    CGFloat hight = ruleWidth/originnalImage.size.width * originnalImage.size.height;
    CGRect rect = CGRectMake(0, 0, ruleWidth, hight);
    // 开启图片上下文
    UIGraphicsBeginImageContext(rect.size);
    // 将图片渲染到图片上下文
    [originnalImage drawInRect:rect];
    // 获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    return img;
}

@end
