//
//  MixedViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/9/16.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "MixedViewController.h"

#import "ObjectOC.h"
#include "ObjectCpp.hpp"

@interface MixedViewController ()

@end

@implementation MixedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ObjectOC * oc = [[ObjectOC alloc]init];
    void* point = (__bridge void*)oc;
    ObjectCpp* cpp = new ObjectCpp(point,oc.call);
    cpp->function((__bridge void*)@"123412");
    
    delete cpp;
}

@end
