//
//  YSMapView.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/6.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSMapView.h"
#import "YSLocationService.h"
#import "YSMapAnnotationView.h"

@implementation YSMapPoint

@end

@interface YSMapView()<
BMKMapViewDelegate,
BMKLocationManagerDelegate,
BMKGeoCodeSearchDelegate>{
    BOOL _centerSetting;
    NSMutableArray *_pointAnns;
    NSMutableArray *_latArr;
    NSMutableArray *_lonArr;
    CLLocationCoordinate2D _lastPoint;
}

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationManager *locationManager; //定位对象
@property (nonatomic, strong) BMKUserLocation *userLocation; //当前位置对象
@property (nonatomic, strong) BMKGeoCodeSearch *geocodeSearch;

@property (nonatomic,strong) UIButton *locationBtn;

@end

@implementation YSMapView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (![YSLocationService canLocation]) {
            [YSLocationService openSettingLocation];
        }
        [self addSubview:self.mapView];
        [self addSubview:self.locationBtn];
        [self startLocation];
    }
    return self;
}

- (void)dealloc{
    NSLog(@"-- %@ -- 正常销毁",NSStringFromClass([self class]));
}

#pragma mark - *********** Public ***********

+ (void)startMapService{
    BOOL ret = [BMKMapManager.new start:@"iUK74XE3USp60A9d736Yv7iKGoSiDhu8" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [YSLocationService.new startLocationService];
}

- (void)viewWillAppear{
    [_mapView viewWillAppear];
}

- (void)viewWillDisappear{
    [_mapView viewWillDisappear];
}

- (void)loadLocationPoints:(NSArray <YSMapPoint *>*)points{
    
    _pointAnns = @[].mutableCopy;
    _latArr = @[].mutableCopy;
    _lonArr = @[].mutableCopy;
    
    [_mapView removeAnnotations:_mapView.annotations];
    
    for (int i = 0; i < points.count; i++) {
        YSMapPoint *point = points[i];
        double lat = [point.latitude doubleValue];
        double lon = [point.longitude doubleValue];
        
        [_latArr addObject:@(lat)];
        [_lonArr addObject:@(lon)];
        
        point.index = i+1;
        point.coordinate = CLLocationCoordinate2DMake(lat,lon);
        point.title = point.address;
        
        [_mapView addAnnotation:point];
        
        [_pointAnns addObject:point];
    }
    [self mapViewFitAnns];
}

#pragma mark - *********** Private ***********

- (void)startLocation{
    
    //优先定位之前的坐标
    if (_lastPoint.latitude != 0) {
        [self centerAndZoom];
    }
    
    _centerSetting = NO;
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];
    
    _mapView.showsUserLocation = YES;
    
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = true;
    displayParam.isAccuracyCircleShow = false;
    displayParam.locationViewImage = [UIImage imageNamed:@"icon_nav_start"];
    [_mapView updateLocationViewWithParam:displayParam];
}

- (void)centerAndZoom{
    [_mapView setCenterCoordinate:_lastPoint animated:YES];
}

- (void)mapViewFitAnns{
    if (_pointAnns.count < 2) return;
    CLLocationCoordinate2D coor = [_pointAnns[0] coordinate];
    BMKMapPoint pt = BMKMapPointForCoordinate(coor);
    CGFloat ltX, ltY, rbX, rbY;
    ltX = pt.x;
    ltY = pt.y;
    rbX = pt.x;
    rbY = pt.y;
    for (int i = 0; i < _pointAnns.count; i++) {
        YSMapPoint *point = [_pointAnns objectAtIndex:i];
        BMKMapPoint pt = BMKMapPointForCoordinate(point.coordinate);
        if (pt.x < ltX) ltX = pt.x;
        if (pt.x > rbX) rbX = pt.x;
        if (pt.y > ltY) ltY = pt.y;
        if (pt.y < rbY) rbY = pt.y;
        
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [self.mapView setVisibleMapRect:rect];
    self.mapView.zoomLevel = self.mapView.zoomLevel - 0.3;
}

#pragma mark - *********** 大头针 ***********

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    
    static NSString *annotationViewIdentifier = @"annotationViewIdentifier";
    
    YSMapAnnotationView *annotationView = (YSMapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
    if (!annotationView) {
        annotationView = [[YSMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.draggable = NO;
    annotationView.hidePaopaoWhenSelectOthers = YES;
    annotationView.hidePaopaoWhenDoubleTapOnMap = YES;
    
    YSMapPoint *pointAnn = (YSMapPoint *)annotation;
    [annotationView setCount:pointAnn.index];
    
    return annotationView;
}

#pragma mark - *********** BMKLocationManagerDelegate ***********

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    if (error) {
        NSLog(@"YSMapView定位失败:{%ld - %@};", (long)error.code, error.localizedDescription);
    }
    if (!location) {
        return;
    }
    
    self.userLocation.location = location.location;
    [_mapView updateLocationData:self.userLocation];
    
    _lastPoint = location.location.coordinate;
    
    if (!_centerSetting) {
        _centerSetting = YES;
        [self reverseGeo:_lastPoint];
        [self centerAndZoom];
    }
}

- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager
          didUpdateHeading:(CLHeading * _Nullable)heading{
    self.userLocation.heading = heading;
}

#pragma mark - *********** 反地理编码 ***********

- (void)reverseGeo:(CLLocationCoordinate2D)point{
    BMKReverseGeoCodeSearchOption *option = BMKReverseGeoCodeSearchOption.new;
    option.location = point;
    option.isLatestAdmin = YES;
    [self.geocodeSearch reverseGeoCode:option];
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_OPEN_NO_ERROR) {
        if (_searchBlock) {
            _searchBlock(result);
        }
    }
}

#pragma mark - *********** lazy ***********

- (BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:self.frame];
        _mapView.delegate = self;
        _mapView.userTrackingMode = BMKUserTrackingModeHeading;
    }
    return _mapView;
}

- (BMKLocationManager *)locationManager {
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

- (BMKUserLocation *)userLocation {
    if (!_userLocation) {
        _userLocation = [[BMKUserLocation alloc] init];
    }
    return _userLocation;
}

- (BMKGeoCodeSearch *)geocodeSearch{
    if (!_geocodeSearch) {
        _geocodeSearch = BMKGeoCodeSearch.new;
        _geocodeSearch.delegate = self;
    }
    return _geocodeSearch;
}

- (UIButton *)locationBtn{
    if (!_locationBtn) {
        _locationBtn = UIButton.new;
        _locationBtn.frame = CGRectMake(24, self.frame.size.height - 24 - 30, 30, 30);
        _locationBtn.backgroundColor = UIColor.whiteColor;
        [_locationBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(startLocation) forControlEvents:UIControlEventTouchUpInside];
        _locationBtn.layer.cornerRadius = _locationBtn.height/2;
    }
    return _locationBtn;
}

@end
