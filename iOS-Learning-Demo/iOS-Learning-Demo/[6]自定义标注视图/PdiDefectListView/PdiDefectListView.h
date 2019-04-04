//
//  PdiDefectListView.h
//  VehicleService
//
//  Created by yuan on 2019/4/4.
//  Copyright © 2019 xince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdiMarkModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PdiDefectCellEditBlock)(PdiMarkModel *model);

@interface PdiDefectListView : YSBaseView

@property (nonatomic,copy) PdiDefectCellEditBlock editBlock;

- (void)loadWithModelArr:(NSArray <PdiMarkModel *> *)modelArr;

@end

NS_ASSUME_NONNULL_END
