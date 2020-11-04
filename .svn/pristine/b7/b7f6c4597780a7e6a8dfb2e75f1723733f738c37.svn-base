//
//  H5activityViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/5/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "H5activityViewController.h"
#import "GlobalTool.h"
@interface H5activityViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation H5activityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"活动页"];
    
    [self createWebView];
    
}


- (void)createWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.webView];
    
    NSURL *url ;
    
    if([self.H5url hasPrefix:@"http:"])
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.H5url]];
    }else{
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_H5],self.H5url]];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
       
    [self createAnimation];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self stopAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
