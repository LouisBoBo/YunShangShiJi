//
//  TaskTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"
#import "MakeMoneyViewController.h"
@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *moreimage;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *titlelable;
@property (weak, nonatomic) IBOutlet UIImageView *titleimage;
@property (weak, nonatomic) IBOutlet UILabel *extraLab;
@property (weak, nonatomic) IBOutlet UIImageView *finisgImg;
@property (weak, nonatomic) IBOutlet UIImageView *buyImage;
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (strong , nonatomic)NSMutableArray *MydataArray;
@property (strong , nonatomic)NSMutableArray *valueArray;
@property (copy , nonatomic)NSString *value;
@property (assign , nonatomic)Mondytype mondaytype;
@property (strong , nonatomic)NSString *fxqd;                //邀请好友获得奖励
@property (assign , nonatomic)NSInteger orderStatus;         //0未完成 1已完成
-(void)refreshData:(TaskModel*)model Data:(NSMutableArray*)dataArr ValueData:(NSMutableArray*)valueArray;
@end
