//
//  NSProxyViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/30.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "NSProxyViewController.h"
#import "WeakProxy.h"
#import "Person.h"
#import "Student.h"
#import "NCProxy.h"

@interface NSProxyViewController ()

@property (strong,nonatomic) NSTimer *timer;

@end

@implementation NSProxyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - *********** 1、避免循环引用 ***********
    /*
     问题描述：
     　　用NSTimer来实现每隔一定时间执行制定的任务，例如最常见的广告轮播图。
        如果我们在 timerWithTimeInterval:1 target:self 中指定target为当前控制器，控制器则会被timer强引用，而控制器对timer也是强引用的。
        一般，我们终止定时器往往在界面销毁时，即dealloc方法中写 [_timer invalidate];。
        基于上面的分析，由于循环引用的存在，控制器永远也不会走dealloc方法，定时器会一直执行方法，造成内存泄露。
     
     解决方案：
        利用消息转发来断开NSTimer对象与视图之间的引用关系。
        初始化NSTimer时把触发事件的target替换成一个单独的对象，然后这个对象中NSTimer的SEL方法触发时让这个方法在当前的视图self中实现。
     */
    self.timer = [NSTimer timerWithTimeInterval:1
                                         target:[WeakProxy proxyWithTarget:self]
                                       selector:@selector(timerInvoked:)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
#pragma mark - *********** 2、实现多继承 ***********
    NCProxy *proxy = [NCProxy alloc];
    [proxy transformToObject:Person.new];
    [proxy performSelector:@selector(setName:) withObject:@"小明"];
    [proxy performSelector:@selector(eat)];
    [proxy transformToObject:Student.new];
    [proxy performSelector:@selector(study)];
}

- (void)timerInvoked:(NSTimer *)timer{
    NSLog(@"============ %@ ===========",timer);
}

- (void)dealloc{
    [self.timer invalidate];
}

@end
