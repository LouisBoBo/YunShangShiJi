//
//  CommentTableViewCell.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
#import "MyMD5.h"
@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)refreshData:(CommenModel*)model
{
//    [self.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.user_url]]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.user_url]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [self.headimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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

    
    self.username.text=[NSString stringWithFormat:@"%@",model.user_name];
    self.discription.text=[NSString stringWithFormat:@"%@",model.content];
    
    NSString *time=[MyMD5 getTimeToShowWithTimestamp:model.add_date];
    NSArray *timearr=[time componentsSeparatedByString:@" "];
    if(timearr.count)
    {
        self.time.text=[NSString stringWithFormat:@"%@",timearr[0]];
    }
    
    //评论级别
    switch (model.comment_type.intValue) {
        case 1:
            self.comment.text=@"好评";
            break;
        case 2:
            self.comment.text=@"中评";
            break;
        case 3:
            self.comment.text=@"差评";
            break;
   
        default:
            break;
    }
    
    //星级指数
    for(int i=0;i<5;i++)
    {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0+22*i, 0, 20, 20)];
        image.image=[UIImage imageNamed:@"评分_选中"];
        [self.startsview addSubview:image];
    }

    self.color.text=[NSString stringWithFormat:@"颜色：%@",model.shop_color];
    self.size.text=[NSString stringWithFormat:@"尺码：%@",model.shop_size];
    self.headimage.clipsToBounds=YES;
    self.headimage.layer.cornerRadius=15;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
