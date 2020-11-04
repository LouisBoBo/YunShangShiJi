//
//  TFGroupBuyVM.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFGroupBuyVM.h"

@implementation TFGroupBuyVM

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[TFGroupBuyShop mappingWithKey:@"list"],@"list",[PagerModel mappingWithKey:@"pager"],@"pager" ,nil];
    return mapping;
}

- (void)getGroupBuysShopListWithCurPage:(NSInteger)curPage success:(void (^)(id data))success
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"%@&token=%@&version=%@&curPage=%ld&pageSize=%@", kApi_shop_queryGroupSquareShopList, token, VERSION, (long)curPage, @"5"];
    [TFGroupBuyVM getDataResponsePath:path success:^(id data) {
        TFGroupBuyVM *model = data;
        MyLog(@"data: %@, list: %@", [data class], model.list);
        if (curPage == 1) {
            [self.tableViewService.dataSource removeAllObjects];
        }
        if (model.status == 1) {
            
            [self.tableViewService.dataSource addObjectsFromArray:model.list];
        }
        
        success(data);
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

@implementation TFGroupBuyShop

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Id",@"id" ,nil];
    return mapping;
}

@end
