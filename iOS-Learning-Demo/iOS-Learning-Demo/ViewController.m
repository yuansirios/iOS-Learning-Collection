//
//  ViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/20.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ViewController.h"
#import "WeakArray.h"
#import "YSVedioViewController.h"
#import "YSRotateViewController.h"
#import "SDListViewController.h"

#define YSTitleKey   @"title"
#define YSEventKey   @"event"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_itemList;
}

@property (nonatomic,strong) UITableView *listTableView;


@property (nonatomic,strong) UIView *topView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"示例";
    
    _itemList = @[@{YSTitleKey:@"[1]数组（字典）中添加弱引用",YSEventKey:@"testWeakArray"},
                  @{YSTitleKey:@"[2]屏幕旋转-方案一",YSEventKey:@"testScreenRotation"},
                  @{YSTitleKey:@"--屏幕旋转-方案二",YSEventKey:@"testScreenRotation2"},
                  @{YSTitleKey:@"[3]SDAutoLayout",YSEventKey:@"testSDAutoLayout"}];
    
    [self.view addSubview:self.listTableView];
    [self layout];
}

#pragma mark - *********** layout ***********

- (void)layout{
    self.listTableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark - *********** lazy ***********

- (UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = UITableView.new;
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.tableFooterView = UIView.new;
    }
    return _listTableView;
}

#pragma mark - *********** delegate ***********

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSDictionary *dic = _itemList[indexPath.row];
    cell.textLabel.text = dic[YSTitleKey];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = _itemList[indexPath.row];
    SEL selector = NSSelectorFromString(dic[YSEventKey]);
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector];
    }
}

#pragma mark - *********** Event ***********

- (void)testWeakArray{
    WeakArray *arr = WeakArray.new;
    [arr run];
}

- (void)testScreenRotation{
    YSVedioViewController *vc = YSVedioViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testScreenRotation2{
    YSRotateViewController *vc = [[YSRotateViewController alloc]init];
    YSBaseNavigationController *nv = [[YSBaseNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nv animated:YES completion:nil];
}

- (void)testSDAutoLayout{
    SDListViewController *vc = SDListViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
