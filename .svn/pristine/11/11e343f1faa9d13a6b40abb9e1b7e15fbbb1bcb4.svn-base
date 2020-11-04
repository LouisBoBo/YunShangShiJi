//
//  RCTokenModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/5/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@class RCModel;

@interface RCTokenModel : BaseModel

@property (nonatomic, assign) NSInteger status; // 状态
@property (nonatomic, copy) NSString *message;  // 结果信息
@property (nonatomic, strong) RCModel *data;    //

+ (void)getRCTokenModelSuccess:(void (^)(id data))success;

@end

@interface RCModel : BaseModel

@property (nonatomic, copy) NSString *userId;   // 用户ID
@property (nonatomic, copy) NSString *token;    // 融云Token

@end