//
//  TFBaseViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "MBProgressHUD+NJ.h"
 
#import "MJRefresh.h"
#import "MBProgressHUD+XJ.h"
#import "TFBackgroundView.h"
#import "UIImageView+WebCache.h"
#import "NavgationbarView.h"
#import "UIScrollView+MyRefresh.h"

#import "Masonry.h"
#import "DXAlertView.h"
#import "UIView+Masonry_TF.h"

extern NSString *const Regular_phone;
extern NSString *const Regular_post;
extern NSString *const Regular_loginPwd;
extern NSString *const Regular_email;

@interface TFBaseViewController : UIViewController
@property (nonatomic, strong) NavgationbarView *showMessage;
@property (nonatomic, strong) UIImageView *navigationView;
@property (nonatomic, assign) BOOL        httpFailure;

- (void)viewWillAppear:(BOOL)animated;
-(void)viewWillDisappear:(BOOL)animated;


- (void)setNavigationItemLeft:(NSString *)title;
- (void)setNavigationItemLeftAndRight:(NSString *)title;


- (BOOL)isString:(NSString *)Sstring toCompString:(NSString *)CompString;
- (BOOL)validateMobile:(NSString *)mobile;
- (BOOL)validatePassword:(NSString *)password;
- (BOOL)validatePostCode:(NSString *)postCode;
- (BOOL)validateEmail:(NSString *)email;
- (NSDictionary *)TFNSDictionaryOfVariableBindings:(NSArray *)strArr;

- (void)createBackgroundView:(UIView *)view andTag:(NSInteger)tag andFrame:(CGRect)frame withImgge:(UIImage *)img andText:(NSString *)text;
- (void)clearBackgroundView:(UIView *)view withTag:(NSInteger)tag;

- (void)createAnimation;
- (void)stopAnimation;

- (NSString *)getCurrTimeString:(NSString *)type;

- (void)leftBarButtonClick;
- (void)rightBarButtonClick;

@end
