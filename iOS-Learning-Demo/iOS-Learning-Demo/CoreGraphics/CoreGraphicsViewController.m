//
//  CoreGraphicsViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/3/12.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "CoreGraphicsViewController.h"
#import "CoreGraphicsView.h"

@interface CoreGraphicsViewController()

@property (nonatomic,strong) CoreGraphicsView *coreGraphicsView;

@end

@implementation CoreGraphicsViewController

#pragma mark - *********** initViews ***********

- (void)addSubviews{
    self.title = @"CoreGraphics示例";
    [self.view addSubview:self.coreGraphicsView];
    //self.coreGraphicsView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.coreGraphicsView.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .widthIs(self.view.width - 40)
    .heightEqualToWidth();
}

#pragma mark - *********** lazy ***********

- (CoreGraphicsView *)coreGraphicsView{
    if (!_coreGraphicsView) {
        _coreGraphicsView = CoreGraphicsView.new;
        _coreGraphicsView.backgroundColor = UIColor.cyanColor;
        _coreGraphicsView.longitudeTitles = @[@"11/26",@"12/3",@"12/10",@"12/17",@"12/24",@"12/31",@"1/7",@"1/14"];
        _coreGraphicsView.latitudeTitles = @[@"0",@"1000",@"2000",@"3000",@"4000"];
    }
    return _coreGraphicsView;
}

@end
