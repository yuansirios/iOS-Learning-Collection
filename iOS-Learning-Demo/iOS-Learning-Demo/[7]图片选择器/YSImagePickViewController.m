//
//  YSImagePickViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/4/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSImagePickViewController.h"
#import "YSImagePickLargeCell.h"
#import "YSImagePickSmallCell.h"
#import "YSImagePickModel.h"
#import "YSImagePicker.h"

@interface YSImagePickViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate>{
    YSImagePicker    *_picker;
    YSImagePickModel *_tempModel;
    YSImagePickInfo  *_tempInfo;
}

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *confirmView;

@property (nonatomic,strong) NSMutableArray *dataArray;

//网约车驾驶员证
@property (nonatomic,strong) NSMutableArray *driveImageArr;     //驾驶员证件
@property (nonatomic,strong) NSMutableArray *driveFailImgArr;
@property (nonatomic,strong) NSMutableArray *driveUploadUrlArr;

//合同资料
@property (nonatomic,strong) NSMutableArray *signImageArr;  //合同视图
@property (nonatomic,strong) NSMutableArray *signFailImgArr;
@property (nonatomic,strong) NSMutableArray *signUploadUrlArr;

//其他资料
@property (nonatomic,strong) NSMutableArray *otherImageArr;     //其他资料
@property (nonatomic,strong) NSMutableArray *otherFailImgArr;
@property (nonatomic,strong) NSMutableArray *otherUploadUrlArr;

@end

@implementation YSImagePickViewController

- (void)addSubviews {
    self.title = @"图片选择器";
    self.view.backgroundColor = UIColor_F8;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.confirmView];
    
    self.confirmView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(90)
    .bottomSpaceToView(self.view, SafeAreaBottomHeight);
    
    self.collectionView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(self.view.height_sd - 90 - SafeAreaBottomHeight - SafeAreaTopHeight);
}

#pragma mark - *********** UICollectionViewDataSource ***********

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    YSImagePickModel *model = self.dataArray[section];
    return model.dataArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionViewHead" forIndexPath:indexPath];
        //添加头视图的内容
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        YSImagePickModel *model = self.dataArray[indexPath.section];
        
        UILabel*titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
        titleLabel.text = model.title;
        [view addSubview:titleLabel];
        
        [header addSubview:view];
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    YSImagePickModel *model = self.dataArray[indexPath.section];
    if (model.type == YSImagePickType_large) {
        return CGSizeMake((SCREEN_WIDTH - 12*3)/2,100);
    }
    return CGSizeMake((SCREEN_WIDTH - 12*5)/4,80);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YSImagePickModel *model = self.dataArray[indexPath.section];
    YSImagePickInfo *info = model.dataArray[indexPath.row];
    
    if (indexPath.section == 0) {
        YSImagePickLargeCell *cell = (YSImagePickLargeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YSImagePickLargeCell" forIndexPath:indexPath];
        [cell setRemoveBlock:^{
            info.selectImage = nil;
            info.isUploadFailer = nil;
            [self reload];
        }];
        cell.infoModel = info;
        return cell;
    }else{
        YSImagePickSmallCell *cell = (YSImagePickSmallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YSImagePickSmallCell" forIndexPath:indexPath];
        [cell setSmallRemoveBlock:^(YSImagePickInfo * _Nonnull info) {
            if (indexPath.section == 1) {
                [model.dataArray removeObject:info];
            }else{
                info.selectImage = nil;
                info.isUploadFailer = nil;
            }
            [self reload];
        }];
        cell.infoModel = info;
        return cell;
    }
    return nil;
}

- (id)sourceObjAtIdx:(NSInteger)index section:(NSInteger)section{
    YSImagePickLargeCell *cell = (YSImagePickLargeCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
    return cell ? cell.imageView : nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YSImagePickModel *model = self.dataArray[indexPath.section];
    YSImagePickInfo *info = model.dataArray[indexPath.row];
    
    _tempModel = model;
    _tempInfo  = info;
    
    //只允许拍照
    if (model.onlyTakePhoto) {
        if (info.selectImage) {
            //获取图像源视图
            [self pickModel:model section:indexPath.section];
            [self showLargeImageDetail:indexPath];
        }else{
            [self onlyTakePhoto:model pickInfo:info];
        }
    } else {
        //拍照和选择
        if (info.selectImage) {
            //获取图像源视图
            [self pickModel:model section:indexPath.section];
            [self showLargeImageDetail:indexPath];
        }else{
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册选择",nil];
            [sheet showInView:self.view];
        }
    }
}

- (void)pickModel:(YSImagePickModel *)model section:(NSInteger)section{
    @weakify(self)
    
    if (section == 0)[self.driveImageArr removeAllObjects];
    if (section == 1) [self.signImageArr removeAllObjects];
    if (section == 2) [self.otherImageArr removeAllObjects];

    [model.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        YSImagePickInfo *info = (YSImagePickInfo *)obj;
        if (info.selectImage != nil) {
            UIImageView *imgView = [self sourceObjAtIdx:idx section:section];
            if (imgView != nil) {
                if (section == 0) {
                    [self.driveImageArr addObject:imgView];
                }else if (section == 1) {
                    [self.signImageArr addObject:imgView];
                }else{
                    [self.otherImageArr addObject:imgView];
                }
            }
        }
    }];
}

- (void)showLargeImageDetail:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            showLargeImage(self.driveImageArr, indexPath.row);
            break;
        case 1:
            showLargeImage(self.signImageArr, indexPath.row);
            break;
        case 2:
            showLargeImage(self.otherImageArr, indexPath.row);
            break;
        default:
            break;
    }
    
}

#pragma mark - *********** Private ***********

- (void)onlyTakePhoto:(YSImagePickModel *)model pickInfo:(YSImagePickInfo *)info{
    if (model.canSelectMore) {
        if (info.isFirst) {
            [self takePhoto:^(UIImage *img) {
                
                YSImagePickInfo *newInfo = YSImagePickInfo.new;
                newInfo.selectImage = img;
                newInfo.isFirst = NO;
                [model.dataArray addObject:newInfo];
                
                [model.dataArray exchangeObjectAtIndex:model.dataArray.count - 1 withObjectAtIndex:model.dataArray.count - 2];
                
                [self reload];
            }];
        }else{
            NSLog(@"点击查看大图");
        }
    }else{
        [self takePhoto:^(UIImage *img) {
            info.selectImage = img;
            [self reload];
        }];
    }
}

- (void)albumSelectPhoto:(YSImagePickModel *)model pickInfo:(YSImagePickInfo *)info{
    if (model.canSelectMore) {
        if (info.isFirst) {
            [self albumPhoto:^(UIImage *img) {
                
                YSImagePickInfo *newInfo = YSImagePickInfo.new;
                newInfo.selectImage = img;
                newInfo.isFirst = NO;
                [model.dataArray addObject:newInfo];
                
                [model.dataArray exchangeObjectAtIndex:model.dataArray.count - 1 withObjectAtIndex:model.dataArray.count - 2];
                
                [self reload];
            }];
        }else{
            NSLog(@"点击查看大图");
        }
    }else{
        [self albumPhoto:^(UIImage *img) {
            info.selectImage = img;
            [self reload];
        }];
    }
}

- (void)noReCycle{
    for (int i = 0 ; i < self.dataArray.count; i++) {
        YSImagePickModel *model = self.dataArray[i];
        for (int j = 0 ; j < model.dataArray.count; j++) {
            NSString *identifier = [NSString stringWithFormat:@"%d:%d",i,j];
            if (i == 0) {
                [_collectionView registerClass:[YSImagePickLargeCell class] forCellWithReuseIdentifier:identifier];
            }else{
                [_collectionView registerClass:[YSImagePickSmallCell class] forCellWithReuseIdentifier:identifier];
            }
        }
    }
}

- (void)reload{
    [self.driveFailImgArr removeAllObjects];
    [self.signFailImgArr removeAllObjects];
    [self.otherFailImgArr removeAllObjects];
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.dataArray.count - 1] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)takePhoto:(void (^)(UIImage *img))imgBlock{
    _picker = [YSImagePicker shareManager];
    _picker.controller = self;
    [_picker takePhoto:^(UIImage * _Nonnull img) {
        if (img) {
            imgBlock(img);
        }
        self->_picker = nil;
    }];
}

- (void)albumPhoto:(void (^)(UIImage *img))imgBlock{
    _picker = [YSImagePicker shareManager];
    _picker.controller = self;
    [_picker openAlbum:1 block:^(NSArray<UIImage *> * _Nonnull imgArray) {
        if (imgArray.count > 0) {
            imgBlock(imgArray[0]);
        }
        self->_picker = nil;
    }];
}

- (void)confirmClick{
    
    for (int i = 0 ; i < self.dataArray.count ; i++){
        YSImagePickModel *model = self.dataArray[i];
        [self pickModel:model section:i];
    }
    
    [self uploadImages:^{
        
    }];
}

#pragma mark - *********** 上传图片，提交信息 ***********

- (void)uploadImages:(void (^)(void))block{
    
    NSMutableArray *totalImgs = @[].mutableCopy;
    
    NSLog(@"网约车驾驶员证：%zd 张",_driveImageArr.count);
    NSLog(@"合同资料：%zd 张",_signImageArr.count);
    NSLog(@"其他资料：%zd 张",_otherImageArr.count);
//    return;
    
    if (_driveImageArr) {
        for (UIImageView *imgView in _driveImageArr) {
            [totalImgs addObject:imgView.image];
        }
    }
    
    if (_signImageArr) {
        for (UIImageView *imgView in _signImageArr) {
            [totalImgs addObject:imgView.image];
        }
    }
    
    if (_otherImageArr) {
        for (UIImageView *imgView in _otherImageArr) {
            [totalImgs addObject:imgView.image];
        }
    }
    
    [self.driveFailImgArr removeAllObjects];
    self.driveFailImgArr = nil;
    [self.signFailImgArr removeAllObjects];
    self.signFailImgArr = nil;
    [self.otherFailImgArr removeAllObjects];
    self.otherFailImgArr = nil;
    
    [self.driveUploadUrlArr removeAllObjects];
    self.driveUploadUrlArr = nil;
    [self.signUploadUrlArr removeAllObjects];
    self.signUploadUrlArr = nil;
    [self.otherUploadUrlArr removeAllObjects];
    self.otherUploadUrlArr = nil;
    
    @weakify(self)
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger i = 0; i < totalImgs.count; i++) {
        
        dispatch_group_enter(group);
        
        UIImage *img = totalImgs[i];
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:1];
            dispatch_async(dispatch_get_main_queue(), ^{
                @strongify(self)
                
                if (1) {
                    
                    @synchronized (self.driveFailImgArr) {
                        for (UIImageView *imgView in self.driveImageArr) {
                            if ([imgView.image isEqual:img]) {
                                [self.driveFailImgArr addObject:img];
                            }
                        }
                    }
                    
                    @synchronized (self.signFailImgArr) {
                        for (UIImageView *imgView in self.signImageArr) {
                            if ([imgView.image isEqual:img]) {
                                [self.signFailImgArr addObject:img];
                            }
                        }
                    }
                    
                    @synchronized (self.otherFailImgArr) {
                        for (UIImageView *imgView in self.otherImageArr) {
                            if ([imgView.image isEqual:img]) {
                                [self.otherFailImgArr addObject:img];
                            }
                        }
                    }
                }else{
                    @synchronized (self.driveUploadUrlArr) {
                        for (UIImageView *imgView in self.driveImageArr) {
                            if ([imgView.image isEqual:img]) {
                                [self.driveUploadUrlArr addObject:img];
                            }
                        }
                    }
                    
                    @synchronized (self.signUploadUrlArr) {
                        for (UIImageView *imgView in self.signImageArr) {
                            if ([imgView.image isEqual:img]) {
                                [self.signUploadUrlArr addObject:img];
                            }
                        }
                    }
                    
                    @synchronized (self.otherUploadUrlArr) {
                        for (UIImageView *imgView in self.otherImageArr) {
                            if ([imgView.image isEqual:img]) {
                                [self.otherUploadUrlArr addObject:img];
                            }
                        }
                    }
                }
                dispatch_group_leave(group);
            });
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        @strongify(self)
        
        if ((self.driveUploadUrlArr.count + self.signUploadUrlArr.count + self.otherUploadUrlArr.count) != totalImgs.count) {
            NSLog(@"图片上传失败，请重新提交");
            NSLog(@"网约车驾驶证：%@",self.driveFailImgArr);
            NSLog(@"合同资料：%@",self.signFailImgArr);
            NSLog(@"其他资料：%@",self.otherFailImgArr);
            [self uploadFail];
        }else{
            NSLog(@"图片上传成功，走提交接口");
            NSLog(@"网约车驾驶证：%@",self.driveUploadUrlArr);
            NSLog(@"合同资料：%@",self.signUploadUrlArr);
            NSLog(@"其他资料：%@",self.otherUploadUrlArr);
            if (block) {
                block();
            }
        }
    });
}

- (void)uploadFail{
    //寻找失败的对象，刷新
    for (UIImage *failImg in self.driveFailImgArr) {
        for (int i = 0 ; i < self.driveImageArr.count ; i ++) {
            UIImageView *imgView = self.driveImageArr[i];
            if ([failImg isEqual:imgView.image]) {
                //找到图片下标，找info
                YSImagePickModel *model = self.dataArray[0];
                YSImagePickInfo *info = model.dataArray[i];
                info.isUploadFailer = YES;
            }
        }
    }
    
    for (UIImage *failImg in self.signFailImgArr) {
        for (int i = 0 ; i < self.signImageArr.count ; i ++) {
            UIImageView *imgView = self.signImageArr[i];
            if ([failImg isEqual:imgView.image]) {
                //找到图片下标，找info
                YSImagePickModel *model = self.dataArray[1];
                YSImagePickInfo *info = model.dataArray[i];
                info.isUploadFailer = YES;
            }
        }
    }
    
    for (UIImage *failImg in self.otherFailImgArr) {
        for (int i = 0 ; i < self.otherImageArr.count ; i ++) {
            UIImageView *imgView = self.otherImageArr[i];
            if ([failImg isEqual:imgView.image]) {
                //找到图片下标，找info
                YSImagePickModel *model = self.dataArray[2];
                YSImagePickInfo *info = model.dataArray[i];
                info.isUploadFailer = YES;
            }
        }
    }
    
    [self.collectionView reloadData];
}

#pragma mark - *********** ActionSheet ***********

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self onlyTakePhoto:_tempModel pickInfo:_tempInfo];
            break;
        case 1:
            [self albumSelectPhoto:_tempModel pickInfo:_tempInfo];
            break;
        default:
            break;
    }
}

#pragma mark - *********** lazy ***********

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
        flowLayout.minimumLineSpacing = 12;
        flowLayout.minimumInteritemSpacing = 12;
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH,40);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator   = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[YSImagePickLargeCell class] forCellWithReuseIdentifier:@"YSImagePickLargeCell"];
        [_collectionView registerClass:[YSImagePickSmallCell class] forCellWithReuseIdentifier:@"YSImagePickSmallCell"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHead"];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self noReCycle];
    }
    return _collectionView;
}


- (UIView *)confirmView{
    if (!_confirmView) {
        _confirmView = UIView.new;
        _confirmView.backgroundColor = UIColor_F8;
        
        UIButton *btn = UIButton.new;
        btn.backgroundColor = UIColorFromRGB(0x00AFAA);
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [btn setTitle:@"确认提交" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius  = 6;
        btn.layer.masksToBounds = YES;
        [_confirmView addSubview:btn];
        
        btn.sd_layout
        .leftSpaceToView(_confirmView, 12)
        .rightSpaceToView(_confirmView, 12)
        .heightIs(38)
        .centerYEqualToView(_confirmView);
    }
    return _confirmView;
}

- (NSMutableArray *)driveImageArr{
    if (!_driveImageArr) {
        _driveImageArr = @[].mutableCopy;
    }
    return _driveImageArr;
}

- (NSMutableArray *)signImageArr{
    if (!_signImageArr) {
        _signImageArr = @[].mutableCopy;
    }
    return _signImageArr;
}

- (NSMutableArray *)otherImageArr{
    if (!_otherImageArr) {
        _otherImageArr = @[].mutableCopy;
    }
    return _otherImageArr;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
        {
            YSImagePickModel *model = YSImagePickModel.new;
            model.title = @"网约车驾驶员证";
            model.canSelectMore = NO;
            model.onlyTakePhoto = NO;
            model.type = YSImagePickType_large;
            
            YSImagePickInfo *info = YSImagePickInfo.new;
            info.normalImage = [UIImage imageNamed:@"driveA"];
            
            YSImagePickInfo *info1 = YSImagePickInfo.new;
            info1.normalImage = [UIImage imageNamed:@"driveB"];
            
            model.dataArray = @[info,info1].mutableCopy;
            
            [_dataArray addObject:model];
        }
        
        {
            YSImagePickModel *model = YSImagePickModel.new;
            model.title = @"合同资料";
            model.canSelectMore = YES;
            model.onlyTakePhoto = YES;
            model.type = YSImagePickType_small;
            
            YSImagePickInfo *info = YSImagePickInfo.new;
            info.desc = @"点击拍摄";
            info.isFirst = YES;
            model.dataArray = @[info].mutableCopy;
            
            [_dataArray addObject:model];
        }
        
        {
            YSImagePickModel *model = YSImagePickModel.new;
            model.title = @"其他资料";
            model.canSelectMore = NO;
            model.onlyTakePhoto = YES;
            model.type = YSImagePickType_small;
            
            YSImagePickInfo *info = YSImagePickInfo.new;
            info.desc = @"与客户合影";
            
            YSImagePickInfo *info2 = YSImagePickInfo.new;
            info2.desc = @"客户签单照片";
            
            model.dataArray = @[info,info2].mutableCopy;
            
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}


- (NSMutableArray *)signFailImgArr{
    if (!_signFailImgArr) {
        _signFailImgArr = @[].mutableCopy;
    }
    return _signFailImgArr;
}

- (NSMutableArray *)signUploadUrlArr{
    if (!_signUploadUrlArr) {
        _signUploadUrlArr = @[].mutableCopy;
    }
    return _signUploadUrlArr;
}

- (NSMutableArray *)driveFailImgArr{
    if (!_driveFailImgArr) {
        _driveFailImgArr = @[].mutableCopy;
    }
    return _driveFailImgArr;
}

- (NSMutableArray *)driveUploadUrlArr{
    if (!_driveUploadUrlArr) {
        _driveUploadUrlArr = @[].mutableCopy;
    }
    return _driveUploadUrlArr;
}

- (NSMutableArray *)otherFailImgArr{
    if (!_otherFailImgArr) {
        _otherFailImgArr = @[].mutableCopy;
    }
    return _otherFailImgArr;
}

- (NSMutableArray *)otherUploadUrlArr{
    if (!_otherUploadUrlArr) {
        _otherUploadUrlArr = @[].mutableCopy;
    }
    return _otherUploadUrlArr;
}

@end
