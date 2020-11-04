//
//  TFJSObjCModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/10/17.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "TFHomeViewController.h"


@protocol JavaScriptObjectiveCDelegate <JSExport>

- (void)callObjectiveCWithDict:(NSDictionary *)params;
- (void)callObjectiveCWithIsFirst;
- (NSString *)callObjectiveCWithIsOpenShop;
- (void)callObjectiveCWithGuideComplete;
- (NSString *)callObjectiveCWithEverydayFirstGoShop;
- (NSString *)callObjectiveCWithReturnUserString;
- (NSString *)callObjectiveCWithReturnFileWithName:(NSString *)fileName;
- (void)callObjectiveCWithRefreshMyShop;
- (void)callObjectiveCWithH5ShareStore;
- (void)callObjectiveCWithH5ShareStoreLink;
- (void)callObjectiveCWithBackViewController;
- (void)callObjectiveCWithChangeShopName:(NSDictionary *)params;
- (void)callObjectiveCWithGoLogin;
- (void)callObjectiveCWithGoShopCart;
- (void)callObjectiveCWithGoPersonCenter;
- (void)callObjectiveCWithAlreadyRed:(NSDictionary *)params;
- (void)callObjectiveCWithH5EditStoreModel:(NSDictionary *)params;
//- (void)callObjectiveCWithH5EditStoreModel2:(NSDictionary *)params;


@end

@protocol TFJSObjCModelDelegate <NSObject>

@optional

- (void)callObjectiveCWithHomeWithUserInfo:(NSDictionary *)userInfo;
- (void)callObjectiveCWithMyShopWithUserInfo:(NSDictionary *)userInfo;
- (void)callObjectiveCWithH5ShareApp:(NSDictionary *)dict witnIndex:(int)index;
- (void)callObjectiveCWithH5ShareStoreLink:(NSDictionary *)dict witnIndex:(int)index;
- (void)callObjectiveCWithBackViewControllerWithIndex:(int)index;
- (void)callObjectiveCWithGoLogin;
- (void)callObjectiveCWithRefreshMyShop;
- (void)callObjectiveCWithAlreadyRed:(NSDictionary *)params;
- (void)callObjectiveCWithGuideComplete;

//编辑店铺模版
- (void)callObjectiveCWithH5EditStoreModelInfo:(NSDictionary *)params;
- (void)callObjectiveCWithGoShopCart;
- (void)callObjectiveCWithGoPersonCenter;
@end

@interface TFJSObjCModel : NSObject <JavaScriptObjectiveCDelegate>

@property (nonatomic, weak  ) JSContext             *jsContext;
@property (nonatomic, weak  ) UIWebView             *webView;
@property (nonatomic, weak  ) id <TFJSObjCModelDelegate> delegate;
@property (nonatomic, assign) int                   index;

@end
