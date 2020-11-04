//
//  TFHomeViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFHomeViewController.h"
#import "ShopDetailViewController.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "HTTPTarbarNum.h"
#import "DShareManager.h"
#import "AppDelegate.h"
#import "ProduceImage.h"
#import "NavgationbarView.h"
#import "SubmitViewController.h"
#define H_SHARE ZOOM(400)
#import "LoginViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "TFLoginView.h"
#import "TFNoviceTaskView.h"
#import "TFDailyTaskView.h"
#import "ScrollView_public.h"
#import "TFFeedBackViewController.h"

#import "QRCodeGenerator.h"
#import "UpYun.h"
#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "WXApi.h"
#import "TFOldPaymentViewController.h"
#import "NewShoppingCartViewController.h"
#import "BoundPhoneVC.h"

NSString *const isShowNoviceTaskView6 = @"isShowNoviceTaskView6"; // 1:弹店铺说明 2:开店

@interface TFHomeViewController () <UIWebViewDelegate, TFJSObjCModelDelegate, DShareManagerDelegate, SubmitViewControllerDelegate,NJKWebViewProgressDelegate, UIAlertViewDelegate>

{
	int _count;
	
	NSInteger _noviceTimerCount_11;
	NSTimer *_noviceTimer_11;
	
	ScrollView_public *_ScrollView_public;
}
@property (nonatomic, strong)TFNoviceTaskView *noviceTaskView;
@property (nonatomic, strong)TFDailyTaskView *dailyTsakView;

@property (nonatomic, strong)NJKWebViewProgress *webViewProgress;
@property (nonatomic, strong)NJKWebViewProgressView *webViewProgressView;

@property (nonatomic,strong)NSString *templet_code;
@property (nonatomic, strong)UIView *shareView;
@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)UIImage *shareAppImg;
@property (nonatomic, assign)BOOL isFiled;

@property (nonatomic, assign)BOOL isSubmitLove;
@property (nonatomic, strong)UIImageView *startImageView;
@property (nonatomic, strong)UIImageView *personImageView;
@property (nonatomic, strong)UIButton *shareBtn;

@property (nonatomic, assign)BOOL isBindPhone;

@end

@implementation TFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationController.navigationBar.hidden = YES;
	self.isFirst = YES;
	
//	self.navigationController.navigationBar.hidden = YES;
//	self.navigationController.navigationBar.translucent = YES;
	self.view.backgroundColor = [UIColor whiteColor];
	
	_noviceTimerCount_11 = 60;


}

- (void)openMyShop
{
	UIImageView *startIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
	startIv.userInteractionEnabled = YES;
	if (kDevice_Is_iPhone4) {
		startIv.image = [UIImage imageNamed:@"开店-引导页_320.jpg"];
	} else {
		startIv.image = [UIImage imageNamed:@"开店-引导页_1080.jpg"];
	}
	[self.view addSubview:_startImageView = startIv];
	
	UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageViewClicK:)];
	[_startImageView addGestureRecognizer:tapGR];

}

- (void)tapImageViewClicK:(UITapGestureRecognizer *)sender
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSString *token = [ud objectForKey:USER_TOKEN];
	if (token.length) {
		SubmitViewController *sbVC = [[SubmitViewController alloc] init];
		sbVC.hidesBottomBarWhenPushed = YES;
		sbVC.typestring = @"开店";
		sbVC.delegate = self;
		
		[self.navigationController pushViewController:sbVC animated:YES];
	} else {

		[self pushLoginAndRegisterView];
	}
}


- (void)toLogin :(NSInteger)tag
{
	LoginViewController *login=[[LoginViewController alloc]init];
	login.tag = tag;
	login.loginStatue=@"toBack";
	login.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:login animated:YES];
}

- (void)pushLoginAndRegisterView
{
	TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
	[tf show];
	
	tf.upBlock = ^() {
		//上键");
		[self toLogin:2000];
	};
	
	tf.downBlock = ^() {
		//下键");
		[self toLogin:1000];
	};
}

/**
 *  开完店的店铺说明
 */
- (void)noviceTaskView6
{
	
	self.noviceTaskView = [[TFNoviceTaskView alloc] init];
	[self.noviceTaskView returnClick:^(NSInteger type) {
		
		self.noviceTaskView = [[TFNoviceTaskView alloc] init];
		[self.noviceTaskView returnClick:^(NSInteger type) {
			[self callObjectiveCWithH5ShareStoreLink:nil witnIndex:0];
		} withCloseBlock:^(NSInteger type) {
			
		}];
		[self.noviceTaskView showWithType:@"5_1"];
	} withCloseBlock:^(NSInteger type) {
		
		self.noviceTaskView = [[TFNoviceTaskView alloc] init];
		[self.noviceTaskView returnClick:^(NSInteger type) {
			[self callObjectiveCWithH5ShareStoreLink:nil witnIndex:0];
		} withCloseBlock:^(NSInteger type) {
			
		}];
		[self.noviceTaskView showWithType:@"5_1"];
	}];
	[self.noviceTaskView showWithType:@"5_2"];
	
}

- (void)addMyWebView
{
//	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSString *token = [ud objectForKey:USER_TOKEN];
//	NSString *realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
//	NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];

	UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20-49)];
	webView.backgroundColor = [UIColor whiteColor];
	webView.scalesPageToFit = YES;
	webView.scrollView.bounces = NO;
	webView.delegate = self;
	
	_webView = webView;
	
	[self.view addSubview:_webView];

//	[self.view addSubview:self.webView];
	
//	[self webViewProgress];

//	[self.view addSubview:self.webViewProgressView];

	self.jsContext = [[JSContext alloc] init];
	
	[self webViewLoad:self.type];

	UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
	statusView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:statusView];
	

	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	[window addSubview:self.backgroundView];
	[window bringSubviewToFront:self.backgroundView];

}

- (NJKWebViewProgress *)webViewProgress
{
	if (_webViewProgress == nil) {
		_webViewProgress = [[NJKWebViewProgress alloc] init];
		_webView.delegate = _webViewProgress;
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

- (void)callObjectiveCWithHomeWithUserInfo:(NSDictionary *)userInfo
{
	NSDictionary *dic = userInfo;
	
	//	//the recived dic = %@", dic);
	dispatch_async(dispatch_get_main_queue(), ^{
		ShopDetailViewController *detail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
		detail.shop_code = dic[@"shop_code"];
		detail.hidesBottomBarWhenPushed=YES;
		[self.navigationController pushViewController:detail animated:YES];
	});
	
}

- (void)callObjectiveCWithRefreshMyShop
{
//	[self webViewLoad:self.type];
	
//	[self.webView removeFromSuperview];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		
//		NSLog(@"callObjectiveCWithRefreshMyShop");
		[self addMyWebView];
		
	});
}

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
	[_webViewProgressView setProgress:progress animated:YES];
//    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	NSURL* url = [request URL];
	NSString* urlstring = [NSString stringWithFormat:@"%@",url];
	MyLog(@"currWebViewUrl: %@",urlstring);
	
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {


	self.isFiled = NO;
	self.isFirst = NO;
	self.isFormMyIntegral = NO;
	self.isSubmitLove = NO;
	
	self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
	
	TFJSObjCModel *model  = [[TFJSObjCModel alloc] init];
	
	model.index = 0;
	model.jsContext = self.jsContext;
	model.delegate = self;
	model.webView = webView;
	
	self.jsContext[@"OCModel"] = model;
	
//	if (self.fromType.length!=0) {
//		JSValue *jsParamFunc = self.jsContext[@"myShopChangesComplete"];
//		[jsParamFunc callWithArguments:nil];
//		
//	}
	
	self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
		context.exception = exceptionValue;
		//异常信息：%@", exceptionValue);
	};
	
	
}
//WebViewJavascriptBridge

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
	
	[[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	

	self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
	
	TFJSObjCModel *model  = [[TFJSObjCModel alloc] init];
	
	model.index = 0;
	model.jsContext = self.jsContext;
	model.delegate = self;
	model.webView = webView;
	
	self.jsContext[@"OCModel"] = model;
	
	if (self.fromType.length!=0) {
		JSValue *jsParamFunc = self.jsContext[@"myShopChangesComplete"];
		[jsParamFunc callWithArguments:nil];
		
	}
	
	self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
		context.exception = exceptionValue;
		//异常信息：%@", exceptionValue);
	};
	
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.isFiled = YES;
	self.isFirst = NO;
	self.isFormMyIntegral = NO;
	self.isSubmitLove = NO;
}

- (void)httpWebViewReload
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSString *isHome;
	if ([ud objectForKey:@"isHome"]) {
		isHome = @"false";
	} else {
		isHome = @"false";
	}
	
//    NSString *token = [ud objectForKey:USER_TOKEN];
	NSString *realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
	NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];

    NSString *urlStr = [NSString stringWithFormat:@"%@view/store/edit.html?isIOS=true&token=%@&realm=%@&isFirstLogin=%@",[NSObject baseURLStr_H5],token,realm,isHome];
    //httpUrlStr = %@",urlStr);
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
	
//	[self.webView reload];
	
}

//- (UIWebView *)webView {
//    if (_webView == nil) {
//        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20-49)];
//		_webView.backgroundColor = [UIColor whiteColor];
//        _webView.scalesPageToFit = YES;
//		_webView.scrollView.bounces = NO;
//		_webView.delegate = self;
//    }
//    
//    return _webView;
//}

- (void)webViewLoad:(NSString *)type
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	
	NSString *isHome;
	
	if ([ud objectForKey:@"isHome"]) {
		isHome = @"false";
		
	} else {
		isHome = @"false";
	}
	
	NSString *realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
	NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];
	
//	NSLog(@"token = %@, realm = %@, type = %@", token, realm, self.type);
	
	NSString *urlStr;
	
	if (type == nil||[type isEqualToString:DailyTaskFriday]) { //直接点或者星期五
		
		urlStr = [NSString stringWithFormat:@"%@view/store/edit.html?isIOS=true&token=%@&realm=%@&isFirstLogin=%@",[NSObject baseURLStr_H5],token,realm,isHome];
		
		//直接进入我的店/星期五任务进入");
		
//		NSURL *url = [NSURL URLWithString:urlStr];
//		NSURLRequest *request = [NSURLRequest requestWithURL:url];
//		[self.webView loadRequest:request];

		NSString *path = [[NSBundle mainBundle] bundlePath];
		NSURL *baseURL = [NSURL fileURLWithPath:path];
		NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"edit"
															  ofType:@"html"];
		
		NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
														encoding:NSUTF8StringEncoding
														   error:nil];
		//htmlPath: %@", htmlPath);
		[_webView loadHTMLString:htmlCont baseURL:baseURL];
		
		
//		NSString *basePath = [[NSBundle mainBundle] bundlePath];
//		NSString *helpHtmlPath = [basePath stringByAppendingPathComponent:@"edit.html"];
//		NSURL *url = [NSURL fileURLWithPath:helpHtmlPath];
//		NSURLRequest *request=[NSURLRequest requestWithURL:url];
//		[self.webView loadRequest:request];
		
		
//		NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"edit.html"];
//		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
//		[self.webView loadRequest:request];
		
		
	} else if ([type isEqualToString:DailyTaskMonday]||[type isEqualToString:NoviciateTaskMonday]) { //选择模版(星期一)
		urlStr = [NSString stringWithFormat:@"%@view/store/selectTheme.html?isIOS=true&token=%@&realm=%@&isFirstLogin=%@",[NSObject baseURLStr_H5],token,realm,isHome];
		
		//选择模版(星期一)");
		
		NSURL *url = [NSURL URLWithString:urlStr];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[_webView loadRequest:request];
		
	} else if ([type isEqualToString:DailyTaskTuesday]||[type isEqualToString:NoviciateTaskTuesday]) { //公告(星期二)
		urlStr = [NSString stringWithFormat:@"%@view/store/theme/editNotice.html?isIOS=true&token=%@&realm=%@&isFirstLogin=%@",[NSObject baseURLStr_H5],token,realm,isHome];
		
		//公告(星期二)");
		
		NSURL *url = [NSURL URLWithString:urlStr];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[_webView loadRequest:request];
		
	} else if ([type isEqualToString:DailyTaskWednesday]||[type isEqualToString:NoviciateTaskWednesday]) {	 //轮播图(星期三)
		urlStr = [NSString stringWithFormat:@"%@view/store/theme/editBanner.html?isIOS=true&token=%@&realm=%@&isFirstLogin=%@",[NSObject baseURLStr_H5],token,realm,isHome];
		
		//轮播图(星期三)");
		
		NSURL *url = [NSURL URLWithString:urlStr];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[_webView loadRequest:request];
		
	} else if ([type isEqualToString:DailyTaskThursday]||[type isEqualToString:NoviciateTaskThursday]) { //推荐(星期四)
		urlStr = [NSString stringWithFormat:@"%@view/store/theme/setRecommend.html?isIOS=true&token=%@&realm=%@&isFirstLogin=%@",[NSObject baseURLStr_H5],token,realm,isHome];
		
		//推荐(星期四)");
		
		NSURL *url = [NSURL URLWithString:urlStr];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[self.webView loadRequest:request];
		
	} else if ([type isEqualToString:@"changeShopName"]) { //店铺名字(更换名字)
		urlStr = [NSString stringWithFormat:@"%@/view/store/theme/editName.html?isIOS=true&token=%@&realm=%@&isFirstLogin=%@",[NSObject baseURLStr_H5],token,realm,isHome];
		
		//店铺名字(更换名字)");
		
		NSURL *url = [NSURL URLWithString:urlStr];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[_webView loadRequest:request];
		
	} else if ([type isEqualToString:@"changeShopHeadImage"]) { //店铺头像(更换头像)
		urlStr = [NSString stringWithFormat:@"%@/view/store/theme/edit.html?isIOS=true&token=%@&realm=%@&isFirstLogin=%@",[NSObject baseURLStr_H5],token,realm,isHome];
		
		//店铺头像(更换头像)");
		
		NSURL *url = [NSURL URLWithString:urlStr];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[_webView loadRequest:request];
		
	}
	
//	//webUrlStr = %@",urlStr);
	
}

- (UIView *)shareView
{
	if (_shareView == nil) {
		_shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, H_SHARE)];
		_shareView.backgroundColor = [UIColor whiteColor];
		
		CGFloat H_Btn = ZOOM(200);
		/*
		NSArray *titleArr = [NSArray arrayWithObjects:@"qq",@"微信", @"微博", nil];
		

		CGFloat Margin = (kScreenWidth-titleArr.count*H_Btn)/4.0;
		for (int i = 0; i<titleArr.count; i++) {
			//
			UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.frame = CGRectMake(Margin+i*H_Btn+i*Margin, (H_SHARE-H_Btn)/2.0, H_Btn, H_Btn);
			btn.tag = 100+i;
			[btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
			
			if (i==0) {
				if ([QQApi isQQInstalled])
				{
					[btn setBackgroundImage:[UIImage imageNamed:titleArr[i]] forState:UIControlStateNormal];
					
				} else{
					btn.hidden=YES;
				}
			} else if (i == 1){
				if ([WXApi isWXAppInstalled]) {
					[btn setBackgroundImage:[UIImage imageNamed:titleArr[i]] forState:UIControlStateNormal];
					
				} else {
					btn.hidden=YES;
				}
			} else{
				[btn setBackgroundImage:[UIImage imageNamed:titleArr[i]] forState:UIControlStateNormal];
			}
			
			[_shareView addSubview:btn];

		}
		 */

		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake((kScreenWidth-H_Btn)/2.0, (H_SHARE-H_Btn)/2.0, H_Btn, H_Btn);
		btn.tag = 100+1;
//		[_shareView addSubview:btn];
		if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
			[btn setBackgroundImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
		} else {
			btn.hidden=YES;
		}
		[btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
		
		[_shareView addSubview:_shareBtn = btn];
	}
	
	return _shareView;
}

- (UIButton *)shareBtn
{
	if (_shareBtn == nil) {
		
		CGFloat H_Btn = ZOOM(200);
		
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = CGRectMake((kScreenWidth-H_Btn)/2.0, (H_SHARE-H_Btn)/2.0, H_Btn, H_Btn);
		btn.tag = 100+1;
		[btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
		_shareBtn = btn;
	}
	
	return _shareBtn;
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
	view.backgroundColor = [RGBCOLOR_I(220,220,220) colorWithAlphaComponent:0.5];
//	view.alpha = ;
	[window addSubview:_backgroundView =  view];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
	[_backgroundView addGestureRecognizer:tap];
	
	[view addSubview:self.shareView];
}

- (void)callObjectiveCWithH5ShareApp:(NSDictionary *)dict witnIndex:(int)index
{
	
	dispatch_async(dispatch_get_main_queue(), ^{
		if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
			AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
			[appDelegate shardk];
			
			UIImage *img;
			if (self.shareAppImg == nil) {
				
			} else {
				img = self.shareAppImg;
			}
			
			DShareManager *ds = [DShareManager share];
			ds.delegate = self;
			[ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:@"TFHome1" withImage:img];
		} else {
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.personImageView removeFromSuperview];
				NavgationbarView *nv = [[NavgationbarView alloc] init];
				[nv showLable:@"请安装微信,再分享" Controller:self];
				
				[self addMyWebView];
			});
			
			
		}
	});
	
//	//App");
	
}

- (void)callObjectiveCWithH5ShareStoreLink:(NSDictionary *)dict witnIndex:(int)index
{
//	//link");
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
		dispatch_async(dispatch_get_main_queue(), ^{
			// 更UI
			
//			[self addBackgroundView];
//			[UIView animateWithDuration:0.5 animations:^{
//				self.shareView.frame = CGRectMake(0, kScreenHeight-H_SHARE, kScreenWidth, H_SHARE);
//			} completion:^(BOOL finished) {
//				
//			}];
			
			[self shareBtnClick:self.shareBtn];
			
		});
	} else {
		
		dispatch_async(dispatch_get_main_queue(), ^{
			NavgationbarView *nv = [[NavgationbarView alloc] init];
			[nv showLable:@"请安装微信,再分享" Controller:self];
		});
		

	}
}

- (void)callObjectiveCWithGoShopCart
{
	dispatch_async(dispatch_get_main_queue(), ^{
//		WTFCartViewController *view = [[WTFCartViewController alloc]init];
//		view.hidesBottomBarWhenPushed=YES;
////		view.Carttype = @"我的店";
//		[self.navigationController pushViewController:view animated:YES];
		
		NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
		shoppingcart.ShopCart_Type = ShopCart_NormalType;
		shoppingcart.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:shoppingcart animated:YES];

	});
	
//	//购物车");
	
}

- (void)callObjectiveCWithGoPersonCenter
{
	dispatch_async(dispatch_get_main_queue(), ^{
		Mtarbar.selectedIndex = 4;
	});

}

- (void)tapClick:(UITapGestureRecognizer *)sender
{
	[self hideHudTheShareView:0.5];
}

- (void)shareBtnClick:(UIButton *)sender
{
	//begin ZGL 分享统计
	[DataManager sharedManager].shareTabType = StatisticalTabTypeShop;
	//end
	
	[MobClick event:STORE_SHARE];
	
	int index = (int)sender.tag;
	
	//share_type = %@", self.type);
	
	AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate shardk];
	
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSString *realm = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_REALM]];
//	NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];

	NSString *link = [NSString stringWithFormat:@"%@view/store/index.html?realm=%@", [NSObject baseURLStr_H5], realm];
	
	//link = %@", link);
	
	DShareManager *ds = [DShareManager share];
	ds.delegate = self;
	
	NSString *name = [ud objectForKey:STORE_NAME];
	NSString *title = [NSString stringWithFormat:@"%@-姐妹们的美丽小屋~",name];
	
	//何波加的 2016-9-18
	int i = arc4random()%ds.ShareTitleArray.count;
	NSString *sharetitle = ds.ShareTitleArray[i];
	title = sharetitle;
	
	
	NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"is_match" ofType:@"png"];
	
	if(index == 100)			//QQ
	{
		[ds shareAppWithType:ShareTypeQQSpace withLinkShareType:self.type withLink:link andImagePath:imagePath andTitle:title andContent:nil];
		
	} else if (index == 101) { //微信
		//ShareTypeWeixiSession		//好友
		//ShareTypeWeixiTimeline//朋友圈
		[ds shareAppWithType:ShareTypeWeixiTimeline withLinkShareType:self.type withLink:link andImagePath:imagePath andTitle:title andContent:nil];
		
	} else if (index == 102) { //微博
		
		[ds shareAppWithType:ShareTypeSinaWeibo withLinkShareType:self.type withLink:link andImagePath:imagePath andTitle:title andContent:nil];
	}


	[self hideHudTheShareView:0.5];
}

- (void)hideHudTheShareView:(NSTimeInterval)timeCount
{
//	Myview.hidden = NO;
	[UIView animateWithDuration:timeCount animations:^{
		self.shareView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, H_SHARE);

	} completion:^(BOOL finished) {
		[self.backgroundView removeFromSuperview];
	}];
}

- (void)httpGetShareImage
{
	AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];

	NSString *url=[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], USER_SHARE_APP];
	//url = %@", url);
	
	manager.responseSerializer = [AFImageResponseSerializer serializer];
	[manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		responseObject = [NSDictionary changeType:responseObject];
		if (responseObject!=nil) {
			NSData *imgData = UIImagePNGRepresentation(responseObject);
			self.shareAppImg = [UIImage imageWithData:imgData];
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		//
	}];

}

- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
	NavgationbarView *nv = [[NavgationbarView alloc] init];
	
	//type = %@", type);
	
	if ([type isEqualToString:self.type] && self.type!=nil) {
//		self.type = nil;
		if (shareStatus == 1) {
			
			[self httpShareSuccessWithType:type];
			
		} else if (shareStatus == 2) {
			
			[nv showLable:@"分享失败" Controller:self];
		} else if (shareStatus == 3) {
			
//			[nv showLable:@"分享取消" Controller:self];
		}
	} else if ([type isEqualToString:@"type == nil"]) {
		if (shareStatus == 1) {
			
			int week = [[MyMD5 getCurrTimeString:@"week"] intValue];
			if (week == 6) { //是星期五才调接口
    			[self httpShareSuccessWithType:DailyTaskFriday];
			}
			
			
		} else if (shareStatus == 2) {

			[nv showLable:@"分享失败" Controller:self];
		} else if (shareStatus == 3) {
			
//			[nv showLable:@"分享取消" Controller:self];
		}
	}
}


-(void)httpShareSuccessWithType:(NSString *)type
{
	NavgationbarView *nv = [[NavgationbarView alloc] init];
	
	AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
	NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
	
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSString *token = [NSString stringWithFormat:@"%@",[ud objectForKey:USER_TOKEN]];
	
	NSString *urlStr;
	if ([type isEqualToString:DailyTaskMonday]) {			//1
		urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=12",[NSObject baseURLStr], VERSION,token];
	} else if ([type isEqualToString:DailyTaskTuesday]) {		//2
		urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=13",[NSObject baseURLStr], VERSION,token];
	} else if ([type isEqualToString:DailyTaskWednesday]) {	//3
		urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=14",[NSObject baseURLStr], VERSION,token];
	} else if ([type isEqualToString:DailyTaskThursday]) {	//4
		urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=15",[NSObject baseURLStr], VERSION,token];
	} else if ([type isEqualToString:DailyTaskFriday]) {		//5
		urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=16",[NSObject baseURLStr], VERSION,token];
	} else if ([type isEqualToString:NoviciateTaskTuesday]) {	//首次发布公告并分享到朋友圈
		urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=22",[NSObject baseURLStr], VERSION,token];
	} else if ([type isEqualToString:NoviciateTaskWednesday]) {	//店铺首次更换轮播图商品并分享到朋友圈
		urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=23",[NSObject baseURLStr], VERSION,token];
	} else if ([type isEqualToString:NoviciateTaskThursday]) {	//店铺首次更换店主最爱商品并分享到朋友圈
		urlStr = [NSString stringWithFormat:@"%@mission/doMission?version=%@&token=%@&m_id=24",[NSObject baseURLStr], VERSION,token];
	}
	
	NSString *URL=[MyMD5 authkey:urlStr];
	
	
	[manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
		responseObject = [NSDictionary changeType:responseObject];
		//type = %@ 分享调用接口 res = %@", type, responseObject);
		
		if (responseObject!=nil) {
			if ([responseObject[@"status"] intValue] == 1) {
				[HTTPTarbarNum httpRedCount];

				if ([type isEqualToString:DailyTaskMonday]) {		//1
					
					int flag = [responseObject[@"flag"] intValue];
					int num = [responseObject[@"num"] intValue];
					
					int newFlag = [responseObject[@"newFlag"] intValue];
					int newNum = [responseObject[@"newNum"] intValue];
					
					if (flag == 0&&newFlag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num+newNum] Controller:self];
					} else if (flag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
					}
					
				} else if ([type isEqualToString:DailyTaskTuesday]) {		//2

					int flag = [responseObject[@"flag"] intValue];
					int num = [responseObject[@"num"] intValue];
					
					int newFlag = [responseObject[@"newFlag"] intValue];
					int newNum = [responseObject[@"newNum"] intValue];
					
					if (flag == 0&&newFlag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num+newNum] Controller:self];
					} else if (flag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
					}
					
				} else if ([type isEqualToString:DailyTaskWednesday]) {	//3
					int flag = [responseObject[@"flag"] intValue];
					int num = [responseObject[@"num"] intValue];
					
					int newFlag = [responseObject[@"newFlag"] intValue];
					int newNum = [responseObject[@"newNum"] intValue];
					
					if (flag == 0&&newFlag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num+newNum] Controller:self];
					} else if (flag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
					}
				} else if ([type isEqualToString:DailyTaskThursday]) {	//4
					int flag = [responseObject[@"flag"] intValue];
					int num = [responseObject[@"num"] intValue];
					
					int newFlag = [responseObject[@"newFlag"] intValue];
					int newNum = [responseObject[@"newNum"] intValue];
					
					if (flag == 0&&newFlag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num+newNum] Controller:self];
					} else if (flag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
					}
					
				} else if ([type isEqualToString:DailyTaskFriday]) {		//5
					int flag = [responseObject[@"flag"] intValue];
					int num = [responseObject[@"num"] intValue];
					
					int newFlag = [responseObject[@"newFlag"] intValue];
					int newNum = [responseObject[@"newNum"] intValue];
					
					if (flag == 0&&newFlag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num+newNum] Controller:self];
					} else if (flag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", num] Controller:self];
					}
				} else if ([type isEqualToString:NoviciateTaskTuesday]) {	//首次发布公告
					
					int flag = [responseObject[@"flag"] intValue];
					int num = [responseObject[@"num"] intValue];
					
					int newFlag = [responseObject[@"newFlag"] intValue];
					int newNum = [responseObject[@"newNum"] intValue];
					
					if (newFlag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", newNum] Controller:self];
					}
					
					[ud setBool:NO forKey:NoviciateTask_22_FLAG];

					
				} else if ([type isEqualToString:NoviciateTaskWednesday]) {	//首次轮播图
					
					int flag = [responseObject[@"flag"] intValue];
					int num = [responseObject[@"num"] intValue];
					
					int newFlag = [responseObject[@"newFlag"] intValue];
					int newNum = [responseObject[@"newNum"] intValue];
					if (newFlag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", newNum] Controller:self];
					}
					
					[ud setBool:NO forKey:NoviciateTask_23_FLAG];
				} else if ([type isEqualToString:NoviciateTaskThursday]) {	//首次店主最爱
					int flag = [responseObject[@"flag"] intValue];
					int num = [responseObject[@"num"] intValue];
					
					int newFlag = [responseObject[@"newFlag"] intValue];
					int newNum = [responseObject[@"newNum"] intValue];
					if (newFlag == 0) {
						[nv showLable:[NSString stringWithFormat:@"任务完成,恭喜获得%d积分", newNum] Controller:self];
					}
					[ud setBool:NO forKey:NoviciateTask_24_FLAG];
				}
				
			} else {
				[nv showLable:responseObject[@"message"] Controller:self];
			}
		}
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		//网络连接失败");
	}];
}

- (void)viewWillAppear:(BOOL)animated
{
//	
//	NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//	for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//		MyLog(@"cookie == %@", cookie);
//	}

	
	[self httpFindPhone];
	
	[self todayOrTomorrow];
	
	[MobClick beginLogPageView:@"XiaodianPage"];
	

	self.automaticallyAdjustsScrollViewInsets = NO;
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSString *token = [ud objectForKey:USER_TOKEN];
	NSString *hobby = [ud objectForKey:USER_HOBBY];
	
	if (self.isSubmitLove) {
		[ud setBool:YES forKey:@"isOpenShop"];
	} else {
		[ud setBool:NO forKey:@"isOpenShop"];
	}
	
	//token = %@", token);
	//hobby = %@", hobby);
	
	if (token!=nil) {
		
		NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];

		[ud setObject:currDic[@"year-month-day"] forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],DailyTaskAddNewShop]];

		if ([[ud objectForKey:USER_HOBBY] length]!=0) {
			
			if (self.isFirst||self.isFormMyIntegral||self.isSubmitLove) {
				
				[self addMyWebView];
				
				if ([[ud objectForKey:isShowNoviceTaskView6] intValue] == 1) { /**<  ＝ 1 弹店铺说明 */
					[ud setObject:@"0" forKey:isShowNoviceTaskView6];
					//弹店铺说明
//					[self noviceTaskView6];
				}
				
			}
			
		} else {
			
			[self openMyShopNew];

		}
	} else {
			
		[self openMyShopNew];
		
	}
	
	if (self.isFiled) {
		self.isFiled = NO;
		self.type = nil;
		[self addMyWebView];
	}
	
	//去吐槽/不去了
	[self noviceTaskView11];
	
	//是否弹店铺说明
	if ([[ud objectForKey:isShowNoviceTaskView6] intValue] == 1) { /**<  ＝ 1弹店铺说明 */
		[ud setObject:@"0" forKey:isShowNoviceTaskView6];
		//弹店铺说明
//		[self noviceTaskView6];
	}
	
}
- (void)viewDidDisappear:(BOOL)animated
{
	[MobClick endLogPageView:@"XiaodianPage"];
	
	[_noviceTimer_11 invalidate];
	[self.startImageView removeFromSuperview];
	[_ScrollView_public removeFromSuperview];
	
}

- (void)todayOrTomorrow
{
	[Mtarbar hideBadgeOnItemIndex:0];
	
//	NSDate * nowDate ;
	
	NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
//	NSString *nowdate = [userdefaul objectForKey:MARK_STORE];
	
//	if(!nowdate)
//	{
//		nowDate = [NSDate date];[[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],MARK_STORE]
		[userdefaul setObject:[MyMD5 getCurrTimeString:@"year-month-day"] forKey:[NSString stringWithFormat:@"%@%@",[userdefaul objectForKey:USER_ID],MARK_STORE]];
//	}
	[HTTPTarbarNum httpRedCount];
}

- (void)submitFailure:(SubmitViewController *)submitController
{
	NavgationbarView *nv = [[NavgationbarView alloc] init];
	[nv showLable:@"提交喜好失败" Controller:self];
	
	self.isSubmitLove = YES;
	
	//	[self addMyWebView];
}

- (void)submitSuccess:(SubmitViewController *)submitController
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	[ud setBool:YES forKey:@"isOpenShop"];
	
//	[ud setBool:YES forKey:@"openShopMsgBox"];
	
	[[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:Phone_isOpen];
	[self.startImageView removeFromSuperview];
	[_ScrollView_public removeFromSuperview];
	self.isSubmitLove = YES;
	
	[self httpGetStoreLink];
	
}

- (void)noviceTaskView11
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSString *token = [ud objectForKey:USER_TOKEN];
	NSString *goFeedbackFlag = [ud objectForKey:UserShowFlag];
	if (token!=nil && [goFeedbackFlag intValue] == 1 && _noviceTimerCount_11!=0) { //用户登录并且第二次打开APP
		
		if ([_noviceTimer_11 isValid]) {
			[_noviceTimer_11 invalidate];
		}
		_noviceTimer_11 = [NSTimer weakTimerWithTimeInterval:MY_SEC target:self selector:@selector(timeGoFeedback) userInfo:nil repeats:YES];
		
	}
}

- (void)timeGoFeedback
{
	_noviceTimerCount_11--;
	//去吐槽/不去了 = %d",(int)_noviceTimerCount_11);
	
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	
	if (_noviceTimerCount_11 == 0) {
		
		[ud setBool:NO forKey:UserShowFlag]; //不用弹出了
		[_noviceTimer_11 invalidate];
		
		self.noviceTaskView = [[TFNoviceTaskView alloc] init];
		[self.noviceTaskView returnClick:^(NSInteger type) {
			
			//type = %d", (int)type);
			if (type == 11) {
				//去吐槽
				TFFeedBackViewController *tffVC = [[TFFeedBackViewController alloc] init];
				tffVC.hidesBottomBarWhenPushed = YES;
				[self.navigationController pushViewController:tffVC animated:YES];
			} else if (type == 511) {
				//不去了
			}
			
		} withCloseBlock:^(NSInteger type) {
			
		}];
		[self.noviceTaskView showWithType:@"11"];
	}
}


- (void)callObjectiveCWithGoLogin
{
	dispatch_async(dispatch_get_main_queue(), ^{
			[self toLogin:1000];
	});

}

- (void)callObjectiveCWithH5EditStoreModelInfo:(NSDictionary *)params
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	
	//fromType = %@", self.fromType);
	//params = %@", params);
	
	
	int typeIndex = [params[@"type"] intValue];
	int week = [[MyMD5 getCurrTimeString:@"week"] intValue];
	
	NSString *myType;
	if (week == 2) {
		myType = @"4_1";
	} else if (week == 3) {
		myType = @"5_1";
	} else if (week == 4) {
		myType = @"6_1";
	} else if (week == 5) {
		myType = @"7_1";
	} else if (week == 6) {
		myType = @"8_1";
	}
	
	switch (typeIndex) {
		case 1: {
				if (week == 2) { //星期一任务
					self.type = DailyTaskMonday;
				}
			}
			break;
		case 2: {
				if ([[ud objectForKey:NoviciateTask_22_FLAG] intValue] == 1) { //判断要不要首次
					if (week == 3) {
						self.type = DailyTaskTuesday;
					} else {
						self.type = NoviciateTaskTuesday;
					}
				} else {
					if (week == 3) {
						self.type = DailyTaskTuesday;
					}
				}
			}
			break;
		case 3: {
				if ([[ud objectForKey:NoviciateTask_23_FLAG] intValue] == 1) { //判断要不要首次
					if (week == 4) {
						self.type = DailyTaskWednesday;
					} else {
						self.type = NoviciateTaskWednesday;
					}
				} else {
					if (week == 4) {
						self.type = DailyTaskWednesday;
					}
				}
			}
			break;
		case 4: {
				if ([[ud objectForKey:NoviciateTask_24_FLAG] intValue] == 1) { //判断要不要首次
					if (week == 5) {
						self.type = DailyTaskWednesday;
					} else {
						self.type = NoviciateTaskThursday;
					}
				} else {
					if (week == 5) {
						self.type = DailyTaskThursday;
					}
				}
			}
			break;
		default:
			break;
	}
	
	if ([self.fromType isEqualToString:DailyTaskGoShop]) { //每日任务
		if ([params[@"dialog"] intValue] == 0) {

		} else if ([params[@"dialog"] intValue] == 1) { //完成
			
			self.dailyTsakView = [[TFDailyTaskView alloc] init];
			[self.dailyTsakView returnClick:^(NSInteger type) {
				
				self.fromType = nil;
				
				[self callObjectiveCWithH5ShareStoreLink:nil witnIndex:0];
				
				
			} withCloseBlock:^(NSInteger type) {
				
				self.fromType = nil;
				
			}];
			[self.dailyTsakView showWithType:myType];
		}
		
	} else if ([self.fromType isEqualToString:IntegralTaskGoShop]) { //积分过来
		if ([params[@"dialog"] intValue] == 0) {
			
		} else if ([params[@"dialog"] intValue] == 1) { //完成
			if ([self.type isEqualToString:DailyTaskThursday]||[self.type isEqualToString:DailyTaskWednesday]||[self.type isEqualToString:DailyTaskTuesday]||[self.type isEqualToString:DailyTaskMonday]) {

				NSDictionary *currDic = [NSDictionary dictionaryWithObjectsAndKeys:[MyMD5 getCurrTimeString:@"year-month-day"], @"year-month-day", nil];
				[ud setObject:currDic[@"year-month-day"] forKey:[NSString stringWithFormat:@"%@%@",[ud objectForKey:USER_ID],self.type]];
			}
			self.fromType = nil;
		}
	}
}

- (void)openMyShopNew
{
	NSMutableArray *imgMuArr = [NSMutableArray array];
	
	for (int i =0; i<4; i++) {
		NSString *stt;
		
		if (kDevice_Is_iPhone4) {
			stt = [NSString stringWithFormat:@"轮播%d_320.jpg",i+1];
		} else
			stt = [NSString stringWithFormat:@"轮播%d.jpg",i+1];
		UIImage *img = [UIImage imageNamed:stt];
		[imgMuArr addObject:img];
	}
	
	//添加轮播图
	_ScrollView_public = [[ScrollView_public alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) pictures:imgMuArr animationDuration:3 contentMode_style:Fill_contentModestyle Haveshiping:NO];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.frame = CGRectMake(ZOOM(67), CGRectGetHeight(_ScrollView_public.frame)-49-ZOOM(54)-ZOOM(100), CGRectGetWidth(_ScrollView_public.frame)-2*ZOOM(67), ZOOM(100));
	[btn setTitle:@"开启我的小店" forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
	btn.layer.masksToBounds = YES;
	btn.layer.cornerRadius = CGRectGetHeight(btn.frame)*0.5;
	btn.titleLabel.font = kFont6px(32);
	
	CGRect pageControlRect = _ScrollView_public.pageControl.frame;
	
	_ScrollView_public.pageControl.frame = CGRectMake(pageControlRect.origin.x, CGRectGetMinY(btn.frame)-pageControlRect.size.height, pageControlRect.size.width, pageControlRect.size.height);
	[btn addTarget:self action:@selector(goOpenMyShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
	
	_ScrollView_public.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"当前轮播滑动条"];
	_ScrollView_public.pageControl.pageIndicatorImage = [UIImage imageNamed:@"默认轮播滑动条"];
	
	[_ScrollView_public addSubview:btn];
	
	[self.view addSubview:_ScrollView_public];
	
	_ScrollView_public.scrollview.scrollsToTop = NO;
	_ScrollView_public.getTapClickPage = ^(NSInteger page){
//		//点击 %d",(int) page);
		
	};
	
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSString *token = [ud objectForKey:USER_TOKEN];
	
	if ([[ud objectForKey:isShowNoviceTaskView6] intValue] == 2) { // 开店
		self.isBindPhone = YES;
		[ud setObject:@"0" forKey:isShowNoviceTaskView6];
		if (token.length) {
			[self goOpenMyShopBtnClick:btn];
		} else {
			[self pushLoginAndRegisterView];
		}
	}
	
}

- (void)callObjectiveCWithGuideComplete
{
	/*
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	
	if ([[ud objectForKey:@"openShopMsgBox"] intValue] == 1) { //刚刚开店
		//	//the recived dic = %@", dic);
		dispatch_async(dispatch_get_main_queue(), ^{
			[ud setBool:NO forKey:@"openShopMsgBox"];
			
			UINavigationController *nc = Mtarbar.viewControllers[2];
			
			HomeSingViewController *hsVC = (HomeSingViewController *)[nc.viewControllers firstObject];
			hsVC.fromType = @"小店";
			Mtarbar.selectedIndex = 2;
		});

	}
	 */
}

- (void)goOpenMyShopBtnClick:(UIButton *)sender
{
	kSelfWeak;
	[self loginVerifySuccess:^{
		if (weakSelf.isBindPhone == YES)
		{
			NSString *UUID = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_UUID]];
			MyLog(@"UUID = %@",UUID);
			if(UUID ==nil || [UUID isEqual:[NSNull null]])
			{
				[weakSelf saveUUIDHttp];
			}
			
			[[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:isShowNoviceTaskView6];
			
			SubmitViewController *sbVC = [[SubmitViewController alloc] init];
			sbVC.hidesBottomBarWhenPushed = YES;
			sbVC.typestring = @"开店";
			sbVC.delegate = weakSelf;
			
			[weakSelf.navigationController pushViewController:sbVC animated:YES];
			
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"为了您的账户安全,请先绑定手机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
			[alert show];
		}
	}];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	//%ld", (long)buttonIndex);
	
	switch (buttonIndex) {
		case 0: {
			
		}
			break;
		case 1: {
//			TFOldPaymentViewController *tovc = [[TFOldPaymentViewController alloc] init];
//			tovc.headTitle = @"绑定手机";
//			tovc.leftStr = @"手机号码";
//			tovc.plaStr = @"输入您要绑定的手机号";
//			tovc.index = 1;
			BoundPhoneVC *tovc = [[BoundPhoneVC alloc] init];
			tovc.hidesBottomBarWhenPushed = YES;
			[self.navigationController pushViewController:tovc animated:YES];
		}
			break;
			
			
	  default:
				break;
	}
	
}

- (void)shareSdkWithAutohorWithTypeGetOpenID
{
	//向微信注册
	//    [WXApi registerApp:@"wx8c5fe3e40669c535" withDescription:@"demo 2.0"];
	
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate shardk];
	
	// 取消授权
	[ShareSDK cancelAuthWithType:ShareTypeWeixiFav];
	
	// 开始授权
	id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
														 allowCallback:YES
														 authViewStyle:SSAuthViewStyleFullScreenPopup
														  viewDelegate:nil
											   authManagerViewDelegate:nil];
	id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
	[app setIsAllowWebAuthorize:YES];
	
	[ShareSDK getUserInfoWithType:ShareTypeWeixiFav
					  authOptions:authOptions
						   result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
							   if (result) {
								   
								   //uid = %@", [userInfo uid]);
								   //sourceData = %@", [userInfo sourceData]);
								   //extInfo = %@", [[userInfo credential] extInfo]);
//								   NSString *nickName = [NSString stringWithFormat:@"%@",[userInfo nickname]];
//								   NSString *headImgUrl = [NSString stringWithFormat:@"%@", [userInfo profileImage]];
								   NSString *wx_openid = [userInfo uid];
								   
								   NSString *unionid = [NSString stringWithFormat:@"%@",[userInfo sourceData][@"unionid"]];
								   
								   //sourceData = %@", [userInfo sourceData]);
								   //uid = %@", [userInfo uid]);
								   
								   if ([userInfo sourceData][@"unionid"]!=nil) {
									   [self httpSendUnionId:unionid Openid:wx_openid];
								   } else {
									   NavgationbarView *nv = [[NavgationbarView alloc] init];
									   [nv showLable:@"信息获取失败,请重新尝试" Controller:self];
								   }
							   }
							   
							   NSString *errorStr = [NSString stringWithFormat:@"%@", [error errorDescription]];
							   if ([errorStr isEqualToString:@"尚未授权"]) {
								   
								   //失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
								   
							   }
							   
						   }];
	
}


- (void)httpSendUnionId:(NSString *)unionId Openid:(NSString *)wx_openid
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSString *token = [TFPublicClass getTokenFromLocal];
	NSString *urlStr = [NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&unionid=%@&wx_openid=%@",[NSObject baseURLStr],VERSION,token,unionId,wx_openid];
	
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	
	NSString *URL = [MyMD5 authkey:urlStr];
	
	[manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		responseObject = [NSDictionary changeType:responseObject];
		if (responseObject!=nil) {
			if ([responseObject[@"status"] intValue] == 1) {
				
				[ud setObject:@"0" forKey:isShowNoviceTaskView6];
				
				[ud setObject:unionId forKey:UNION_ID];
				
				SubmitViewController *sbVC = [[SubmitViewController alloc] init];
				sbVC.hidesBottomBarWhenPushed = YES;
				sbVC.typestring = @"开店";
				sbVC.delegate = self;
				
				[self.navigationController pushViewController:sbVC animated:YES];
				
				
			} else {
				NavgationbarView *nv = [[NavgationbarView alloc] init];
				[nv showLable:@"授权失败" Controller:self];
			}
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		//
	}];
}

-(void)saveUUIDHttp
{
	AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
	NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
	
	NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
	NSString *token=[user objectForKey:USER_TOKEN];
	NSString *UUID = [user objectForKey:USER_IMEI];
	
	NSString *url=[NSString stringWithFormat:@"%@user/update_userinfo?version=%@&token=%@&imei=%@",[NSObject baseURLStr],VERSION,token,UUID];
	
	NSString *URL=[MyMD5 authkey:url];
	
	[[Animation shareAnimation] createAnimationAt:self.view];
	
	[manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
		responseObject = [NSDictionary changeType:responseObject];
		[[Animation shareAnimation] stopAnimationAt:self.view];
		
		//responseObject is %@",responseObject);
		
		if (responseObject!=nil) {
			NSString *str=responseObject[@"status"];
			
			if(str.intValue==1)
			{
				MyLog(@"上传成功");
			}
			else{
				MyLog(@"上传失败");
			}
			
		}
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		
		//网络连接失败");
		
		NavgationbarView *mentionview=[[NavgationbarView alloc]init];
		[mentionview showLable:@"保存失败,请重试!" Controller:self];
		
		[[Animation shareAnimation] stopAnimationAt:self.view];
	}];
	
	
}

/*
- (void)httpGetUserIsOpenStoreStatus
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSString *token = [ud objectForKey:USER_TOKEN];
	
	if (token == nil) {
		return;
	}

	NSString *urlStr = [NSString stringWithFormat:@"%@user/checkStore?token=%@&version=%@", [NSObject baseURLStr], token, VERSION];
	
	NSString *URL = [MyMD5 authkey:urlStr];
	
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	
	[manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		//是否开店 = %@", responseObject);
 responseObject = [NSDictionary changeType:responseObject];
		if (responseObject!=nil) {
			if ([responseObject[@"status"] intValue] == 1) {
 
				if ([responseObject[@"is_store"] intValue] == 1) {
					self.isOpenStore = YES;
				} else {
					self.isOpenStore = NO;
				}
 
			}
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		//
	}];

}
 */

- (void)httpGetStoreLink
{
	NSString *token = [TFPublicClass getTokenFromLocal];
	NSString *realm = [TFPublicClass getRealmFromLocal];
	
	NSString *urlStr = [NSString stringWithFormat:@"%@store/getQRUrl?token=%@&version=%@&realm=%@", [NSObject baseURLStr], token, VERSION, realm];
	
	NSString *URL = [MyMD5 authkey:urlStr];
	
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	
	[manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		//店铺链接 = %@", responseObject);
		responseObject = [NSDictionary changeType:responseObject];
		if (responseObject!=nil) {
			if ([responseObject[@"status"] intValue] == 1) {
				NSString *pic = responseObject[@"pic"];
				NSString *urlStore = responseObject[@"url"];
				
				UIImage *QRImage =[[UIImage alloc] init];
				QRImage = [QRCodeGenerator qrImageForString:urlStore imageSize:160];
				
				[self uploadData:QRImage andImageKey:pic];
				
			}
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		//
	}];
}
- (void)uploadData:(UIImage *)image andImageKey:(NSString *)imageKey
{
	UpYun *uy = [[UpYun alloc] init];
	uy.successBlocker = ^(id data){
		MyLog(@"data = %@",data);

	};
	uy.failBlocker = ^(NSError * error) //上传失败
	{
		NSString *message = [error.userInfo objectForKey:@"message"];
		[MBProgressHUD showError:message];
		//error = %@",error);
	};
	uy.progressBlocker = ^(CGFloat percent, long long requestDidSendBytes) //上传进度
	{
		
	};
	[uy uploadFile:image saveKey:imageKey];
}
- (void)httpFindPhone
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSString *token = [ud objectForKey:USER_TOKEN];

	if (token == nil) {
		return;
	}
	
	NSString *urlStr = [NSString stringWithFormat:@"%@user/queryPhone?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
	NSString *URL = [MyMD5 authkey:urlStr];
//	//
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		//
		responseObject = [NSDictionary changeType:responseObject];
		if (responseObject!=nil) {
			if ([responseObject[@"status"] intValue] == 1) {
				if ([responseObject[@"bool"] boolValue]== YES) { // 绑定过手机
					self.isBindPhone = YES;
					
				} else { //没有绑定过手机
					self.isBindPhone = NO;
				}
			} else {
				[MBProgressHUD showError:responseObject[@"message"]];
			}
		}
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
		
		NavgationbarView *mentionview=[[NavgationbarView alloc]init];
		[mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
	}];
}



//    /*
//     查看cookie
//     */
//
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        //cookie == %@", cookie);
//    }
//
//    /*
//     清除cookie
//     */
//
//    NSHTTPCookieStorage *cookieJar2 = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar2 cookies]];
//    for (id obj in _tmpArray) {
//        [cookieJar deleteCookie:obj];
//    }
//
//    /*
//     设置指定的cookie
//     */
//
//    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//    [cookieProperties setObject:@"username" forKey:NSHTTPCookieName];
//    [cookieProperties setObject:@"rainbird" forKey:NSHTTPCookieValue];
//    [cookieProperties setObject:@"cnrainbird.com" forKey:NSHTTPCookieDomain];
//    [cookieProperties setObject:@"cnrainbird.com" forKey:NSHTTPCookieOriginURL];
//    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
//    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
//
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];


/**
 
 NSMutableURLRequest(可以用于webview)
 
 NSDictionary *properties = [[[NSMutableDictionary alloc] init] autorelease];
 [properties setValue:userId forKey:NSHTTPCookieValue];
 [properties setValue:@"BENQGURU.GAIA.USERID" forKey:NSHTTPCookieName];
 [properties setValue:@"" forKey:NSHTTPCookieDomain];
 [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
 [properties setValue:@"/" forKey:NSHTTPCookiePath];
 NSHTTPCookie *cookie = [[[NSHTTPCookie alloc] initWithProperties:properties] autorelease];
 NSDictionary *properties1 = [[[NSMutableDictionary alloc] init] autorelease];
 [properties1 setValue:[LoginViewController getLanguageType:loginInfo.lang] forKey:NSHTTPCookieValue];
 [properties1 setValue:@"BENGGURU.GAIA.CULTURE_CODE" forKey:NSHTTPCookieName];
 [properties1 setValue:@"" forKey:NSHTTPCookieDomain];
 [properties1 setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
 [properties1 setValue:@"/" forKey:NSHTTPCookiePath];
 NSHTTPCookie *cookie1 = [[[NSHTTPCookie alloc] initWithProperties:properties1] autorelease];
 NSArray *cookies=[NSArray arrayWithObjects:cookie,cookie1,nil];
 NSDictionary *headers=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
 NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[object valueForKey:@"url"]]];
 [request setValue:[headers objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
 [webView loadRequest:request];
 
 */

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	
	if ([_webView window] == nil) {
		[_webView removeFromSuperview];
		_webView = nil;
	}
	
	if ([self.view window] == nil) {
		self.view = nil;
	}
	
}



@end
