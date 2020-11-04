//
//  TFWarningView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/7/22.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseView.h"

typedef void(^warningBlock)(NSString *flag);

@interface TFWarningView : TFBaseView


@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, copy)warningBlock block;

- (void)returnBlock:(warningBlock)block;


@end
