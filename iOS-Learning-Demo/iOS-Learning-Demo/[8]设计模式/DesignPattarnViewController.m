//
//  DesignPattarnViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/31.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "DesignPattarnViewController.h"

//策略
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
//代理
#import "ConcreteProxy.h"
#import "MessageProtocol.h"
//享元
#import "CoffeeShop.h"
//责任链
#import "HeadChain.h"
#import "PhoneNumChain.h"
#import "EmailChain.h"
#import "UserNameChain.h"
#import "EndChain.h"
//模板
#import "Chess.h"
#import "Monopoly.h"
//访问者
#import "ElementCollection.h"
#import "ElementA.h"
#import "ElementB.h"
#import "Visitor.h"
//迭代器
#import "LinkedList.h"
#import "LinkedListIterator.h"
//中介者
#import "MediatorViewController.h"

@interface DesignPattarnViewController ()<UITableViewDelegate,UITableViewDataSource,SubscriptionServiceCenterProtocol>{
    NSArray *_itemList;
}

@property (nonatomic,strong) UITableView *listTableView;

@end

@implementation DesignPattarnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemList = @[@{YSTitleKey:@"[1]策略",YSEventKey:@"testStrategy"},
                  @{YSTitleKey:@"[2]装饰器",YSEventKey:@"testDecorator"},
                  @{YSTitleKey:@"[3]简单工厂",YSEventKey:@"testFactory"},
                  @{YSTitleKey:@"[4]抽象工厂",YSEventKey:@"testAbstractFactory"},
                  @{YSTitleKey:@"[5]观察者",YSEventKey:@"testObserve"},
                  @{YSTitleKey:@"[6]代理",YSEventKey:@"testAbstract"},
                  @{YSTitleKey:@"[7]享元",YSEventKey:@"testFlyweight"},
                  @{YSTitleKey:@"[8]责任链",YSEventKey:@"testChainOfResponsibility"},
                  @{YSTitleKey:@"[9]模板",YSEventKey:@"testTemplate"},
                  @{YSTitleKey:@"[10]访问者",YSEventKey:@"testVisitor"},
                  @{YSTitleKey:@"[11]迭代器",YSEventKey:@"testIterator"},
                  @{YSTitleKey:@"[12]中介者",YSEventKey:@"testMediator"}];
    
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

//TODO:策略
- (void)testStrategy{
    [self.navigationController pushViewController:StrategyPatternViewController.new animated:YES];
}

//TODO:装饰器
- (void)testDecorator{
    DecoratorGamePlay *play = DecoratorGamePlay.new;
    [play cheat];
    NSLog(@"play.lives:%lu",play.lives);
    
    GamePlay *game = GamePlay.new;
    [game cheat];
    NSLog(@"game:%lu",game.lives);
}

//TODO:简单工厂
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

//TODO:抽象工厂
- (void)testAbstractFactory{
    BrandingFactory *acme = [AcmeBrandingFactory factory];
    BrandingFactory *sierra = [SierraBrandingFactory factory];
    
    [acme brandedView];
    [acme brandedMainButton];
    
    [sierra brandedView];
    [sierra brandedMainButton];
}

//TODO:观察者
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

//TODO:代理
- (void)testAbstract{
    ConcreteProxy *proxy = [[ConcreteProxy alloc] initWithCustomer:self];
    [proxy helloWorld];
    [proxy goodBye];
}

- (void)helloWorld {
    NSLog(@"helloWorld");
}

//TODO:享元
/**
 享元模式使用共享物件，用来尽可能减少内存使用量以及分享资讯给尽可能多的相似物件；
 它适合用于只是因重复而导致使用无法令人接受的大量内存的大量物件。
 通常物件中的部分状态是可以分享。
 常见做法是把它们放在外部数据结构，当需要使用时再将它们传递给享元。
 */
- (void)testFlyweight{
    // 创建咖啡厅
    CoffeeShop *coffeeShop = [[CoffeeShop alloc] init];
    
    // 相同类型的数据公用
    [coffeeShop takeOrder:@"Cappuccino" table:1];
    [coffeeShop takeOrder:@"Frappe"     table:10];
    [coffeeShop takeOrder:@"Cappuccino" table:6];
    [coffeeShop takeOrder:@"Espresso"   table:9];
    [coffeeShop takeOrder:@"Frappe"     table:8];
    
    // 开始服务
    [coffeeShop serve];
}


//TODO:责任链
/**
 在责任链模式里，很多对象由每一个对象对其下家的引用而连接起来形成一条链。
 请求在这个链上传递，直到链上的某一个对象决定处理此请求。
 发出这个请求的客户端并不知道链上的哪一个对象最终处理这个请求，
 这使得系统可以在不影响客户端的情况下动态地重新组织和分配责任。
 */
- (void)testChainOfResponsibility{
    // 创建责任链对象
    id <ChainOfResponsibilityProtocol> headChain     = [[HeadChain alloc] init];
    id <ChainOfResponsibilityProtocol> phoneNumChain = [[PhoneNumChain alloc] init];
    id <ChainOfResponsibilityProtocol> emailChain    = [[EmailChain alloc] init];
    id <ChainOfResponsibilityProtocol> userNameChain = [[UserNameChain alloc] init];
    id <ChainOfResponsibilityProtocol> endChain      = [[EndChain alloc] init];
    
    // 链接责任链
    headChain.successor     = phoneNumChain;
    phoneNumChain.successor = emailChain;
    emailChain.successor    = userNameChain;
    userNameChain.successor = endChain;
    
    // 处理事件
    [headChain handlerRequest:@"15910514636"];
    [headChain handlerRequest:@"705786299@qq.com"];
    [headChain handlerRequest:@"705786230"];
    [headChain handlerRequest:@"---"];
}

//TODO:模板
/**
 定义一个操作中的算法的骨架，而将步骤延迟到子类中。
 模板方法使得子类可以不改变一个算法的结构即可重定义算法的某些特定步骤。
 */
- (void)testTemplate{
    // chess game
    id <GameProtocol> chess = [[Chess alloc] init];
    chess.playerCount       = 2;
    [chess initializeGame];
    [chess makePlay];
    [chess endOfGame];
    
    // monopoly game
    id <GameProtocol> monopoly = [[Monopoly alloc] init];
    monopoly.playerCount       = 4;
    [monopoly initializeGame];
    [monopoly makePlay];
    [monopoly endOfGame];
}

//TODO:访问者
/**
 表示一个作用于某对象结构中的各元素的操作，它使你可以在不改变各元素类的前提下定义作用于这些元素的新操作。
 
 1.Visitor 抽象访问者角色，为该对象结构中具体元素角色声明一个访问操作接口。
 该操作接口的名字和参数标识了发送访问请求给具体访问者的具体元素角色，这样访问者就可以通过该元素角色的特定接口直接访问它。
 2.ConcreteVisitor.具体访问者角色，实现Visitor声明的接口。
 3.Element 定义一个接受访问操作(accept())，它以一个访问者(Visitor)作为参数。
 4.ConcreteElement 具体元素，实现了抽象元素(Element)所定义的接受操作接口。
 5.ObjectStructure 结构对象角色，这是使用访问者模式必备的角色。
 它具备以下特性：能枚举它的元素；
 可以提供一个高层接口以允许访问者访问它的元素；
 如有需要，可以设计成一个复合对象或者一个聚集（如一个列表或无序集合）。
 */
- (void)testVisitor{
    // 创建集合
    ElementCollection *collection = [[ElementCollection alloc] init];
    
    // 给集合添加元素
    [collection addElement:[[ElementA alloc] init] withKey:@"ElementA"];
    [collection addElement:[[ElementB alloc] init] withKey:@"ElementB"];
    
    // 遍历出元素
    for (int i = 0; i < collection.allKeys.count; i++) {
        
        NSString            *key     = collection.allKeys[i];
        id <ElementProtocol> element = [collection elementWithKey:key];
        
        // 接收访问者
        Visitor *visitor = [[Visitor alloc] init];
        [element accept:visitor];
    }
}

//TODO:迭代器
/**
 提供一种方法顺序访问一个聚合对象中的各种元素，而又不暴露该对象的内部表示。
 */
- (void)testIterator{
    // 创建链表结构
    LinkedList *linkedList = [[LinkedList alloc] init];
    
    // 添加链表元素
    [linkedList addItem:@"1"];
    [linkedList addItem:@"2"];
    [linkedList addItem:@"3"];
    [linkedList addItem:@"4"];
    [linkedList addItem:@"5"];
    
    // 创建迭代器
    id <IteratorProtocol> iterator = [linkedList createIterator];
    
    // 进行元素迭代
    while ([iterator hasNext]) {
        NSLog(@"%@", iterator.item);
        [iterator next];
    }
}

//TODO:中介者
/**
 用一个中介对象来封装一系列的对象交互。中介者使各对象不需要显式地相互引用，从而使其耦合松散，而且可以独立地改变它们之间的交互。
 注：中介者对象本身没有复用价值，只是将逻辑操作封装在一个类里面而已
 */
- (void)testMediator{
    [self.navigationController pushViewController:MediatorViewController.new animated:YES];
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
