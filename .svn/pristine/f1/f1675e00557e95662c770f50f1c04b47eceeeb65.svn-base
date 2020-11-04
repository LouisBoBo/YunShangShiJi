//
//  TFPayPasswordView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/15.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseView.h"

typedef void(^paySuccessBlock)(NSString *pwd);
typedef void(^payFailBlock)(NSString *error);


@interface TFPayPasswordView : TFBaseView <UITextFieldDelegate>
@property (nonatomic, strong)UIView *whiteView;
@property (nonatomic, strong)NSMutableArray *textFeildArr;

@property (nonatomic, strong)UITextField *pwdField;
@property (nonatomic, strong)UIButton *cancelBtn;
@property (nonatomic, strong)UIButton *okBtn;
@property (nonatomic, copy)NSString *pwd;

@property (nonatomic, copy)void (^dismissBlock)();
@property (nonatomic, copy)payFailBlock failBlock;
@property (nonatomic, copy)paySuccessBlock successBlock;

@property (nonatomic, strong)NSString *money;

- (void)returnPayResultSuccess:(paySuccessBlock)succssBlock withFail:(payFailBlock)failBlock withTitle:(NSString*)title;

@end
