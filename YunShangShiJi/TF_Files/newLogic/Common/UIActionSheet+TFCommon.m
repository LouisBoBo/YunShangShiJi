//
//  UIActionSheet+TFCommon.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/8/6.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UIActionSheet+TFCommon.h"
static const char sheetKey;
@implementation UIActionSheet (TFCommon)
- (void)showWithInView:(UIView *)view withBlock:(successBlock)block
{
    if (block && view) {
        objc_setAssociatedObject(self, &sheetKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.delegate = self;
    }
    [self showInView:view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    successBlock block = objc_getAssociatedObject(self, &sheetKey);
    block(buttonIndex);
}

@end
