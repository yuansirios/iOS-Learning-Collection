//
//  YSImageLargeCell.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/10/17.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSImageLargeCell.h"

#pragma mark - *********** YSImageLargeCollectionCell ***********

typedef void(^LargeCollectionCellRemove)(YSImagePickInfo *infoModel);

@interface YSImageLargeCollectionCell : YSBaseCollectionViewCell

@property (nonatomic,strong) YSImagePickInfo *infoModel;
//前景图
@property (nonatomic,strong) UIImageView *frontImageView;
//背景图
@property (nonatomic,strong) UIImageView *backImageView;
//删除按钮
@property (nonatomic,strong) UIButton *removeButton;
//失败展示
@property (nonatomic,strong) UIView *failView;

@property (nonatomic,copy) LargeCollectionCellRemove removeClick;

@end

@implementation YSImageLargeCollectionCell

- (void)setupViews{
//    self.contentView.backgroundColor = UIColorRandom;
    [self.contentView addSubview:self.backImageView];
    [self.backImageView addSubview:self.frontImageView];
    [self.contentView addSubview:self.failView];
    [self.contentView addSubview:self.removeButton];
    
    //上左下右
    self.backImageView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(20, 12, 20, 12));
    
    self.frontImageView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(20, 20, 20, 20));
    
    self.failView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(20, 12, 20, 12));
    
    self.removeButton.sd_layout
    .topSpaceToView(self.contentView, 12)
    .rightSpaceToView(self.contentView,6)
    .widthIs(24)
    .heightIs(24);
}

#pragma mark - *********** Private ***********

- (void)setInfoModel:(YSImagePickInfo *)infoModel{
    
    _infoModel = infoModel;
    
    if (infoModel.backGroundImage){
        self.frontImageView.image = infoModel.backGroundImage;
    }
    
    if (infoModel.selectImage) {
        self.removeButton.hidden = NO;
        self.frontImageView.hidden = YES;
        self.backImageView.image = infoModel.selectImage;
        self.backImageView.layer.masksToBounds = YES;
    }else{
        self.removeButton.hidden = YES;
        self.frontImageView.hidden = NO;
        self.backImageView.image = infoModel.normalImage;
        self.backImageView.layer.masksToBounds = NO;
    }
    self.backImageView.layer.cornerRadius = 6;
    YSButtonShadow(_backImageView);
    
    if (infoModel.isUploadFailer) {
        self.failView.hidden = NO;
    }else{
        self.failView.hidden = YES;
    }
}

- (void)removeImage{
    if (_removeClick) {
        _removeClick(_infoModel);
    }
}

#pragma mark - *********** lazy ***********

- (UIImageView *)frontImageView{
    if (!_frontImageView) {
        _frontImageView = UIImageView.new;
        _frontImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _frontImageView;
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = UIImageView.new;
        _backImageView.backgroundColor = UIColor.whiteColor;
    }
    return _backImageView;
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

- (UIButton *)removeButton{
    if (!_removeButton) {
        _removeButton = UIButton.new;
        [_removeButton setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_removeButton addTarget:self action:@selector(removeImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeButton;
}

@end

#pragma mark - *********** YSImageLargeCell ***********

NSString * const ImageLargeCell = @"YSImageLargeCollectionCell";

@interface YSImageLargeCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation YSImageLargeCell

- (void)setupViews{
    [self.contentView addSubview:self.collectionView];
    self.collectionView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
}

#pragma mark - *********** get & set ***********

- (void)setPickModel:(YSImagePickModel *)pickModel{
    _pickModel = pickModel;
    _pickModel.rowHeight = 140;
    [self.collectionView reloadData];
}

#pragma mark - *********** UICollectionViewDataSource ***********

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _pickModel.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/2,140);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YSImagePickInfo *info = _pickModel.dataArray[indexPath.row];
    YSImageLargeCollectionCell *cell = (YSImageLargeCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ImageLargeCell forIndexPath:indexPath];
    cell.infoModel = info;
    [cell setRemoveClick:^(YSImagePickInfo *infoModel) {
        [self removeItem:infoModel index:indexPath.row];
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YSImagePickInfo *infoModel = _pickModel.dataArray[indexPath.row];
    if (infoModel.selectImage) {
        NSMutableArray *imageViewArr = @[].mutableCopy;
        for (int i = 0; i < _pickModel.dataArray.count; i++) {
            UIImageView *imageView = [self imageViewForCell:i];
            [imageViewArr addObject:imageView];
        }
        showLargeImage(imageViewArr, indexPath.row);
    }else{
        if (self.addItemBlock) {
            self.addItemBlock(_pickModel,indexPath.row);
        }
    }
}

- (UIImageView *)imageViewForCell:(NSInteger)index{
    YSImageLargeCollectionCell *cell = (YSImageLargeCollectionCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return cell ? cell.backImageView : nil;
}

- (void)removeItem:(YSImagePickInfo *)info
             index:(NSInteger)index{
    if (self.removeItemBlock) {
        self.removeItemBlock(info,index);
    }
}

#pragma mark - *********** lazy ***********

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator   = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:NSClassFromString(ImageLargeCell) forCellWithReuseIdentifier:ImageLargeCell];
    }
    return _collectionView;
}

@end
