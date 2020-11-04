//
//  TFOldPaymentViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/14.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

@interface TFOldPaymentViewController : TFBaseViewController

@property (nonatomic, copy)NSString *oldPhone;
@property (nonatomic, copy)NSString *headTitle;
@property (nonatomic, copy)NSString *leftStr;
@property (nonatomic, copy)NSString *plaStr;
@property (nonatomic, copy)NSString *labelStr;
@property (nonatomic, assign)int index;


@property (nonatomic, strong)UITextField *inputField;
@property (nonatomic, strong)UILabel *titleLabel;


@end
