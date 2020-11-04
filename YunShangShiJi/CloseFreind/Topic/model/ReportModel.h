//
//  ReportModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface ReportModel : BaseModel

@property (nonatomic, assign) NSInteger status;          //状态
@property (nonatomic, copy) NSString *message;           //提示
@property (nonatomic ,strong)NSString *title;            //名称
@property (nonatomic ,strong)NSString *is_select;        //是否选中
//举报
+ (void)ReportData:(NSString*)content Theme_id:(NSString*)theme_id Success:(void(^)(id data))success;
@end
