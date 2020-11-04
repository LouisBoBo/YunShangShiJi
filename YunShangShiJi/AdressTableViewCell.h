//
//  AdressTableViewCell.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/24.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Ordername;
@property (weak, nonatomic) IBOutlet UILabel *OrderPhone;
@property (weak, nonatomic) IBOutlet UILabel *OrderAddress;
@property (weak, nonatomic) IBOutlet UIButton *markbtn;

@end
