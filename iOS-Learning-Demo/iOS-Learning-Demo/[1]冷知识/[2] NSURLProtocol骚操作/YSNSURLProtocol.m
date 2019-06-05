//
//  YSNSURLProtocol.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/5.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSNSURLProtocol.h"

static NSString *URLProtocolHandledKey = @"URLProtocolHandledKey";

@interface YSNSURLProtocol(){
    NSURLConnection *_connection;
}

@end

@implementation YSNSURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    NSLog(@"canInitWithRequest url-->%@",request.URL.absoluteString);
    
    //看看是否已经处理过了，防止无限循环
    if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request]) {
        return NO;
    }
    
    NSString *urlString = request.URL.absoluteString;
    if([urlString isEqualToString:@"https://sina.cn/"]){
        return YES;
    }
    
    return NO;
}

//重新设置NSURLRequest的信息
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

//这个方法主要是用来判断两个request是否相同，如果相同的话可以使用缓存数据，通常调用父类的实现即可
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

//被拦截的请求开始执行的地方
- (void)startLoading{
    
    NSMutableURLRequest * request = [self.request mutableCopy];
    
    // 标记当前传入的Request已经被拦截处理过，
    //防止在最开始又继续拦截处理
    [NSURLProtocol setProperty:@(YES) forKey:URLProtocolHandledKey inRequest:request];
    
    _connection = [NSURLConnection connectionWithRequest:[self changeSinaToSohu:request] delegate:self];
}

//结束加载URL请求
- (void)stopLoading{
    
}

//把所用url中包括sina的url重定向到sohu
- (NSMutableURLRequest *)changeSinaToSohu:(NSMutableURLRequest *)request{
    NSString *urlString = request.URL.absoluteString;
    if ([urlString isEqualToString:@"https://sina.cn/"]) {
        urlString = @"https://www.baidu.com";
        request.URL = [NSURL URLWithString:urlString];
    }
    return request;
}

#pragma mark - *********** delegate ***********

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}

@end
