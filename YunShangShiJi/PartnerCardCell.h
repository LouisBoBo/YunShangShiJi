//
//  PartnerCardCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/3/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartnerCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cardlab;
@property (weak, nonatomic) IBOutlet UILabel *activationlab;
@property (weak, nonatomic) IBOutlet UILabel *statuelab;
@property (weak, nonatomic) IBOutlet UILabel *activationID;
@property (weak, nonatomic) IBOutlet UIImageView *activationImage;
@property (weak, nonatomic) IBOutlet UILabel *lableline;

@end
