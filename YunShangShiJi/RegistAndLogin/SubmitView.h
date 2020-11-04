//
//  SubmitView.h
//  YunShangShiJi
//
//  Created by hyj on 15/9/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseView.h"

@class SubmitView;
@protocol SubmitViewDelegate <NSObject>

@required
- (void)selectBtnEnd:(SubmitView *)screeningView withBtnIndex:(int)index;
- (void)cancelSelectBtnEnd:(SubmitView *)screeningView withBtnIndex:(int)index;

@end

@interface SubmitView : TFBaseView

@property (nonatomic, copy)NSString *headImgString;

@property (nonatomic, copy)NSString *title;         //标题
@property (nonatomic, strong)NSArray *contentArray; //内容数组

@property (nonatomic, strong)NSArray *contentIDArray; //内容ID数组

@property (nonatomic, strong)UIImage *headImg;      //图片
@property (nonatomic, strong)UIImageView *headImgView;
@property (nonatomic, assign)CGFloat fontSize;      //字体大小
@property (nonatomic, assign)CGFloat h_Margin;           //按钮水平间隔
@property (nonatomic, assign)CGFloat v_Margin;           //按钮垂直间隔
@property (nonatomic, assign)CGFloat btnH;           //按钮的高度
@property (nonatomic, assign)CGFloat headH;          //头部标题的高度

@property (nonatomic, assign)CGFloat lrMargin;

@property (nonatomic, weak)id <SubmitViewDelegate>delegate;



- (void)createView;
- (void)refreshChooseBtn;

@end
