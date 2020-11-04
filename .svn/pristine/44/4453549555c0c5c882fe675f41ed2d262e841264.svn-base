//
//  ManPicModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/7/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface ManPicDataModel : BaseModel

@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, copy) NSString *head_pic;

@end

@interface ManPicModel : BaseModel

@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, copy) NSString *message;       //结果信息
@property (nonatomic, strong) ManPicDataModel *data;

+ (void)getManPicModelWithShopCodes:(NSString *)shopCodes issueCode:(NSString *)issueCode success:(void (^)(id data))success;

@end
