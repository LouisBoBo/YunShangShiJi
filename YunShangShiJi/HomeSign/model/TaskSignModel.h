//
//  TaskSignModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/19.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface TaskSignModel : BaseModel
@property (nonatomic, assign) NSInteger status;//状态
@property (nonatomic, copy) NSString *message;//提示
@property (nonatomic, copy) NSString *link;   //分享链接
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, copy) NSString *money;  //奖金数
@property (nonatomic, copy) NSString *task_count;//任务个数

//完成签到任务
+(void)getTaskHttp:(NSString*)index_id Day:(NSString*)day Success:(void(^)(id data))success;
//为好友点赞
+(void)fabousHttpSuccess:(BOOL)isFirst :(void(^)(id data))success;
//重置免费点赞成功
+(void)popupHttpSuccess:(void(^)(id data))success;
//改变参团状态
+(void)fightStatusSuccess:(void(^)(id data))success;
//拼团初始数据
+(void)fightinitialSuccess:(NSString*)roll_code :(void(^)(id data))success;
//分享赢提现-夺宝的链接
+(void)IndiaHttpShopcode:(NSString*)shopcode :(void(^)(id data))success;
//分享赢提现拼团团号
+(void)IndiaHttpR_code:(void(^)(id data))success;
//明日任务预告
+(void)TomorrowTaskTrailer:(void(^)(id data))success;
//当前用户打卡数组
+(void)clockInHttp:(NSString*)curyearAndMonth :(void(^)(id data))success;
@end
