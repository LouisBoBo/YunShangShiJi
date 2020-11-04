//
//  AddShopCarModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface AddShopCarModel : BaseModel

@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, copy) NSString *message;       //结果信息
@property (nonatomic, assign) NSInteger isCart;      //0成功
@property (nonatomic, assign) NSTimeInterval c_time; //过期时间
@property (nonatomic, assign) NSTimeInterval s_time; //当前时间

+ (void)getAddShopCarModelWithPairedCode:(NSString *)pairedCode
                                cartJson:(NSArray *)cartJson
                                 success:(void (^)(id data))success;

@end

    
