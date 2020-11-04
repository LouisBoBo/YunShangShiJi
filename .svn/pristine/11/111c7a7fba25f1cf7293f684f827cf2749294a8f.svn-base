//
//  ShopLikeModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface ShopLikeModel : BaseModel
@property (nonatomic, assign) NSInteger status;          //状态
@property (nonatomic, copy) NSString *message;           //提示

+(void)getShopLike:(NSString*)shopcode Success:(void(^)(id data))success;
+(void)getShopDisLike:(NSString*)shopcode Success:(void(^)(id data))success;

@end
