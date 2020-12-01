//
//  SVGImageViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan xiaodong on 2020/11/26.
//  Copyright © 2020 yuan. All rights reserved.
//

#import "SVGImageViewController.h"
#import "UIImage+SVGManager.h"
#import "SVGKit.h"

@interface SVGImageViewController ()

@end

@implementation SVGImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgView = UIImageView.new;
    [imgView setFrame:CGRectMake(0, 0, 200, 200)];
    imgView.center = self.view.center;
    [self.view addSubview:imgView];
    
    SVGKImage *svgImg = [SVGKImage imageNamed:@"b"];
    SVGKFastImageView *fastView = [[SVGKFastImageView alloc]initWithSVGKImage:svgImg];
    fastView.frame = imgView.bounds;
    [imgView addSubview:fastView];

}

@end
