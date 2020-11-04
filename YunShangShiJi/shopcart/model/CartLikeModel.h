//
//  CartLikeModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "LikeModel.h"
@interface CartLikeModel : BaseModel
@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, copy) NSString *message;       //结果信息
@property (nonatomic, strong) NSArray *likeArray;    //喜欢数据
@property (nonatomic, strong) NSNumber *isVip;
@property (nonatomic, strong) NSNumber *maxType;
+ (void)getLikeDataSuccess:(NSInteger)page Success:(void(^)(id))success;
@end
