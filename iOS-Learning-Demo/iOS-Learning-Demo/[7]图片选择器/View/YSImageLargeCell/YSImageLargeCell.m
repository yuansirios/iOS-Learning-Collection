//
//  YSImageLargeCell.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/10/17.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSImageLargeCell.h"
#import "YSButton.h"

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
    
    self.backImageView.image = infoModel.selectImage;
    if (infoModel.selectImage) {
        self.removeButton.hidden = NO;
        self.frontImageView.hidden = YES;
        self.backImageView.layer.masksToBounds = YES;
    }else{
        self.removeButton.hidden = YES;
        self.frontImageView.hidden = NO;
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

@interface YSImageLargeCell()<UICollectionViewDataSource,UICollectionViewDelegate>{
    BOOL _checkRadio;
}

@property (nonatomic,strong) UIView *topHeadView;
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation YSImageLargeCell

- (void)setupViews{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.contentView addSubview:self.topHeadView];
    [self.contentView addSubview:self.collectionView];
    
    CGFloat topH = 40;
    self.topHeadView
    .sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .heightIs(topH);
    
    self.collectionView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(topH, 0, 0, 0));
}

#pragma mark - *********** get & set ***********

- (void)setPickModel:(YSImagePickModel *)pickModel{
    _pickModel = pickModel;
    
    _pickModel.rowHeight = 130 + self.topHeadView.height;
    [self.collectionView reloadData];
    
    //处理标题
    UILabel *topLabel = [_topHeadView viewWithTag:1000];
    topLabel.text = pickModel.title;
    [topLabel sizeToFit];
    
    topLabel.sd_layout
    .leftSpaceToView(self.topHeadView, 12)
    .widthIs(topLabel.width)
    .heightIs(topLabel.height)
    .bottomEqualToView(self.topHeadView);
    
    //处理按钮
    NSString *title = @"暂无网约车驾驶员证";
    float iconW = 20;
    UIFont *font = [UIFont systemFontOfSize:14];
    
    UIButton *button = [_topHeadView viewWithTag:2000];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, _topHeadView.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    float btnW = titleSize.width + 5 + 10 + iconW;
    
    button.sd_layout
    .rightSpaceToView(self.topHeadView, 12)
    .widthIs(btnW)
    .heightIs(iconW+10)
    .centerYEqualToView(topLabel);
    
//    self.topHeadView.backgroundColor = UIColor.greenColor;
//    topLabel.backgroundColor = UIColor.redColor;
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
    if (infoModel.unable) {
        NSLog(@"按钮不能点击");
        return;
    }
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

#pragma mark - *********** event ***********

- (void)checkRadioEvent{
    _checkRadio = !_checkRadio;
    
    UIButton *btn = [_topHeadView viewWithTag:2000];
    if (_checkRadio){
        [btn setImage:[UIImage imageNamed:@"icon_criedt_yes"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    }
    
    if (_showLearnBlock) {
        _showLearnBlock(_pickModel,_checkRadio);
    }
}

#pragma mark - *********** lazy ***********

- (UIView *)topHeadView{
    if (!_topHeadView) {
        _topHeadView = UIView.new;
        
        UILabel *label = UILabel.new;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = UIColorFromRGB(0x4A4A4A);
        label.tag = 1000;
        [_topHeadView addSubview:label];
        
        if (!_isDuplicates) {
            YSButton *btn = [YSButton buttonWithType:UIButtonTypeCustom withSpace:5 withPadding:0 withType:YSButtonImageStyle_Left];
            btn.tag = 2000;
            if (_checkRadio){
                [btn setImage:[UIImage imageNamed:@"icon_criedt_yes"] forState:UIControlStateNormal];
            }else{
                [btn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
            }
            [btn setTitleColor:UIColorFromRGB(0x4A4A4A) forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(checkRadioEvent) forControlEvents:UIControlEventTouchUpInside];
            [_topHeadView addSubview:btn];
        }
    }
    return _topHeadView;
}

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
