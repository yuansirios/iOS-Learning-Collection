//
//  LeaksTestViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/11/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "LeaksTestViewController.h"

typedef void(^TestBlock)(void);

@interface LeaksTestViewController ()

@property (nonatomic,copy) TestBlock block;

@property (nonatomic,copy) NSString *str;

@end

@implementation LeaksTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.str = @"Hello World!!!";
    
    @weakify(self)
    self.block = ^{
        @strongify(self)
        NSLog(@"%@",self.str);
    };
    self.block();
}

@end


