//
//  CollecLikeTaskVC.h
//  YunShangShiJi
//
//  Created by zgl on 17/5/26.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollecLikeTaskVC : UIViewController
@property (nonatomic , assign) BOOL isFiristInvit;     //是否是第一次邀请
@property (nonatomic , copy) dispatch_block_t TaskFinishBlock;

@end
