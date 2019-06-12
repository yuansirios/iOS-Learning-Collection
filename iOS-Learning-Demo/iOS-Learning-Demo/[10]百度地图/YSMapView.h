//
//  YSMapView.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/6.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YSMapViewBlock)(BMKReverseGeoCodeSearchResult *searchResult);

@interface YSMapPoint : BMKPointAnnotation

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) NSString * imgUrl;
@property (nonatomic,copy) NSString * address;

@property (nonatomic,copy) NSString * latitude;
@property (nonatomic,copy) NSString * longitude;

@end

@interface YSMapView : UIView

@property (nonatomic,copy) YSMapViewBlock searchBlock;

+ (void)startMapService;

- (void)viewWillAppear;

- (void)viewWillDisappear;

- (void)loadLocationPoints:(NSArray <YSMapPoint *>*)points;

@end

NS_ASSUME_NONNULL_END
