//
//  TFPublishThemeVC.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/17.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "SharePlatformView.h"
#pragma mark - 分享

typedef void(^ShareButtonBlock)(BOOL isSelected);
@interface ShareTagsView : UICollectionReusableView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *wxButton;
@property (nonatomic, strong) UIButton *qqButton;
@property (nonatomic, strong) UIButton *weiboButton;
@property (nonatomic, copy) ShareButtonBlock wxBlock;
@property (nonatomic, copy) ShareButtonBlock qqBlock;
@property (nonatomic, copy) ShareButtonBlock weiboBlock;

- (void)setButtonBlockWithWxBlock:(ShareButtonBlock)wxBlock qqBlock:(ShareButtonBlock)qqBlock weiboBlock:(ShareButtonBlock)weiboBlock;

@end

@interface TFPublishThemeVC : TFBaseViewController
@property (nonatomic , strong) SharePlatformView *shareview;
@property (nonatomic, copy) dispatch_block_t refreshBlock;
@end
