//
//  LoginViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/9.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PooCodeView.h"

typedef void(^loginBlock)();
typedef void(^registerBlock)();

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic ,assign)NSInteger tag;
@property(nonatomic, assign) int secondsCountDown;
@property(nonatomic, strong) NSTimer *countDownTimer;
@property(nonatomic, retain) NSString *filePath;
@property(nonatomic, copy) NSString *string;

@property (nonatomic, retain) PooCodeView *phoneCodeView;

@property (nonatomic, retain) PooCodeView *codeView;
@property (nonatomic, copy)loginBlock myLoginBlock;
@property (nonatomic, copy)registerBlock myRegisterBlock;

//商品分类 ///////////////
@property (nonatomic , strong)NSString *dir_level;//级别
@property (nonatomic , strong)NSString *type_id;
@property (nonatomic , strong)NSString *type_parent_id;
@property (nonatomic , strong)NSString *type_name;

//商品标签
@property (nonatomic , strong)NSString *tag_name;
@property (nonatomic , strong)NSString *tag_id;
@property (nonatomic , strong)NSString *tag_show;
@property (nonatomic , strong)NSString *tag_parent_id;

//商品属性
@property (nonatomic , strong)NSString *shuxing_id;
@property (nonatomic , strong)NSString *attr_name;
@property (nonatomic , strong)NSString *attr_Parent_id;
@property (nonatomic , strong)NSString *is_show;

//用户没登录状态
@property (nonatomic , strong)NSString *loginStatue;

- (void)returnClick:(loginBlock)myLogin withCloseBlock:(registerBlock)myRegister;

@end
