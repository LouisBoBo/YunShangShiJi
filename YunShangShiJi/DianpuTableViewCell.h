//
//  DianpuTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/20.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DianpuModel.h"
@interface DianpuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;
@property (weak, nonatomic) IBOutlet UILabel *Titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *saleprice;
@property (weak, nonatomic) IBOutlet UILabel *shouprice;
-(void)creashData:(DianpuModel*)model;
-(void)creashBestlikeData:(DianpuModel*)model;
@end
