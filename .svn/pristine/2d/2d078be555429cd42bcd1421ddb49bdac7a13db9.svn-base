//
//  TFUserCardViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/9/2.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "MyCardModel.h"

typedef void(^SuccessBlock)(MyCardModel *model);


@interface TFUserCardViewController : TFBaseViewController

@property (nonatomic ,assign)double c_cond;
@property (nonatomic ,assign)double totalPrice;//用金券时需要的价格


@property (nonatomic ,copy)SuccessBlock myBlock;

- (void)returnSuccessBlock:(SuccessBlock)theBlock;


@end
