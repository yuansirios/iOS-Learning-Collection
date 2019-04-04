//
//  PdiDefectViewController.m
//  VehicleService
//
//  Created by yuan on 2019/4/4.
//  Copyright © 2019 xince. All rights reserved.
//

#import "PdiDefectViewController.h"
#import "PdiDefectMarkView.h"
#import "PdiDefectListView.h"

@interface PdiDefectViewController (){
    NSArray *_pdiModelArr;
}

@property (nonatomic,strong) UIScrollView *defectScrollView;

@property (nonatomic,strong) PdiDefectMarkView *defectMarkView;

@property (nonatomic,strong) PdiDefectListView *defectListView;

@property (nonatomic,strong) UIButton *screenShotBtn;

@end

@implementation PdiDefectViewController

- (void)addSubviews {
    self.title = @"外观缺陷标注";
    [self.view addSubview:self.defectScrollView];
    self.defectScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)screenShot{
    
    UIImage *img = self.defectMarkView.screenShot;
    
    YSBaseViewController *vc = YSBaseViewController.new;
    vc.title = @"截图";
    
    UIImageView *imgView = UIImageView.new;
    imgView.image = img;
    imgView.frame = vc.view.frame;
    imgView.contentMode = UIViewContentModeCenter;
    [vc.view addSubview:imgView];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [_pdiModelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
}

//刷新列表数据
- (void)refreshListView:(NSArray<PdiMarkModel *> *)modelArr{
    [self.defectListView loadWithModelArr:modelArr];
    [self.defectScrollView setupAutoContentSizeWithBottomView:self.defectListView bottomMargin:20];
    
    _pdiModelArr = modelArr.copy;
}

#pragma mark - *********** lazy ***********

- (UIScrollView *)defectScrollView{
    if (!_defectScrollView) {
        _defectScrollView = UIScrollView.new;
        
        [_defectScrollView addSubview:self.defectMarkView];
        [_defectScrollView addSubview:self.defectListView];
        [_defectScrollView addSubview:self.screenShotBtn];
    }
    return _defectScrollView;
}

- (PdiDefectMarkView *)defectMarkView{
    if (!_defectMarkView) {
        _defectMarkView = PdiDefectMarkView.new;
        _defectMarkView.center = self.view.center;
        @weakify(self)
        [_defectMarkView setRefreshBlock:^(NSArray<PdiMarkModel *> * _Nonnull modelArr) {
            @strongify(self)
            [self refreshListView:modelArr];
        }];
    }
    return _defectMarkView;
}

- (PdiDefectListView *)defectListView{
    if (!_defectListView) {
        _defectListView = [[PdiDefectListView alloc]initWithFrame:CGRectMake(self.defectMarkView.left, self.defectMarkView.bottom + 20, self.defectMarkView.width, 0)];
        @weakify(self)
        [_defectListView setEditBlock:^(PdiMarkModel * _Nonnull model) {
            @strongify(self)
            [self.defectMarkView refreshMarkPoint:model];
        }];
    }
    return _defectListView;
}

- (UIButton *)screenShotBtn{
    if (!_screenShotBtn) {
        _screenShotBtn = UIButton.new;
        _screenShotBtn.backgroundColor = UIColorRandom;
        [_screenShotBtn setTitle:@"截图" forState:UIControlStateNormal];
        [_screenShotBtn addTarget:self action:@selector(screenShot) forControlEvents:UIControlEventTouchUpInside];
        _screenShotBtn.frame = CGRectMake(self.defectMarkView.left, self.defectMarkView.top - 20 - 50, 100, 50);
    }
    return _screenShotBtn;
}


@end
