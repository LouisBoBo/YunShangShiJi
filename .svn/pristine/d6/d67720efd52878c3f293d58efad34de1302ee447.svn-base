//
//  TixianRedHongbao.h
//  YunShangShiJi
//
//  Created by hebo on 2019/1/22.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TixianRedHongbao : UIView<MiniShareManagerDelegate>
@property (nonatomic , strong) UIView *SharePopview;
@property (nonatomic , strong) UIView *shareInvitationBackView;
@property (nonatomic , strong) UIView *ShareInvitationCodeView;
@property (nonatomic , strong) UIImageView *bigImageview;
@property (nonatomic , strong) UIImageView *lingButton;
@property (nonatomic , strong) UIButton * canclebtn;

@property (nonatomic , assign) BOOL isNewUser; //是否是没有交易记录的新用户
@property (nonatomic , assign) double homePage3FirstTime;//第一次弹出时间
@property (nonatomic , assign) double homePage3ElastTime;//循环弹出时间
@property (nonatomic , strong) void (^lingHongBaoBlock)(BOOL isNewUser);//点领去赚钱
@property (nonatomic , strong) void (^closeHongBaoBlack)(double lastTime);
- (instancetype)initWithFrame:(CGRect)frame Nextpop:(double)lastTime;
- (void)remindViewDisapper;
@end

NS_ASSUME_NONNULL_END
