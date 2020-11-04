//
//  CollocationMainModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/21.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "CollocationModel.h"
#import "PagerModel.h"

@interface CollocationMainModel : BaseModel

@property (nonatomic, assign) NSInteger status;             //结果
@property (nonatomic, copy) NSString *message;              //结果信息
@property (nonatomic, strong) NSArray *listShop;            //内容（CollocationModel）
@property (nonatomic, strong) PagerModel *pager;            //页码

+ (void)getCollocationMainModelWithPageSize:(NSInteger)pageSize curPager:(NSInteger)curPager success:(void (^)(id data))success;
+ (void)getCollocationMainModelWithType:(NSNumber *)type PageSize:(NSInteger)pageSize curPager:(NSInteger)curPager success:(void (^)(id))success;
+ (void)getLedBrowseCollocationMainModelWithPageSize:(NSInteger)pageSize curPager:(NSInteger)curPager success:(void (^)(id data))success;
@end
