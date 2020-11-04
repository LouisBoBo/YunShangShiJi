//
//  HobbyCollectionFootView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "HobbyCollectionFootView.h"
#import "GlobalTool.h"

@implementation HobbyCollectionFootView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titlelab.textColor = RGBCOLOR_I(62, 62, 62);
    self.titlelab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    self.height.textColor = RGBCOLOR_I(62, 62, 62);
    self.height.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    self.weight.textColor = RGBCOLOR_I(62, 62, 62);
    self.weight.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    CGFloat btnwith = (kScreenWidth-45)/2;
    self.canclebtn.frame = CGRectMake(self.canclebtn.frame.origin.x, self.canclebtn.frame.origin.y, btnwith, self.canclebtn.frame.size.height);
    
    self.okbtn.frame = CGRectMake(CGRectGetMaxX(self.canclebtn.frame)+15, self.okbtn.frame.origin.y, btnwith, self.okbtn.frame.size.height);
}

- (void)refreshData
{
    self.heightinput.layer.cornerRadius = 5;
    self.heightinput.layer.borderWidth = 0.5;
    self.heightinput.layer.borderColor = RGBCOLOR_I(168, 168, 168).CGColor;
    
    self.heightTextFild.tag = 88888;
    self.heightTextFild.placeholder = @"100-200cm";
    self.heightTextFild.textColor = RGBCOLOR_I(62, 62, 62);
    self.heightTextFild.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.heightTextFild.keyboardType = UIKeyboardTypeDecimalPad;
   
    self.weightinput.layer.cornerRadius = 5;
    self.weightinput.layer.borderWidth = 0.5;
    self.weightinput.layer.borderColor = RGBCOLOR_I(168, 168, 168).CGColor;
    
    self.weightTextFild.tag = 99999;
    self.weightTextFild.placeholder = @"30-100KG";
    self.weightTextFild.textColor = RGBCOLOR_I(62, 62, 62);
    self.weightTextFild.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.weightTextFild.keyboardType = UIKeyboardTypeDecimalPad;
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin .y, kScreenWidth, 40);
    self.heightTextFild.inputAccessoryView = tool;
    self.weightTextFild.inputAccessoryView = tool;
    
    //取消按钮
    self.canclebtn.layer.borderWidth = 1;
    self.canclebtn.layer.cornerRadius= 5;
    self.canclebtn.layer.borderColor = tarbarrossred.CGColor;
    [self.canclebtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
    self.canclebtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [self.canclebtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    
    //确认按钮
    self.okbtn.layer.cornerRadius= 5;
    [self.okbtn setBackgroundColor:tarbarrossred];
    [self.okbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.okbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    [self.okbtn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 键盘
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if (itemType == KeyboardToolItemTypePrevious) { // 上一个
        //----上一个----");
    } else if (itemType == KeyboardToolItemTypeNext) { // 下一个
        //----下一个----");
    } else { // 完成
        //----完成----");
        [self endEditing:YES];
    }
}

//取消
- (void)cancle:(UIButton*)sender
{
    if(self.cancleBlock)
    {
        self.cancleBlock();
    }
}
//确认
- (void)ok:(UIButton*)sender
{
    if(self.okBlock)
    {
        self.okBlock();
    }
}

@end
