//
//  Animation.h
//  YunShangShiJi
//
//  Created by hyj on 15/8/18.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalTool.h"
 


@interface Animation : NSObject


+ (Animation *) shareAnimation;

-(void)createAnimationAt:(UIView *)view;
-(void)CreateAnimationAt:(UIView *)view;
- (void)stopAnimationAt:(UIView *)View;

@end
