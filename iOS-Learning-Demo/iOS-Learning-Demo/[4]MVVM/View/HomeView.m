//
//  HomeView.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "HomeView.h"
#import "HomeViewModel.h"

@interface HomeView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *homeTableView;
@property (nonatomic,strong) HomeViewModel *homeViewModel;

@end

@implementation HomeView

- (instancetype)initWithViewModel:(id<ViewModelProtocol>)viewModel{
    self.homeViewModel = (HomeViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark - *********** initViews ***********

- (void)setupViews{
    [self addSubview:self.homeTableView];
    self.homeTableView
    .sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark - *********** RAC ***********

- (void)racViewModel{
    @weakify(self)
    [[self.homeViewModel.loadDataSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.homeTableView reloadData];
    }];
}
    
#pragma mark - *********** UITabelViewDelegate ***********

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.homeViewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdetify = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    HomeModel *model = self.homeViewModel.dataArray[indexPath.row];
    
    cell.textLabel.text = model.title;
    
    return cell;
}

#pragma mark - *********** lazy ***********

- (UITableView *)homeTableView{
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] init];
        _homeTableView.backgroundColor = UIColorViewBG;
        _homeTableView.tableFooterView = [[UIView alloc] init];
        _homeTableView.dataSource = self;
        _homeTableView.delegate = self;
        
        if (@available(iOS 11.0, *)) {
            _homeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _homeTableView;
}

- (HomeViewModel *)homeViewModel{
    if (!_homeViewModel) {
        _homeViewModel = [[HomeViewModel alloc] init];
    }
    return _homeViewModel;
}

@end
