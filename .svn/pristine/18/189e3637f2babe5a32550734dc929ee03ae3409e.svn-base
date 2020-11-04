//
//  TFBusinessCategoryBackgroundView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/10/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFBaseView.h"
#import "TFBusinessCategoryScrollView.h"
@class TFBusinessCategoryBackgroundView;
@protocol TFBusinessCategoryBackgroundDelegate <NSObject>
@required

- (void)selectBtnEnd:(TFBusinessCategoryBackgroundView *)screeningBackgroundView withChooseArray:(NSArray *)chooseArray;

@end


@interface TFBusinessCategoryBackgroundView : TFBaseView <TFBusinessCategoryDelegate>
@property (nonatomic, strong)NSArray *categoryArr;
@property (nonatomic, strong)NSArray *charArr;
@property (nonatomic, strong)TFBusinessCategoryScrollView *BusinessCategoryScrollView;

@property (nonatomic, assign)CGFloat titleFontSize;
@property (nonatomic, assign)CGFloat btnFontSize;
@property (nonatomic, assign)CGFloat h_Margin;
@property (nonatomic, assign)CGFloat v_Margin;
@property (nonatomic, assign)CGFloat cate_v_Margin;
@property (nonatomic, assign)CGFloat btnH;
@property (nonatomic, assign)CGFloat headH;          
@property (nonatomic, assign)CGFloat lrMargin;

@property (nonatomic, strong)UIButton *commitBtn;

@property (nonatomic, weak)id <TFBusinessCategoryBackgroundDelegate>delegate;

@property (nonatomic, strong)NSMutableArray *chooseArr;
@end
