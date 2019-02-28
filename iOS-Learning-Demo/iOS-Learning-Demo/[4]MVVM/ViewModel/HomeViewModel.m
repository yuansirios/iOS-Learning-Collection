//
//  HomeViewModel.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (void)initialize{
    @weakify(self)
    //轮播
    [self.loadDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (x == nil) {
            [self.loadDataSubject sendNext:nil];
            return;
        }
        if ([x[@"success"] boolValue]) {
            NSArray *arr = x[@"body"];
            if ([arr isKindOfClass:[NSArray class]]) {
                if (self.dataArray) {
                    [self.dataArray removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:arr];
            }
            [self.loadDataSubject sendNext:@"请求成功"];
        }else{
            [self.loadDataSubject sendNext:@"请求失败"];
        }
    }];
}

- (RACCommand *)loadDataCommand{
    if (!_loadDataCommand) {
        _loadDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                NSMutableArray *arr = @[].mutableCopy;
                for (int i = 0 ; i < 10 ; i++){
                    HomeModel *home = HomeModel.new;
                    home.title = [NSString stringWithFormat:@"home : %d",i];
                    [arr addObject:home];
                }
                
                [subscriber sendNext:@{@"success":@"1",@
                                       "body":arr.copy
                                       }];
                [subscriber sendCompleted];
                
                return nil;
            }];
        }];
    }
    return _loadDataCommand;
}

- (RACSubject *)loadDataSubject{
    if (!_loadDataSubject) {
        _loadDataSubject = [RACSubject subject];
    }
    return _loadDataSubject;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
