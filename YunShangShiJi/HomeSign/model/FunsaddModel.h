//
//  FunsaddModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/9/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface FunsaddModel : BaseModel
@property (nonatomic, assign) NSInteger status;//状态
@property (nonatomic, copy) NSString *message;//提示
@property (nonatomic, strong) NSArray *barr_list;//粉丝列表

+ (void)getFunsHeadimageAndNickname:(void (^)(id data))success;
@end
