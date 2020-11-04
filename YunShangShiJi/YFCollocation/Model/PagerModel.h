//
//  PagerModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/21.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface PagerModel : BaseModel

@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, assign) NSUInteger curPage;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) NSUInteger rowCount;

@end
