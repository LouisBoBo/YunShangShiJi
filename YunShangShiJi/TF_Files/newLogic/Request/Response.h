//
//  Response.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@class Pager;
@interface Response : NSObject

@property (nonatomic, assign) NSInteger status;//请求结果返回
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) BOOL isCaches;
@property (nonatomic, strong) Pager *pager;
@property (nonatomic, copy) NSString *theme_id;
@end


@interface Pager : NSObject

@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger rowCount;
@end
