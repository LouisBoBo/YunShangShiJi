//
//  TreasureGroupsModel.h
//  YunShangShiJi
//
//  Created by YF on 2017/9/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "issue_code": 期号 (==0 时表示没满足人数)
 "tuserId": 团长id,
 "btime": 开团时间,
 "shop_code": 商品编号,
 "thead": 团长头像,
 "num": 当前参与人数,
 "nickname": 团长昵称,
 "user": [// 所有的团员都在这里面了
 {
 "head": 团员头像,
 "uid": 团员id,
 "btime": 团员参与时间,
 "nickname": 团员昵称"
 }]

 */
@interface TreasureGroupsModel : NSObject
@property (nonatomic, strong) NSString *issue_code;
@property (nonatomic, strong) NSString *u_code;    //幸运号码
@property (nonatomic, strong) NSNumber *tuserId;
@property (nonatomic, strong) NSNumber *btime;
@property (nonatomic, strong) NSString *shop_code;
@property (nonatomic, strong) NSString *thead;
@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSMutableArray *user;
@property (nonatomic, strong) NSNumber *uid;
@end
