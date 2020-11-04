//
//  PersonTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headimg;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_headImg_left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_moreImg_right;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_headImg_height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_headImg_width;
@end
