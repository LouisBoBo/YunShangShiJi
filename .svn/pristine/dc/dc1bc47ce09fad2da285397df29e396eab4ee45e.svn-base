//
//  TopicReportView.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicReportView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UIView *popBackView;               //底视图
@property (nonatomic , strong) UILabel *titlelabel;               //列表头
@property (nonatomic , strong) UITableView *mytableView;          //列表
@property (nonatomic , strong) NSMutableArray *dataArray;         //数据
@property (nonatomic , strong) void(^(reportBlock))(NSString*content);
- (instancetype)initWithFrame:(CGRect)frame;

@end
