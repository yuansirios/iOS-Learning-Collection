//
//  ColdKnowledgeViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/5.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ColdKnowledgeViewController.h"
#import "WeakArray.h"
#import "NSURLProtocolViewController.h"
#import "YSCheckLockStatus.h"
#import "A.h"

#import "LeaksTestViewController.h"
#import "MessageForwardViewController.h"
#import "AspectUtil.h"

@interface ColdKnowledgeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_itemList;
    YSCheckLockStatus *_checkLock;
}

@property (nonatomic,strong) UITableView *listTableView;

@end

@implementation ColdKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"冷知识";
    _itemList = @[@{YSTitleKey:@"[1]数组（字典）中添加弱引用",YSEventKey:@"testWeakArray"},
                  @{YSTitleKey:@"[2]NSURLProtocol",YSEventKey:@"testNSURLProtocol"},
                  @{YSTitleKey:@"[3]检测锁屏和解锁",YSEventKey:@"testScreenLock"},
                  @{YSTitleKey:@"[4]super.class",YSEventKey:@"testSuperClass"},
                  @{YSTitleKey:@"[5]NSString.copy",YSEventKey:@"testStringCopy"},
                  @{YSTitleKey:@"[6]自定义内存检测工具",YSEventKey:@"testLeaks"},
    @{YSTitleKey:@"[7]消息转发机制",YSEventKey:@"testMessageForward"},
    @{YSTitleKey:@"[8]Aspect框架使用",YSEventKey:@"testAspect"}];
    
    [self.view addSubview:self.listTableView];
    [self layout];
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
        SafePerformSelector([self performSelector:selector]);
    }
}

#pragma mark - *********** Event ***********

- (void)testWeakArray{
    WeakArray *arr = WeakArray.new;
    [arr run];
}

- (void)testNSURLProtocol{
    [NSURLProtocol registerClass:[YSNSURLProtocol class]];
    [self.navigationController pushViewController:NSURLProtocolViewController.new animated:YES];
}

- (void)testScreenLock{
    _checkLock = YSCheckLockStatus.new;
    [_checkLock registerforDeviceLockNotif];
}

- (void)testSuperClass{
    [[A alloc]show];
}

- (void)testStringCopy{
    [[A alloc]testCopy];
}

- (void)testLeaks{
    [self.navigationController pushViewController:LeaksTestViewController.new animated:YES];
}

- (void)testMessageForward{
    [self.navigationController pushViewController:MessageForwardViewController.new animated:YES];
}

- (void)testAspect{
    
    // [AspectUtil setUp];
    
    AspectUtil *as = AspectUtil.new;
        
    [AspectUtil setUpObj:as];
    
    [as show];
    
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

@end
