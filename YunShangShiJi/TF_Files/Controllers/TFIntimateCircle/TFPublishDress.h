//
//  TFPublishDress.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/17.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "SharePlatformView.h"
@interface TFPublishDress : TFBaseViewController
@property (nonatomic , strong) SharePlatformView *shareview;
@property (nonatomic, copy) dispatch_block_t refreshBlock;
@end
