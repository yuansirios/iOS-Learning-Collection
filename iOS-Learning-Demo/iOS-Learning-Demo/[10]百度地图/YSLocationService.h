//
//  YSLocationService.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/6.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <BMKLocationKit/BMKLocationComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSLocationModel : NSObject

@property (nonatomic,assign) BOOL success;
@property (nonatomic,copy  ) NSString *_Nullable errorMsg;
@property (nonatomic,copy  ) NSString *_Nullable latitude;
@property (nonatomic,copy  ) NSString *_Nullable longitude;
@property (nonatomic,strong) BMKLocationReGeocode *_Nullable addressData;

@end

typedef void(^YSLocationBlock)(YSLocationModel *model);

@interface YSLocationService : NSObject

+ (BOOL)canLocation;

+ (void)openSettingLocation;

- (void)startLocationService;

- (void)startLocation:(YSLocationBlock)block;

@end

NS_ASSUME_NONNULL_END
