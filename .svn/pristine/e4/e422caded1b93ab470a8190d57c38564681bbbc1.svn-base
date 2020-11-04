//
//  IndianaPublicModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/6/30.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface IndianaPublicModel : BaseModel
@property (nonatomic, assign) NSInteger status;  //状态
@property (nonatomic, copy) NSString *message;   //提示
@property (nonatomic, copy) NSString *data;

@property (nonatomic, copy) NSString *sc;        //分享了几次
@property (nonatomic, copy) NSString *oc;        //1分钱机会
@property (nonatomic, copy) NSString *scDay;     //当天分享了多少次

//保存分享的信息
+(void)saveShareStaue:(NSString*)shopcode success:(void(^)(id data))success;
//获取分享的状态
+(void)getShareStatuesuccess:(void(^)(id data))success;
//H5赚钱数
+(void)H5getMoney:(void(^)(id data))success;
@end
