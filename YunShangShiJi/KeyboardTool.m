//
//  KeyboardTool.m
//  xibDemo
//
//  Created by 晓杰 on 14-11-13.
//  Copyright (c) 2014年 晓杰. All rights reserved.
//

#import "KeyboardTool.h"


@interface KeyboardTool ()




@end

@implementation KeyboardTool
+ (id)keyboardTool
{
        return [[NSBundle mainBundle] loadNibNamed:@"KeyboardTool" owner:nil options:nil][0];
}

//+(id)keyboardTool
//{
//    UIView *
//}


//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        UIToolbar *toolBar = [[UIToolbar alloc] init];
//        toolBar.frame = self.bounds;
//        [self addSubview:toolBar];
//        
//        UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
//        
//        
//        [toolBar addSubview:doneBarButtonItem];
//        
////        [toolBar ]
//        
//    }
//    return self;
//
//}

- (IBAction)done:(UIBarButtonItem *)sender {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        
        [self.delegate keyboardTool:self itemClick:KeyboardToolItemTypeDone];
    }
}
@end
