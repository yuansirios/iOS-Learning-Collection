//
//  AdapterViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "AdapterViewController.h"
#import "BusinessCardView.h"

#import "NormalModel.h"
#import "NormalModelAdapter.h"

#import "SpecialModel.h"
#import "SpecialModelAdapter.h"

#import "CommonUsedAdapter.h"

@interface AdapterViewController ()

@end

@implementation AdapterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"适配器";
    
//    [self normalModelAdapterExample];
    
    [self specialModelAdapterExample];
//
//    [self commonUsedAdapterExample];
}

/**
 *  适配类型1Model
 */
- (void)normalModelAdapterExample {
    
    // 数据源
    NormalModel *data = [[NormalModel alloc] init];
    data.name         = @"YouXianMing";
    data.lineColor    = [UIColor redColor];
    data.phoneNumber  = @"159 - 1051 - 4636";
    
    // 适配器类
    BusinessCardAdapter *adapter = [[NormalModelAdapter alloc] initWithData:data];
    BusinessCardView *cardView   = [[BusinessCardView alloc] initWithFrame:BUSINESS_FRAME];
    cardView.center              = self.view.center;
    [cardView loadData:adapter];
    
    [self.view addSubview:cardView];
}

/**
 *  适配类型2Model
 */
- (void)specialModelAdapterExample {
    
    // 数据源
    SpecialModel *data = [[SpecialModel alloc] init];
    data.name          = @"NoZuoNoDie";
    data.colorString   = @"green";
    data.phoneNumber   = @"159 - 1051 - 4636";
    
    // 适配器类
    BusinessCardAdapter *adapter = [[SpecialModelAdapter alloc] initWithData:data];
    BusinessCardView *cardView   = [[BusinessCardView alloc] initWithFrame:BUSINESS_FRAME];
    cardView.center              = self.view.center;
    [cardView loadData:adapter];
    
    [self.view addSubview:cardView];
}

/**
 *  通用型适配器
 */
- (void)commonUsedAdapterExample {
    
    // 数据源
    NormalModel *data1 = [[NormalModel alloc] init];
    data1.name         = @"YouXianMing";
    data1.lineColor    = [UIColor redColor];
    data1.phoneNumber  = @"159 - 1051 - 4636";
    
    // 数据源
    SpecialModel *data2 = [[SpecialModel alloc] init];
    data2.name          = @"NoZuoNoDie";
    data2.colorString   = @"green";
    data2.phoneNumber   = @"159 - 1051 - 4636";
    
    // 通用型适配器类(可以加载数据data1或者data2)
    BusinessCardAdapter *adapter = [[CommonUsedAdapter alloc] initWithData:data1];
    BusinessCardView *cardView   = [[BusinessCardView alloc] initWithFrame:BUSINESS_FRAME];
    cardView.center              = self.view.center;
    [cardView loadData:adapter];
    
    [self.view addSubview:cardView];
}

@end
