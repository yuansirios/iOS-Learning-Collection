//
//  NSURLProtocolViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/5.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "NSURLProtocolViewController.h"

@interface NSURLProtocolViewController()<UIWebViewDelegate>{
    UIWebView *_webView;
}

@end

@implementation NSURLProtocolViewController

- (void)viewDidLoad{
    self.title = @"NSURLProtocol";
    _webView = UIWebView.new;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    [self layout];
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://sina.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)layout{
    _webView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

@end
