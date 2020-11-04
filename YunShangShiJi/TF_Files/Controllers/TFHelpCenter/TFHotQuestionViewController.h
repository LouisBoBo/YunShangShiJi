//
//  TFHotQuestionViewController.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/17.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "HelpCenterModel.h"
@interface TFHotQuestionViewController : TFBaseViewController

@property (nonatomic, copy  ) NSString        *titleStr;
@property (nonatomic, strong) HelpCenterModel *model;
@property (nonatomic, copy) NSString *typestring;
@end
