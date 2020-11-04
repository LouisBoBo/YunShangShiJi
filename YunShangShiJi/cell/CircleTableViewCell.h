//
//  CircleTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumModel.h"

@protocol AddcircleDelegate <NSObject>

-(void)Addcircle:(NSInteger)index;

@end
@interface CircleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *day_count;
@property (weak, nonatomic) IBOutlet UIButton *addcircle;
@property (weak, nonatomic) IBOutlet UILabel *trendslab;

@property (weak, nonatomic) IBOutlet UILabel *funslab;
@property(nonatomic,assign)NSInteger row;
@property (nonatomic ,strong)id<AddcircleDelegate>delegate;
-(void)refreshData:(ForumModel*)model;
-(void)refreshData1:(ForumModel*)model;
-(void)refreshData2:(ForumModel*)model;
@end
