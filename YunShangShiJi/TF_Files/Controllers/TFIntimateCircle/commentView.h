//
//  commentView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/8.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntimateCircleModel.h"
@interface commentView : UIView
@property (nonatomic , strong) UIView *backview;
- (instancetype)initWithFrame:(CGRect)frame data:(IntimateCircleModel*)model;
- (void)refreshView:(IntimateCircleModel*)model;
@end
