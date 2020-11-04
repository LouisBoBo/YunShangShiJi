//
//  SendenvelopeViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/3/29.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "SendenvelopeViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface SendenvelopeViewController ()<UIWebViewDelegate,TFJSObjCModelDelegate,NJKWebViewProgressDelegate>

@property (nonatomic, strong)NJKWebViewProgress *webViewProgress;
@property (nonatomic, strong)NJKWebViewProgressView *webViewProgressView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, assign) BOOL isFiled;

@property (nonatomic, copy) NSString *realm;

@end

@implementation SendenvelopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //    NSString *token = [ud objectForKey:USER_TOKEN];
    self.realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
    
    NSLog(@"self.realm = %@", self.realm);
    
    [super setNavigationItemLeft:@"已发红包"];
    
    
    [self addMyWebView];
    
    
}

- (void)addMyWebView
{
    self.isFiled = NO;
    
    [self.view addSubview:self.webView];
    
    
    [self webViewLoad];
    
    
    self.jsContext = [[JSContext alloc] init];
    
}

- (NJKWebViewProgress *)webViewProgress
{
    if (_webViewProgress == nil) {
        _webViewProgress = [[NJKWebViewProgress alloc] init];
        self.webView.delegate = _webViewProgress;
        _webViewProgress.webViewProxyDelegate = self;
        _webViewProgress.progressDelegate = self;
    }
    return _webViewProgress;
}

- (NJKWebViewProgressView *)webViewProgressView
{
    if (_webViewProgressView == nil) {
        CGRect navBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0,
                                     64-2,
                                     navBounds.size.width,
                                     2);
        _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_webViewProgressView setProgress:0 animated:YES];
        
    }
    return _webViewProgressView;
}


- (void)callObjectiveCWithMyShopWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary *dic = userInfo;
    
    NSLog(@"the recived dic = %@", dic);
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        ShopDetailViewController *detail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
//        detail.shop_code = dic[@"shop_code"];
//        detail.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:detail animated:YES];
//    });
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
    NSString *urlStr = webView.request.URL.absoluteString;
    
    NSLog(@"URL = %@", urlStr);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成!");
    
    self.isFiled = NO;
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    TFJSObjCModel *model  = [[TFJSObjCModel alloc] init];
    self.jsContext[@"OCModel"] = model;
    model.index = 1;
    model.jsContext = self.jsContext;
    model.webView = self.webView;
    model.delegate = self;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.isFiled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.isFiled == YES) {
        [self httpWebViewReload];
    }
    
}

- (void)httpWebViewReload
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@view/hb/mysents_app.html?uid=oj8JHt-fZZRAdTLzY9Nwr-rDznWw",HTTPURLH5];
    NSLog(@"urlStr = %@",urlStr);
    
    
    NSURL *URL = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [self.webView loadRequest:request];
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 69, kScreenWidth, kScreenHeight-69)];
        _webView.scalesPageToFit = YES;
        _webView.scrollView.bounces = NO;
        _webView.delegate = self;
    }
    
    return _webView;
}

- (void)webViewLoad
{
    NSString *urlStr = [NSString stringWithFormat:@"%@view/hb/mysents_app.html?uid=oj8JHt-fZZRAdTLzY9Nwr-rDznWw",HTTPURLH5];
    NSLog(@"urlStr = %@",urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}


- (void)callObjectiveCWithBackViewControllerWithIndex:(int)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    //    [_webViewProgressView setProgress:progress animated:YES];
    //    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
