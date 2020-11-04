//
//  AppDelegate.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/9.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//
//wx4868b35061f87885
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ShopDetailViewController.h"
#import "AffirmOrderViewController.h"
#import "WXApi.h"
#import <sys/utsname.h>
//支付宝相关
#define PAY_PARTNER @"partner"
#define PAY_SELLER @"seller"
#define PAY_PRIVATE_KEY @"private_key"
#define PAY_URL @"pay_url"
#define PAY_ALI_PUBLIC_KEY @"ali_public_key"
#define PAY_SIGN_TYPE @"ali_public_key"
#define PAY_ALI_PRICE @"ali_pay_price"
#import "SqliteManager.h"
#import "ImageSizeManager.h"
#import "AFAppDotNetAPIClient.h"
#import "FunsaddModel.h"
typedef NS_ENUM(NSInteger,pushType)
{
    PushArriveType = 1,//到达
    PushOpenType = 2,//点击进入
    PushFirstOpenType =3//初次进入
};
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,UITabBarControllerDelegate,WXApiDelegate,sendMsgToWeChatViewDelegate,IChatManagerDelegate>

@property (nonatomic, assign) NetworkStates networkStatus;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIImageView *Myview;
@property (strong, nonatomic)AffirmOrderViewController *takeoutPay;
@property (assign, nonatomic)pushType pushtype;

//版本更新
@property (nonatomic, assign)BOOL isUpdata;
@property (nonatomic, assign)BOOL isQiangGeng;
@property (strong, nonatomic)NSString *versionmsg;
@property (nonatomic, assign)BOOL isComeing;
@property (nonatomic, copy)NSString *msg;
@property (nonatomic, copy)NSString *version_no;

//商品属性
@property (nonatomic , strong)NSString *shuxing_id;
@property (nonatomic , strong)NSString *attr_name;
@property (nonatomic , strong)NSString *attr_Parent_id;
@property (nonatomic , strong)NSString *is_show;

//商品分类
@property (nonatomic , strong)NSString *dir_level;//级别
@property (nonatomic , strong)NSString *type_id;
@property (nonatomic , strong)NSString *type_parent_id;
@property (nonatomic , strong)NSString *type_name;
@property (nonatomic , strong)NSString *type_ico;
@property (nonatomic , strong)NSString *type_is_show;
@property (nonatomic , strong)NSString *type_group_flag;
@property (nonatomic , strong)NSString *type_sequence;

//商品标签
@property (nonatomic , strong)NSString *tag_name;
@property (nonatomic , strong)NSString *tag_id;
@property (nonatomic , strong)NSString *tag_show;
@property (nonatomic , strong)NSString *tag_parent_id;
@property (nonatomic , strong)NSString *tag_ico;
@property (nonatomic , strong)NSString *tag_sequence;
@property (nonatomic , strong)NSString *tag_e_name;

//商家类目
@property (nonatomic , strong)NSString *bus_name;
@property (nonatomic , strong)NSString *bus_ico;
@property (nonatomic , strong)NSString *bus_is_show;
@property (nonatomic , strong)NSString *bus_id;
@property (nonatomic , strong)NSString *bus_sequence;
@property (nonatomic , strong)NSString *bus_parent_id;

//分类标签
@property (nonatomic , strong)NSString *type_tag_id;
@property (nonatomic , strong)NSString *type_tag_class_name;
@property (nonatomic , strong)NSString *type_tag_sort;
@property (nonatomic , strong)NSString *type_tag_pic;
@property (nonatomic , strong)NSString *type_tag_is_new;
@property (nonatomic , strong)NSString *type_tag_is_hot;
@property (nonatomic , strong)NSString *type_tag_type;
@property (nonatomic , strong)NSString *class_type;

@property (nonatomic , strong)NSString *Sqlitetype;

@property (nonatomic , assign)int funsIndex;

@property (nonatomic , strong)FunsaddModel *model;
@property (nonatomic , assign)BOOL isFuns;
@property (nonatomic , strong)NSTimer *mytimer;
@property (nonatomic , assign)int mentionCount;

- (void)shardk;
- (void)wxpay;
- (void)showMessage;
- (void)weixinArgumentHttp;
- (void)zhifubaoArgumentHttp:(NSString*)ordercode;
- (void)shareSuccess;
- (void)shareStatistics;
- (void)getUserLikeHttp;
- (void)goFuns;
- (void)removeNotification;
- (void)exitApplication;
//- (void)getVitalityGradeHttp;
#pragma mark 查找数据库
-(NSDictionary *)FindNameForTPYEDB:(NSString *)findStr;
@end

