//
//  RawardTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/14.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "RawardTableViewCell.h"
#import "UIImageView+WebCache.m"
#import "GlobalTool.h"
@implementation RawardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headimg.clipsToBounds = YES;
    self.headimg.layer.cornerRadius = CGRectGetWidth(self.headimg.frame)/2;
    
//    self.titlename.font = [UIFont systemFontOfSize:ZOOM(28)];
    self.titlename.textColor = RGBCOLOR_I(125, 125, 125);
    
//    self.price.font = [UIFont systemFontOfSize:ZOOM(30)];
    self.price.textColor = tarbarrossred;
    self.price.textAlignment = NSTextAlignmentRight;
    
    self.titlename.font=kFont6px(25);
    self.price.font=kFont6px(25);
}

- (void)refreshData:(RawardModel*)model
{
    [model.headpic hasPrefix:@"http"]?[self.headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headpic]]]:[self.headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.headpic]]];
    
    self.titlename.text = model.title;
    
    if([model.title hasSuffix:@"提现额度"])
    {
        self.price.text = [NSString stringWithFormat:@"+%.1f元",[model.price floatValue]];
    }else{
        self.price.text = [NSString stringWithFormat:@"+%@豆",model.price];
    }
}
- (void)refreshOneyuanData:(RawardModel*)model;
{
    self.titlename.font=kFont6px(24);
    self.price.font=kFont6px(24);
    
    [model.headpic hasPrefix:@"http"]?[self.headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headpic]]]:[self.headimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.headpic]]];
    
    self.titlename.text = model.title;
    
//    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:self.titlename.text];
//    
//    [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(30)] range:NSMakeRange(5, text.length)];
//    [lab setAttributedText:mutable];
    
    self.price.text = [NSString stringWithFormat:@"原价%.1f元",model.price.floatValue];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
