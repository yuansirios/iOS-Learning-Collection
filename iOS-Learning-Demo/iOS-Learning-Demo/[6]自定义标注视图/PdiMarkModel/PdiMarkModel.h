//
//  PdiMarkModel.h
//  VehicleService
//
//  Created by yuan on 2019/4/3.
//  Copyright © 2019 xince. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PdiMarkModel : YSBaseModel

@property (nonatomic,  copy) NSString *title;         //标题
@property (nonatomic,  copy) NSString *content;       //内容
@property (nonatomic,assign) CGPoint  point;          //坐标点
@property (nonatomic,assign) BOOL     edit;           //显示和编辑状态

@end

NS_ASSUME_NONNULL_END
