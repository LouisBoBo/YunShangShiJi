//
//  TFHomeViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

//#import "TFBaseViewController.h"

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "TFJSObjCModel.h"
#import "GlobalTool.h"

extern NSString *const isShowNoviceTaskView6;

@interface TFHomeViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, assign) BOOL      isFirst;
@property (nonatomic, copy  ) NSString  *type;
@property (nonatomic, assign) BOOL      isFormMyIntegral;
@property (nonatomic, copy  ) NSString  *fromType;


@end
