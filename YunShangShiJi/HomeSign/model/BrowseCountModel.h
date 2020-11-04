//
//  BrowseCountModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/9/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface BrowseCountModel : BaseModel
@property (nonatomic, assign) NSInteger status;//状态
@property (nonatomic, copy) NSString *message;//提示
@property (nonatomic, assign) NSInteger bro_count;//浏览数
@property (nonatomic, assign) NSInteger fans_count; //粉丝数

+ (void)getBrowseSuccess:(void(^)(id data))success;
@end
