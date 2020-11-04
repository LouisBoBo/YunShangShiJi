//
//  TopselectView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TdetailsModel.h"
@interface TopselectView : UIView
@property (nonatomic , strong) UIView *selectBackView;                 //底视图
@property (nonatomic , strong)  UIButton *fabulousBtn;                 //点赞
@property (nonatomic , strong) void(^selectBlock)(NSInteger tag);      //评论
@property (nonatomic , strong) void(^fabulousBlock)(NSInteger fabulousNum);
- (instancetype)initWithFrame:(CGRect)frame WithNames:(NSArray *)nameArr pubIndex:(NSInteger)pubIndex Data:(TdetailsModel*)model;
@end
