//
//  RecommendRemindView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/7.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCDraggableContainer.h"
#import "CustomCardView.h"
#import "SlideRemindView.h"
#import "RecommendModel.h"

@interface RecommendRemindView : UIView<
CCDraggableContainerDataSource,
CCDraggableContainerDelegate
>

@property (nonatomic , strong) UIView *RemindBackView;             //底视图
@property (nonatomic , strong) UIButton *remindbtn;                //不再自动弹出
@property (nonatomic , strong) UIButton *canclebtn;                //关闭按钮
@property (nonatomic , strong) UIView *slideCardView;              //滑动视图
@property (nonatomic , strong) UIButton *likebutton;               //喜欢
@property (nonatomic , strong) UIButton *dislikebtn;               //不喜欢
@property (nonatomic , strong) UIButton *sharebutton;              //分享
@property (nonatomic , strong) UIButton *lastbutton;               //上一件
@property (nonatomic , strong) SlideRemindView *SlideView;         //蒙层

@property (nonatomic, strong) CCDraggableContainer *container;
@property (nonatomic, assign) CCDraggableDirection direction;
@property (nonatomic, strong) NSMutableArray *dataSources;         //数据源
@property (nonatomic, strong) NSMutableArray *dataArray;           //保存的数据源
@property (nonatomic, strong) NSMutableArray *likeArray;           //点赞的商品
@property (nonatomic, strong) NSMutableArray *dislikeArray;        //不喜欢的商品
@property (nonatomic, strong) NSMutableArray *allCrads;            //所有商品
@property (nonatomic , strong) void(^addImageBlock)(NSArray *photos);//添加图片
@property (nonatomic , strong) void(^didselectShopBlock)(NSString *shopcode);//点击了商品
@property (nonatomic , strong) void(^likeDataBlock)(NSString *message);
@property (nonatomic , strong) dispatch_block_t FinishbrowseBlock; //浏览完
@property (nonatomic , strong) dispatch_block_t RemindFinishBlock; //推荐任务完成
@property (nonatomic, assign) NSInteger currentPage;               //当前页
@property (nonatomic, assign) NSInteger totalPage;                 //总页数
- (instancetype)initWithFrame:(CGRect)frame DataModel:(RecommendModel*)model;
- (void)refreshView:(NSArray*)images;
@end
