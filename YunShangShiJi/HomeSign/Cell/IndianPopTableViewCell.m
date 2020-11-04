//
//  IndianPopTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/6/29.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "IndianPopTableViewCell.h"
#import "GlobalTool.h"
@implementation IndianPopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLab.frame = CGRectMake(10, ZOOM6(25), CGRectGetWidth(self.titleLab.frame), ZOOM6(50));
    self.contentLab.frame = CGRectMake(self.contentLab.frame.origin.x, ZOOM6(25), CGRectGetWidth(self.contentLab.frame), ZOOM6(50));
}
- (void)refreshData:(IndianaPopModel*)model Max:(NSInteger)maxnumValue
{
    self.titleLab.text = model.title;
    self.titleLab.textColor = RGBCOLOR_I(62, 62, 62);
    self.titleLab.font = [UIFont systemFontOfSize:ZOOM6(28)];
    
    self.contentLab.textAlignment = NSTextAlignmentRight;
    self.contentLab.font = [UIFont systemFontOfSize:ZOOM6(28)];
    self.contentLab.text = model.content;
    self.contentLab.textColor = RGBCOLOR_I(62, 62, 62);
    
    if([self.titleLab.text isEqualToString:@"还需支付"])
    {
        self.contentLab.textColor = tarbarrossred;
    }
    if([self.titleLab.text isEqualToString:@"参与次数"])
    {
        self.contentLab.text = @"";
        self.contentLab.userInteractionEnabled = YES;
        
        [self.stepperView removeFromSuperview];
        self.stepperView = [[YFStepperView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.contentLab.frame)-kZoom6pt(100),0, kZoom6pt(100), kZoom6pt(25))];
        _stepperView.tag = 88888;
        _stepperView.minimumValue = 1;
        _stepperView.maximumValue = maxnumValue;
        _stepperView.stepValue = 1;
        _stepperView.value = model.content.intValue>1?model.content.intValue:1;
        [self.contentLab addSubview:self.stepperView];
    }
    if([self.contentLab.text isEqualToString:@"取消"])
    {
        self.contentLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentClick:)];
        [self.contentLab addGestureRecognizer:tap];
    }
}

#pragma mark - setter
- (void)setNumberBlock:(void (^)(NSInteger))numberBlock {
    _stepperView.valueChangeBlock = numberBlock;
}

- (void)contentClick:(UITapGestureRecognizer*)tap
{
    if(self.cancleBlock)
    {
        self.cancleBlock();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
