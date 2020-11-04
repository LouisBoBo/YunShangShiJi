//
//  CustomTitleView.h
//  TFTestCollctionViewDemo
//
//  Created by 云商 on 15/8/21.
//  Copyright (c) 2015年 云商. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTitleView;

@protocol CustomTitleViewDelegate <NSObject>

@required
- (BOOL)selectEndWithView:(CustomTitleView *)cusTomTitleView withBtnIndex:(int)index;

@end


@interface CustomTitleView : UIView
@property (nonatomic, assign) BOOL isShopping;
@property (nonatomic, assign) BOOL isSecretFriend;


+(instancetype)scrollWithFrame:(CGRect)frame withTag:(int)tag withIndex:(int)index withButtonNames:(NSArray *)names withImage:(NSArray*)images;
- (instancetype)initWithFrame:(CGRect)frame withTag:(int)tag wintIndex:(int)index withButtonNames:(NSArray *)names withImage:(NSArray *)images;

@property (nonatomic, assign)int index;
@property (nonatomic, assign)CGPoint contentOffset;

@property (nonatomic ,strong)UIColor *backColor;
@property (nonatomic ,assign) CGFloat buttonFont;
@property (nonatomic, assign)int buttonNums;
@property (nonatomic, assign)CGFloat buttonWidth;
@property (nonatomic, strong)UIColor *buttonSelect;
@property (nonatomic, strong)UIColor *buttonNormol;
@property (nonatomic, assign)CGFloat imageW;
@property (nonatomic, strong)dispatch_block_t loginBlock;
@property (nonatomic, strong)UIScrollView *bgScrollView;
@property (nonatomic, weak)id <CustomTitleViewDelegate>customTitleViewDelegate;

- (void)refreshIndex:(int)index withContentOffset:(CGPoint)point;
- (void)refreshTitleViewUI:(NSArray *)btnNames withImgNames:(NSArray *)imgNames;

- (void)btnClick:(UIButton *)sender;
- (void)switchToPageIndex:(int)index;
@end
