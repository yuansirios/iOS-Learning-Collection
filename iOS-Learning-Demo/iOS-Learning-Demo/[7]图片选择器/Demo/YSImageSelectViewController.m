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

#import "YSImageLargeCell.h"
#import "YSImageSmallCell.h"


@interface YSImageSelectViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSDictionary *_imgeDic;
}


@property (nonatomic,strong) UITableView *baseTableView;

@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation YSImageSelectViewController

- (void)addSubviews {
    self.title = @"图片选择器";
    self.view.backgroundColor = UIColor_F8;
    [self.view addSubview:self.baseTableView];
    [self.view addSubview:self.confirmBtn];
    
    float pade = 16;
    
    self.baseTableView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 50+pade*2+SafeAreaBottomHeight, 0));
    
    self.confirmBtn
    .sd_layout
    .topSpaceToView(self.baseTableView, self.baseTableView.height + pade)
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

#pragma mark - *********** UITableViewDelegate ***********

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    YSImagePickModel *model = self.dataArray[section];
    
    UILabel *label = UILabel.new;
    label.text = model.title;
    label.font = [UIFont systemFontOfSize:14];
    label.frame = CGRectMake(12, 12, 0, 0);
    [label sizeToFit];
    
    UIView *view = UIView.new;
    [view setFrame:CGRectMake(0, 0, label.width, label.height + 20)];
//    view.backgroundColor = UIColorRandom;
    [view addSubview:label];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YSImagePickModel *model = self.dataArray[indexPath.section];
    return model.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    
    YSImagePickModel *pickModel = self.dataArray[section];
    
    if (section == 0) {
        static NSString *ID = @"largeCell";
        YSImageLargeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[YSImageLargeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.pickModel = pickModel;
        [cell setAddItemBlock:^(YSImagePickModel * _Nonnull pickModel,
                                NSInteger index) {
            [self driveTakePhoto:pickModel withIndex:index];
        }];
        [cell setRemoveItemBlock:^(YSImagePickInfo * _Nonnull pickInfo,
                                   NSInteger index) {
            [self driveItemRemove:pickModel withIndex:index];
        }];
        
        return cell;
    }else if(section == 1){
        static NSString *ID = @"CertificateCell";
        YSImageSmallCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[YSImageSmallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.pickModel = pickModel;
        [cell setAddItemBlock:^(YSImagePickModel * _Nonnull pickModel,
                                NSInteger index) {
            [self certificateTakePhoto:pickModel];
        }];
        [cell setRemoveItemBlock:^(YSImagePickInfo * _Nonnull pickInfo,
                                   NSInteger index) {
            [self certificateRemove:pickModel withItem:pickInfo];
        }];
        return cell;
    }else if(section == 2){
        static NSString *ID = @"otherCell";
        YSImageSmallCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[YSImageSmallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.pickModel = self.dataArray[indexPath.section];
        [cell setAddItemBlock:^(YSImagePickModel * _Nonnull pickModel,
                                NSInteger index) {
            [self otherTakePhoto:pickModel withIndex:index];
        }];
        [cell setRemoveItemBlock:^(YSImagePickInfo * _Nonnull pickInfo,
                                   NSInteger index) {
            [self otherItemRemove:pickModel withIndex:index];
        }];
        return cell;
    }else{
        return nil;
    }
}

#pragma mark - *********** 网约车驾驶员证 ***********
//网约车驾驶员证添加
- (void)driveTakePhoto:(YSImagePickModel *)pickModel withIndex:(NSInteger)index{
    NSMutableArray *itemList = pickModel.dataArray.mutableCopy;
    YSImagePickInfo *selectItem = itemList[index];
    selectItem.selectImage = createImageWithColor(UIColorRandom, 50, 50);
    self.dataArray[0] = pickModel;
    [self.baseTableView reloadData];
    [self checkConfirmStatus];
}
//网约车驾驶员证删除
- (void)driveItemRemove:(YSImagePickModel *)pickModel withIndex:(NSInteger)index{
    NSMutableArray *itemList = pickModel.dataArray.mutableCopy;
    YSImagePickInfo *selectItem = itemList[index];
    selectItem.selectImage = nil;
    self.dataArray[0] = pickModel;
    [self.baseTableView reloadData];
    [self checkConfirmStatus];
}

#pragma mark - *********** 合同资料操作 ***********
//合同资料添加
- (void)certificateTakePhoto:(YSImagePickModel *)pickModel{
    YSImagePickInfo *newInfo = YSImagePickInfo.new;
    newInfo.selectImage = createImageWithColor(UIColorRandom, 50, 50);
    
    YSImagePickInfo *addInfo = pickModel.dataArray.lastObject;
    
    NSMutableArray *oldArr = pickModel.dataArray.mutableCopy;
    [oldArr removeLastObject];
    
    NSMutableArray *dataArr = oldArr.mutableCopy;
    [dataArr addObject:newInfo];
    [dataArr addObject:addInfo];
    
    pickModel.dataArray = dataArr.copy;
    
    self.dataArray[1] = pickModel;
    
    [self.baseTableView reloadData];
    
    [self checkConfirmStatus];
}
//合同资料删除
- (void)certificateRemove:(YSImagePickModel *)pickModel
                 withItem:(YSImagePickInfo *)pickInfo {
    NSMutableArray *oldArr = pickModel.dataArray.mutableCopy;
    [oldArr removeObject:pickInfo];
    pickModel.dataArray = oldArr.copy;
    self.dataArray[1] = pickModel;
    [self.baseTableView reloadData];
    [self checkConfirmStatus];
}

#pragma mark - *********** 其他资料操作 ***********
//其他资料添加
- (void)otherTakePhoto:(YSImagePickModel *)pickModel withIndex:(NSInteger)index{
    NSMutableArray *itemList = pickModel.dataArray.mutableCopy;
    YSImagePickInfo *selectItem = itemList[index];
    if (selectItem.isFirst) {
        selectItem.selectImage = createImageWithColor(UIColorRandom, 50, 50);
        selectItem.isFirst = NO;
    }
    self.dataArray[2] = pickModel;
    [self.baseTableView reloadData];
    [self checkConfirmStatus];
}
//其他资料删除
- (void)otherItemRemove:(YSImagePickModel *)pickModel withIndex:(NSInteger)index{
    NSMutableArray *itemList = pickModel.dataArray.mutableCopy;
    YSImagePickInfo *selectItem = itemList[index];
    selectItem.selectImage = nil;
    selectItem.backGroundImage = [UIImage imageNamed:@"相机"];
    selectItem.desc = index == 0?@"与客户合影":@"客户签单照片";
    selectItem.isFirst = YES;
    self.dataArray[2] = pickModel;
    [self.baseTableView reloadData];
    [self checkConfirmStatus];
}

#pragma mark - *********** Private ***********

- (void)confirmClick{
    NSLog(@"选择的图片:%@",_imgeDic);
}

#pragma mark - *********** Tool ***********

- (void)checkConfirmStatus{

    //网约车驾驶员证
    YSImagePickModel *model = self.dataArray[0];
    YSImagePickInfo *info   = model.dataArray[0];
    YSImagePickInfo *info1  = model.dataArray[1];
    
    UIImage *image = info.selectImage;
    UIImage *image1 = info1.selectImage;
    
    //合同资料
    YSImagePickModel *certModel = self.dataArray[1];
    NSArray *certInfoArr = certModel.dataArray;
    NSMutableArray *certImages = @[].mutableCopy;
    for (YSImagePickInfo *infoModel in certInfoArr) {
        if (infoModel.selectImage) {
            [certImages addObject:infoModel.selectImage];
        }
    }
    
    //其他资料
    YSImagePickModel *otherModel = self.dataArray[2];
    NSArray *otherInfoArr = otherModel.dataArray;
    NSMutableArray *otherImages = @[].mutableCopy;
    for (YSImagePickInfo *infoModel in otherInfoArr) {
        if (infoModel.selectImage) {
            [otherImages addObject:infoModel.selectImage];
        }
    }
    
    if (image &&
        image1 &&
        certImages.count > 0 &&
        otherImages.count == 2) {
        self.confirmBtn.backgroundColor = UIColor_AA;
        self.confirmBtn.userInteractionEnabled = YES;
        
        NSMutableDictionary *dic = @{}.mutableCopy;
        [dic setValue:image forKey:@"front"];
        [dic setValue:image1 forKey:@"back"];
        [dic setValue:certImages forKey:@"cert"];
        [dic setValue:otherImages forKey:@"other"];
        _imgeDic = dic.copy;
    }else{
        self.confirmBtn.backgroundColor = UIColor_9B;
        self.confirmBtn.userInteractionEnabled = NO;
    }
}

#pragma mark - *********** lazy ***********

- (UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView = UITableView.new;
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.tableFooterView = UIView.new;
    }
    return _baseTableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
        {
            YSImagePickModel *model = YSImagePickModel.new;
            model.title = @"网约车驾驶员证";
            model.canSelectMore = NO;
            model.onlyTakePhoto = YES;
            model.type = YSImagePickType_large;
            
            YSImagePickInfo *front = YSImagePickInfo.new;
            front.desc = @"点击拍摄封面";
            front.backGroundImage = [UIImage imageNamed:@"drive_front"];
            
            YSImagePickInfo *back = YSImagePickInfo.new;
            back.desc = @"点击拍摄内页";
            back.backGroundImage = [UIImage imageNamed:@"drive_back"];
            
            model.dataArray = @[front,back];
            [_dataArray addObject:model];
        }
        
        {
            YSImagePickModel *model = YSImagePickModel.new;
            model.title = @"合同资料";
            model.canSelectMore = YES;
            model.onlyTakePhoto = YES;
            model.type = YSImagePickType_small;
            
            YSImagePickInfo *info = YSImagePickInfo.new;
            info.backGroundImage = [UIImage imageNamed:@"相机"];
            info.desc = @"点击拍摄";
            info.isFirst = YES;
            model.dataArray = @[info];
            
            [_dataArray addObject:model];
        }
        
        {
            YSImagePickModel *model = YSImagePickModel.new;
            model.title = @"其他资料";
            model.canSelectMore = NO;
            model.onlyTakePhoto = YES;
            model.type = YSImagePickType_small;
            
            YSImagePickInfo *info = YSImagePickInfo.new;
            info.backGroundImage = [UIImage imageNamed:@"相机"];
            info.desc = @"与客户合影";
            info.isFirst = YES;
            
            YSImagePickInfo *info1 = YSImagePickInfo.new;
            info1.backGroundImage = [UIImage imageNamed:@"相机"];
            info1.desc = @"客户签单照片";
            info1.isFirst = YES;
            
            model.dataArray = @[info,info1];
            
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

@end
