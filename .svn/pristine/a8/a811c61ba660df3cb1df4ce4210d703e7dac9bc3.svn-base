//
//  FinishTaskPopview.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/13.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,TaskPopType)
{
    Task_order_type  = 1,      //订单成功
    Task_liulanFinish = 2,     //浏览完成
    Task_liulan_type = 3,      //浏览美衣
    Task_dapeiFinish_type = 4, //完成搭配浏览
    Task_duobao_type = 5,      //成功参与夺宝
    Task_shreSucess_type = 6,  //分享成功
    Task_goldcupons_type = 7,  //积分升级金币
    Task_addCart_type = 8,     //加购物车
    Task_addCartSuccess = 9,   //加购物车成功
    Task_supprise_type = 10,   //惊喜任务
    Task_goldticket_type = 11, //优惠劵升级金券
    Task_double_type = 12,     //余额翻倍
    Task_addingCart_type = 13, //正在加入购物车
    Task_shareShop_type = 14,  //正在分享商品
    Task_liulan_gouwushop = 15,//浏览购物页面
    Task_Manufacturer_type =16,//制造商
    Task_submitHobby = 17,     //提交喜好
    Task_setHobbySuccess = 18, //设置喜好成功
    Task_dapei_type = 19,      //浏览搭配
    Task_buyFinish_type = 20,  //购买完成
    Task_goumai_type = 21,     //购买任务
    Task_jizan_type = 22,      //分享集赞
    Task_jizanFinish_type =23, //点赞完成
    Task_jizanOver_type =24,   //免费点赞用完
    Task_jizanSuccess_type= 25,//点赞成功
    Task_yiduNoenough_type= 26,//衣豆不足
    Task_InvitationSuccess= 27,//邀请成功
    Task_liulan_tixian = 28,   //浏览赢提现
    Task_duobao_kaijiang =29,  //夺宝开奖
    Task_duobao_zongjiang=30,  //夺宝中奖
    Task_count_mention = 31,   //更新任务数提示
    Task_noFinish_mention = 32,//任务未完成提示
    Task_tixian_finish = 33,   //提现任务完成提示
    Task_Finish_mention = 34,  //所有任务完成提示
    Task_Recommend_finish = 35,//推荐任务完成
    Task_liulanChuanDaFinish = 36,//浏览穿搭完成
    Task_H5money_Remind = 37,   //h5任务获得的金额
    Task_DoubleActiveRule = 38, //余额翻倍活动规则
    Task_ThousandYunRed = 39,   //千元红包雨
    Task_newShareTixian = 40,   //新分享赢提现
    Balance_notEnough = 41,     //提现额度不足
    OrderDetail_paySuccess = 42,//普通下单支付成功
    RedHongBao_tixian = 43,     //红包入账去提现
    OrderFreeling_paySuccess = 44,//首单免费领下单成功
    vipCard_discription = 45,   //会员说明
};

@interface FinishTaskPopview : UIView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UIView *SharePopview;
@property (nonatomic , strong) UIView *ShareInvitationCodeView;
@property (nonatomic , strong) UIImageView *SharetitleImg;
@property (nonatomic , strong) UIImageView *SignImageview;
@property (nonatomic , strong) UIButton * canclebtn;
@property (nonatomic , strong) UIView * backview;

@property (nonatomic , strong) UILabel *headlabel;
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UILabel *discriptionlab;
@property (nonatomic , strong) UILabel *bwlklab;
@property (nonatomic , strong) UILabel *timelable;
@property (nonatomic , strong) UILabel *minutelab;
@property (nonatomic , strong) UILabel *secondlab;
@property (nonatomic , assign) NSInteger minute;
@property (nonatomic , assign) NSInteger second;
@property (nonatomic , strong) NSTimer *timer;

@property (nonatomic , copy) NSString *TaskValue;
@property (nonatomic , copy) NSString *Tasktitle;
@property (nonatomic , copy) NSString *Rewardvalue;
@property (nonatomic , copy) NSString *Rewardtype;
@property (nonatomic , assign) NSInteger number;
@property (nonatomic , assign) TaskPopType taskpoptype;

@property (nonatomic , strong) UITableView *mytableview;
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) dispatch_block_t tapHideMindBlock; //关闭按钮
@property (nonatomic , copy) void(^leftHideMindBlock)(NSString*);   //左按钮
@property (nonatomic , copy) void(^rightHideMindBlock)(NSString*);  //右按钮
@property (nonatomic , copy) void(^balanceHideMindBlock)(NSInteger);

- (instancetype)initWithFrame:(CGRect)frame TaskType:(TaskPopType)tasktype TaskValue:(NSString*)taskvalue Title:(NSString*)title RewardValue:(NSString*)rewardValue RewardNumber:(int)num Rewardtype:(NSString*)rewardtype;
//弹框消失
- (void)remindViewHiden;

@end
