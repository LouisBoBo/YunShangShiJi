//
//  QualificationsModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface QualificationsModel : BaseModel
@property (nonatomic, assign) NSInteger status;          //状态
@property (nonatomic, assign) NSInteger send_allow;      //发布资格0没有 1有
@property (nonatomic, copy) NSString *message;           //提示

+(void)getQualificationsSuccess:(void(^)(id data))success;
@end
