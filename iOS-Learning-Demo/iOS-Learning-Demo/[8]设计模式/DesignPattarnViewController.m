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
//组合
#import "CompositeViewController.h"
//命令
#import "CommandViewController.h"
//生成器
#import "VehicleAssemblyPlant.h"
#import "SportsCar.h"
#import "SuperBike.h"
//备忘录
#import "Model.h"
#import "MementoCenter.h"
//外观
#import "ShapeMaker.h"
//桥接
#import "GameBoyEmulator.h"
#import "GameBoyConsoleController.h"
#import "GameGearEmulator.h"
#import "GameGearConsoleController.h"
//适配器
#import "AdapterViewController.h"

@interface DesignPattarnViewController ()<UITableViewDelegate,UITableViewDataSource,SubscriptionServiceCenterProtocol>{
    NSArray *_itemList;
}

@property (nonatomic,strong) UITableView *listTableView;

@end

@implementation DesignPattarnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设计模式";
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
                  @{YSTitleKey:@"[12]中介者",YSEventKey:@"testMediator"},
                  @{YSTitleKey:@"[13]组合",YSEventKey:@"testComposite"},
                  @{YSTitleKey:@"[14]命令",YSEventKey:@"testCommand"},
                  @{YSTitleKey:@"[15]生成器",YSEventKey:@"testBuilder"},
                  @{YSTitleKey:@"[16]备忘录",YSEventKey:@"testMemento"},
                  @{YSTitleKey:@"[17]外观",YSEventKey:@"testFacade"},
                  @{YSTitleKey:@"[18]桥接",YSEventKey:@"testBridge"},
                  @{YSTitleKey:@"[19]适配器",YSEventKey:@"testAdapter"}];
    
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

//TODO:组合
/*
 将对象组合成树形结构以表示“部分-整体”的层次结构，组合模式使得用户对单个对象和组合对象的使用具有一致性。
 掌握组合模式的重点是要理解清楚 “部分/整体” 还有 ”单个对象“ 与 "组合对象" 的含义。
 */
- (void)testComposite{
    [self.navigationController pushViewController:CompositeViewController.new animated:YES];
}

//TODO:命令
/*
 命令对象封装了如何对目标执行指令的信息，因此客户端或调用者不必了解目标的任何细节，
 却仍可以对他执行任何已有的操作。
 通过把请求封装成对象，客户端可以把它参数化并置入队列或日志中，也能够支持可撤销操作。
 命令对象将一个或多个动作绑定到特定的接收器。
 命令模式消除了作为对象的动作和执行它的接收器之间的绑定。
 */
- (void)testCommand{
    [self.navigationController pushViewController:CommandViewController.new animated:YES];
}

//TODO:生成器
/*
 1. 将构建复杂对象的过程拆分成一个一个的模块,通过统一的指导者来指导对象的构建过程称之为生成器模式
 2. 生成器模式适合用于构建组合的对象
 */
- (void)testBuilder{
    // 生成器 + 构造图
    VehicleBuilder *sportCar  = [VehicleAssemblyPlant vehicleAssembly:[SportsCar new]];
    VehicleBuilder *superBike = [VehicleAssemblyPlant vehicleAssembly:[SuperBike new]];
    
    NSLog(@"%@", sportCar.vehicleInfo);
    NSLog(@"%@", superBike.vehicleInfo);
}

//TODO:备忘录
/*
 1. 在不破坏封装的情况下，捕获一个对象的内部状态，并在该对象之外保存这个状态，这样以后就可以将该对象恢复到原先保存的状态
 2. 本人已经将创建状态与恢复状态的逻辑抽象成了协议，并配合备忘录中心一起使用
 */
- (void)testMemento{
    // 初始化model
    Model *model = [[Model alloc] init];
    
    // 获取状态
    id state = [MementoCenter mementoObjectWithKey:@"Model"];
    
    // 恢复状态
    [model recoverFromState:state];
    
    // 打印
    NSLog(@"name:%@  age:%@", model.name, model.age);
    
    // 赋值
    model.name   = @"YouXianMing";
    model.age    = @27;
    
    // 存储状态
    [MementoCenter saveMementoObject:model withKey:@"Model"];
}

//TODO:外观
/*
 1. 当客服端需要使用一个复杂的子系统(子系统之间关系错综复杂),但又不想和他们扯上关系时,
 我们需要单独的写出一个类来与子系统交互,隔离客户端与子系统之间的联系,客户端只与这个单独写出来的类交互
 2. 外观模式实质为为系统中的一组接口提供一个统一的接口,外观定义了一个高层接口,让子系统易于使用
 */
- (void)testFacade{
    [ShapeMaker drawCircleAndRectangle];
    [ShapeMaker drawCircleAndSquare];
    [ShapeMaker drawAll];
}

//TODO:桥接
/*
 1. 桥接模式为把抽象层次结构从实现中分离出来,使其可以独立变更,
 抽象层定义了供客户端使用的上层抽象接口,
 实现层次结构定义了供抽象层次使用的底层接口,
 实现类的引用被封装于抽象层的实例中,桥接就形成了.
 
 2. 桥接模式可以解决具有功能类似但又不完全相同的某种功能架构,为了能让实现更加灵活.
 */
- (void)testBridge{
    GameBoyConsoleController *gameBoyConsoleController = [GameBoyConsoleController new];
    gameBoyConsoleController.emulator                  = [GameBoyEmulator new];
    [gameBoyConsoleController up];
    
    GameGearConsoleController *gameGearConsoleController = [GameGearConsoleController new];
    gameGearConsoleController.emulator                   = [GameGearEmulator new];
    [gameGearConsoleController up];
}

//TODO:适配器
/*
 1. 为了让客户端尽可能的通用,我们使用适配器模式来隔离客户端与外部参数的联系,只让客户端与适配器通信.
 2. 本教程实现了适配器模式的类适配器与对象适配器两种模式,各有优缺点.
 3. 如果对面向对象基本原理以及设计模式基本原理不熟悉,本教程会变得难以理解.
 */
- (void)testAdapter{
     [self.navigationController pushViewController:AdapterViewController.new animated:YES];
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
