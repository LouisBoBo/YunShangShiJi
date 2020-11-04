//
//  TFScreeningBackgroundView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/8/18.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseView.h"
#import "TFScreeningScrollView.h"

@class TFScreeningBackgroundView;
@protocol TFScreeningBackgroundDelegate <NSObject>
@required

- (void)selectBtnEnd:(TFScreeningBackgroundView *)screeningBackgroundView withChooseArray:(NSArray *)chooseArray;

@end


@interface TFScreeningBackgroundView : TFBaseView <TFScreeningDelegate>

@property (nonatomic, strong) NSArray                       *categoryArr;
@property (nonatomic, strong) NSArray                       *charArr;
@property (nonatomic, strong) TFScreeningScrollView         *screeningScrollView;

@property (nonatomic, assign) CGFloat                       titleFontSize;
@property (nonatomic, assign) CGFloat                       btnFontSize;
@property (nonatomic, assign) CGFloat                       h_Margin;
@property (nonatomic, assign) CGFloat                       v_Margin;
@property (nonatomic, assign) CGFloat                       cate_v_Margin;
@property (nonatomic, assign) CGFloat                       btnH;
@property (nonatomic, assign) CGFloat                       headH;
@property (nonatomic, assign) CGFloat                       lrMargin;

@property (nonatomic, strong) UIButton                      *commitBtn;

@property (nonatomic, weak  ) id <TFScreeningBackgroundDelegate> delegate;

@property (nonatomic, strong) NSMutableArray                *chooseArr;

@end
