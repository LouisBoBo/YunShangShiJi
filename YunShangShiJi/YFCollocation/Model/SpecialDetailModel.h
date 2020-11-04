//
//  SpecialDetailModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "SpecialShopModel.h"
#import "SpecialMainModel.h"
@interface SpecialDetailModel : BaseModel
@property (nonatomic , assign)NSInteger status;             //结果
@property (nonatomic , copy)  NSString *message;            //信息
@property (nonatomic , strong)NSDictionary *shop;           //数据

+(void)getSpecialDetailData:(NSString*)collocationCode Success:(void(^)(id data))success;
@end
