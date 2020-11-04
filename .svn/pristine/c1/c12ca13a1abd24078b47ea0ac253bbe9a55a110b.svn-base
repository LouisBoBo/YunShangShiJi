//
//  CommentCell.m
//  YunShangShiJi
//
//  Created by yssj on 15/8/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "CommentCell.h"
#import "GlobalTool.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
    self.line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];

    
    _headImg.frame = CGRectMake(ZOOM(30), ZOOM(65),ZOOM(130), ZOOM(130));
    _ImgBtn.frame = CGRectMake(ZOOM(30), ZOOM(65),ZOOM(130), ZOOM(130));
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImg.frame)+ZOOM(39), CGRectGetMidY(_headImg.frame)-_nameLabel.frame.size.height/2, _nameLabel.frame.size.width, _nameLabel.frame.size.height);
    _commentLabel.frame = CGRectMake(_headImg.frame.origin.x, CGRectGetMaxY(_headImg.frame)+ZOOM(51), _commentLabel.frame.size.width, _commentLabel.frame.size.height);
    _timeLabel.frame = CGRectMake(kScreenWidth-150-ZOOM(32), CGRectGetMaxY(_headImg.frame)-_timeLabel.frame.size.height/2-5, 150, _timeLabel.frame.size.height);
    _rowLabel.frame = CGRectMake(_timeLabel.frame.origin.x, CGRectGetMinY(_timeLabel.frame)-_rowLabel.frame.size.height-5, 150, _rowLabel.frame.size.height);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    // Configure the view for the selected state
}

@end
