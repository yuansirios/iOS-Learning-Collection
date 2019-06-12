//
//  BaiduMapViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/6.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "BaiduMapViewController.h"
#import "YSLocationService.h"
#import "YSMapView.h"

@interface BaiduMapViewController(){
    YSLocationService *_service;
}

@property (nonatomic,strong) YSMapView *mapView;

@end

@implementation BaiduMapViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
}

- (void)onRight{

    NSMutableArray *pointArr = @[].mutableCopy;

    int i = [self getRandomNumber:0 to:20];
    
    YSMapPoint *point = YSMapPoint.new;
    point.address = @"地点一";
    point.latitude = [NSString stringWithFormat:@"30.2%d6316",i];
    point.longitude = @"120.22949";
    [pointArr addObject:point];
    
    YSMapPoint *point2 = YSMapPoint.new;
    point2.address = @"地点二";
    point2.latitude = [NSString stringWithFormat:@"30.2%d6392",i];
    point2.longitude = @"120.238689";
    [pointArr addObject:point2];
    
    YSMapPoint *point3 = YSMapPoint.new;
    point3.address = @"地点三";
    point3.latitude = [NSString stringWithFormat:@"30.2%d599",i];
    point3.longitude = @"120.230353";
    [pointArr addObject:point3];
    
    YSMapPoint *point4 = YSMapPoint.new;
    point4.address = @"地点四";
    point4.latitude = [NSString stringWithFormat:@"30.2%d566",i];
    point4.longitude = @"120.219429";
    [pointArr addObject:point4];
    
    YSMapPoint *point5 = YSMapPoint.new;
    point5.address = @"地点五";
    point5.latitude = [NSString stringWithFormat:@"30.2%d734",i];
    point5.longitude = @"120.254643";
    [pointArr addObject:point5];
    
    YSMapPoint *point6 = YSMapPoint.new;
    point6.address = @"地点六";
    point6.latitude = @"30.202459";
    point6.longitude = @"120.203835";
    [pointArr addObject:point6];
    
    [_mapView loadLocationPoints:pointArr];
}

- (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to-from + 1)));
}

- (void)addSubviews{
    [super addSubviews];
    self.title = @"百度地图";
    self.view.backgroundColor = UIColor.greenColor;
    [self setRightBarButtonWithTitle:@"刷新"];
    
    _service = YSLocationService.new;
    [_service startLocation:^(YSLocationModel *model) {
        if (model.success) {
            NSLog(@"纬度：%@ 经度：%@ 地址：%@",model.latitude,model.longitude,model.addressData.city);
        }else{
            NSLog(@"定位失败 %@",model.errorMsg);
        }
    }];
    
    [self.view addSubview:self.mapView];
    [_mapView setSearchBlock:^(BMKReverseGeoCodeSearchResult * _Nonnull searchResult) {
        NSLog(@"address:%@",searchResult.address);
    }];
    [self onRight];
}

- (YSMapView *)mapView{
    if (!_mapView) {
        _mapView = [[YSMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    }
    return _mapView;
}

@end
