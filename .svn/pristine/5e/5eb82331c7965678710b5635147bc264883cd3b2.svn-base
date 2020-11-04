//
//  TFAlreadySendRedViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 16/3/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFAlreadySendRedViewController.h"
#import "DShareManager.h"
#define H_SHARE ZOOM(600)
#import "AppDelegate.h"
#import "DShareManager.h"
@interface TFAlreadySendRedViewController () <UIWebViewDelegate, TFJSObjCModelDelegate, DShareManagerDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, assign) BOOL      isFirst;

@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)UIView *shareView;
@property (nonatomic, strong)UIImage *redPackImage;

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *titleCircle;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *shareSrc;


@end

@implementation TFAlreadySendRedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"已发的红包"];
    
    [self createUI];
    
//    [self addBackgroundView];
}

- (void)createUI
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scalesPageToFit = YES;
    webView.scrollView.bounces = NO;
    webView.delegate = self;
    
    [self.view addSubview:_webView = webView];
    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *union_id = [user objectForKey:UNION_ID];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@view/hb/mysents_app.html?uid=%@",[NSObject baseURLStr_H5],self.unionid];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL* url = [request URL];
    NSString* urlstring = [NSString stringWithFormat:@"%@",url];
    //currWebViewUrl: %@",urlstring);
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.isFirst = NO;
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    TFJSObjCModel *model       = [[TFJSObjCModel alloc] init];
    model.index                = 0;
    model.jsContext            = self.jsContext;
    model.delegate             = self;
    model.webView              = webView;
    self.jsContext[@"OCModel"] = model;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        //异常信息：%@", exceptionValue);
    };
    
    
}
//WebViewJavascriptBridge

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    TFJSObjCModel *model       = [[TFJSObjCModel alloc] init];

    model.index                = 0;
    model.jsContext            = self.jsContext;
    model.delegate             = self;
    model.webView              = webView;
    self.jsContext[@"OCModel"] = model;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        //异常信息：%@", exceptionValue);
    };
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //error = %@", error);
}

- (void)callObjectiveCWithAlreadyRed:(NSDictionary *)params
{
    //params = %@",params);
    
    NSString *shareSrc = [NSString stringWithFormat:@"%@",params[@"shareSrc"]];
    NSString *title     = [NSString stringWithFormat:@"%@",params[@"title"]];
    NSString *titleCircle     = [NSString stringWithFormat:@"%@",params[@"titleCircle"]];
    NSString *imgSrc   = [NSString stringWithFormat:@"%@",params[@"imgSrc"]];
    NSString *desc     = [NSString stringWithFormat:@"%@",params[@"desc"]];
    
//    //name = %@", name);
//    //word = %@", word);
    
    self.title     = title;
    self.titleCircle = titleCircle;
    self.desc     = desc;
    self.shareSrc = shareSrc;

    //title = %@", self.title);
    //titleCircle = %@", self.titleCircle);
    //desc = %@", self.desc);
    //shareSrc = %@", self.shareSrc);
    
    [self httpGetShareImage:imgSrc];

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
        //更UI
            [self addBackgroundView];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NavgationbarView *nv = [[NavgationbarView alloc] init];
            [nv showLable:@"请安装微信,再分享" Controller:self];
        });
    }
}


- (UIView *)shareView
{
    if (_shareView == nil) {
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, H_SHARE)];
        _shareView.backgroundColor = [UIColor whiteColor];
        
        NSString *st = @"您的语音红包已备好,分享给小伙伴一起玩吧!";
        
        CGFloat M_lr = ZOOM(0);
        CGFloat M_ud = ZOOM(67);
        
        CGSize size_st = [st boundingRectWithSize:CGSizeMake(CGRectGetWidth(_shareView.frame)-2*M_lr, CGRectGetHeight(_shareView.frame)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]} context:nil].size;
        
        UILabel *titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(M_lr, M_ud, CGRectGetWidth(_shareView.frame)-2*M_lr, size_st.height)];
        titleLabel.text          = st;
        titleLabel.font          = kFont6px(34);
        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.backgroundColor = COLOR_ROSERED;
        [_shareView addSubview:titleLabel];

        CGFloat H_Btn            = ZOOM(200);
        NSArray *titleArr        = [NSArray arrayWithObjects:@"微信", @"朋友圈", nil];

        CGFloat M_btn            = (kScreenWidth-titleArr.count*H_Btn)/3.0;
        for (int i = 0; i<titleArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(M_btn+i*H_Btn+i*M_btn, CGRectGetMaxY(titleLabel.frame)+(H_SHARE-CGRectGetMaxY(titleLabel.frame)-H_Btn)/2.0, H_Btn, H_Btn);
            btn.tag = 100+i;
            [btn setBackgroundImage:[UIImage imageNamed:titleArr[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_shareView addSubview:btn];
         
        }
    }
    
    return _shareView;
}


- (void)shareBtnClick:(UIButton *)sender
{
    int index = (int)sender.tag;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shardk];
    
    //	NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];
    
    NSString *link      = [NSString stringWithFormat:@"%@", self.shareSrc];
    //link        = %@", link);
    DShareManager *ds   = [DShareManager share];
    ds.delegate         = self;
    NSString *title;
    NSString *content;
    
    NSString *imagePath;
    if (self.redPackImage == nil) {
        //red_packet");
        imagePath = [[NSBundle mainBundle] pathForResource:@"red_packet" ofType:@"png"];
        
    } else {
        //save_red_packet");
        imagePath=[NSString stringWithFormat:@"%@/Documents/save_red_packet.png",NSHomeDirectory()];
        
    }

    //imagePath = %@" ,imagePath);
    
    if(index == 100)			//好友
    {
        title = [NSString stringWithFormat:@"%@",self.title];
        content  = [NSString stringWithFormat:@"%@", self.desc];
        [ds shareAppWithType:ShareTypeWeixiSession withLinkShareType:@"已发的红包" withLink:link andImagePath:imagePath andTitle:title andContent:content];
        
    } else if (index == 101) { //微信朋友圈
        //ShareTypeWeixiSession		//好友
        //ShareTypeWeixiTimeline    //朋友圈
        
        title = [NSString stringWithFormat:@"%@",self.titleCircle];
        
        [ds shareAppWithType:ShareTypeWeixiTimeline withLinkShareType:@"已发的红包" withLink:link andImagePath:imagePath andTitle:title andContent:nil];
        
    } else if (index == 102) { //微博
        [ds shareAppWithType:ShareTypeSinaWeibo withLinkShareType:@"已发的红包" withLink:link andImagePath:imagePath andTitle:title andContent:content];
   
    }
    
    [self hideHudTheShareView:0.5];
}

- (void)hideHudTheShareView:(NSTimeInterval)timeCount
{
    [UIView animateWithDuration:timeCount animations:^{
        self.shareView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, H_SHARE);
        
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
    }];
}


- (void)addBackgroundView
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    for (UIView *view in window.subviews) {
        if (view == self.backgroundView) {
            view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            self.shareView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, H_SHARE);
            [window bringSubviewToFront:view];
            return;
        }
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [window addSubview:_backgroundView = view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_backgroundView addGestureRecognizer:tap];
    
    [view addSubview:self.shareView];
    
    self.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.shareView.frame = CGRectMake(0, kScreenHeight-H_SHARE, kScreenWidth, H_SHARE);
        
        UIButton *btn1 = (UIButton *)[self.shareView viewWithTag:100];
        UIButton *btn2 = (UIButton *)[self.shareView viewWithTag:101];
        
        CGRect oldRect1 = btn1.frame;
        CGRect oldRect2 = btn2.frame;
        
        CGFloat M_ud = ZOOM(30);
        
        CGRect newRect1 = CGRectMake(oldRect1.origin.x, oldRect1.origin.y-M_ud, oldRect1.size.width, oldRect1.size.height);
        CGRect newRect2 = CGRectMake(oldRect2.origin.x, oldRect2.origin.y-M_ud, oldRect2.size.width, oldRect2.size.height);
        
        CGRect newRect3 = CGRectMake(oldRect1.origin.x, oldRect1.origin.y+M_ud, oldRect1.size.width, oldRect1.size.height);
        CGRect newRect4 = CGRectMake(oldRect2.origin.x, oldRect2.origin.y+M_ud, oldRect2.size.width, oldRect2.size.height);
        
        [UIView animateWithDuration:0.25 animations:^{
            btn1.frame = newRect1;
            btn2.frame = newRect2;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                btn1.frame = newRect3;
                btn2.frame = newRect4;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    btn1.frame = oldRect1;
                    btn2.frame = oldRect2;
                } completion:^(BOOL finished) {
                    //
                }];
            }];
        }];
        
        
        self.backgroundView.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tapClick:(UITapGestureRecognizer *)sender
{
    [self hideHudTheShareView:0.5];
}


- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    if ([type isEqualToString:@"已发的红包"]) {
        if (shareStatus == STATE_SUCCESS) {
            [nv showLable:@"分享成功" Controller:self];
            
        } else if (shareStatus == STATE_FAILED) {
            [nv showLable:@"分享失败" Controller:self];
            
        } else if (shareStatus == STATE_CANCEL) {
//            [nv showLable:@"分享取消" Controller:self];
            
        }
    }
}



- (void)httpGetShareImage:(NSString *)imageUrl
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url = imageUrl;
    //url = %@", url);
    
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.redPackImage = [UIImage imageWithData:imgData];
            
            [imgData writeToFile:[NSString stringWithFormat:@"%@/Documents/save_red_packet.png",NSHomeDirectory()] atomically:YES];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
    
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


