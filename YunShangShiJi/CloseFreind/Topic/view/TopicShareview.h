//
//  TopicShareview.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicShareview : UIView
@property (nonatomic , strong) UIView *popBackView;               //底视图
@property (nonatomic , strong) UIView *shareModelview;            //分享弹框

@property (nonatomic , strong) void(^shareBlock)(NSInteger tag);  //分享
- (instancetype)initWithFrame:(CGRect)frame;
@end
