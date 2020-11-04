//
//  PersonalizedViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/9/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFBaseViewController.h"

@interface PersonalizedViewController :TFBaseViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *TextView;

@end
