//
//  FindPasswordViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PooCodeView.h"
#import "TFBaseViewController.h"
@interface FindPasswordViewController : TFBaseViewController<UITextFieldDelegate>
//验证码
@property (nonatomic, retain) UITextField *input;
@property (nonatomic, retain) PooCodeView *codeView;
@end
