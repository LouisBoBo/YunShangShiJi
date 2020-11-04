//
//  SignCell.m
//  YunShangShiJi
//
//  Created by yssj on 15/9/10.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SignCell.h"
#import "GlobalTool.h"

@implementation SignCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat HH = ZOOM(160);
        CGFloat H = ZOOM(67);
        CGFloat Margin = ZOOM(67);
        CGFloat Y = (HH-H)/2.0;
        
        _imgView = [[UIImageView alloc]init];
        _imgView.frame = CGRectMake(Margin, Y, H, H);
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        _name = [[UILabel alloc] init];
        _name.frame = CGRectMake(CGRectGetMaxX(_imgView.frame)+Margin, Y, ZOOM(600), H);
        _name.font = kFont6px(29);
        [self.contentView addSubview:_name];
        _detail = [[UILabel alloc] init];
        _detail.frame = CGRectMake(self.frame.size.width-30-ZOOM(200), Y, ZOOM(200), H);
        _detail.font = kFont6px(29);
        _detail.textAlignment=NSTextAlignmentRight;
        _detail.textColor=[UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0];
        [self.contentView addSubview:_detail];
    }
    return self;
}
-(void)setImg:(NSString *)img name:(NSString *)name detail:(NSString *)detail
{

    
    _imgView.image = [UIImage imageNamed:img];
    _name.text = [NSString stringWithFormat:@"%@",name];
    _detail.text = [NSString stringWithFormat:@"+%@",detail];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat HH = CGRectGetHeight(self.contentView.frame);
    CGFloat H = ZOOM(67);
    CGFloat Margin = ZOOM(67);
    CGFloat Y = (HH-H)/2.0;
    
    _imgView.frame = CGRectMake(Margin, Y, H, H);
    _name.frame = CGRectMake(CGRectGetMaxX(_imgView.frame)+Margin, Y, ZOOM(600), H);
    _detail.frame = CGRectMake(self.frame.size.width-40-ZOOM(200), Y, ZOOM(200), H);

}
@end
