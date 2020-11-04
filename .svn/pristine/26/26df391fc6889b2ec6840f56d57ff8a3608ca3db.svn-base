//
//  NavgationbarView.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/9.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface NavgationbarView : NSObject

@property (nonatomic, strong)UIView *headView;

-(void)creatView;

//弹出提示框
- (void)timerFireMethod:(NSTimer*)theTimer;//弹出框
- (void)showAlert:(NSString *) _message;
-(void)showLable:(NSString *)_message Controller:(UIViewController*)coller;
-(void)disapperlable;


+ (NavgationbarView *)shared;
+ (void)showMessageAndHide:(NSString *)message backgroundVisiable:(BOOL)visiable;
+ (void)showMessageAndHide:(NSString *)message;
+ (void)showMessage:(NSString *)message;
+ (void)dismiss;

@end
