//
//  FightIndianaPopView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/7/31.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FightIndianaPopView : UIView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UIView *SharePopview;
@property (nonatomic , strong) UIView *shareInvitationBackView;
@property (nonatomic , strong) UIView *ShareInvitationCodeView;
@property (nonatomic , strong) UIImageView *SharetitleImg;
@property (nonatomic , strong) UIImageView *SignImageview;
@property (nonatomic , strong) UIView *confirmView;
@property (nonatomic , strong) UIButton *confirmBtn;
@property (nonatomic , strong) UIButton * canclebtn;
@property (nonatomic , strong) UIView * backview;
@property (nonatomic , strong) UITableView *discriptionTableView;
@property (nonatomic , strong) NSMutableArray *discriptionData;
@property (nonatomic , strong) UILabel *shareMarkLab;
@property (nonatomic , strong) UILabel *duobaaoMarkLab;
@property (nonatomic , strong) NSMutableArray *RedcentData;
@property (nonatomic , strong) NSMutableArray *duobaoData;
@property (nonatomic , strong) UIView *shareview;

@property (nonatomic , strong) dispatch_block_t tapHideMindBlock;   //关闭按钮
@property (nonatomic , strong) dispatch_block_t weixinBlock;        //微信分享
@property (nonatomic , strong) dispatch_block_t tixianBlock;        //提现

- (instancetype)initWithFrame:(CGRect)frame;

//弹框消失
- (void)remindViewHiden;
- (void)shareData;
@end
