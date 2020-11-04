//
//  membersCell.h
//  YunShangShiJi
//
//  Created by yssj on 15/10/27.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistributionModel.h"

@interface membersCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addressImg;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImg;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *membersLabel;
@property (weak, nonatomic) IBOutlet UILabel *card_noLabel;
@property (weak, nonatomic) IBOutlet UILabel *plaintextLabel;

@property (strong,nonatomic)DistributionModel *model;

-(void)refreshModel:(DistributionModel *)model;

@end
