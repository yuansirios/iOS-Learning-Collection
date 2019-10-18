//
//  ObjectOC.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/9/16.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "ObjectOC.h"

void OcObjectDoSomethingWith(void* caller, void* parameter){
    [(__bridge id)caller doSomething:parameter];
}

@implementation ObjectOC

-(instancetype)init{
    if ([super init]) {
        _call = OcObjectDoSomethingWith;
    }
    return self;
}

-(void)doSomething:(void *)parameter{
    NSLog(@"%@",parameter);
}

-(void)dealloc{
    NSLog(@"OC Object dealloc");
}

@end
