//
//  SharePlatformView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/11.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DShareManager.h"
#import "WXApi.h"
@interface SharePlatformView : UIView<DShareManagerDelegate,WXApiDelegate,MiniShareManagerDelegate>
@property (nonatomic , strong) UIView *shareBackView;         //底视图
@property (nonatomic , strong) UIButton *weixinBtn;
@property (nonatomic , strong) UIButton *QQbtn;
@property (nonatomic , strong) UIButton *weiboBtn;
@property (nonatomic , copy)   NSString *shareImage;
@property (nonatomic , copy)   NSString *shareTitle;
@property (nonatomic , copy)   NSString *shareLink;
@property (nonatomic , copy)   NSString *theme_id;

@property (nonatomic , strong) DShareManager *shareManager;
@property (nonatomic , strong) dispatch_block_t shareFinishBlock;
-(instancetype)initWithFrame:(CGRect)frame;
- (void)goshare:(BOOL)isshare;
@end
