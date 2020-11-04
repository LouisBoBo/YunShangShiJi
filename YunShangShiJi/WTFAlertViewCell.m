//
//  WTFAlertViewCell.m
//  YunShangShiJi
//
//  Created by yssj on 16/5/19.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "WTFAlertViewCell.h"

@implementation WTFAlertViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor=[UIColor clearColor];
        backImgView = [[UIImageView alloc] init];
        backImgView.image = [UIImage imageNamed:@"红包_优惠券"];
//        backImgView.backgroundColor = [UIColor grayColor];
        [self addSubview:backImgView];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.font=[UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
    }
    return self;
}


- (void)setFrame:(CGRect)frame{
    super.frame = frame;

    backImgView.frame = CGRectMake(0,2, self.frame.size.width, self.frame.size.height-4);
    titleLabel.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)setDataSource:(NSString *)titleString
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@元抵用券",titleString]];
    NSRange redRange = NSMakeRange(1, [[noteStr string] rangeOfString:@"元"].location-1);
    [noteStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} range:redRange];
    [titleLabel setAttributedText:noteStr];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
