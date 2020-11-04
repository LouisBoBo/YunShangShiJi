//
//  HBcardTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 16/1/26.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCardModel.h"

@interface HBcardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backimage;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;

- (void)receiveDataModel:(MyCardModel *)model;
@end
