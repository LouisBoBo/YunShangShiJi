//
//  TaskModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject<NSCoding>
//****************task_type************
//0:开店
//1：邀请好友
//2：夺宝
//3：加X购物车
//4：浏览商品(原强制浏览)
//5：浏览集合
//6：购买X商品
//7：分享商品
//701：分享商品（余额翻倍）
//702：分享商品（积分升级）
//703：分享商品（优惠券升级）
//8：分享搭配购
//801：分享搭配购（余额翻倍）
//802：分享搭配购（积分升级）
//803：分享搭配购（优惠券升级）
//*************************************

@property (nonatomic , strong)NSString *index;
@property (nonatomic , strong)NSString *num;
@property (nonatomic , strong)NSString *t_id;          //任务ID
@property (nonatomic , strong)NSString *task_class;    //1必做任务，2额外任务，3惊喜任务 4惊喜提现任务
@property (nonatomic , strong)NSString *icon;          //完成任务图片ID
@property (nonatomic , strong)NSString *shopImage;     //完成任务图片
@property (nonatomic , strong)NSString *task_type;     //任务类型
@property (nonatomic , strong)NSString *t_name;        //任务名称
@property (nonatomic , strong)NSString *imagestr;      //任务图像
@property (nonatomic , strong)NSString *value;
@property (nonatomic , strong)NSString *name;
@property (nonatomic , strong)NSString *status;
@property (nonatomic , strong)NSString *app_name;
@property (nonatomic , strong)NSString *raward_false;  //假的奖励
@property (nonatomic , assign)BOOL isfinish;           //任务是否完成
/*
 仅app完成H5不展示 1
 H5可展示 app完成  2
 不限制           3
 app可展示 H5完成  4
 仅H5完成app不展示 5
 
 H5  判断    >1可展示    >2可完成
 app判断    <5 可展示   <4可完成
*/
@property (nonatomic , strong)NSString *task_h5;
@end
