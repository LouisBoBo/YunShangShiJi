//
//  TopfooterView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TdetailsModel.h"
#import "HXTagsView.h"
@interface TopfooterView : UIView
@property (nonatomic , strong) UIView *footerBackView;               //底视图
@property (nonatomic , strong) UILabel *contentLabel;                //内容
@property (nonatomic , strong) HXTagsView *hxtagsView;               //标签视
@property (nonatomic , strong) UIScrollView *shopview;               //商品
@property (nonatomic , strong) void(^shareBlock)(NSInteger tag);     //分享
@property (nonatomic , strong) void(^shopBlock)(NSInteger tag ,NSString *shopcode);    //推荐商品
@property (nonatomic , copy) void(^tagsBlock)(NSInteger tag ,NSString *title);       //标签
@property (nonatomic , copy) void(^customTagBlock)(NSString *supID ,NSString *title,BOOL repeat); //自定义标签
@property (nonatomic , strong) TdetailsModel *DataModel;            //数据源
@property (nonatomic , strong) NSMutableArray*tagsArray;            //标签数据
@property (nonatomic , assign) CGFloat tagsviewHeigh;               //标签高度
- (instancetype)initWithFrame:(CGRect)frame Data:(TdetailsModel *)model;
@end
