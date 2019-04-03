//
//  SDListViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/26.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "SDListViewController.h"
#import "SDTabelViewController.h"

@interface SDListViewController (){
    UILabel *_autoWidthlabel;
}

@property (nonatomic,strong) UIScrollView *listView;

@end

@implementation SDListViewController

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_autoWidthlabel setSingleLineAutoResizeWithMaxWidth:self.view.width - 20*2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDAutoLayout用法大全";
    
    UIView *lastView;
    
    //TODO:基本布局
    {
        //1、填充一个和父视图一样的滚动视图
        [self.view addSubview:self.listView];
        self.listView.sd_layout
        .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        //2、左、上20，长50，宽100
        UIView *view1 = [UIView new];
        view1.backgroundColor = UIColor.redColor;
        [self.listView addSubview:view1];
        view1.sd_layout
        .topSpaceToView(self.listView, 20)
        .leftSpaceToView(self.listView,20)
        .heightIs(100)
        .widthIs(200);
        
        //3、长宽为view1一半，
        UIView *view2 = [UIView new];
        view2.backgroundColor = UIColor.greenColor;
        [self.listView addSubview:view2];
        view2.sd_layout
        .heightRatioToView(view1,.5)
        .widthRatioToView(view1,.5)
        .centerYEqualToView(view1)
        .centerXEqualToView(view1);
        
        //4、距离view1为20，距离右侧屏幕20，顶部、高度和view一样
        UIView *view3 = [UIView new];
        view3.backgroundColor = UIColor.blueColor;
        [self.listView addSubview:view3];
        view3.sd_layout
        .topEqualToView(view1)
        .leftSpaceToView(view1, 20)
        .rightSpaceToView(self.listView, 20)
        .heightIs(view1.height_sd);
        
        lastView = view1;
    }
    
    //TODO:label的父视图根据label的高度自适应
    {
        UILabel *label1 = [UILabel new];
        label1.text = @"这个label会根据这些文字内容高度自适应；\n而这个父view会根据label和view具体情况实现高度自适应。\nGot it! OH YAEH! 这个label会根据这些文字内容高度自适应；而这个父view会根据label和view具体情况实现高度自适应。\nGot it! OH YAEH!";
        label1.backgroundColor = UIColor.whiteColor;
        
        UILabel *label2 = UILabel.new;
        label2.backgroundColor = UIColor.greenColor;
        
        UIView *view4 = [UIView new];
        view4.backgroundColor = UIColor.yellowColor;
        [self.listView addSubview:view4];
        [view4 sd_addSubviews:@[label1, label2]];
        
        label1.sd_layout
        .topSpaceToView(view4,20)
        .leftSpaceToView(view4, 20)
        .widthRatioToView(self.listView, .5)
        .autoHeightRatio(0);
        //设置文本内容自适应，如果这里的参数为大于0的数值则会以此数值作为view的高宽比设置view的高度
        
        label2.sd_layout
        .topEqualToView(label1)
        .leftSpaceToView(label1, 20)
        .rightSpaceToView(view4, 20)
        .heightIs(60);
        
        view4.sd_layout
        .leftSpaceToView(self.listView,20)
        .topSpaceToView(lastView, 20)
        .rightSpaceToView(self.listView,20);
        // 设置view1高度根据子其内容自适应
        [view4 setupAutoHeightWithBottomView:label1 bottomMargin:20];
        
        lastView = view4;
    }
    
    //TODO:label宽度自适应
    {
        UILabel *autoWidthlabel = [UILabel new];
        autoWidthlabel.backgroundColor = UIColorRandom;
        autoWidthlabel.font = [UIFont systemFontOfSize:12];
        autoWidthlabel.text = @"宽度自适应(最大宽度距离父view左、右边距20)宽度自适应(最大宽度距离父view左、右边距20)宽度自适应(最大宽度距离父view左、右边距20)";
        [self.listView addSubview:autoWidthlabel];
        
        autoWidthlabel.sd_layout
        .topSpaceToView(lastView, 20)
        .leftEqualToView(lastView)
        .heightIs(20);
        
        [autoWidthlabel setSingleLineAutoResizeWithMaxWidth:self.view.width - 20*2];
        lastView = autoWidthlabel;
        
        _autoWidthlabel = autoWidthlabel;
    }
    
    //TODO:label高度自适应
    {
        UILabel *autoHeightlabel = [UILabel new];
        autoHeightlabel.backgroundColor = UIColorRandom;
        autoHeightlabel.font = [UIFont systemFontOfSize:12];
        autoHeightlabel.text = @"高度自适应(距离父view顶部左边距20，宽度为100)";
        [self.listView addSubview:autoHeightlabel];
        
        autoHeightlabel.sd_layout
        .topSpaceToView(lastView, 20)
        .leftEqualToView(lastView)
        .widthRatioToView(lastView, .5)
        .autoHeightRatio(0);
        
        autoHeightlabel.sd_cornerRadius = @(5);
        lastView = autoHeightlabel;
    }
    
    //TODO:设置一排固定间距自动宽度子view
    {
        NSInteger count = 4;
        CGFloat margin = 20;
        
        UIView *autoWidthViewsContainer = [UIView new]; //放button的父视图
        
        autoWidthViewsContainer.backgroundColor = [UIColor greenColor];
        
        [self.listView addSubview:autoWidthViewsContainer];
        
        NSMutableArray *temp = [NSMutableArray new];
        
        for (int i = 0; i < count; i++) {
            
            UIView *view = [UIView new];
            
            view.backgroundColor = UIColorRandom;
            
            [autoWidthViewsContainer addSubview:view];
            
            view.sd_layout.autoHeightRatio(.5);// 设置高度约束，长宽比
            view.sd_cornerRadius = @(5);
            
            [temp addObject:view];
            
        }
        
        autoWidthViewsContainer.sd_layout
        .leftSpaceToView(self.listView, 20)
        .rightSpaceToView(self.listView,20)
        .topSpaceToView(lastView,20);
        
        // 此步设置之后_autoWidthViewsContainer的高度可以根据子view自适应
        [autoWidthViewsContainer setupAutoWidthFlowItems:[temp copy]
                                    withPerRowItemsCount:count
                                          verticalMargin:margin
                                        horizontalMargin:margin
                                       verticalEdgeInset:margin
                                     horizontalEdgeInset:margin];
        
        lastView = autoWidthViewsContainer;
    }
    
    //TODO:设置一排固定宽度自动间距子view
    {
        NSInteger count = 4;
        CGFloat margin = 20;
        CGFloat itemWidth = (self.view.width_sd - 20*2 - (count - 1)*20)/count;
        
        UIView *autoMarginViewsContainer = [UIView new];
        
        autoMarginViewsContainer.backgroundColor = [UIColor lightGrayColor];
        
        [self.listView addSubview:autoMarginViewsContainer];
        
        NSMutableArray *temp = [NSMutableArray new];
        
        for (int i =0; i < count; i++) {
            
            UIView *view = [UIView new];
            
            view.backgroundColor = UIColorRandom;
            
            [autoMarginViewsContainer addSubview:view];
            
            view.sd_layout.autoHeightRatio(0.5);
            view.sd_cornerRadius = @(5);
            
            [temp addObject:view];
            
        }
        
        autoMarginViewsContainer.sd_layout
        .leftSpaceToView(self.listView, 20)
        .rightSpaceToView(self.listView, 20)
        .topSpaceToView(lastView, 20);
        
        //此步设置之后autoMarginViewsContainer的高度可以根据子view自适应
        [autoMarginViewsContainer setupAutoMarginFlowItems:[temp copy] withPerRowItemsCount:count itemWidth:itemWidth verticalMargin:margin verticalEdgeInset:margin horizontalEdgeInset:margin];
        
        lastView = autoMarginViewsContainer;
    }
    
    //cell自定义高度
    {
        UIButton *btn = UIButton.new;
        btn.backgroundColor = UIColorRandom;
        [btn setTitle:@"cell自定义高度" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(turnToCellDemo) forControlEvents:UIControlEventTouchUpInside];
        [self.listView addSubview:btn];
        btn.sd_layout
        .topSpaceToView(lastView, 20)
        .leftEqualToView(lastView)
        .rightEqualToView(lastView)
        .heightIs(50);
        
        lastView = btn;
    }
    [self.listView setupAutoContentSizeWithBottomView:lastView bottomMargin:20];
}

- (void)turnToCellDemo{
    [self.navigationController pushViewController:SDTabelViewController.new animated:YES];
}

#pragma mark - *********** lazy ***********

- (UIScrollView *)listView{
    if (!_listView) {
        _listView = UIScrollView.new;
        _listView.backgroundColor = UIColorViewBG;
    }
    return _listView;
}

#pragma mark - *********** 旋转设置 ***********

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

@end
