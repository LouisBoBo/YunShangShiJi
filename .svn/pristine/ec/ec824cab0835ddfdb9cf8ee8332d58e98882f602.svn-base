//
//  Signmanager.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/8/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskModel.h"
@interface Signmanager : NSObject

@property (nonatomic , assign)BOOL signChange;          //标记签到表有没有改变
@property (nonatomic , assign)NSInteger addShopCart;    //赚钱任务加购物车数量
@property (nonatomic , assign)NSInteger shareShopCart;  //赚钱任务分享商品数量
@property (nonatomic , assign)NSInteger liulanShopCount;//赚钱任务浏览商品数量
@property (nonatomic , assign)NSInteger rewardNumber;   //奖励分几次发
@property (nonatomic , copy)NSString *task_value;       //任务值
@property (nonatomic , copy)NSString *signIn_status;    //0完成签到任务 1未完成
@property (nonatomic , copy)NSString *reward_type;      //签到任务奖励类型
@property (nonatomic , copy)NSString *reward_value;     //签到任务奖励值
@property (nonatomic , copy)NSString *index_id;         //签到任务的下标
@property (nonatomic , copy)NSString *day;              //完成任务的天数
@property (nonatomic , copy)NSString *liulan_taskvalue; //浏览的任务值

/**************************邀请好友任务***************************/
@property (nonatomic , copy)NSString *share_indexid;    //邀请好友下标
@property (nonatomic , copy)NSString *share_day;        //邀请好友天数
@property (nonatomic , assign)BOOL share_isFinish;      //邀请好友是否完成过
@property (nonatomic , assign)NSInteger shop_index;     //签到跳转到购物页的下标

/**************************拼团任务***************************/
@property (nonatomic , copy)NSString *fight_indexid;    //邀请好友下标
@property (nonatomic , copy)NSString *fight_day;        //邀请好友天数
/**************************精选推荐任务***************************/
@property (nonatomic , copy)NSString *recommend_indexid;//精选推荐下标
@property (nonatomic , copy)NSString *recommend_day;    //精选推荐天数
@property (nonatomic , copy)NSString *rnum;             //成团人数
@property (nonatomic , copy)NSString *DPPAYPRICE;       //成团订单支付价格
@property (nonatomic , copy)NSString *validHour;        //团过期时间,小时单位
/**************************热门穿搭任务***************************/
@property (nonatomic , copy)NSString *topic_indexid;        //热门穿搭下标
@property (nonatomic , copy)NSString *topic_day;            //热门穿搭天数
@property (nonatomic , copy)NSString *topic_type;           //签到任务奖励类型
@property (nonatomic , copy)NSString *topic_value;          //签到任务奖励值
@property (nonatomic , assign)NSInteger topic_rewardNumber; //奖励分几次发
@property (nonatomic , assign)NSInteger topic_liulanNumber; //浏览几次
@property (nonatomic , assign)BOOL task_isfinish;           //有任务完成
@property (nonatomic , assign)BOOL task_Fightgroups;        //发起拼团成功

/**************************浏览分钟数任务***************************/
@property (nonatomic , copy) NSString *liulan_rewardvalue;    //当前浏览分钟数任务奖励
@property (nonatomic , copy) NSString *liulan_rewardtype;     //当前浏览分钟数任务类型
@property (nonatomic , assign) NSInteger liulan_rewardnumber;//当前浏览分钟数任务分几次奖励
@property (nonatomic , strong) TaskModel *liulanModel;        //当前浏览的分钟数任务
@property (nonatomic , assign)NSInteger now_minute;           //当前浏览的分钟
@property (nonatomic , assign)NSInteger now_second;           //当前浏览的秒数

/************************分享赢提现*****************************/
@property (nonatomic, assign) NSInteger shareTixianCount;  //当前分享了多少次
@property (nonatomic, assign) NSInteger takFinishCount;    //任务完成的次数
@property (nonatomic, assign) NSInteger AlreadyFinishCount;//已经完成的次数
@property (nonatomic, assign) NSInteger everyShareCount;   //每次任务分享商品的个数
@property (nonatomic, assign) NSInteger everyShareRaward;  //每次任务获得的奖励
@property (nonatomic, strong) NSString* indianaShareRaward;//一元夺宝的奖励
/************************浏览赢提现*****************************/
@property (nonatomic, assign) NSInteger liulanTixianCount; //当前浏览了多少次
@property (nonatomic, assign) NSInteger liulanFinishCount; //任务完成的次数
@property (nonatomic, assign) NSInteger liulanAlreadyCount;//已经完成的次数
@property (nonatomic, assign) NSInteger everyLinlanCount;  //每次任务浏览商品的个数
@property (nonatomic, assign) NSInteger everyLiulanRaward; //每次任务获得的奖励

@property (nonatomic , assign)NSInteger IndianaSurplusCount;//夺宝剩余可参与次数
@property (nonatomic , copy)NSString *suppstr;
@property (nonatomic , copy)NSString *content1;
@property (nonatomic , copy)NSString *content2;
@property (nonatomic , copy)NSString *signstring;

@property (nonatomic , copy)NSString *detailtypestr;
+(instancetype)SignManarer;
@end
