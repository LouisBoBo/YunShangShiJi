//
//  SalePurchaseHeadCell.h
//  YunShangShiJi
//
//  Created by 云商 on 15/12/11.
//  Copyright © 2015年 ios-1. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "TFTableViewBaseCell.h"

@interface SalePurchaseHeadCell : TFTableViewBaseCell

@property (nonatomic, copy)NSString *type;
@property (weak, nonatomic) IBOutlet UIView *headLine;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *S_Top_imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *S_Bot_imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_leftBtn;

@end
