//
//  TFTopShopsVM.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/11.
//  Copyright © 2016年 ios-1. All rights reserved.
//  轮播图和热图

#import "PublicViewModel.h"
#import "TFShoppingM.h"
@interface TFTopShopsVM : PublicViewModel

@property (nonatomic, strong) TFCollectionViewService *hotService;


- (void)handleDataWithSuccess:(void (^)(NSArray *centShopsArray, NSArray *topShopsArray, Response *response))success failure:(void(^)(NSError *error))failure;

+ (void)handleZeroShopsDataWithSuccess:(void (^)(NSArray *zeroShopsArray, Response *response))success failure:(void(^)(NSError *error))failure;

@end


@interface TFHotServiceCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageV;

@end
