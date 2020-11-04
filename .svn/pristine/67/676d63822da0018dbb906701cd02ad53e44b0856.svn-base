//
//  YFStepperView.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFStepperView : UIView

@property(nonatomic) NSInteger value;          // 默认为0，范围在minimumValue/maximumValue之间
@property(nonatomic) NSInteger minimumValue;   // 默认为0，最大为maximumValue
@property(nonatomic) NSInteger maximumValue;   // 默认为100，最小为minimumValue
@property(nonatomic) NSInteger stepValue;      // 默认为1，最小大于0

@property(nonatomic, copy) void(^valueChangeBlock)(NSInteger value);

@end
