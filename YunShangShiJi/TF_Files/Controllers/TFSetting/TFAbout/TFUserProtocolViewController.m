//
//  TFUserProtocolViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/4.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFUserProtocolViewController.h"
//#import "ChatListViewController.h"

@interface TFUserProtocolViewController () <UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)UIActivityIndicatorView *activityIndicator;
@end

@implementation TFUserProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"用户协议"];
    [self createWebView];
    
    
    
}
/*
 http://192.168.1.205:8080//cloud-h5/view/other/userPortocol.jsp
 */

- (void)createWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@view/other/userPortocol.jsp",[NSObject baseURLStr_H5]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
//    //创建UIActivityIndicatorView背底半透明View
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth , kScreenHeight-kNavigationheightForIOS7)];
//    [view setTag:108];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [view setAlpha:0.2];
//    [self.view addSubview:view];
//    
//    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    [self.activityIndicator setCenter:view.center];
//    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [view addSubview:self.activityIndicator];
//    
//    [self.activityIndicator startAnimating];
    
    [self createAnimation];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
//    [self.activityIndicator stopAnimating];
//    UIView *view = (UIView*)[self.view viewWithTag:108];
//    [view removeFromSuperview];
//    //webViewDidFinishLoad");
    
    [self stopAnimation];
}

#pragma mark - 创建UI
- (void)createUI
{

    NSString *str;
    if (ThreeAndFiveInch) {
        str = [NSString stringWithFormat:@"                       软件许可使用协议\r\t"];
    } else if (FourInch) {
        str = [NSString stringWithFormat:@"                  软件许可使用协议\r\t"];
    } else if (FourAndSevenInch) {
        str = [NSString stringWithFormat:@"                  软件许可使用协议\r\t"];
    } else if (FiveAndFiveInch) {
        str = [NSString stringWithFormat:@"                  软件许可使用协议\r\t"];
    }
    NSMutableString *muStr = [NSMutableString stringWithString:str];
    [muStr appendString:@"本软件许可使用协议（以下称\"本协议\"）由您与淘宝（中国）软件有限公司（以下称淘宝）共同签署。\r\t\
在使用“无线淘宝软件产品（iPhone版）”软件（以下称许可软件）之前，请仔细阅读本协议。一旦您下载安装使用许可软件，即表示您同意接受本协议所有条款和条件的约束。如您不同意本协议条款和条件，请勿使用许可软件，并请销毁所有许可软件副本。\r\t\
淘宝有权随时修改本协议，并以在淘宝网（www.taobao.com）公示的方式通知您，无需单独通知您。修改后的协议于公示时生效。协议条款修改后，您继续使用许可软件的，即视为您已阅读并接受修改后的协议。\r\
1、定义\r\t\
1.许可软件：是指由淘宝开发 的，供您从 Apple Inc. (以下称苹果公司)的 App Store平台（以下称下载平台）下载，并仅限在 iPhone、iPod touch等手持移动终端（以下称苹果终端）中安装、使用的软件系统。\r\t\
2.淘宝网服务：由浙江淘宝网络有限公司为您提供的服务。您可以通过许可软件在手持移动终端使用淘宝网服务。\r\
2、定义\r\t\
1.许可软件：是指由淘宝开发 的，供您从 Apple Inc. (以下称苹果公司)的 App Store平台（以下称下载平台）下载，并仅限在 iPhone、iPod touch等手持移动终端（以下称苹果终端）中安装、使用的软件系统。\r\t\
2.淘宝网服务：由浙江淘宝网络有限公司为您提供的服务。您可以通过许可软件在手持移动终端使用淘宝网服务。"];
    
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake((10),kNavigationheightForIOS7, kScreenWidth-2*(10), kScreenHeight-kNavigationheightForIOS7)];
    tv.scrollEnabled = YES;
    tv.text = muStr;
    tv.editable = NO;
    tv.showsVerticalScrollIndicator = NO;
    tv.font = [UIFont systemFontOfSize:(16)];
    [self.view addSubview:tv];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarButtonClick
{
    [self message];
}
- (void)message
{
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
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
