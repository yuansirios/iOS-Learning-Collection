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
#import "HomeViewController.h"
#import "YSPopViewController.h"
#import "CoreGraphicsViewController.h"
#import "PdiDefectViewController.h"
#import "YSImagePickViewController.h"
#import "StrategyPatternViewController.h"
//装饰器
#import "DecoratorGamePlay.h"
#import "GamePlay+More.h"
//简单工厂
#import "DeviceCreator.h"
#import "BaseDevice.h"
//抽象工厂
#import "BrandingFactory.h"
#import "AcmeBrandingFactory.h"
#import "SierraBrandingFactory.h"
//观察者
#import "SubscriptionServiceCenter.h"

#define YSTitleKey   @"title"
#define YSEventKey   @"event"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SubscriptionServiceCenterProtocol>{
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
                  @{YSTitleKey:@"[3]SDAutoLayout",YSEventKey:@"testSDAutoLayout"},
                  @{YSTitleKey:@"[4]MVVM",YSEventKey:@"testMVVM"},
                  @{YSTitleKey:@"[5]自定义PopView",YSEventKey:@"testPopView"},
                  @{YSTitleKey:@"[6]自定义标注视图",YSEventKey:@"testMarkView"},
                  @{YSTitleKey:@"[7]图片选择器",YSEventKey:@"testImagePick"},
                  @{YSTitleKey:@"[8]设计模式-策略",YSEventKey:@"testStrategy"},
                  @{YSTitleKey:@"--设计模式-装饰器",YSEventKey:@"testDecorator"},
                  @{YSTitleKey:@"--设计模式-简单工厂",YSEventKey:@"testFactory"},
                  @{YSTitleKey:@"--设计模式-抽象工厂",YSEventKey:@"testAbstractFactory"},
                  @{YSTitleKey:@"--设计模式-观察者",YSEventKey:@"testObserve"},
                  @{YSTitleKey:@"[9]CoreGraphics",YSEventKey:@"testCoreGraphics"}];
    
    [self.view addSubview:self.listTableView];
    [self layout];
}

- (void)layoutNavigation{}

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

- (void)testMVVM{
    HomeViewController *vc = HomeViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testPopView{
    [self.navigationController pushViewController:YSPopViewController.new animated:YES];
}

- (void)testMarkView{
    [self.navigationController pushViewController:PdiDefectViewController.new animated:YES];
}

- (void)testImagePick{
    [self.navigationController pushViewController:YSImagePickViewController.new animated:YES];
}

- (void)testCoreGraphics{
    [self.navigationController pushViewController:CoreGraphicsViewController.new animated:YES];
}

- (void)testStrategy{
    [self.navigationController pushViewController:StrategyPatternViewController.new animated:YES];
}

- (void)testDecorator{
    DecoratorGamePlay *play = DecoratorGamePlay.new;
    [play cheat];
    NSLog(@"play.lives:%lu",play.lives);
    
    GamePlay *game = GamePlay.new;
    [game cheat];
    NSLog(@"game:%lu",game.lives);
}

- (void)testFactory{
    BaseDevice *iphone = [DeviceCreator deviceCreatorWithDeviceType:kiPhone];
    BaseDevice *android = [DeviceCreator deviceCreatorWithDeviceType:kAndroid];
    BaseDevice *windows = [DeviceCreator deviceCreatorWithDeviceType:kWindows];
    
    [iphone phoneCall];
    NSLog(@"iphone:%@",[iphone systemInfomation]);
    [android phoneCall];
    NSLog(@"android:%@",[android systemInfomation]);
    [windows phoneCall];
    NSLog(@"windows:%@",[windows systemInfomation]);
}

- (void)testAbstractFactory{
    BrandingFactory *acme = [AcmeBrandingFactory factory];
    BrandingFactory *sierra = [SierraBrandingFactory factory];
    
    [acme brandedView];
    [acme brandedMainButton];
    
    [sierra brandedView];
    [sierra brandedMainButton];
}

- (void)testObserve{
    NSString *number = @"111";
    //创建订阅号
    [SubscriptionServiceCenter createSubscriptionNumber:number];
    
    //添加订阅号
    [SubscriptionServiceCenter addCustomer:self withSubscriptionNumber:number];
    
    //发送消息
    [SubscriptionServiceCenter sendMessage:@"我是消息" toSubscriptionNumber:number];
}

- (void)subscriptionMessage:(id)message subscriptionNumber:(NSString *)subscriptionNumber{
    NSLog(@"收到消息了:%@ number:%@",message,subscriptionNumber);
}

@end
