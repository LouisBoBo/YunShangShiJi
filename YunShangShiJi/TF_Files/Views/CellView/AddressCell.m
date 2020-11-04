//
//  AddressCell.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/22.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell ()

@property (nonatomic, copy)NSString *addressStr;


@end

@implementation AddressCell

- (void)awakeFromNib {
    // Initialization code
    self.addressLabel.font = kFont6px(26);
    self.nameLabel.font = kFont6px(32);
    self.phoneLabel.font = kFont6px(32);
    
}

- (void)receiveDataModel:(AddressModel *)model
{
    NSArray *array = model.addressArray;
    if (array.count == 4) {
        if ([model.is_default intValue] == 1) {
            self.addressStr = [NSString stringWithFormat:@"[默认]%@%@%@%@%@",array[0],array[1],array[2],array[3],model.address];
        } else {
            self.addressStr = [NSString stringWithFormat:@"%@%@%@%@%@",array[0],array[1],array[2],array[3],model.address];
        }
    } else if (array.count == 3) {
        if ([model.is_default intValue] == 1) {
            self.addressStr = [NSString stringWithFormat:@"[默认]%@%@%@%@",array[0],array[1],array[2],model.address];
        } else {
            self.addressStr = [NSString stringWithFormat:@"%@%@%@%@",array[0],array[1],array[2],model.address];
        }
    } else if (array.count == 2) {
        if ([model.is_default intValue] == 1) {
            self.addressStr = [NSString stringWithFormat:@"[默认]%@%@%@",array[0],array[1],model.address];
        } else {
            self.addressStr = [NSString stringWithFormat:@"%@%@%@",array[0],array[1],model.address];
        }
    }    
    if ([model.is_default intValue] == 1) {
        self.headImageView.image = [UIImage imageNamed:@"收货地址选中"];
        self.nameLabel.textColor = COLOR_ROSERED;
        self.addressLabel.textColor = COLOR_ROSERED;
        self.phoneLabel.textColor = COLOR_ROSERED;
    } else {
        self.headImageView.image = [UIImage imageNamed:@"收货地址未选中"];
        self.nameLabel.textColor = [UIColor blackColor];
        self.addressLabel.textColor = [UIColor blackColor];
        self.phoneLabel.textColor = [UIColor blackColor];
    }
    self.addressLabel.text = self.addressStr;
    self.nameLabel.text = model.consignee;
    self.phoneLabel.text = model.phone;
    
//    //fram = %@",NSStringFromCGRect(self.addressLabel.frame));
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
