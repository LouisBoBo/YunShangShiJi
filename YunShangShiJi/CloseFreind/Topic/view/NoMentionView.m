//
//  NoMentionView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/5/22.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "NoMentionView.h"
#import "GlobalTool.h"

#define viewheigh ZOOM6(300)
@implementation NoMentionView
- (instancetype)initWithFrame:(CGRect)frame Image:(NSString*)headImage Content:(NSString*)content;
{
    if(self = [super initWithFrame:frame])
    {
        [self creatMainView:headImage Content:content];
    }
    return self;
}

- (void)creatMainView:(NSString*)image Content:(NSString*)content
{

    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-ZOOM6(140))/2, (self.frame.size.height-ZOOM6(400))/2, ZOOM6(140), ZOOM6(140))];
    self.headImageView.image = [UIImage imageNamed:image];
    [self addSubview:self.headImageView];
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headImageView.frame)+ZOOM6(40), self.frame.size.width, ZOOM6(40))];
    self.contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
    self.contentLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.text = content;
    [self addSubview:self.contentLabel];
}
@end
