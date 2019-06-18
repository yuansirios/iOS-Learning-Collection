//
//  MakrViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/14.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "MarkViewController.h"
#import "YSMarkView.h"

@interface MarkViewController ()

@end

@implementation MarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    YSMarkView *markView = YSMarkView.new;
    markView.frame = CGRectMake(0, 100, self.view.width, 0);
    markView.backgroundColor = UIColor.greenColor;
    [self.view addSubview:markView];
    
    [markView loadItems:@[@"111111111",@"111111111",@"111111111",@"12313123123123123",@"123",@"123123123123",@"13",@"234234234"]];
}

@end
