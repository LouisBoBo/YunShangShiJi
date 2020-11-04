//
//  TFTopShopsVM.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFTopShopsVM.h"

@implementation TFTopShopsVM

- (void)handleDataWithSuccess:(void (^)(NSArray *centShopsArray, NSArray *topShopsArray, Response *response))success failure:(void(^)(NSError *error))failure
{
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_shop_queryOption caches:YES cachesTimeInterval:0*TFMinute token:NO success:^(id data, Response *response) {
        
        NSMutableArray *centShopsArr = [NSMutableArray array];
        NSMutableArray *topShopsArr = [NSMutableArray array];
        for (NSDictionary *centShopsDic in data[@"centShops"]) {
            TFShoppingM *model=[TFShoppingM yy_modelWithJSON:centShopsDic];
            [centShopsArr addObject:model];
        }
        
        for (NSDictionary *topShopsDic in data[@"topShops"]) {
            TFShoppingM *model=[TFShoppingM yy_modelWithJSON:topShopsDic];
            [topShopsArr addObject:model];
        }
        
        //何波加的2016-10-24
        for (NSDictionary *topShopsDic in data[@"supplier_label"]) {
            TFShoppingM *model=[TFShoppingM yy_modelWithJSON:topShopsDic];
            [topShopsArr addObject:model];
        }

        if (centShopsArr.count) {
            [self.hotService.dataSource removeAllObjects];
            self.hotService.dataSource = [NSMutableArray arrayWithArray:centShopsArr];
        }
        
        success(centShopsArr, topShopsArr, response);
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
}

+ (void)handleZeroShopsDataWithSuccess:(void (^)(NSArray *zeroShopsArray, Response *response))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *parameter = @{@"type": @"3"};
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_shop_queryOption parameter:parameter caches:YES cachesTimeInterval:0*TFMinute token:NO success:^(id data, Response *response) {
        
        NSMutableArray *zeroShopsArr = [NSMutableArray array];
        for (NSDictionary *dic in data[@"zeroShops"]) {
            TFShoppingM *model=[TFShoppingM yy_modelWithJSON:dic];
            [zeroShopsArr addObject:model];
        }
        success(zeroShopsArr, response);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (TFCollectionViewService *)hotService
{
    if (!_hotService) {
        _hotService = [[TFCollectionViewService alloc] init];
    }
    return _hotService;
}



@end

@implementation TFHotServiceCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIImageView *imageV = [UIImageView new];
    [self.contentView addSubview:_imageV = imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    imageV.backgroundColor = RGBCOLOR_I(240, 240, 240);
}

@end

