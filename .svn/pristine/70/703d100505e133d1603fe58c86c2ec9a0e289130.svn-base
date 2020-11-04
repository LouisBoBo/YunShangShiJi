//
//  TFCustomTitleView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/11/30.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFCustomTitleView;

@protocol TFCustomTitleViewDelegate <NSObject>

@required
- (BOOL)selectEndWithView:(TFCustomTitleView *)cusTomTitleView withBtnIndex:(int)index;

@end

@interface TFCustomTitleView : UIView

@property (nonatomic, weak)id <TFCustomTitleViewDelegate>customTitleViewDelegate;

@property (nonatomic, assign)int index;

- (instancetype)initWithFrame:(CGRect)frame withTag:(int)tag wintIndex:(int)index withNormalImage:(NSArray *)normalImages withSelectImage:(NSArray *)selectImages;
+ (instancetype)scrollWithFrame:(CGRect)frame withTag:(int)tag wintIndex:(int)index withNormalImage:(NSArray *)normalImages withSelectImage:(NSArray *)selectImages;

- (instancetype)initWithFrame:(CGRect)frame withTag:(int)tag withIndex:(int)index withButtonNames:(NSArray *)buttonNames;

@property (nonatomic, weak)id <TFCustomTitleViewDelegate>tfCustomTitleViewDelegate;

- (void)switchToPageIndex:(int)index;

@end
