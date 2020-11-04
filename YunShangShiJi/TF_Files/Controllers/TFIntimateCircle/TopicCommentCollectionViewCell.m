//
//  TopicCommentCollectionViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/10.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TopicCommentCollectionViewCell.h"
#import "GlobalTool.h"
@implementation TopicCommentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, ZOOM6(40));
}

- (void)settitle:(CommetReplyModel*)model{
   
    if(model.send_nickname.length > 8)
    {
        model.send_nickname = [model.send_nickname substringToIndex:8];
    }

    if(model.receive_nickname != nil)
    {
        if(model.receive_nickname.length > 8)
        {
            model.receive_nickname = [model.receive_nickname substringToIndex:8];
        }
        self.titleLabel.text = [NSString stringWithFormat:@"%@回复%@：%@",model.send_nickname,model.receive_nickname,model.content];
    }else{
        self.titleLabel.text = [NSString stringWithFormat:@"%@：%@",model.send_nickname,model.content];
    }
    
    NSMutableAttributedString *noteStr ;
    if(self.titleLabel.text)
    {
        noteStr = [[NSMutableAttributedString alloc]initWithString:self.titleLabel.text];
    }
    NSString *str1;
    
    NSString *str2;
    
    if(model.send_nickname)
    {
        str1 =[NSString stringWithFormat:@"%@",model.send_nickname];
        str1.length>0?[noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, str1.length)]:nil;
        
        if(model.receive_nickname)
        {
            str2 =[NSString stringWithFormat:@"%@",model.receive_nickname];
            str2.length>0?[noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(str1.length+2, str2.length)]:nil;
        }
    }
    [self.titleLabel setAttributedText:noteStr];
    
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM6(20), 0, kScreenWidth-2*ZOOM6(20), ZOOM6(40))];
        _titleLabel.textColor = RGBCOLOR_I(125, 125, 125);
        _titleLabel.font = kFont6px(26);
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}



@end
