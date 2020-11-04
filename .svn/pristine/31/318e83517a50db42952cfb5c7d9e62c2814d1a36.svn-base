//
//  TFRequest.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/21.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFRequest.h"

@interface TFRequest () <NSURLConnectionDataDelegate>
{
    NSMutableData *_mData;
}

@end

@implementation TFRequest

-(void)startRequest
{
    _mData = [[NSMutableData alloc] init];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_mData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (self.finisBlock!=nil) {
        self.finisBlock(_mData);
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (self.failedBlock) {
        self.failedBlock();
    }
    
}

+ (void)connectionWithUrl:(NSString *)url FinishBlock:(FinishBlock)finishBlock FaileedBlock:(FailedBlock)failedBlock
{
    TFRequest *request = [[TFRequest alloc] init];
    request.url = url;
    request.finisBlock = finishBlock;
    request.failedBlock = failedBlock;
    [request startRequest];
}


@end
