//
//  SubmitBackgroundView.h
//  YunShangShiJi
//
//  Created by hyj on 15/9/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseView.h"
#import "SubmitView.h"
#import "MyscrollerView.h"

@class SubmitBackgroundView;
@protocol SubmitBackgroundViewDelegate <NSObject>
@required

- (void)selectBtnEnd:(SubmitBackgroundView *)screeningBackgroundView withChooseArray:(NSArray *)chooseArray;

@end

@interface SubmitBackgroundView : TFBaseView<SubmitViewDelegate>

@property (nonatomic, strong)NSArray *categoryArr;
@property (nonatomic, strong)NSArray *charArr;
@property (nonatomic, strong)MyscrollerView *screeningScrollView;

@property (nonatomic, assign)CGFloat fontSize;
@property (nonatomic, assign)int h_Margin;
@property (nonatomic, assign)int v_Margin;
@property (nonatomic, assign)CGFloat btnH;
@property (nonatomic, assign)CGFloat headH;
@property (nonatomic, assign)CGFloat lrMargin;

@property (nonatomic, strong)UIButton *commitBtn;

@property (nonatomic, weak)id <SubmitBackgroundViewDelegate>delegate;

@property (nonatomic, strong)NSMutableArray *chooseArr;
@property (nonatomic, strong)NSMutableArray *sectionArr;

- (void)refreshView;

@end
