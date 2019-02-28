//
//  HomeViewModel.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSBaseViewModel.h"
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : YSBaseViewModel

@property (nonatomic,strong) RACSubject *loadDataSubject;
@property (nonatomic,strong) RACCommand *loadDataCommand;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
