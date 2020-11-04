//
//  CircleTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "CircleTableViewCell.h"
#import "GlobalTool.h"
#import "UIImageView+WebCache.h"
@implementation CircleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.addcircle.contentMode = UIViewContentModeScaleAspectFit;
    self.content.font=[UIFont systemFontOfSize:ZOOM(44)];
    self.title.font=[UIFont systemFontOfSize:ZOOM(46)];
    self.headimage.frame=CGRectMake(ZOOM(62), self.headimage.frame.origin.y, self.headimage.frame.size.width, self.headimage.frame.size.height);
    
    self.title.frame = CGRectMake(self.title.frame.origin.x, self.title.frame.origin.y, self.title.frame.size.width, self.title.frame.size.height);
}

-(void)refreshData:(ForumModel*)model
{
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]]placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
    
//    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.pic]];
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.pic]];
    if ([model.pic hasPrefix:@"http://"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]];
    }
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headimage.image = image;
        }
    }];
    
    self.headimage.clipsToBounds=YES;
    self.headimage.layer.cornerRadius=self.headimage.frame.size.width/2;
    

    self.content.text=model.content;
    self.content.textColor=kTextColor;
    self.content.font = [UIFont systemFontOfSize:ZOOM(37)];
    


    self.title.textColor = tarbarrossred;
    self.title.font = [UIFont systemFontOfSize:ZOOM(37)];
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  今日:%@",model.title,model.day_count]];
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@" "].location);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(51)]} range:redRange];
    [self.title setAttributedText:noteStr];
   
    self.addcircle.frame = CGRectMake(kApplicationWidth -ZOOM(38) -IMGSIZEW(@"组-18")*0.8, (self.frame.size.height - IMGSIZEH(@"组-18")*0.8)/2, IMGSIZEW(@"组-18")*0.8, IMGSIZEH(@"组-18")*0.8);
    
    if(model.isNO.intValue==0)
    {
        CGFloat HHHH= kApplicationWidth -(ZOOM(38))-(IMGSIZEW(@"组-18")*0.8);
        
        self.addcircle.clipsToBounds=YES;
        
        [self.addcircle setBackgroundImage:[UIImage imageNamed:@"组-18"] forState:UIControlStateNormal];
        [self.addcircle addTarget:self action:@selector(addcircle:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (model.isNO.intValue==1)
    {
        self.addcircle.clipsToBounds=YES;
        
        
        [self.addcircle setBackgroundImage:[UIImage imageNamed:@"退出-1"] forState:UIControlStateNormal];
        
        [self.addcircle addTarget:self action:@selector(addcircle:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (model.isNO.intValue==2)
    {
        self.addcircle.hidden=YES;
    }
}

-(void)refreshData1:(ForumModel*)model
{
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]]placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
    
//    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.pic]];
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.pic]];
    if ([model.pic hasPrefix:@"http://"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]];
    }
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headimage.image = image;
        }
    }];

    self.headimage.frame =CGRectMake(ZOOM(40), self.headimage.frame.origin.y, self.headimage.frame.size.width, self.headimage.frame.size.height);
    
    self.title.frame = CGRectMake(self.title.frame.origin.x, 15, self.title.frame.size.width, self.title.frame.size.height);
    self.content.frame=CGRectMake(_content.frame.origin.x, CGRectGetMaxY(_title.frame), _content.frame.size.width, _content.frame.size.height);
    self.trendslab.frame=CGRectMake(self.trendslab.frame.origin.x, CGRectGetMaxY(_content.frame), _trendslab.frame.size.width, _trendslab.frame.size.height);
    self.funslab.frame=CGRectMake(_funslab.frame.origin.x, CGRectGetMaxY(_content.frame), _funslab.frame.size.width, _funslab.frame.size.height);
    
    self.headimage.clipsToBounds=YES;
    self.headimage.layer.cornerRadius=self.headimage.frame.size.width/2;
    
    NSString *nickname=model.nickname;
    if (model.nickname.length>8) {
        nickname=[nickname substringToIndex:8];
    }
    self.title.text=nickname;
    self.title.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.title.textColor = kTitleColor;
    
    
//    self.content.frame = CGRectMake(self.content.frame.origin.x, self.content.frame.origin.y, self.content.frame.size.width, self.content.frame.size.height);
    self.content.text = @"";
    if(![model.person_sign isKindOfClass:[NSNull class]])
    {
        self.content.text=[NSString stringWithFormat:@"%@",model.person_sign];
    }
    self.content.textColor=kTextColor;
    self.content.font = [UIFont systemFontOfSize:ZOOM(40)];
    
    UILabel *trendslable = [[UILabel alloc]initWithFrame:CGRectMake(self.content.frame.origin.x, CGRectGetMaxY(self.content.frame), ZOOM(300), 20)];
    self.trendslab.frame = trendslable.frame;
    
    self.trendslab.text = [NSString stringWithFormat:@"动态:%d",[model.news_count intValue]];
    self.trendslab.font = [UIFont systemFontOfSize:ZOOM(37)];
    self.trendslab.textColor = kTextColor;

    
    UILabel *funslable =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(trendslable.frame)+20, trendslable.frame.origin.y, ZOOM(300), 20)];
    self.funslab.frame = funslable.frame;
    
    self.funslab.text = [NSString stringWithFormat:@"粉丝:%d",[model.fans_count intValue]];
    self.funslab.font = [UIFont systemFontOfSize:ZOOM(37)];
    self.funslab.textColor = kTextColor;

    
    self.day_count.hidden = YES;
    
    self.addcircle.frame = CGRectMake(kApplicationWidth -ZOOM(38) -IMGSIZEW(@"组-18")*0.8, (self.frame.size.height - IMGSIZEH(@"组-18")*0.8)/2, IMGSIZEW(@"组-18")*0.8, IMGSIZEH(@"组-18")*0.8);
    
    if(model.isNO.intValue==0)
    {
        [self.addcircle setBackgroundImage:[UIImage imageNamed:@"组-18"] forState:UIControlStateNormal];
        [self.addcircle addTarget:self action:@selector(addcircle:) forControlEvents:UIControlEventTouchUpInside];
    }else if (model.isNO.intValue==1)
    {
        self.addcircle.clipsToBounds=YES;
        [self.addcircle setBackgroundImage:[UIImage imageNamed:@"退出-1"] forState:UIControlStateNormal];
        [self.addcircle addTarget:self action:@selector(addcircle:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (model.isNO.intValue==2)
    {
        self.addcircle.hidden=YES;
    }

}

-(void)refreshData2:(ForumModel*)model
{
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]]placeholderImage:[UIImage imageNamed:@"默认头像.jpg"]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!180",[NSObject baseURLStr_Upy],model.pic]];
    if ([model.pic hasPrefix:@"http://"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]];
    }
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            self.headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            self.headimage.image = image;
        }
    }];

    
    self.headimage.clipsToBounds=YES;
    self.headimage.layer.cornerRadius=self.headimage.frame.size.width/2;
    
    
    self.title.frame = CGRectMake(self.title.frame.origin.x, self.title.frame.origin.y, self.title.frame.size.width, self.title.frame.size.height);
    self.title.frame = CGRectMake(self.title.frame.origin.x, 15, self.title.frame.size.width, self.title.frame.size.height);
    self.content.frame=CGRectMake(_content.frame.origin.x, CGRectGetMaxY(_title.frame), _content.frame.size.width, _content.frame.size.height);
    self.trendslab.frame=CGRectMake(self.trendslab.frame.origin.x, CGRectGetMaxY(_content.frame), _trendslab.frame.size.width, _trendslab.frame.size.height);
    self.funslab.frame=CGRectMake(_funslab.frame.origin.x, CGRectGetMaxY(_content.frame), _funslab.frame.size.width, _funslab.frame.size.height);
    
    self.title.text=model.title;
    self.title.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.title.textColor = kTitleColor;
    
    
//    self.content.frame = CGRectMake(self.content.frame.origin.x, self.content.frame.origin.y, self.content.frame.size.width, self.content.frame.size.height);
    self.content.text=model.content;
    self.content.textColor=kTextColor;
    self.content.font = [UIFont systemFontOfSize:ZOOM(40)];
    
    UILabel *trendslable = [[UILabel alloc]initWithFrame:CGRectMake(self.content.frame.origin.x, CGRectGetMaxY(self.content.frame), ZOOM(300), 20)];
    
    self.trendslab.frame = trendslable.frame;
    self.trendslab.text = [NSString stringWithFormat:@"动态:%@",model.n_count];
    self.trendslab.font = [UIFont systemFontOfSize:ZOOM(37)];
    self.trendslab.textColor = kTextColor;
    

    
    UILabel *funslable =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(trendslable.frame)+20, trendslable.frame.origin.y, ZOOM(300), 20)];
    self.funslab.frame =funslable.frame;
    self.funslab.text = [NSString stringWithFormat:@"粉丝:%@",model.u_count];
    self.funslab.font = [UIFont systemFontOfSize:ZOOM(37)];
    self.funslab.textColor = kTextColor;
    

    
    self.day_count.hidden=YES;
    
    self.addcircle.frame = CGRectMake(kApplicationWidth -ZOOM(38) -IMGSIZEW(@"组-18")*0.8, (self.frame.size.height - IMGSIZEH(@"组-18")*0.8)/2, IMGSIZEW(@"组-18")*0.8, IMGSIZEH(@"组-18")*0.8);
   
        
    if(model.isNO.intValue==0)
    {
        [self.addcircle setBackgroundImage:[UIImage imageNamed:@"组-18"] forState:UIControlStateNormal];
        [self.addcircle addTarget:self action:@selector(addcircle:) forControlEvents:UIControlEventTouchUpInside];
    }else if (model.isNO.intValue==1)
    {
        self.addcircle.clipsToBounds=YES;
        [self.addcircle setBackgroundImage:[UIImage imageNamed:@"退出-1"] forState:UIControlStateNormal];
        [self.addcircle addTarget:self action:@selector(addcircle:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (model.isNO.intValue==2)
    {
        self.addcircle.hidden=YES;
    }

    
}


-(void)addcircle:(UIButton*)sender
{
    if(_delegate &&[_delegate respondsToSelector:@selector(Addcircle:)])
    {
        [_delegate Addcircle:_row];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
