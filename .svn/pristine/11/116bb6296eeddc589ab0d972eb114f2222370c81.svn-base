//
//  UIButton+TFButton.m
//  YunShangShiJi
//
//  Created by 云商 on 16/3/4.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UIButton+TFButton.h"
#import <objc/runtime.h>

static char btnFlagChar;

@implementation UIButton (TFButton)


- (NSNumber *)btnFlag{
    return objc_getAssociatedObject(self, &btnFlagChar);
}

- (void)setBtnFlag:(NSNumber *)btnFlag
{
    objc_setAssociatedObject(self, &btnFlagChar, btnFlag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
