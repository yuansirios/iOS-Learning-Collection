//
//  CommandViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "CommandViewController.h"

#import "Invoker.h"
#import "Receiver.h"
#import "MakeDarkerCommand.h"
#import "MakeLighterCommand.h"

typedef enum : NSUInteger {
    
    kAddButtonTag = 10,
    kDelButtonTag,
    
} ViewControllerEnumValue;

@interface CommandViewController ()

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *delButton;

/**
 *  客户端接收器
 */
@property (nonatomic, strong) Receiver *reciver;

@end

@implementation CommandViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"命令模式";
    
    [self initButtons];
    
    // 创建客户端接收器
    self.reciver           = [[Receiver alloc] init];
    self.reciver.colorView = self.view;
}

- (void)buttonsEvent:(UIButton *)button {
    
    if (button.tag == kAddButtonTag) {
        
        // 生成命令
        MakeDarkerCommand *darkerCommand = [[MakeDarkerCommand alloc] initWithReceiver:self.reciver parameter:0.1];
        
        // 执行命令
        [[Invoker sharedInstance] addAndExecute:darkerCommand];
        
    } else if (button.tag == kDelButtonTag) {
        
        // 生成命令
        MakeLighterCommand *lighterCommand = [[MakeLighterCommand alloc] initWithReceiver:self.reciver parameter:0.1];
        
        // 执行命令
        [[Invoker sharedInstance] addAndExecute:lighterCommand];
    }
}

#pragma mark - 无关初始化

- (void)initButtons {
    
    // delButton
    self.delButton     = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 30, 30)];
    
    self.delButton.tag               = kDelButtonTag;
    self.delButton.layer.borderWidth = 1.f;
    
    [self.delButton setTitle:@"-"
                    forState:UIControlStateNormal];
    
    [self.delButton setTitleColor:[UIColor redColor]
                         forState:UIControlStateNormal];
    
    [self.delButton addTarget:self
                       action:@selector(buttonsEvent:)
             forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.delButton];
    
    // addButton
    self.addButton     = [[UIButton alloc] initWithFrame:CGRectMake(10 + 100, 100, 30, 30)];
    
    self.addButton.tag               = kAddButtonTag;
    self.addButton.layer.borderWidth = 1.f;
    
    [self.addButton setTitle:@"+"
                    forState:UIControlStateNormal];
    
    [self.addButton setTitleColor:[UIColor redColor]
                         forState:UIControlStateNormal];
    
    [self.addButton addTarget:self
                       action:@selector(buttonsEvent:)
             forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addButton];
}

@end
