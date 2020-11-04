//
//  ShoppingCartViewModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/1/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ShoppingCartViewModel.h"
#import "ShopCarManager.h"
#import "ShopDetailModel.h"
#import "ShopCarModel.h"
#import "CartLikeModel.h"
@implementation ShoppingCartViewModel
- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.dataArray = [NSMutableArray array];
        self.invalidArray = [NSMutableArray array];
//        self.likeArray = [NSMutableArray array];
    }
    return self;
}

- (void)getData:(void (^)())success Fail:(void (^)())fail
{
    self.dataArray = [self detailModelsWidthArray:[ShopCarManager sharedManager].pData];
    self.invalidArray = [self detailModelsWidthArray:[ShopCarManager sharedManager].peData];
   
    if(self.dataArray.count)
    {
        if(success)
        {
            success();
        }
    }else{
        if(fail)
        {
            fail();
        }
    }
}
- (void)getLikeData:(void(^)())success
{
    [CartLikeModel getLikeDataSuccess:1 Success:^(id data) {
        CartLikeModel *model = data;
        if(model.status == 1)
        {
            
            for(int i =0;i<model.likeArray.count;i++)
            {
                LikeModel *md = model.likeArray[i];
                [self.likeArray addObject:md];
            }
            if(success)
            {
                success();
            }
        }
    }];
}

#pragma mark ＊＊＊＊＊＊＊＊＊＊＊＊数据处理＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
- (NSMutableArray *)detailModelsWidthArray:(NSArray <ShopCarModel *> *)array {
    NSMutableArray *muary = [NSMutableArray array];
    for (ShopCarModel *model in array) {
        ShopDetailModel *dmodel=[[ShopDetailModel alloc] init];
        dmodel.def_pic=model.def_pic;
        dmodel.shop_name=model.shop_name;
        dmodel.shop_price=[@(model.shop_price)stringValue];
        dmodel.shop_se_price=[@(model.shop_se_price)stringValue];
        dmodel.original_price=[@(model.original_price)stringValue];
        dmodel.shop_color=model.color;
        dmodel.shop_id=@"";
        dmodel.ID=[[@(model.ID)stringValue] copy];
        dmodel.shop_num= [@(model.shop_num) stringValue];
        dmodel.shop_size=model.size;
        dmodel.valid=[@(model.valid) stringValue];
        dmodel.shop_code=model.shop_code;
        dmodel.stock_type_id=[@(model.stock_type_id)stringValue];
        dmodel.stock = [@(model.stock) stringValue];
        dmodel.store_code=@"";
        dmodel.supp_id=[@(model.supp_id)stringValue];
        dmodel.kickback=[@(model.kickback)stringValue];
        
        dmodel.core=[@(model.original_price)stringValue];
        dmodel.select=NO;
        dmodel.BtnSelect=YES;
        dmodel.isGray=[@(model.valid) stringValue];
        dmodel.is_del=[@(model.is_del) stringValue];
        dmodel.shop_from=@"0";
        dmodel.supp_label=[self decodeFromPercentEscapeString:[NSString stringWithFormat:@"%@",model.supp_label]];
//        dmodel.supp_label=model.supp_label;
        dmodel.selectShop = NO;
        [muary addObject:dmodel];
    }
    return muary;
}

//特殊字符解码
- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
- (NSMutableArray*)likeArray
{
    if(_likeArray == nil)
    {
        _likeArray = [NSMutableArray array];
    }
    return _likeArray;
}
@end
