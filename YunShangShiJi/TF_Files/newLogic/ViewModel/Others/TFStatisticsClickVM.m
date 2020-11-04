//
//  TFStatisticsClickVM.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/8/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFStatisticsClickVM.h"



@implementation TFStatisticsClickVM

+ (void)handleDataWithPageType:(NSString *)pageType withClickType:(NSString *)clickType success:(void (^)(id data, Response *response))success failure:(void(^)(NSError *error))failure
{
    
    NSString *type= @"1";
    
    type = [TFStatisticsClickVM indexOfContentText:[NSString stringWithFormat:@"统计数据规则-%@", pageType == nil?@"":pageType] Object:clickType];
    NSDictionary *parameter = @{@"type": type};
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_dataRecord_addDataRecord parameter:parameter caches:NO cachesTimeInterval:0*TFSecond token:NO success:^(id data, Response *response) {
//        MyLog(@"clickType: %@, type: %@, data: %@",clickType, type, data);
        if (success) {
            success(data, response);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)StatisticshandleDataWithClickType:(NSString *)clickType success:(void (^)(id data, Response *response))success failure:(void(^)(NSError *error))failure;
{
    NSString *type= @"1";
    
    type = [TFStatisticsClickVM indexOfContentText:[NSString stringWithFormat:@"统计数据规则-跳出APP统计"] Object:clickType];
    NSDictionary *parameter = @{@"type": type};
    [[APIClient sharedManager] StatisticsnetWorkGeneralRequestWithApi:newkApi_dataRecord_addDataRecord parameter:parameter caches:NO cachesTimeInterval:0*TFSecond token:NO success:^(id data, Response *response) {
        //        MyLog(@"clickType: %@, type: %@, data: %@",clickType, type, data);
        if (success) {
            success(data, response);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+ (NSString *)indexOfContentText:(NSString *)contentText Object:(NSString *)object
{

    __block NSString *tmpString = @"1";
    if (contentText == nil || object == nil) {
        return tmpString;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:contentText ofType:@"txt"];
    NSString *string=[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *stringsArray = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    [stringsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *subArr = [obj componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        MyLog(@"subArr: %@", subArr);
        if ([subArr[0] isEqualToString:object]) {
            tmpString = [NSString stringWithFormat:@"%@", subArr[subArr.count-1]];
            *stop = YES;
        }
    }];
    return tmpString;
}
@end
