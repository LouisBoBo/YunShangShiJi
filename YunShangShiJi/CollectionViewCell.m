//
//  CollectionViewCell.m
//  UiTabBarController
//
//  Created by apple on 15/3/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
@implementation CollectionViewCell

- (void)awakeFromNib {
    self.titleImage.frame=CGRectMake(0, self.titleImage.frame.origin.y, kApplicationWidth/2-15/2, self.titleImage.frame.size.height);
    
}
-(id)initWithFrame:(CGRect)frame
{   self = [super initWithFrame:frame];
    if (self)
    {
       
//        [self setImage];
//        [self setlable];
    }
    return self;

}

-(void)setImage
{
//    self.titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    self.titleImage.layer.cornerRadius = 5;
    self.titleImage.layer.masksToBounds = YES;
    self.titleImage.layer.borderColor = [UIColor brownColor].CGColor;
    self.titleImage.layer.borderWidth = 2;
    self.titleImage.backgroundColor = [UIColor greenColor];
    [self addSubview:self.titleImage];

}
-(void)setlable
{
//    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    self.title.layer.cornerRadius = 5;
    self.title.layer.masksToBounds = YES;
    self.title.layer.borderColor = [UIColor whiteColor].CGColor;
    self.title.layer.borderWidth = 1;
    self.title.textColor = [UIColor whiteColor];
    self.title.backgroundColor = [UIColor clearColor];
    [self addSubview:self.title];

}
-(void)creashData:(ShopDetailModel*)model
{
#if 0
    [self.layer setMasksToBounds:YES];

               //GCD加载图片
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.def_pic]]];
    
    CGFloat imgwidh;
    CGFloat imgheigh;
    
    NSString *str=model.def_pic;
    str=[str substringToIndex:[str length]-4];
    NSArray *arr=[str componentsSeparatedByString:@"_"];
    if(arr.count)
    {
        imgheigh=[arr[1] floatValue];
        imgwidh=[arr[2] floatValue];
    }
    
    CGFloat f=imgwidh/imgheigh;
    
    self.titleImage.frame=CGRectMake(0, 0, self.titleImage.frame.size.width, self.titleImage.frame.size.width/f);
            
    self.titleImage.layer.cornerRadius=5;
    self.titleImage.layer.masksToBounds = YES;
    self.titleImage.layer.borderColor = [UIColor brownColor].CGColor;
    self.titleImage.layer.borderWidth = 1;

    //文字
    self.title.text=model.shop_name;
    self.title.numberOfLines=0;
    self.title.font=[UIFont systemFontOfSize:15];
    
    CGFloat titleHeigh=0;
    titleHeigh=[self getRowHeight:self.title.text];
    self.title.frame=CGRectMake(0, self.titleImage.frame.origin.y+self.titleImage.frame.size.height+5, 145, titleHeigh);

    //价格
    self.shopprice.text=[NSString stringWithFormat:@"￥%.2f",[model.shop_se_price floatValue]];
    self.shopprice.frame=CGRectMake(0, self.title.frame.origin.y+self.title.frame.size.height, self.shopprice.frame.size.width, 25);
    
    //喜欢数
    self.lovenumber.text=[NSString stringWithFormat:@"%@",model.love_num];
    self.lovenumber.frame=CGRectMake(self.lovenumber.frame.origin.x, self.title.frame.origin.y+self.title.frame.size.height, self.lovenumber.frame.size.width, 25);

    
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.titleImage.frame.size.height+5+self.title.frame.size.height+25);
    
#endif
    
    self.overhead.hidden=NO;
    [self.overhead setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option@2x"] forState:UIControlStateNormal];

//    [self.overhead setBackgroundColor:tarbarrossred];
//    [self.overhead setTitle:@"删除" forState:UIControlStateNormal];
//    self.overhead.titleLabel.font=[UIFont systemFontOfSize:13];
//    [self.overhead setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.overhead.clipsToBounds=YES;
    self.overhead.layer.cornerRadius=15;
    [self.overhead addTarget:self action:@selector(overheadclick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)creashData1:(ShopDetailModel*)model
{
    self.overhead.hidden=YES;
    [self.overhead setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
}
-(void)overheadclick:(UIButton*)sender
{
    if(_delegate &&[_delegate respondsToSelector:@selector(Overhead:)])
    {
        [_delegate Overhead:_row];
    }

}


-(CGFloat)getRowHeight:(NSString *)text
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(230, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    return height;
}

@end
