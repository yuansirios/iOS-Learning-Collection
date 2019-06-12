//
//  YSLocationService.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/6.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSLocationService.h"
#import "WeakProxy.h"

@implementation YSLocationModel

@end

@interface YSLocationService()<
BMKLocationManagerDelegate,
BMKLocationAuthDelegate>{
    YSLocationBlock _block;
}

@property (nonatomic,strong) BMKLocationManager *locationManager;

@end

@implementation YSLocationService

- (void)dealloc{
    NSLog(@"-- %@ -- 正常销毁",NSStringFromClass([self class]));
}

#pragma mark - *********** Public ***********

+ (BOOL)canLocation{
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse ||
         [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined  ||
         [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
            return YES;
        }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
            return NO;
        }
    return NO;
}

- (void)startLocation:(YSLocationBlock)block{
    _block = block;
    if ([YSLocationService canLocation]) {
        [self startLocationService];
    }else{
        YSLocationModel *model = YSLocationModel.new;
        model.success = NO;
        model.errorMsg = @"未授权";
        _block(model);
        [YSLocationService openSettingLocation];
    }
}

#pragma mark - *********** Private ***********

- (void)startLocationService{
    id obj = [WeakProxy proxyWithTarget:self];
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:@"iUK74XE3USp60A9d736Yv7iKGoSiDhu8" authDelegate:obj];
}

- (void)startLocation{
    __weak typeof(self) weakSelf = self;
    [weakSelf.locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        //获取经纬度和该定位点对应的位置信息
        
        __strong typeof(self) strongSelf = self;
        
        if (!error){
            NSLog(@"定位成功：%@",location);
            if (strongSelf->_block) {
                CLLocationDegrees latitude = location.location.coordinate.latitude;
                CLLocationDegrees longitude = location.location.coordinate.longitude;
                
                YSLocationModel *model = YSLocationModel.new;
                model.success = YES;
                model.errorMsg = nil;
                model.latitude = [NSString stringWithFormat:@"%f",latitude];
                model.longitude = [NSString stringWithFormat:@"%f",longitude];
                model.addressData = location.rgcData;
                strongSelf->_block(model);
            }
        }else{
            NSLog(@"定位失败：%@",error);
            if (strongSelf->_block) {
                YSLocationModel *model = YSLocationModel.new;
                model.success = NO;
                model.errorMsg = error.localizedDescription;
                model.latitude = nil;
                model.longitude = nil;
                model.addressData = nil;
                strongSelf->_block(model);
            }
        }
        
        [strongSelf clearService];
    }];
}

- (void)clearService{
    _locationManager = nil;
    _block = nil;
}

+ (void)openSettingLocation{
    NSLog(@"您的GPS定位尚未打开,请到设置->隐私->定位服务中开启定位服务");
    
//    [AlertSheet alertViewWithController:[UIApplication sharedApplication].delegate.window.rootViewController title:nil message:@"您的GPS定位尚未打开,请到设置->隐私->定位服务中开启定位服务" items:@[@"取消",@"确定"] style:(UIAlertControllerStyleAlert) idx:^(NSInteger index) {
//        if (index == 1) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//        }
//    }];
}

#pragma mark - *********** BMKLocationAuthDelegate ***********

- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError{
    if (iError == 0) {
        NSLog(@"<<<<<<<<<<<< 定位服务成功 >>>>>>>>>>>");
        [self startLocation];
    }else{
        NSLog(@"<<<<<<<<<<<< 定位服务失败 %@ >>>>>>>>>>>",@(iError));
        if (_block) {
            YSLocationModel *model = YSLocationModel.new;
            model.success = NO;
            model.errorMsg = @"定位服务失败初始化失败";
            model.latitude = nil;
            model.longitude = nil;
            model.addressData = nil;
            _block(model);
        }
        [self clearService];
    }
}

#pragma mark - *********** Lazy ***********

- (BMKLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[BMKLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        _locationManager.allowsBackgroundLocationUpdates = NO;
    }
    return _locationManager;
}

@end
