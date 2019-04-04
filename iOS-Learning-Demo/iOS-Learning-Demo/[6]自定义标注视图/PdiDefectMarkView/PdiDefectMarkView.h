//
//  PdiDefectMarkView.h
//  VehicleService
//
//  Created by yuan on 2019/4/3.
//  Copyright © 2019 xince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdiMarkModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PdiDefectMarkViewRefreshBlock)(NSArray <PdiMarkModel *>* modelArr);

@interface PdiDefectMarkView : YSBaseView

@property (nonatomic,copy) PdiDefectMarkViewRefreshBlock refreshBlock;

- (void)refreshMarkPoint:(PdiMarkModel *)model;

- (UIImage *)screenShot;

@end

NS_ASSUME_NONNULL_END
