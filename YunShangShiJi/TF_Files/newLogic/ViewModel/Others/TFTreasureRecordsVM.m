//
//  TFTreasureRecordsVM.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/19.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFTreasureRecordsVM.h"

@implementation TFTreasureRecordsVM

+ (void)handleDataWithTreasureRecordsPageNum:(NSInteger)pageNum success:(void (^)(NSArray *modelArray,Response *response))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *parameter= @{@"page": [NSNumber numberWithInteger:pageNum],
                               @"sort": @"btime",
                               @"order": @"desc"};
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_treasures_getMyParticipationList parameter:parameter caches:YES cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        
//        MyLog(@"TFTreasureRecordsVM data: %@", data);
        
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *subDic in (NSArray *)[data valueForKey:@"data"]) {
            TFTreasureRecordsM *model=[TFTreasureRecordsM yy_modelWithJSON:subDic];
            [tmpArr addObject:model];
        }
        success(tmpArr, response);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
