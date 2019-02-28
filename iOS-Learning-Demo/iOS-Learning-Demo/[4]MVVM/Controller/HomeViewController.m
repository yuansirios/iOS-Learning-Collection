//
//  HomeViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "HomeViewModel.h"

@interface HomeViewController ()

@property (nonatomic,strong) HomeView *homeView;
@property (nonatomic,strong) HomeViewModel *homeViewModel;

@end

@implementation HomeViewController

#pragma mark - *********** initViews ***********

- (void)addSubviews{
    self.title = @"MVVM示例";
    [self.view addSubview:self.homeView];
    self.homeView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark - *********** lazy ***********

- (HomeView *)homeView{
    if (!_homeView) {
        _homeView = [[HomeView alloc] initWithViewModel:self.homeViewModel];
    }
    return _homeView;
}

- (HomeViewModel *)homeViewModel{
    if (!_homeViewModel) {
        _homeViewModel = [[HomeViewModel alloc] init];
        [_homeViewModel.loadDataCommand execute:nil];
    }
    return _homeViewModel;
}

@end
