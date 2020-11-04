//
//  UIAlertView+TFCommon.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/13.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UIAlertView+TFCommon.h"
#import <objc/runtime.h>

static const char alertKey;
@implementation UIAlertView (TFCommon)
- (void)showWithBlock:(successBlock)block
{
    if (block)
    {
        objc_setAssociatedObject(self, &alertKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.delegate = self;
    }
    
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    successBlock block = objc_getAssociatedObject(self, &alertKey);
    
    block(buttonIndex);
}

@end
