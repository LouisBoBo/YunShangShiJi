//
//  TFMoreTopicsVM.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/12/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "PagerModel.h"

@interface TFMoreTopicsVM : BaseModel
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) PagerModel *pager;            //页码
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;       //结果信息


@property (nonatomic, strong) TFTableViewService *tableViewService;

- (void)getTopicsShopListWithCurPage:(NSInteger)curPage success:(void (^)(id data))success;

@end

@interface TFTopicsShop : BaseModel
@property (nonatomic, copy) NSString *collocation_code;
@property (nonatomic, copy) NSString *collocation_pic;
@property (nonatomic, copy) NSString *collocation_name;
@property (nonatomic, copy) NSString *collocation_name2;
@end
