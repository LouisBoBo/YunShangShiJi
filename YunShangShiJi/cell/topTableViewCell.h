//
//  topTableViewCell.h
//  YunShangShiJi
//
//  Created by yssj on 15/8/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumModel.h"

@interface topTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImg;
@property (weak, nonatomic) IBOutlet UIImageView *essenceImg;
@property (weak, nonatomic) IBOutlet UIImageView *hotImg;

@property (weak, nonatomic) IBOutlet UIImageView *photoImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *line;

-(void)refreshData:(ForumModel*)model;

@end
