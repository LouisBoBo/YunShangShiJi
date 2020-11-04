//
//  TixianSharePopview.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/9/2.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TixianSharePopview : UIView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UIView *SharePopview;
@property (nonatomic , strong) UIView *shareInvitationBackView;
@property (nonatomic , strong) UIView *ShareInvitationCodeView;
@property (nonatomic , strong) UIImageView *SharetitleImg;
@property (nonatomic , strong) UIImageView *SignImageview;
@property (nonatomic , strong) UIButton * canclebtn;
@property (nonatomic , strong) UIView * backview;
@property (nonatomic , strong) UIButton *leftgobtn;
@property (nonatomic , strong) UIButton *rightgobtn;
@property (nonatomic , strong) UIScrollView *Myscrollview;
@property (nonatomic , strong) UIView *scbackview;
@property (nonatomic , strong) UIPageControl *pageControl;
@property (nonatomic , strong) UITableView *discriptionTableView;
@property (nonatomic , strong) NSMutableArray *discriptionData;
@property (nonatomic , strong) dispatch_block_t tapHideMindBlock; //关闭按钮

@property (nonatomic , strong) dispatch_block_t moreunderstandBlock; //了解更多

@property (nonatomic , strong) dispatch_block_t weixinBlock; //微信分享
@property (nonatomic , strong) dispatch_block_t friendBlock; //朋友圈分享
@property (nonatomic , strong) dispatch_block_t QQBlock;     //QQ分享


- (instancetype)initWithFrame:(CGRect)frame;

//弹框消失
- (void)remindViewHiden;

@end
