//
//  ContendTreasuresAreaVC.h
//  YunShangShiJi
//
//  Created by YF on 2017/8/2.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

typedef NS_ENUM(NSUInteger, TreasuresType) {
    TreasuresType_Shop,  //夺宝
    TreasuresType_edu,   //额度夺宝
    TreasuresType_GroupShop, //拼团夺宝
};

@interface ContendTreasuresAreaVC : TFBaseViewController
@property (nonatomic, assign) TreasuresType type;
@end
