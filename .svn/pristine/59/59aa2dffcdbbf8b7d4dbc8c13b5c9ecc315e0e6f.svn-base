//
//  BuySuccessViewController.h
//  YunShangShiJi
//
//  Created by yssj on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuySuccessViewController : UIViewController
@property (nonatomic ,strong)NSString *shopprice;
@property (nonatomic,strong)NSArray* orderArray;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic ,strong)NSString *titlestr;
@property (strong , nonatomic) NSString *orderCode;

@property (nonatomic ,strong)NSArray *shopArray;

@property (nonatomic ,strong)NSString *p_type;
@property (nonatomic ,strong)NSString *shop_from;

@property (nonatomic , assign)BOOL isNormolShop;     /**< 是不是正价商品 */
@property (nonatomic , assign)BOOL isTM;          //是否特卖
@property (nonatomic, copy)dispatch_block_t paySuccessBlock;

+(BuySuccessViewController *)sharedManager;

@end
