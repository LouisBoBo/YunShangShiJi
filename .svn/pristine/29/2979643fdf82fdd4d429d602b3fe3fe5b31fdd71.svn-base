//
//  TopheaderView.h
//  TestStickHeader
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 liqi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "IntimateCircleModel.h"
#import "TdetailsModel.h"
@interface TopheaderView : UIView

@property (nonatomic , strong) UIView *headerBackView;               //底视图
@property (nonatomic , strong) UIScrollView *tagsView;               //标签视图
@property (nonatomic , strong) NSArray *tagsArray;                   //标签数据
@property (nonatomic , strong) UILabel *discriptionLabel;            //描述
@property (nonatomic , strong) UIButton *followbutton;               //关注按钮
@property (nonatomic , strong) UIImageView *userVipIco;              //加V
@property (nonatomic , strong) void(^tagBlock)(NSInteger tag ,NSString *title);       //标签
@property (nonatomic , strong) void(^followBlock)(NSInteger type);   //关注

@property (nonatomic , strong) TdetailsModel *model;                 //数据
- (instancetype)initWithFrame:(CGRect)frame Data:(TdetailsModel *)model;
@end
