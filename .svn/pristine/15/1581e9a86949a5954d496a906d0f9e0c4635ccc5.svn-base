//
//  DelRedDotModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/7/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger, DelRedDotType) {
    DelRedDotTypeCoupon, //卡券
    DelRedDotTypeWallet  //余额
};

@interface DelRedDotModel : BaseModel

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;

+ (void)getDelRegDotWithType:(DelRedDotType)type success:(void (^)(id data))success;

@end
