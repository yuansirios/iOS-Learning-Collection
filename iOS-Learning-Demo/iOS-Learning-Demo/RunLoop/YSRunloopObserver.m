//
//  YSRunloopObserver.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/3/12.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSRunloopObserver.h"

@interface YSRunloopObserver(){
    NSTimer *timer;
}

@property (nonatomic, strong) NSMutableArray *taskArray;

@end

@implementation YSRunloopObserver

+ (instancetype)runloopObserver {
    static dispatch_once_t once;
    static YSRunloopObserver *observer;
    dispatch_once(&once, ^{
        observer = [[YSRunloopObserver alloc] init];
    });
    return observer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerFiredMethod) userInfo:nil repeats:YES];
        [self runloopBeforeWaiting];
    }
    return self;
}

- (void)addTask:(void(^)(void))task {
    if (task) {
        [self.taskArray addObject:task];
    }
}

- (void)runloopBeforeWaiting {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopBeforeWaiting, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        if (self.taskArray.count == 0) {
            return;
        }
        // 取出耗性能的任务
        void(^task)(void) = self.taskArray.firstObject;
        // 执行任务
        task();
        // 第一个任务出队列
        [self.taskArray removeObjectAtIndex:0];
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
}

- (void)timerFiredMethod {
    
}

- (NSMutableArray *)taskArray {
    if (_taskArray == nil) {
        _taskArray = [NSMutableArray array];
    }
    return _taskArray;
}

@end
