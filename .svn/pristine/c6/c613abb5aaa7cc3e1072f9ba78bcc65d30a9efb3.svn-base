//
//  GifImageView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/8/23.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "GifImageView.h"

@implementation GifImageView
{
    UIWebView *webView;
}
- (id)initWithFrame:(CGRect)frame GifImageName:(NSString*)gitImageName{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *placeholdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
        [self addSubview:placeholdView];
                
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:gitImageName]];
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [webView setScalesPageToFit: YES];
        [webView setBackgroundColor: [UIColor clearColor]];
        [webView setOpaque: 0];
        [self addSubview:webView];
        [webView loadData:data MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
        [webView setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)refreshGif:(NSString*)gitImageName
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:gitImageName]];
    [webView loadData:data MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
}
@end
