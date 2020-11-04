//
//  ValueObserver.h
//  YunShangShiJi
//
//  Created by 云商 on 15/10/9.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValueObserver : NSObject

@property (nonatomic, strong)NSNumber *index; //普通智能分享
@property (nonatomic, strong)NSNumber *detail; //详情购买分享
@property (nonatomic, strong)NSNumber *affirm; //订单支付分享
@property (nonatomic, strong)NSNumber *comdetail; //0元购详情分享
@property (nonatomic, strong)NSNumber *shopping; //购物车支付分享
@property (nonatomic, strong)NSNumber *order; //订单列表支付分享
@property (nonatomic, strong)NSNumber *zeroindex; //0元购智能分享
@property (nonatomic, strong)NSNumber *myNewSign;
@property (nonatomic, copy)NSString *text;


+ (ValueObserver *) shareValueObserver;

@end
