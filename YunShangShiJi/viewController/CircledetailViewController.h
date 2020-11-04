//
//  CircledetailViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumModel.h"
@interface CircledetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *num_cont;

@property (weak, nonatomic) IBOutlet UILabel *circle_count;
@property (weak, nonatomic) IBOutlet UIImageView *bigimage;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *circletitle;
@property (weak, nonatomic) IBOutlet UIView *ruleView;
@property (weak, nonatomic) IBOutlet UIView *circleview;
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollview;
//类别
@property (weak, nonatomic) IBOutlet UILabel *categorylab;
@property (weak, nonatomic) IBOutlet UILabel *circleAdmin;
@property (weak, nonatomic) IBOutlet UIImageView *punlunImg;
@property (weak, nonatomic) IBOutlet UIImageView *numImg;
@property (weak, nonatomic) IBOutlet UILabel *duihuaNum;
@property (weak, nonatomic) IBOutlet UILabel *circleRule;

//成为圈主
@property (weak, nonatomic) IBOutlet UIButton *addcirdle;
//对话数
@property (weak, nonatomic) IBOutlet UILabel *dailogue;
//圈人数
@property (nonatomic,strong)NSString *u_count;
//圈帖数
@property (nonatomic,strong)NSString *n_count;
//总对话数
@property (nonatomic,strong)NSString *rn_count;
@property (nonatomic,strong)ForumModel *circleModel;

@property (nonatomic,strong)NSArray *circleArr;
@end
