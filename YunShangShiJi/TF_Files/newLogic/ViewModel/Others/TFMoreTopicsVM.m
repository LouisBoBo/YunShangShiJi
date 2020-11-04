//
//  TFMoreTopicsVM.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/12/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFMoreTopicsVM.h"

@implementation TFMoreTopicsVM

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[TFTopicsShop mappingWithKey:@"data"],@"data",[PagerModel mappingWithKey:@"pager"],@"pager" ,nil];
    return mapping;
}
- (void)getTopicsShopListWithCurPage:(NSInteger)curPage success:(void (^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"%@&token=%@&version=%@&curPage=%ld&pageSize=%@", @"collocationShop/moreProject?", token, VERSION, (long)curPage, @"5"];
    
    [TFMoreTopicsVM getDataResponsePath:path success:^(id data) {
        TFMoreTopicsVM *model = data;
        MyLog(@"data: %@, list: %@", [data class], model.data);
        if (curPage == 1) {
            [self.tableViewService.dataSource removeAllObjects];
        }
        if (model.status == 1) {
            
            [self.tableViewService.dataSource addObjectsFromArray:model.data];
        }
        if (success) {
            success(data);
        }
    }];
}

- (TFTableViewService *)tableViewService
{
    if (!_tableViewService) {
        _tableViewService = [[TFTableViewService alloc] init];
    }
    return _tableViewService;
}
@end

@implementation TFTopicsShop

- (NSString *)shop_url
{
    return @"https://yssj-real-test.b0.upaiyun.com/collocationShop/2016-11-18/gejhh4Cr.jpg!382";
}

@end
