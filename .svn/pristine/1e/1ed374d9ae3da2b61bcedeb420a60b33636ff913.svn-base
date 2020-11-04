//
//  VitalityModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/11/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface VitalityModel : BaseModel
@property (nonatomic, assign) NSInteger status;//状态
@property (nonatomic, copy) NSString *message; //提示
@property (nonatomic, copy) NSString *data;   //活力值

+(void)getVitality:(void(^)(id data))success;

+(void)posguide:(void(^)(id data))success;
@end
