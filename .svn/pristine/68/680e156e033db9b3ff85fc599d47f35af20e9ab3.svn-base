//
//  DoubleModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/6/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface DoubleModel : BaseModel

@property (nonatomic, assign) NSInteger status;//状态
@property (nonatomic, copy) NSString *message;//提示
@property (nonatomic, assign) long long now;//系统当前时间
@property (nonatomic, assign) NSInteger vt;//小时为单位,仅通过提现时的那个弹框使用.其余地方不做修改

/// 开启余额翻倍  entrance:1签到任务 2签到有礼 3我的钱包 4提现
+ (void)getDoubleEntrance:(int)entrance Sucess:(void(^)(id data))success;

@end
