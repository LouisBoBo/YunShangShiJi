//
//  UIButton+WTF.m
//  YunShangShiJi
//
//  Created by yssj on 16/6/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "UIButton+WTF.h"
#import <objc/runtime.h>

static char btnTextLabel;

@implementation UIButton (WTF)
-(void)setTextLabel:(UILabel *)textLabel
{
    objc_setAssociatedObject(self, &btnTextLabel, textLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UILabel *)textLabel
{
    UILabel *_textLabel=objc_getAssociatedObject(self, &btnTextLabel);
    if (!_textLabel) {
        _textLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _textLabel.textAlignment=NSTextAlignmentCenter;
        _textLabel.numberOfLines=2;
        _textLabel.textColor=[UIColor whiteColor];
         objc_setAssociatedObject(self, &btnTextLabel, _textLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:_textLabel];
    }
    return _textLabel;
}


@end
