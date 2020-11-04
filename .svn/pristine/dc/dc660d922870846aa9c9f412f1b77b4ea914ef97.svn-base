//
//  YFUserModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/5/31.
//  Copyright © 2016年 ios-1. All rights reserved.
//  查询用户信息

#import "BaseModel.h"
#import "YFUserInfoModel.h"

@interface YFUserModel : BaseModel

@property (nonatomic, assign) NSInteger status; // 状态
@property (nonatomic, copy) NSString *message;  // 结果信息
@property (nonatomic, strong) YFUserInfoModel *userinfo; //用户信息

+ (void)getUserInfoWithUserId:(NSString *)userId success:(void (^)(id data))success;

@end
