//
//  PdiMarkView.h
//  VehicleService
//
//  Created by yuan on 2019/4/3.
//  Copyright © 2019 xince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdiMarkModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PdiMarkViewRemoveBlock)(PdiMarkModel *model);

@interface PdiMarkView : UIView

@property (nonatomic,copy) PdiMarkViewRemoveBlock removeBlock;

- (instancetype)initWithPointModel:(PdiMarkModel *)model;

//设置编辑状态
- (void)setEditStatus:(BOOL)edit;

//设置标记顺序
- (void)setCountNum:(int)count;

@end

NS_ASSUME_NONNULL_END
