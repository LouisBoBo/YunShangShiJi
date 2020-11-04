//
//  TFTableViewBaseViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/2.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFBaseViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "MBProgressHUD+NJ.h"
 
#import "MJRefresh.h"

#import "TFBackgroundView.h"

@interface TFTableViewBaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

- (void)createBackgroundView:(UIView *)view andTag:(NSInteger)tag andFrame:(CGRect)frame withImgge:(UIImage *)img andText:(NSString *)text;
- (void)clearBackgroundView:(UIView *)view withTag:(NSInteger)tag;

- (void)viewWillAppear:(BOOL)animated;
-(void)viewWillDisappear:(BOOL)animated;

- (NSMutableArray *)dataArray;

- (void)setNavigationItemLeft:(NSString *)title;
- (void)setNavigationItemLeftAndRight:(NSString *)title;
- (BOOL)isString:(NSString *)Sstring toCompString:(NSString *)CompString;
- (BOOL)validateMobile:(NSString *)mobile;
- (BOOL)validatePassword:(NSString *)password;
- (NSDictionary *)TFNSDictionaryOfVariableBindings:(NSArray *)strArr;

- (void)createAnimation;
- (void)stopAnimation;
@end
