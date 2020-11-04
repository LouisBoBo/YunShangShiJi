//
//  GroupBuyPopView.h
//  YunShangShiJi
//
//  Created by YF on 2017/7/13.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GroupBuyPopType1 = 1,
    GroupBuyPopType2, //拼团成功
    GroupBuyPopType3, //拼团失败  未达到拼团人数
    GroupBuyPopType4, //拼团失败  未达到付款团员数
    GroupBuyPopType5, //拼团失败  人数满
    GroupBuyPopType6, //拼团失败  已过期
    GroupBuyPopType7, //拼团人数已满,请立即付款！
//    GroupBuyPopType8, //很遗憾，该团你并未在指定时间内付款，本次拼团已失效，谢谢你的参与。
    GroupBuyPopType9, //拼团失败（用户未付款）——人满后未达到付款人数的失败蒙层文案
    GroupBuySuccess,  //拼团成功 去提现
    OneIndianaMinute, //一元夺宝  马上开奖
    OneIndianaWinning,//一元夺宝  中奖
    OneIndianaNotwinning, //一元夺宝  未中奖
    OneIndianaSuccess,//一元夺宝  参与成功
    AddCardMemberType,//成为会员
} GroupBuyPopType;

@interface GroupBuyPopView : UIView

@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) NSString *taskNum;
@property (nonatomic, strong) NSString *moneyNum;
@property (nonatomic, strong) UIButton *mymoneyBtn;
@property (nonatomic, assign) NSInteger timeout;
@property (nonatomic,copy) void (^btnBlok)(NSInteger index);
@property (nonatomic, copy) dispatch_block_t timeOutBlock;
- (instancetype)initWithFrame:(CGRect)frame popType:(GroupBuyPopType)popType;

- (void)show;
- (void)close;

@end
