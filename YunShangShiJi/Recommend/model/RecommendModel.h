//
//  RecommendModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "RecommendLikeModel.h"
#import "ShopShareModel.h"
@interface RecommendModel : BaseModel
@property (nonatomic, assign) NSInteger status;          //状态
@property (nonatomic, copy) NSString *message;           //提示
@property (nonatomic, assign) NSInteger pageCount;       //分页
@property (nonatomic, strong) NSArray *likes;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) BOOL isphone;
+(void)getLikeData:(NSInteger)currentpage Success:(void(^)(id data))success;

+(void)getShareData:(void(^)(id data))success;

+(void)getPhoneData:(void(^)(id data))success;//是否绑定手机
@end
