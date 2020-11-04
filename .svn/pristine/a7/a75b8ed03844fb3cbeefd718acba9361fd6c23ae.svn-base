//
//  TimeLineTableViewCell.m
//  UicollectionView
//
//  Created by apple on 15/3/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TimeLineTableViewCell.h"
#import "GlobalTool.h"
@implementation TimeLineTableViewCell
{
    CGRect _lableHeigh;
    CGFloat _rowHeigh;
}
- (void)awakeFromNib {
    
    self.backView.frame=CGRectMake(self.backView.frame.origin.x, self.backView.frame.origin.y, kApplicationWidth-70, self.backView.frame.size.height);
    self.name.textColor = kbackgrayColor;
    self.couunt.textColor = kbackgrayColor;
    self.DiscriiptionLable.textColor = kbackgrayColor;
    self.standLine.backgroundColor = lineGreyColor;
    self.standLine.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.5f);
}

-(void)refreshData:(FlowModel *)model
{
    CGRect frame=[self frame];
    //图片
    self.TitleImage.layer.cornerRadius=self.TitleImage.frame.size.width/2;
    [self.TitleImage.layer setMasksToBounds:YES];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *Data=[NSData dataWithContentsOfURL:[NSURL URLWithString:model.Image]];
        UIImage *image=[UIImage imageWithData:Data];
       
        if(Data!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.Image.frame=CGRectMake(self.Image.frame.origin.x, self.Image.frame.origin.y, image.size.width, image.size.height);
                [self.Image.layer setMasksToBounds:YES];
                self.TitleImage.image=image;
                self.Image.image=image;
                
            });
        }
    });
    
    dispatch_async(dispatch_get_main_queue(),^{
        
        //文字
        self.DiscriiptionLable.text=model.Title;
        self.DiscriiptionLable.font=[UIFont boldSystemFontOfSize:17];
        _rowHeigh=[self getRowHeight:model.Title];
        self.DiscriiptionLable.frame=CGRectMake(self.DiscriiptionLable.frame.origin.x,self.Image.frame.origin.y+self.Image.frame.size.height+20, self.DiscriiptionLable.frame.size.width, _rowHeigh+30);
    });
    
    
    
    
    frame.size.height=self.DiscriiptionLable.frame.origin.y+ _rowHeigh+150;
    self.frame=frame;
    
    self.titlename.font = [UIFont systemFontOfSize:ZOOM(46)];
    self.circlename.font = [UIFont systemFontOfSize:ZOOM(40)];
    self.DiscriiptionLable.font = [UIFont systemFontOfSize:ZOOM(37)];
    
}
-(CGFloat)getRowHeight:(NSString *)text
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(230, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    return height;
}
-(CGFloat)getRowHeight:(NSString *)text andImage:(FlowModel*)model
{
    //取得图片的高度
    CGRect imageheigh;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *Data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model]]];
        UIImage *image=[UIImage imageWithData:Data];
        [self.Image.layer setMasksToBounds:YES];
        if(Data!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.Image.frame=CGRectMake(self.Image.frame.origin.x, self.Image.frame.origin.y, image.size.width, image.size.height);
                self.TitleImage.image=image;
                self.Image.image=image;
            });
        }
        
    });
    imageheigh=self.Image.frame;

    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(230, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }

    return imageheigh.size.height+height+150;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
