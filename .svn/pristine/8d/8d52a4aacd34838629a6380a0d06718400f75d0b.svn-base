//
//  LuckModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface LuckModel : BaseModel
@property (nonatomic, assign) NSInteger status; //状态
@property (nonatomic, copy)   NSString *message;//提示
@property (nonatomic, assign) CGFloat raffle;   //抽中的金额
@property (nonatomic, assign) CGFloat data;     //抽中的金额
@property (nonatomic, strong) NSDictionary *order;//订单信息
@property (nonatomic, assign) int t;            //抽中的奖励类型 0额度 1现金
@property (nonatomic, assign) NSInteger OrNotPrize;//是否中奖 0中 1不中
@property (nonatomic, assign) NSInteger remainder; //抽奖次数
@property (nonatomic, assign) NSInteger firstGroup;
+(void)getLuckHttpRedMoney:(BOOL)redMoney Success:(void(^)(id data))success;
+(void)getLuckHttpRedCount:(void(^)(id data))success;

//初始化抽奖信息
+(void)getLuckHttpLotteryDraw:(NSString*)orderCode FirstGroup:(NSInteger)firstGroup Success:(void(^)(id data))success;
//是否有中奖资格
+(void)getLuckHttpOrNotPrize:(void(^)(id data))success;
//中奖结果
+(void)getLuckHttpLuckDraw:(BOOL)Prize orderCode:(NSString*)orderCode FirstGroup:(NSInteger)firstGroup Success:(void(^)(id data))success;
@end
