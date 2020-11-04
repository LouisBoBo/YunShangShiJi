//
//  BrowseRemindView.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/8/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseRemindView : UIView

@property (nonatomic , strong) UIView *SharePopview;
@property (nonatomic , strong) UIView *ShareInvitationCodeView;
@property (nonatomic , strong) UIView *SharebackView;
@property (nonatomic , strong) UIImageView *SharetitleImg;
@property (nonatomic , strong) UIImageView *SignImageview;

@property (nonatomic , copy) NSString *rewordType;//奖励类型
@property (nonatomic , copy) NSString *rewordValue;//奖励金额
@property (nonatomic , strong) NSArray *MyDataArray;//任务数据源
@property (nonatomic , strong) NSArray *motaskList;//签到任务ID
@property (nonatomic , strong) NSArray *finishList;//完成的签到任务
@property (nonatomic , assign) int selectSigntag; //选择的任务tag

@property (nonatomic , strong) void(^leftHideMindBlock)(NSString*);
@property (nonatomic , strong) void(^rightHideMindBlock)(NSString*);
@property (nonatomic , strong) dispatch_block_t tapHideMindBlock;

- (instancetype)initWithFrame:(CGRect)frame andrewordType:(NSString*)rewordType MotaskList:(NSArray*)motaskList FinishList:(NSArray*)finishlist DataArray:(NSArray*)mydataArray SelectTag:(int)selectSigntag;

//弹框消失
- (void)remindViewHiden;
@end
