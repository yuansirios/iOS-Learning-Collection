//
//  YSImageSelectViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/7/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSImageSelectViewController.h"
#import "YSImagePickSmallCell.h"
#import "YSImagePickModel.h"

@interface YSImageSelectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSDictionary *_imgeDic;
}

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation YSImageSelectViewController

- (void)addSubviews {
    self.title = @"图片选择器";
    self.view.backgroundColor = UIColor_F8;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.confirmBtn];
    
    float pade = 16;
    
    self.collectionView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 50+pade*2+SafeAreaBottomHeight, 0));
    
    self.confirmBtn
    .sd_layout
    .topSpaceToView(self.collectionView, self.collectionView.height + pade)
    .leftSpaceToView(self.view, pade)
    .widthIs(self.view.width - pade*2)
    .heightIs(50);
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        UIButton *btn = UIButton.new;
        btn.backgroundColor = UIColorFromRGB(0x9B9B9B);
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [btn setTitle:@"确认提交" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius  = 6;
        btn.layer.masksToBounds = YES;
        btn.userInteractionEnabled = NO;
        _confirmBtn = btn;
    }
    return _confirmBtn;
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
    YSImagePickSmallCell *cell = (YSImagePickSmallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YSImagePickSmallCell" forIndexPath:indexPath];
    [cell setSmallRemoveBlock:^(YSImagePickInfo * _Nonnull info) {
        info.selectImage = nil;
        info.isUploadFailer = nil;
        info.isFirst = YES;
        [self reload];
    }];
    cell.infoModel = info;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YSImagePickModel *model = self.dataArray[indexPath.section];
    YSImagePickInfo *info = model.dataArray[indexPath.row];
    
    //只允许拍照
    if (model.onlyTakePhoto) {
        if (info.selectImage) {
            NSLog(@"查看大图:%@",info.selectImage);
        }else{
            [self takePhoto:info];
        }
    } else {
        //拍照和选择
        if (info.selectImage) {
            NSLog(@"查看大图:%@",info.selectImage);
        }else{
            [self takePhoto:info];
        }
    }
}

- (void)takePhoto:(YSImagePickInfo *)info{
    info.isFirst = NO;
    info.selectImage = createImageWithColor(UIColorRandom, 50, 50);
    [self reload];
}

#pragma mark - *********** Private ***********

- (void)confirmClick{
    NSLog(@"选择的图片:%@",_imgeDic);
}

#pragma mark - *********** Tool ***********

- (void)reload{
    [self.collectionView reloadData];
    [self checkConfirmStatus];
}

- (NSDictionary *)checkConfirmStatus{

    YSImagePickModel *model = self.dataArray[0];
    YSImagePickInfo *info = model.dataArray[0];
    
    YSImagePickModel *model1 = self.dataArray[1];
    YSImagePickInfo *info1 = model1.dataArray[0];
    
    UIImage *image = info.selectImage;
    UIImage *image1 = info1.selectImage;
    
    if (image && image1) {
        self.confirmBtn.backgroundColor = UIColor_AA;
        self.confirmBtn.userInteractionEnabled = YES;
    }else{
        self.confirmBtn.backgroundColor = UIColor_9B;
        self.confirmBtn.userInteractionEnabled = NO;
    }
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setValue:image forKey:@"image"];
    [dic setValue:image1 forKey:@"image1"];
    _imgeDic = dic.copy;
    
    return dic;
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
        
        [_collectionView registerClass:[YSImagePickSmallCell class] forCellWithReuseIdentifier:@"YSImagePickSmallCell"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHead"];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
        {
            YSImagePickModel *model = YSImagePickModel.new;
            model.title = @"客户人车合影";
            model.canSelectMore = NO;
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
            model.title = @"车辆移交清单";
            model.canSelectMore = NO;
            model.onlyTakePhoto = YES;
            model.type = YSImagePickType_small;
            
            YSImagePickInfo *info = YSImagePickInfo.new;
            info.desc = @"点击拍摄";
            info.isFirst = YES;
            model.dataArray = @[info].mutableCopy;
            
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

@end
