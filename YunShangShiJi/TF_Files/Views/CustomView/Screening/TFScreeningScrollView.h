//
//  TFScreeningScrollView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/31.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFScreeningView.h"

@interface TFScreeningScrollView : UIScrollView <TFScreeningDelegate>

@property (nonatomic, strong) NSArray *categoryArr;
@property (nonatomic, strong) NSArray *charArr;

@property (nonatomic, assign) CGFloat titleFontSize;
@property (nonatomic, assign) CGFloat btnFontSize;
@property (nonatomic, assign) CGFloat h_Margin;
@property (nonatomic, assign) CGFloat v_Margin;
@property (nonatomic, assign) CGFloat cate_v_Margin;
@property (nonatomic, assign) CGFloat btnH;
@property (nonatomic, assign) CGFloat headH;
@property (nonatomic, assign) CGFloat lrMargin;

@end
