//
//  YFStepperView.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFStepperView.h"
#import "GlobalTool.h"
#import "MBProgressHUD+NJ.h"

@implementation YFStepperView
{
    UILabel *titleLabel;
    UIButton *incrementBtn;
    UIButton *decrementBtn;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        incrementBtn = [self buttonWithImg:@"icon_jian" sImg:@"icon_jian_disable" tag:2001];
        decrementBtn = [self buttonWithImg:@"icon_jia" sImg:@"" tag:2002];
        titleLabel = [self labelWithString:@"20" color:[UIColor colorWithWhite:62/255. alpha:1.]];
        titleLabel.font = [UIFont systemFontOfSize:kZoom6pt(15)];
        [self addSubview:incrementBtn];
        [self addSubview:decrementBtn];
        [self addSubview:titleLabel];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor colorWithWhite:168/255. alpha:1.].CGColor;
        self.minimumValue = 0;
        self.maximumValue = 100;
        self.stepValue = 1;
        self.value = 0;
    }
    return self;
}

- (UILabel *)labelWithString:(NSString *)string color:(UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.borderWidth = 0.5f;
    label.layer.borderColor = [UIColor colorWithWhite:168/255. alpha:1.].CGColor;
    label.text = string;
    return label;
}

- (UIButton *)buttonWithImg:(NSString *)imgName sImg:(NSString *)sImgName tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal|UIControlStateHighlighted];
    if (sImgName.length) {
        [btn setImage:[UIImage imageNamed:sImgName] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:sImgName] forState:UIControlStateSelected|UIControlStateHighlighted];
    }
    btn.tag = tag;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    incrementBtn.frame = CGRectMake(0, 0, height, height);
    titleLabel.frame = CGRectMake(height, 0, width - height*2, height);
    decrementBtn.frame = CGRectMake(width - height, 0, height, height);
}

- (void)click:(UIButton *)sender {
    switch (sender.tag) {
        case 2001:
            if (!sender.selected) {
                self.value -= self.stepValue;
            }
            break;
        case 2002:
            if (!sender.selected) {
                self.value += self.stepValue;
                if (self.value >= self.maximumValue) {
                    self.tag !=88888?[MBProgressHUD show:@"已是最大库存" icon:nil view:nil]:nil;
                }
            }
            break;
        default:
            break;
    }
    if (_valueChangeBlock) {
        _valueChangeBlock(self.value);
    }
}

- (void)setValue:(NSInteger)value {
    _value = value;
    titleLabel.text = [NSString stringWithFormat:@"%ld",(long)_value];
    incrementBtn.selected = NO;
    incrementBtn.userInteractionEnabled = YES;
    decrementBtn.selected = NO;
    decrementBtn.userInteractionEnabled = YES;
    if (_value <= _minimumValue) {
        incrementBtn.selected = YES;
        incrementBtn.userInteractionEnabled = NO;
    }
    
    if (_value >= _maximumValue) {
        decrementBtn.selected = YES;
        decrementBtn.userInteractionEnabled = YES;
    }
}

- (void)setMinimumValue:(NSInteger)minimumValue {
    _minimumValue = minimumValue;
    if (_value < minimumValue) {
        _value = minimumValue;
    }
    [self setValue:_value];
}

- (void)setMaximumValue:(NSInteger)maximumValue {
    _maximumValue = maximumValue;
    if (_value > maximumValue) {
        _value = maximumValue;
    }
    [self setValue:_value];
}

- (void)setStepValue:(NSInteger)stepValue {
    _stepValue = stepValue;
    [self setValue:_value];
}

@end
