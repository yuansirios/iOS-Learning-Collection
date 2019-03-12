//
//  YSRunloopObserver.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/3/12.
//  Copyright © 2019 yuan. All rights reserved.
//

/*
 思路：
 任务数组中保存的是用户的耗性能操作，用Block传递过来。
 工具类本身是一个单例，所以任务数组是唯一的，所有操作都在保存在这个像 “队列”
 一样的数组(taskArray)中，按照先进先出的原则，在Runloop空闲的时候逐个完成。
 这样这些耗性能的操作不会在Runloop需要完成其它操作的时候来抢占CPU资源，
 卡顿的情况就会明显得到缓解。
 
 __weak typeof(self) weakSelf = self;
 [[YSRunloopObserver runloopObserver] addTask:^{
    UIImageView *imgView = weakSelf.imgViewArray[i];
    UIImage *img = [UIImage imageNamed:dataArray[i]];
    imgView.image = img;
 }];
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSRunloopObserver : NSObject

+ (instancetype)runloopObserver;

- (void)addTask:(void(^)(void))task;

@end

NS_ASSUME_NONNULL_END
