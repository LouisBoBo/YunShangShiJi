//
//  MakeMoneyViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExtrabonusTopView.h"
#import "TFNoviceTaskView.h"
#import "TaskTimerManager.h"
typedef NS_ENUM(NSInteger , Mondytype)
{
    Mondytype_NO = 1,            //不是疯狂星期一
    Mondytype_YES = 2            //是疯狂星期一
};

typedef NS_ENUM(NSInteger,MAKEMONEY_TYPE) {
    MakeMoney_NormalType=0,
    MakeMoney_NTarbarType=1
};
@interface MakeMoneyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , assign) MAKEMONEY_TYPE MakeMoney_Type;

@property (nonatomic , strong) UITableView *MytableView;          //任务列表
@property (nonatomic , strong) UITableView *DiscriptableView;     //任务说明列表
@property (nonatomic , strong) NSMutableArray *discreptionList;   //任务列表数据
@property (nonatomic , strong) NSMutableArray *dayMustTaskList;   //每日必做任务数据
@property (nonatomic , strong) NSMutableArray *dayMustFinsishList;//每日必做完成的任务
@property (nonatomic , strong) NSMutableArray *dayExtraTasklist;  //每日额外任务数据
@property (nonatomic , strong) NSMutableArray *dayExtraFinishlist;//每日额外完成的任务
@property (nonatomic , strong) NSMutableArray *surpriseTaskList;  //每月惊喜任务数据
@property (nonatomic , strong) NSMutableArray *surFinishTaskList; //完成惊喜任务
@property (nonatomic , strong) NSMutableArray *FabulousTaskList;  //每日点赞任务
@property (nonatomic , strong) NSMutableArray *FabulousFinishlist;//每日点赞完成的任务
@property (nonatomic , strong) NSMutableArray *surTixianTaskList; //惊喜提现任务
@property (nonatomic , strong) NSMutableArray *surTixianFinishlist;//惊喜提现完成的任务
@property (nonatomic , strong) NSMutableArray *tomorrowTaskList;  //明日任务
@property (nonatomic , strong) NSMutableArray *alldayTaskList;    //今天所有任务
@property (nonatomic , strong) NSMutableArray *noFinishTasklist;  //今天未完成的任务
@property (nonatomic , strong) NSMutableArray *shopGroupList;     //完成任务的图标列表
@property (nonatomic , strong) NSMutableArray *selectTaskList;    //点击的任务
@property (nonatomic , strong) NSArray *shopData;                 //分享搭配详情数据

@property (nonatomic , strong) ExtrabonusTopView *ExtratopView;   //头部顶置条

@property (nonatomic , strong) UIView *SharePopview;              //分享弹框
@property (nonatomic , strong) UIView *ShareInvitationCodeView;   //分享弹框上的内容
@property (nonatomic , strong) UIButton *Sharecanclebtn;          //分享弹框关闭按钮
@property (nonatomic , strong) UIView *SharebackView;
@property (nonatomic , strong) NSTimer *Taskmytimer;              //倒计时
@property (nonatomic , assign) NSInteger mentionCount;            //记数

@property (nonatomic , assign) BOOL isWeixin_share;               //是否是微信分享
@property (nonatomic , strong) NSString *tasktype;                //分享的类型
@property (nonatomic , assign) int taskValue;                     //1图片 2链接
@property (nonatomic , strong) NSString *changeTable;
@property (nonatomic , strong) UIImage *shareImage;               //分享的图片
@property (nonatomic , strong) NSString *shareImageStr;//图片链接
@property (nonatomic , strong) UIImage *shareRandShopImage;       //分享的原始图片

@property (nonatomic, assign) NSString *bonusMoney;               //额外奖励的钱
//任务说明弹框
@property (nonatomic , strong) UIView *Popview;
@property (nonatomic , strong) UIView *InvitationCodeView;
@property (nonatomic , strong) UIView *backview;
@property (nonatomic , strong) UIButton *canclebtn;

//当前任务
@property (nonatomic , copy) NSString *index_id;                  //完成任务的下标
@property (nonatomic , copy) NSString *day;                       //完成任务天数
@property (nonatomic , copy) NSString *reward_type;               //奖励类型
@property (nonatomic , copy) NSString *reward_value;              //奖励值
@property (nonatomic , assign) NSInteger rewardNumber;            //分几次奖励
@property (nonatomic , copy) NSString *task_value;                //任务值

@property (nonatomic , assign) NSInteger second;                  //浏览分钟
@property (nonatomic , assign) NSInteger minute;                  //浏览秒数


//vip活力值
@property (nonatomic , assign) NSInteger valityGrade;             //活力值等级
@property (nonatomic , strong ) TFNoviceTaskView *noviceTaskView;
@property (nonatomic , strong) NSString *fromType;
@property (nonatomic , assign) NSInteger lastGrade;               //新用户等级

@property (nonatomic , strong) UILabel *todayEarnMoney;           //今日赚钱
@property (nonatomic , strong) UILabel *totalMoney;               //总余额
@property (nonatomic , strong) UILabel *tixianMoney;              //可提现金额
@property (nonatomic , strong) UILabel *tixianUnderway;
@property (nonatomic , strong) NSString*toatlbCount;              //余额
@property (nonatomic , assign) NSInteger yidouCount;              //衣豆数量
@property (nonatomic , strong) UILabel *todayReturnMoneyLab;
@property (nonatomic , strong) UILabel *cumReturnMoneyLab;
@property (nonatomic , strong) UILabel *cumWitMoneyLab;
//疯狂星期一
@property (nonatomic , assign) BOOL isMonday;                     //是否是星期一
@property (nonatomic , assign) BOOL isPingtuan;                   //是否是拼团购
@property (nonatomic , assign) BOOL isMonthSurprise;              //是否每月惊喜
@property (nonatomic , assign) Mondytype mondytype;               //是否是疯狂星期一
@property (nonatomic , assign) NSInteger LotteryNumber;           //抽奖次数
/*
 *point_status:NumberInt(0), //点赞状态 0默认，1第一次点赞，2多次点赞
 isGratis://免费状态 true免费，false收费
 popup //弹窗状态 0不弹窗，1弹窗
 */
@property (nonatomic , assign) BOOL popup;                       //弹框状态
@property (nonatomic , assign) BOOL isGratis;                    //免费点赞
@property (nonatomic , assign) NSInteger point_status;           //点赞状态
@property (nonatomic , copy) NSString *point_count;              //点赞数
@property (nonatomic , copy) NSString *total_rewards;            //奖励数
@property (strong , nonatomic)NSString *fxqd;                    //邀请好友获得奖励
@property (nonatomic , assign)NSInteger today_ref;               //千元红包雨任务0否，1是
@property (nonatomic , assign)NSInteger newbie;                  //0新手 1不是新手
//拼团相关
/**fighStatus
 -1、多次引导参团完成
 0、没有被引导新用户，---不能参团 默认值
 1、正常引导
 2、已参团新用户被引导	 ---不能参团	提示只能参与一次
 3、老用户（活动时间前注册）	---不能参团  提示 老用户不能参与、
 必备条件团号（len>=8）、新用户被引导未参团（可以参团时为团号）
 注：2、3重置之后变为0  ---无提示
 */
@property (nonatomic , assign) NSInteger roll;                //0已无资格，1有资格
@property (nonatomic , strong) NSString *fighStatus;
@property (nonatomic , copy)   NSString *orderStatus;         //0拼团未完成 1拼团完成
@property (nonatomic , copy)   NSString *offered;             //0参团未完成 1参团完成 2可参与
@property (nonatomic , assign) NSInteger orderCount;          //开团次数 0 1 2

@property (nonatomic , copy) NSString *shareType;             //分享类型

@property (nonatomic , strong) UIView *zeroshopview;

@property (nonatomic , assign) NSInteger musttaskCount;
@property (nonatomic , assign) NSInteger extrataskCount;
@property (nonatomic , assign) NSInteger tixiantaskCount;

@property (nonatomic , assign) NSInteger musttaskFtinishCount;
@property (nonatomic , assign) NSInteger extrataskFtinishCount;
@property (nonatomic , assign) NSInteger tixiantaskFtinishCount;

//一键做下个任务
@property (nonatomic , assign) BOOL backtoSelf;               //任务完成回到赚钱页

@property (nonatomic , copy) NSString *comeFrom;            //从哪个界面来到赚钱任务页
@end
