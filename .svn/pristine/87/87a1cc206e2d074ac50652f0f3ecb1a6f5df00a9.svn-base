//
//  TFBusinessCategoryView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/10/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
 

@class TFBusinessCategoryView;
@protocol TFBusinessCategoryDelegate <NSObject>

@required

- (void)selectBtnEnd:(TFBusinessCategoryView *)screeningView withBtnIndex:(int)index;
- (void)cancelSelectBtnEnd:(TFBusinessCategoryView *)screeningView withBtnIndex:(int)index;

@end

@interface TFBusinessCategoryView : UIView

@property (nonatomic, copy)NSString *title;
@property (nonatomic, strong)NSArray *categoryImgArr;
@property (nonatomic, strong)NSArray *contentArray;
@property (nonatomic, copy)NSString *imgUrl;

@property (nonatomic, strong)UIImageView *headImgView;
@property (nonatomic, assign)CGFloat titleFontSize;
@property (nonatomic, assign)CGFloat btnFontSize;
@property (nonatomic, assign)CGFloat h_Margin;
@property (nonatomic, assign)CGFloat v_Margin;
@property (nonatomic, assign)CGFloat btnH;
@property (nonatomic, assign)CGFloat headH;
@property (nonatomic, assign)CGFloat lrMargin;

@property (nonatomic, weak)id <TFBusinessCategoryDelegate>delegate;

- (void)clearChooseChar;

@end
