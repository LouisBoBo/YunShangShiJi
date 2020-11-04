//
//  WelcomeView.h
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseView.h"
#import "HYJGuideView.h"

@interface TFWelcomeView : TFBaseView

@property (nonatomic, copy)void (^welcomeBlock)();
//@property (nonatomic, copy)void (^loginBlock)(NSNumber *index);

@end
