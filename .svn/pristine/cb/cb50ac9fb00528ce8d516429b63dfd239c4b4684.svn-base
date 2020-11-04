//
//  YFDPCollectionCell.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFDPCollectionCell.h"
#import "GlobalTool.h"

@implementation YFDPCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        _imgView.backgroundColor = lineGreyColor;
        _imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        [self.contentView addSubview:_imgView];
        
        CGFloat txteHeight = [NSString heightWithString:@"高" font:[UIFont systemFontOfSize:ZOOMPT(11)] constrainedToWidth:100];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imgView.frame.size.height + ZOOMPT(13), frame.size.width, txteHeight)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithWhite:62.0/255 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:kZoom6pt(11)];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
        [self.contentView addSubview:_titleLabel];
        
        UIImageView* mengcengImageView = [[UIImageView alloc] init];
        mengcengImageView.frame = CGRectMake(0, _imgView.frame.size.height - txteHeight-kZoom6pt(20), frame.size.width, txteHeight+kZoom6pt(20));
        UIImage *image = [UIImage imageNamed:@"miyou_mengceng"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        mengcengImageView.image = image;
        [_imgView addSubview:mengcengImageView];
        
        _suppLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, _imgView.frame.size.height - ZOOMPT(3) - txteHeight, frame.size.width-6, txteHeight)];
        _suppLabel.textAlignment = NSTextAlignmentCenter;
        _suppLabel.textColor = [UIColor whiteColor];
        _suppLabel.font = [UIFont systemFontOfSize:kZoom6pt(11)];
        [_imgView addSubview:_suppLabel];
        
        txteHeight = [NSString heightWithString:@"高" font:[UIFont systemFontOfSize:kZoom6pt(14)] constrainedToWidth:100];
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - txteHeight, frame.size.width, txteHeight)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0];
        _contentLabel.font = [UIFont systemFontOfSize:kZoom6pt(14)];
        [self.contentView addSubview:_contentLabel];

        if([DataManager sharedManager].is_OneYuan)
        {
            _fengqiangLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(_contentLabel.frame)-ZOOM6(140))/2, 0, ZOOM6(90), CGRectGetHeight(_contentLabel.frame))];
            _fengqiangLabel.backgroundColor = [UIColor whiteColor];
            _fengqiangLabel.font = [UIFont systemFontOfSize:kZoom6pt(12)];
            _fengqiangLabel.textAlignment = NSTextAlignmentCenter;
            _fengqiangLabel.layer.borderColor = [UIColor redColor].CGColor;
            _fengqiangLabel.layer.borderWidth = 1;
            _fengqiangLabel.clipsToBounds = YES;
            _fengqiangLabel.layer.cornerRadius = 5;
            _fengqiangLabel.text = @"疯抢价";
            _fengqiangLabel.textColor = [UIColor redColor];
            [_contentLabel addSubview:_fengqiangLabel];
            
            _oneyuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_fengqiangLabel.frame), 0, ZOOM6(50), CGRectGetHeight(_contentLabel.frame))];
            _oneyuanLabel.backgroundColor = kWiteColor;
            _oneyuanLabel.font = [UIFont systemFontOfSize:kZoom6pt(12)];
            _oneyuanLabel.textAlignment = NSTextAlignmentRight;
            _oneyuanLabel.text = [NSString stringWithFormat:@"%.1f元",[DataManager sharedManager].app_value];
            
            _oneyuanLabel.textColor = [UIColor redColor];
            [_contentLabel addSubview:_oneyuanLabel];
        }
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
@end
