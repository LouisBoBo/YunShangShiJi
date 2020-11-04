//
//  ShopDislikeModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface ShopDislikeModel : BaseModel
@property (nonatomic, assign) NSInteger status;          //状态
@property (nonatomic, copy) NSString *message;           //提示

+(void)getShopDisLike:(NSString*)shopcodes Success:(void(^)(id data))success;
+(void)apptimeStartistice:(int)timeInterval Success:(void(^)(id data))success;
@end
