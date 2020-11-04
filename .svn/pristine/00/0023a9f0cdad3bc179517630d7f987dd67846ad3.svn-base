//
//  ShareBeautifulRemindView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/8.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharePlatformView.h"
#import "KeyboardTool.h"
@interface ShareBeautifulRemindView : UIView<UIAlertViewDelegate,KeyboardToolDelegate,UITextViewDelegate>
@property (nonatomic , strong) UIView *RemindPopview;
@property (nonatomic , strong) UIView *RemindBackView;
@property (nonatomic , strong) UIButton * canclebtn;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *discriptionLabel;
@property (nonatomic , strong) UIView *shareImageView;
@property (nonatomic , strong) UITextView *ContentTextView;
@property (nonatomic , strong) UIButton *submitBtn;                 //发布按钮
@property (nonatomic , strong) UIButton *exitBtn;                   //退出按钮
@property (nonatomic , strong)UIScrollView *photoScrollView;        //图滑动视图
@property (nonatomic , strong) UIButton *addImage;                  //增加图片
@property (nonatomic , strong) NSMutableArray *selectPhotos;        //数据源
@property (nonatomic , strong) NSMutableArray *selectShopcodes;     //要发布的商品
@property (nonatomic , strong) NSMutableDictionary *shopDictionary; //商品数据
@property (nonatomic , strong) NSMutableArray *selectImages;        //要发布的图片
@property (nonatomic , strong) SharePlatformView *shareview;        //分享视图
@property (nonatomic , strong) void(^addImageBlock)(NSArray *photos);//添加图片
@property (nonatomic , strong) dispatch_block_t exitBlock;          //退出
@property (nonatomic , strong) dispatch_block_t cancleBlock;        //关闭
@property (nonatomic , strong) NSArray *textviewTitleArray;         //提示数据
@property (nonatomic , strong) NSString *themeid;                  //帖子id
- (instancetype)initWithFrame:(CGRect)frame Photos:(NSMutableArray*)photos exitBtnHide:(BOOL)hide;
- (void)refreshView:(NSArray*)images;
@end
