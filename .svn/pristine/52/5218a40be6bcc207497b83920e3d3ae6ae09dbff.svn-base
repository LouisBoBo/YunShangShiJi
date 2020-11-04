//
//  TreasureRecordsModel.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//
/**
 "id": id
 "r_code": 编号,
 "shop_code": 商品编号,
 "issue_code": 期号,
 "shop_name": 商品名称,

 btime:开始时间

 "etime": 开奖时间,
 "status": 当前状态 0正常参与 1等待开奖 2已经开奖,
 "in_code": 中奖幸运号,
 "in_sum": 参与次数,
 "in_rollUserName": 中奖昵称,
 "in_rollHead": 中奖头像,
 "in_userId": 中奖用户id,
 "shop_pic": 商品图片
 ***/
#import <Foundation/Foundation.h>

@class TreasureRecordsUser;
@interface TreasureRecordsModel : NSObject

@property (copy, nonatomic) NSString *shop_code;
@property (strong, nonatomic) NSNumber *status; // 0nor 2inv 3open
@property (strong, nonatomic) NSNumber *etime; // start
@property (strong, nonatomic) NSNumber *btime; // end
@property (strong, nonatomic) NSNumber *virtual_num; // 虚拟参加人数
@property (copy, nonatomic) NSString *shop_pic;
@property (copy, nonatomic) NSString *issue_code; //
@property (copy, nonatomic) NSString *shop_name; //
@property (strong, nonatomic) NSNumber *num;     //
@property (copy, nonatomic) NSString *otime; // openT

@property (strong, nonatomic) NSNumber *in_uid;
@property (copy, nonatomic) NSString *in_code; 
@property (copy, nonatomic) NSString *in_name;
@property (copy, nonatomic) NSString *in_head;

@property (strong, nonatomic)NSArray *user;
@property (strong, nonatomic)NSMutableArray *USER;
@property (assign, nonatomic)BOOL OneIndiana; //是否是一元夺宝

@property (nonatomic, strong) NSString *r_code;
@property (nonatomic, strong) NSNumber *in_sum;
@property (nonatomic, strong) NSString *in_rollUserName;
@property (nonatomic, strong) NSString *in_rollHead;
@property (nonatomic, strong) NSNumber *in_userId;
@property (nonatomic, strong) NSNumber *v_num;
@end

@interface TreasureRecordsUser : NSObject

@property (strong, nonatomic) NSNumber *uid;
@property (strong, nonatomic) NSNumber *num; // 次数
@property (strong, nonatomic) NSNumber *atime; // 参
@property (copy, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSNumber *money;
@property (copy, nonatomic) NSString *uhead;

@end
