//
//  SmileView.h
//  YunShangShiJi
//
//  Created by yssj on 15/8/8.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmileView : UIView

@property(nonatomic,strong)UILabel *thanksLabel;
@property(nonatomic,strong)UILabel *remindLabel;
@property(nonatomic,strong)UIImageView *smileImg;

@property (nonatomic, copy)NSString *str;
@property (nonatomic, copy)NSString *str2;


- (void)addview:(UIView *)view;
@end
