//
//  DecoratorGamePlay.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "DecoratorGamePlay.h"
#import "GamePlay.h"

@interface DecoratorGamePlay ()

@property (nonatomic, strong) GamePlay  *gamePlay;

@end

@implementation DecoratorGamePlay

#pragma mark - 初始化
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        // 装饰对象包含一个真实对象的引用
        self.gamePlay = [GamePlay new];
    }
    
    return self;
}

#pragma mark - 让真实对象的引用执行对应的方法
- (void)up {
    
    [_gamePlay up];
}

- (void)down {
    
    [_gamePlay down];
}

- (void)left {
    
    [_gamePlay left];
}

- (void)right {
    
    [_gamePlay right];
}

- (void)select {
    
    [_gamePlay select];
}

- (void)start {
    
    [_gamePlay start];
}

- (void)commandA {
    
    [_gamePlay commandA];
}

- (void)commandB {
    
    [_gamePlay commandB];
}

#pragma mark - 装饰器新添加的方法
- (void)cheat {
    
    [_gamePlay up];
    [_gamePlay down];
    [_gamePlay up];
    [_gamePlay down];
    [_gamePlay left];
    [_gamePlay right];
    [_gamePlay left];
    [_gamePlay right];
    [_gamePlay commandA];
    [_gamePlay commandB];
    [_gamePlay commandA];
    [_gamePlay commandB];
}

@synthesize lives = _lives;
- (NSInteger)lives {
    
    // 相关处理逻辑
    return 10;
}

@end
