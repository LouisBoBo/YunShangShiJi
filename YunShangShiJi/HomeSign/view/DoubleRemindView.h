//
//  DoubleRemindView.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/8/15.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoubleRemindView : UIView

@property (nonatomic , strong) UIView *SharePopview;
@property (nonatomic , strong) UIView *ShareInvitationCodeView;
@property (nonatomic , strong) UIView *SharebackView;
@property (nonatomic , strong) UIImageView *SharetitleImg;
@property (nonatomic , copy) NSString *balance; //余额


@property (nonatomic , strong) dispatch_block_t leftHideMindBlock;
@property (nonatomic , strong) dispatch_block_t rightHideMindBlock;
@property (nonatomic , strong) dispatch_block_t tapHideMindBlock;

- (instancetype)initWithFrame:(CGRect)frame andbalance:(NSString*)balance;
- (void)remindViewHiden;

@end
