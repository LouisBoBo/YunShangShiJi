//
//  TFStatisticsClickVM.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/8/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "PublicViewModel.h"



@interface TFStatisticsClickVM : PublicViewModel

// 处理网络获取的数据
+ (void)handleDataWithPageType:(NSString *)pageType withClickType:(NSString *)clickType success:(void (^)(id data, Response *response))success failure:(void(^)(NSError *error))failure;

+ (void)StatisticshandleDataWithClickType:(NSString *)clickType success:(void (^)(id data, Response *response))success failure:(void(^)(NSError *error))failure;
@end
