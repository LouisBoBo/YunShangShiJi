//
//  VitalityTaskPopview.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/11/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , VitalityType)
{
    Vitality_Zero = 0,                 //活力值为0
    Vitality_Twenty = 20,              //活力值为20
    Vitality_Onehundred = 100,         //活力值为100
    Fightgroups_from = 11,             //拼团发起成功
    Fightgroups_success = 22,          //拼团成功
    Raward_getyidou = 31,              //如何获取衣豆
    Raward_noenoughyidou = 32,         //衣豆不足
    Raward_fiveyidou = 33,             //使用10衣豆
    Raward_twentyyidou = 34,           //获取20衣豆
    Raward_twentyChance = 35,          //获取20次抽奖机会
    Raward_noenoughChance = 36,        //抽奖机会没有了
    Deleate_shoppingcart = 37,         //删除购物车商品
    Detail_Deductible = 38,            //余额抵扣
    Topic_delateTopic = 39,            //删除穿搭
    Raward_order_Tixian = 40,          //奖励提现额度
    Raward_paySuccess_yidou = 41,      //支付成功获取衣豆
    Detail_Prompt_raward = 42,         //商品详情奖金提示
    GuideOrder_paysuccess = 43,        //引导支付订单
    Order_red_fivieChance = 44,        //订单5次红包抽奖机会
    Order_red_fiveOver = 45,           //订单5次红包抽奖机会用完
    Raward_weixin_bingding = 46,       //微信绑定
    Raward_getyue = 47,                //如何获取余额
    Raward_howMuchChance = 48,         //多少次抽奖机会
    Super_zeroShopping = 49,           //超级0元购
    Task_zero_BuyFinish = 50,          //购买成功
    Super_redZeroShopping = 51,        //红色超级0元购
    Stop_business = 52,                //暂停运营
    Raward_oneLuckRule = 53,           //1元抽奖活动规则
    Raward_oneLuckMore = 54,           //1元抽奖再来一次
    Detail_OneYuanDeductible = 55,     //1元购余额抵扣
    Detail_comeBack = 56,              //从详情返回上个界面
    Raward_oneLuckPrize = 57,          //1元购中奖
    Fight_luckSuccess = 58,            //拼团成功
    Robot_Fight_luckSuccess = 59,      //机器人拼团成功
    Close_Fight_luckSuccess = 60,      //申请关闭拼团
    BecomeMember_task = 61,            //成为会员才能做任务
    Fight_luckFail = 62,               //拼团失败
    Raward_oneLuckNOPrize = 63,        //会员免费领未中奖
    CodeInvite_what = 64,              //什么是邀请码
    Share_Deductible = 65,             //分享说明
    Fight_rawardSuccess = 66,          //奖励金入账弹框
    Fight_rawardClear = 67,            //奖励金清空
};

@interface VitalityTaskPopview : UIView

@property (nonatomic , assign) VitalityType vitalityTasktype;

@property (nonatomic , strong) UIView *SharePopview;
@property (nonatomic , strong) UIView *ShareInvitationCodeView;
@property (nonatomic , strong) UIImageView *SharetitleImg;
@property (nonatomic , strong) UIImageView *SignImageview;
@property (nonatomic , strong) UIButton * canclebtn;
@property (nonatomic , strong) UIView * backview;

@property (nonatomic , strong) UILabel *headlabel;
@property (nonatomic , strong) UIImageView *titleimage;
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UILabel *discriptionlab;
@property (nonatomic , strong) UILabel *bwlklab;

@property (nonatomic , assign) NSInteger valityGrade;               //活力值等级
@property (nonatomic , assign) NSInteger getYidouCount;             //获取的衣豆
@property (nonatomic , assign) NSInteger oneLuckCount;              //1元购抽奖次数
@property (nonatomic , strong) NSArray *orderShopArray;             //订单商品
@property (nonatomic , strong) NSString *type_data;                 //商品类目
@property (nonatomic , strong) dispatch_block_t tapHideMindBlock;   //关闭按钮
@property (nonatomic , strong) dispatch_block_t closeMindBlock;     //关闭
@property (nonatomic , copy) void(^leftHideMindBlock)(NSString*);   //左按钮
@property (nonatomic , copy) void(^rightHideMindBlock)(NSString*);  //右按钮
@property (nonatomic , assign) CGFloat oneYuanDiKou;
- (instancetype)initWithFrame:(CGRect)frame VitalityType:(VitalityType)Vitalitytype valityGrade:(NSInteger)valityGrade YidouCount:(NSInteger)yidouCount;

//弹框消失
- (void)remindViewHiden;

@end
