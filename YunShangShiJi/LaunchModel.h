//
//  LaunchModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/7/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//  启动图

#import "BaseModel.h"

@class LaunchImgModel;

@interface LaunchModel : BaseModel

@property (nonatomic, assign) NSInteger status;     //状态码：1请求成功
@property (nonatomic, copy) NSString *message;      //提示消息
@property (nonatomic, strong) LaunchImgModel *data; //启动图数据

/// 启动图接口请求
+ (void)getLaunchModelWithSuccess:(void (^)(LaunchModel *data))success;

@end


@interface LaunchImgModel : BaseModel

@property (nonatomic, copy) NSString *pic;  //图片路径
@property (nonatomic, copy) NSString *time; //时间

@end