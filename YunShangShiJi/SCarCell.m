//
//  SCarCell.m
//  YunShangShiJi
//
//  Created by yssj on 15/8/15.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SCarCell.h"
#import "GlobalTool.h"
#define firstFont [UIFont systemFontOfSize:ZOOM(46)]



@implementation SCarCell



- (void)awakeFromNib {
    
    CGFloat spaceHeight = ZOOM(35);
    // Initialization code
    self.title.textColor=kMainTitleColor;
    self.price.textColor=kMainTitleColor;
    self.brandLabel.textColor = kTextColor;
    self.brandLabel.backgroundColor = [UIColor clearColor];
    self.number.textColor=kTextColor;
    self.line.backgroundColor = kTextColor;
    self.shop_oldPrice.textColor = kTextColor;
    self.color_size.textColor = kTextColor;
    self.changeNum.layer.borderWidth = 1;
    self.changeNum.layer.borderColor = kbackgrayColor.CGColor;
    self.changeNumTextField.layer.borderWidth = 1;
    self.changeNumTextField.layer.borderColor = kbackgrayColor.CGColor;
    
    self.title.font=firstFont;
    self.color_size.font=[UIFont systemFontOfSize:ZOOM(44)];
    self.zeroTypeLabel.font=[UIFont systemFontOfSize:ZOOM(44)];
    self.shop_oldPrice.font=kFont6px(24);
    self.price.font=firstFont;
    self.brandLabel.font = kFont6px(24);
    self.number.font=[UIFont systemFontOfSize:ZOOM(44)];
    self.headimage.frame = CGRectMake(ZOOM(62), ZOOM(62), ZOOM(230),ZOOM(320));
    _title.frame=CGRectMake(_headimage.frame.origin.x+_headimage.frame.size.width+ZOOM(32), _headimage.frame.origin.y, _title.frame.size.width,ZOOM(50));
    
    self.color_size.frame=CGRectMake(_title.frame.origin.x, _title.frame.origin.y+_title.frame.size.height+spaceHeight, _color_size.frame.size.width, _title.frame.size.height);
//    _zeroTypeLabel.frame=CGRectMake(_title.frame.origin.x, _title.frame.origin.y+_title.frame.size.height+spaceHeight, _zeroTypeLabel.frame.size.width, _zeroTypeLabel.frame.size.height);
    NSString *string = @"超值套餐";
    CGSize size=[string boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(42)]} context:nil].size;
    
    self.zeroTypeLabel.frame=CGRectMake(self.title.frame.origin.x,  _title.frame.origin.y+_title.frame.size.height+spaceHeight, (int)size.width+5, (int)size.height+5);

    _price.frame=CGRectMake(_title.frame.origin.x, _color_size.frame.origin.y+_color_size.frame.size.height+spaceHeight, _price.frame.size.width,_title.frame.size.height);
   
   
    _shop_oldPrice.frame=CGRectMake(_price.frame.origin.x+_price.frame.size.width+10, _price.frame.origin.y, _shop_oldPrice.frame.size.width, _title.frame.size.height);
   
        _brandLabel.frame = CGRectMake(CGRectGetWidth(self.frame)-ZOOM6(300)-ZOOM(42), CGRectGetMinY(_shop_oldPrice.frame),ZOOM6(300), CGRectGetHeight(_shop_oldPrice.frame));
    _minusBtn.frame=CGRectMake(_title.frame.origin.x,CGRectGetMaxY(_headimage.frame)-_minusBtn.frame.size.height, _minusBtn.frame.size.width, _minusBtn.frame.size.height);
    _changeNum.frame=CGRectMake(_minusBtn.frame.origin.x+_minusBtn.frame.size.width+3, _minusBtn.frame.origin.y, _changeNum.frame.size.width, _changeNum.frame.size.height);
    _changeNumTextField.frame=CGRectMake(_minusBtn.frame.origin.x+_minusBtn.frame.size.width+3, _minusBtn.frame.origin.y, _changeNum.frame.size.width, _changeNum.frame.size.height);
    _plusBtn.frame=CGRectMake(_changeNum.frame.origin.x+_changeNum.frame.size.width+3, _minusBtn.frame.origin.y, _plusBtn.frame.size.width, _plusBtn.frame.size.height);

    self.line.frame = CGRectMake(self.shop_oldPrice.frame.origin.x, self.shop_oldPrice.frame.origin.y+_shop_oldPrice.frame.size.height/2, _line.frame.size.width, self.line.frame.size.height);

    self.number.frame = CGRectMake(self.frame.size.width- self.number.frame.size.width - ZOOM(42), _title.frame.origin.y, self.number.frame.size.width, self.number.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    // Configure the view for the selected state
}

@end
