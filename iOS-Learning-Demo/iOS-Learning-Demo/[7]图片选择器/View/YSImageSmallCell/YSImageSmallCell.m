//
//  YSImageSmallCell.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/10/18.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSImageSmallCell.h"

#pragma mark - *********** YSImageSmallCollectionCell ***********

typedef void(^SmallCollectionCellRemove)(YSImagePickInfo *infoModel);

@interface YSImageSmallCollectionCell : YSBaseCollectionViewCell

@property (nonatomic,strong) YSImagePickInfo *infoModel;
//前景图
@property (nonatomic,strong) UIImageView *frontImageView;
@property (nonatomic,strong) UILabel *defaultLabel;
//背景图
@property (nonatomic,strong) UIImageView *backImageView;
//删除按钮
@property (nonatomic,strong) UIButton *removeButton;
//失败展示
@property (nonatomic,strong) UIView *failView;

@property (nonatomic,copy) SmallCollectionCellRemove removeClick;

@end

@implementation YSImageSmallCollectionCell

- (void)setupViews{
//    self.contentView.backgroundColor = UIColorRandom;
    [self.contentView addSubview:self.backImageView];
    [self.backImageView addSubview:self.frontImageView];
    [self.backImageView addSubview:self.defaultLabel];
    [self.contentView addSubview:self.failView];
    [self.contentView addSubview:self.removeButton];
    
    //上左下右
    self.backImageView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
    
    self.frontImageView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(10, 20, 30, 20));
    
    self.failView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(20, 12, 20, 12));
    
    self.removeButton.sd_layout
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView,0)
    .widthIs(24)
    .heightIs(24);
}

#pragma mark - *********** Private ***********

- (void)setInfoModel:(YSImagePickInfo *)infoModel{
    
    _infoModel = infoModel;
    
    if (infoModel.backGroundImage){
        self.frontImageView.image = infoModel.backGroundImage;
    }
    
    if (infoModel.isFirst) {
        _backImageView.backgroundColor = UIColor.lightGrayColor;
        
        if (infoModel.desc) {
            self.defaultLabel.text = infoModel.desc;
            [self.defaultLabel sizeToFit];
            
            self.defaultLabel
              .sd_layout
              .topSpaceToView(self.frontImageView, 10)
              .centerXEqualToView(self.frontImageView)
              .heightIs(self.defaultLabel.height);
        }
    }
    
    if (infoModel.selectImage) {
        self.removeButton.hidden = NO;
        self.frontImageView.hidden = YES;
        self.defaultLabel.hidden = YES;
        self.backImageView.image = infoModel.selectImage;
        self.backImageView.layer.masksToBounds = YES;
    }else{
        self.removeButton.hidden = YES;
        self.frontImageView.hidden = NO;
        self.defaultLabel.hidden = NO;
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

- (UILabel *)defaultLabel{
    if (!_defaultLabel) {
        _defaultLabel = UILabel.new;
        _defaultLabel.textColor = UIColor.whiteColor;
        _defaultLabel.font = [UIFont systemFontOfSize:11];
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _defaultLabel;
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = UIImageView.new;
        _backImageView.backgroundColor = UIColorRandom;
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

#pragma mark - *********** YSImageSmallCell ***********

NSString * const ImageSmallCell = @"YSImageSmallCollectionCell";

@interface YSImageSmallCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation YSImageSmallCell

- (void)setupViews{
    [self.contentView addSubview:self.collectionView];
    self.collectionView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(20, 12, 0, 12));
}

#pragma mark - *********** get & set ***********

- (void)setPickModel:(YSImagePickModel *)pickModel{
 
    _pickModel = pickModel;
    
    [self reloadView];
}

- (void)reloadView{
    //计算高度
    int num = 0;
    if(_pickModel.dataArray.count % 4){
        num = 1;
    }
    
    NSUInteger row = _pickModel.dataArray.count / 4 + num;
    CGFloat itemW = ((SCREEN_WIDTH - 12*2) - 12*3)/4.;
    CGFloat contentHeight = row * itemW + (row - 1)*12;
    _pickModel.rowHeight = contentHeight + 20;
    [self.collectionView reloadData];
}

#pragma mark - *********** UICollectionViewDataSource ***********

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _pickModel.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemW = ((SCREEN_WIDTH - 12*2) - 12*3)/4.;
    return CGSizeMake(itemW,itemW);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YSImagePickInfo *info = _pickModel.dataArray[indexPath.row];
    YSImageSmallCollectionCell *cell = (YSImageSmallCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ImageSmallCell forIndexPath:indexPath];
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
            YSImagePickInfo *info = _pickModel.dataArray[i];
            if (info.selectImage) {
                UIImageView *imageView = [self imageViewForCell:i];
                [imageViewArr addObject:imageView];
            }
        }
        showLargeImage(imageViewArr, indexPath.row);
    }else{
        if (self.addItemBlock) {
            self.addItemBlock(_pickModel,indexPath.row);
        }
    }
}

- (void)removeItem:(YSImagePickInfo *)info
             index:(NSInteger)index{
    if (self.removeItemBlock) {
        self.removeItemBlock(info,index);
    }
}

#pragma mark - *********** 获取cell的imageView ***********

- (UIImageView *)imageViewForCell:(NSInteger)index{
    YSImageSmallCollectionCell *cell = (YSImageSmallCollectionCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return cell ? cell.backImageView : nil;
}

#pragma mark - *********** lazy ***********

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 12;
        flowLayout.minimumInteritemSpacing = 12;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColor.greenColor;
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator   = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:NSClassFromString(ImageSmallCell) forCellWithReuseIdentifier:ImageSmallCell];
    }
    return _collectionView;
}

@end
