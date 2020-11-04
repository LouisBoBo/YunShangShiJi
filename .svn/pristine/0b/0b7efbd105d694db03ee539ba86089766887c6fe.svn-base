//
//  DataManager.h
//  YunShangShiJi
//
//  Created by zgl on 16/5/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//  全局数据管理（单例）

#import <Foundation/Foundation.h>
#import "RawardRedPopView.h"
/*
 907app赚钱页面——点击“分享邀请好友集赞”任务	com.tbs.api.action.RecordAction.add（/record/add） key=point ,type=907 ,tab_type=9
 908app集赞奖励页——点击“马上去集赞”按钮	com.tbs.api.action.RecordAction.add（/record/add） key=point ,type=908 ,tab_type=9
 909app集赞奖励页——点击马上去集赞按钮——点击“微信”图标 com.tbs.api.action.RecordAction.add（/record/add）	key=point ,type=909 ,tab_type=9
 910app集赞奖励页——点击马上去集赞按钮——点击“朋友圈”图标 com.tbs.api.action.RecordAction.add（/record/add）	key=point ,type=910 ,tab_type=9
 
 1001.任务点击次数；											com.tbs.api.action.RecordAction.add（/record/add）			key=duobao ,type=1001 ,tab_type=10
 1002.“立即参与”按钮点击次数；									com.tbs.api.action.RecordAction.add（/record/add）			key=duobao ,type=1002 ,tab_type=10
 1003.“2元参与”点击次数；										com.tbs.api.action.RecordAction.add（/record/add）			key=duobao ,type=1003 ,tab_type=10
 1004.“分享微信好友”按钮点击次数；							com.tbs.api.action.RecordAction.add（/record/add）			key=duobao ,type=1004 ,tab_type=10
 1005.“分享微信好友”按钮点击用户数；							com.tbs.api.action.RecordAction.add（/record/add）			key=duobao ,type=1005 ,tab_type=10
 1006.“1分钱参与”点击次数；										com.tbs.api.action.RecordAction.add（/record/add）			key=duobao ,type=1006 ,tab_type=10
 1007红包弹出次数												com.tbs.api.action.RecordAction.add（/record/add）			key=duobao ,type=1007 ,tab_type=10
 */

typedef NS_ENUM(NSInteger, StatisticalType) {
    StatisticalTypeWxfsUse = 1,         //分享到微信朋友圈人数
    StatisticalTypeQuse = 104,          //分享到qq空间人数
    StatisticalTypeWxfUse = 106,        //分享到微信好友人数
    StatisticalTypeSettlement = 200,    //购物车 结算次数
    StatisticalTypeForcibly = 400,       //强制浏览
    StatisticalTypeShareFriend = 907,
    StatisticalTypeToShare = 908,
    StatisticalTypeToShareWX = 909,
    StatisticalTypeToSharePYQ = 910,
    StatisticalTypeIndianaTask = 1001,
    StatisticalTypeIndianaMustParticipate = 1002,
    StatisticalTypeIndianaTwoParticipate = 1003,
    StatisticalTypeIndianaShareClick = 1004,
    StatisticalTypeIndianaShareUser = 1005,
    StatisticalTypeIndianaCentParticipate = 1006,
    StatisticalTypeRedpop = 1007,
    StatisticalTypeTixianClick = 1101,
    StatisticalTypeShareTixian = 1102,
};

typedef NS_ENUM(NSInteger, StatisticalTabType) {
    StatisticalTabTypeShop = 1,         //小店
    StatisticalTabTypeCommodity = 2,    //商品
    StatisticalTabTypeCar = 3,          //购物车
    StatisticalTabTypeCollocation = 4,  //搭配
    StatisticalTabTypeForcibly = 5,      //强制浏览
    StatisticalTabTypeLikeCollect = 9,
    StatisticalTabTypeIndiana = 10,
    StatistiaclTabTypeShareTixian = 11
};

@interface DataManager : NSObject

/************************融云*****************************/
@property (nonatomic, assign) BOOL isRongCloub;      // 是否用融云（YES融云，NO环信）
@property (nonatomic, assign) BOOL isRongCloubLogin; // 融云是否登录
@property (nonatomic, copy) NSString *userId;        // 用户ID
@property (nonatomic, copy) NSString *rcToken;       // 融云token

/************************余额翻倍*****************************/
@property (nonatomic, assign) BOOL isOligible;       // 是否开店
@property (nonatomic, assign) BOOL isOpen;           // 是否开启
@property (nonatomic, assign) NSInteger twofoldness; // 倍数
@property (nonatomic, assign) long long endDate;     // 结束时间

/************************分享统计*****************************/
@property (nonatomic, assign) StatisticalTabType shareTabType;  //分享页面来源
@property (nonatomic, assign) StatisticalType shareType;        //分享去向
@property (nonatomic, copy) NSString *key;

/************************强制浏览*****************************/
@property (nonatomic, assign) BOOL isBrowse;         //是否强制浏览

/************************启动页*****************************/
@property (nonatomic, assign) BOOL isLaunch;         //是否有启动页

/************************精选推荐*****************************/
@property (nonatomic, assign) BOOL isRecommendTask;         //是否有精选推荐任务
@property (nonatomic, assign) BOOL isFinishRecommendTask;   //是否完成
@property (nonatomic, assign) BOOL isSubmitSuccess;         //是否发布成功
/************************用户等级*****************************/
@property (nonatomic, assign) NSInteger grade;         //用户等级   1==A类 2==B类…以此类推,目前只有两类
@property (nonatomic, assign) BOOL InvitationSuccess;  //邀请好友集赞成功
@property (nonatomic, assign) NSInteger sguidance;     //分类后获取的衣豆
@property (nonatomic, assign) NSInteger vipGrade;      //vip用户等级，用活力值判断

/************************1元购*****************************/
@property (nonatomic, assign) BOOL is_OneYuan;         //是否1元购
@property (nonatomic, assign) CGFloat app_value;       //1元购的价格
@property (nonatomic, assign) CGFloat OneYuan_count;   //1元购返回的总数
@property (nonatomic, assign) CGFloat one_not_use_price;//1元购可用的余额
@property (nonatomic, assign) CGFloat app_every;        //抽奖多少元每次
@property (nonatomic, assign) NSInteger app_zero;       //0元购免费的次数
@property (nonatomic, strong) NSArray *orderShopAarray; //订单商品
@property (nonatomic, strong) NSString *type_data;      //商品类目
/**
 0否1是, 根据此字段判断微信提现时是否绑定身份证
 */
@property (nonatomic, assign) BOOL idcardFlag;
@property (nonatomic, assign) NSInteger auseTwofold;   //auseTwofold    a类用户的余额可以使用额度
@property (nonatomic, assign) NSInteger buseTwofold;   //buseTwofold    b类用户的余额可以使用的额度

//商品详情图片压缩比例
@property (nonatomic, assign) NSInteger img_rate;
//统计
@property (nonatomic, copy) NSString *outAppStatistics;

@property (nonatomic, copy) NSString *version;      //系统最新版本
@property (nonatomic, copy) NSString *appversion;   //应用版本
@property (nonatomic, assign) NSInteger vitality;   //活力值 当用户等级是a的时候才返回此值
/**< 是否普通A类 */
@property (nonatomic, assign, getter=isGeneralA) BOOL generalA;

/**
 打开App的时间
 */
@property (nonatomic, assign) NSTimeInterval beginYiFuApp;
/**
 首页停留的时间
 */
@property (nonatomic, assign) NSTimeInterval beginYiFuShouye;
/**
 左滑右滑停留的时间
 */
@property (nonatomic, assign) NSTimeInterval beginYiFuRecommend;
/**
 密友圈停留的时间
 */
@property (nonatomic, assign) NSTimeInterval beginYiFuMiyou;

+ (instancetype)sharedManager;
+ (instancetype)new __attribute__((unavailable("new 不可用,请调用sharedManager")));
- (instancetype)init __attribute__((unavailable("init 不可用,请调用sharedManager")));

/// 从后台获取融云token,并登录
- (void)updateRcToken;

//疯狂星期一
@property (nonatomic , assign) BOOL IS_Monday;          //是否是星期一
@property (nonatomic , assign) BOOL is_Monday;          //是否是星期一(启动接口)
@property (nonatomic , assign) BOOL Buy_Task;           //是否是购买任务
@property (nonatomic , assign) BOOL Finish_Buy_task;    //是否完成购买任务
@property (nonatomic , strong) NSString *mondayValue;   //疯狂星期一任务类型
@property (nonatomic , assign) BOOL is_RedMoney;        //是否有红包抽奖资格
@property (nonatomic , assign) BOOL is_MakeMoneyHiden;  //赚钱页是否隐藏
@property (nonatomic , assign) BOOL is_SuperZeroShop;   //超级0元购
@property (nonatomic , assign) BOOL is_balance_with;    //余额抽提现
@property (nonatomic , assign) BOOL is_friendShare_day; //好友分享日
@property (nonatomic , assign) BOOL is_rawardDouble;    //奖励翻倍
@property (nonatomic , assign) BOOL is_thousandYunRed;  //千元红包
- (void)taskListHttp:(NSInteger)Tasktype Success:(void(^)())redmoney_taskBlock;
/**
 获取用户是否有未付款的订单
 */
@property (nonatomic , assign) BOOL is_guideOrder;         //是否是引导支付
@property (nonatomic , assign) NSInteger guidetwofoldness; // 倍数
@property (nonatomic , assign) long long halve;            //倒计时弹框
@property (nonatomic , assign) BOOL is_guidePopviewShow;   //千元红包是否弹出
- (BOOL)getOrderHttp:(BOOL)ispop;
- (void)guidePopview;
- (void)paySuccessMentionView;
/**
 夺宝分享相关
 */
@property (nonatomic , assign) long long shareToNum;    // 分享满多少次给一次机会
@property (nonatomic , assign) long long shareToDayNum; // 当天分享次数上限
@property (nonatomic , copy) NSString *sharetitle;       // 分享标题
@property (nonatomic , copy) NSString *sharecontent;     // 内容分享
@property (nonatomic , copy) NSString *duobaoMessage;    // 夺宝信息
@property (nonatomic , copy) void(^duobaoSuccessBlock)(NSString*);
- (void)getduobaoStatueHttp;

/**
 拼团相关
 */
@property (nonatomic , strong) NSMutableArray *fightData;   //拼团的商品
@property (nonatomic , assign) NSInteger opengroup;         //1开团 2参团
@property (nonatomic , strong) NSString *fightStatus;       //参团的团号
//1开团成功 2开团中 3开团完成 4参团成功 5参团完成
@property (nonatomic , assign) NSInteger opengroutSuccess;

/**
 落地页 1首页 2赚钱任务页
 */
@property (nonatomic , assign) NSInteger shouYeGround;
@property (nonatomic , assign) BOOL Startpage;

/**
 获取图片验证码
 */
- (void)getPictureVerificationCode:(NSString*)phone Success:(void(^)(NSString*url))success Fail:(void(^)(NSString*message))fail;
- (void)getPictureCode:(NSString*)phone;
/**
 千元红包雨
 */
- (void)RawardRedPopView:(RawardRedType)type;
- (void)getyidouQualifications;
/**
 H5赚钱金额
 */
@property (nonatomic , assign) CGFloat h5money;
- (void)remindGetH5Money;
@end
