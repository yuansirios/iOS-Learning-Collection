//
//  AspectUtil.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/12/2.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "AspectUtil.h"
#import "Aspect.h"

@implementation AspectUtil

+ (void)setUp {
    [UIViewController hookSelector:@selector(viewWillAppear:) position:AspectPositionAfter usingBlock:^(id info){
        NSString *className = NSStringFromClass([[info instance] class]);
        NSLog(@"aspect --- viewWillAppear:%@ ---",className);
    }];
}

+ (void)setUpObj:(id)obj{
    [obj hookSelector:@selector(show) position:AspectPositionAfter usingBlock:^(id info){
        NSString *className = NSStringFromClass([[info instance] class]);
        NSLog(@"aspect --- show:%@ ---",className);
    }];
}

- (void)show{
    NSLog(@"--- AspectUtil show ---");
}

@end
