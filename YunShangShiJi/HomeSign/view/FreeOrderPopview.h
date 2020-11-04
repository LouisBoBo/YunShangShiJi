//
//  FreeOrderPopview.h
//  YunShangShiJi
//
//  Created by ios-1 on 2016/11/28.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeOrderPopview : UIView
typedef NS_ENUM(NSInteger , FreeOrderType)
{
    FreeOrder_fifty = 0,             //50免单
    FreeOrder_hundred = 1,           //100免单
    CrazyMonday_activity = 2         //疯狂星期一
};

@property (nonatomic , assign)FreeOrderType freeOrderType;
@property (nonatomic , strong) UIView *SharePopview;
@property (nonatomic , strong) UIView *ShareBackView;
@property (nonatomic , strong) UIView *ShareInvitationCodeView;
@property (nonatomic , strong) UIImageView *SignImageview;
@property (nonatomic , strong) UIButton * canclebtn;
@property (nonatomic , strong) dispatch_block_t tapHideMindBlock;
@property (nonatomic , strong) dispatch_block_t getLuckBlock;

- (instancetype)initWithFrame:(CGRect)frame FreeOrderType:(FreeOrderType)FreeOrderType;

@end
