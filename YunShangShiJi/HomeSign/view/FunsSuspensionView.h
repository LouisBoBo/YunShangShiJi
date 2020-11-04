//
//  FunsSuspensionView.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/9/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunsSuspensionView : UIView

/*
slb/queryBarr  （悬浮弹框）
"头像,昵称,type，金额"）其中type 1为新增粉丝，2为分享获得奖励，3为粉丝获得奖励
金额暂时只在type=3时才有
*/
@property (nonatomic , copy) NSString *Funsbackview;
@property (nonatomic , copy) NSString *headImageurl;
@property (nonatomic , copy) NSString *nickname;
@property (nonatomic , assign) int usertype;
@property (nonatomic , assign) float money;//金额暂时只在type=3时才有
@property (nonatomic , assign) int mentionCount;

@property (nonatomic , strong) dispatch_block_t funsClickBlock;

- (instancetype)initWithFrame:(CGRect)frame HeadImageUrl:(NSString*)headImageurl NickName:(NSString*)nickname UserType:(int)type Money:(float)money MentionCount:(int)mentioncount;
- (void)setRemindIsHidden;//是否隐藏
@end
