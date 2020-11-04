//
//  TopselectView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TopselectView.h"
#import "TopicPublicModel.h"
#import "GlobalTool.h"
@implementation TopselectView
{
    TdetailsModel *detailModel;
}
- (instancetype)initWithFrame:(CGRect)frame WithNames:(NSArray *)nameArr pubIndex:(NSInteger)pubIndex Data:(TdetailsModel*)model;
{
    if(self = [super initWithFrame:frame])
    {
        detailModel = model;
        [self creatMainViewWithNames:nameArr pubIndex:pubIndex Data:model];
    }
    return self;
}

- (void)creatMainViewWithNames:(NSArray *)nameArr pubIndex:(NSInteger)pubIndex Data:(TdetailsModel*)model
{
    self.selectBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
    [self addSubview:self.selectBackView];
    
    //切换按钮
    CGFloat viewwith = kScreenWidth*0.66;
    CGFloat btnwidth = ZOOM6(180);
    CGFloat lineYY = 0;
    for(int i=0;i<nameArr.count;i++)
    {
        UIButton *shopbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shopbtn.frame = CGRectMake((viewwith/2-btnwidth)/2 + (viewwith/2)*i, ZOOM6(20), btnwidth, ZOOM6(40));
        [shopbtn setTitle:nameArr[i] forState:UIControlStateNormal];
        
        [shopbtn setTitleColor:RGBCOLOR_I(62, 62, 62) forState:UIControlStateNormal];
        shopbtn.tag = 3333+i;
        shopbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        [shopbtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectBackView addSubview:shopbtn];
        
        UILabel *shoplable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shopbtn.frame), CGRectGetMaxY(shopbtn.frame)+ZOOM6(10), btnwidth, ZOOM6(2))];
        shoplable.textColor = [UIColor clearColor];
        shoplable.tag = 4444+i;
        [self.selectBackView addSubview:shoplable];
        
        lineYY = CGRectGetMaxY(shoplable.frame);
        if(i==pubIndex)
        {
            [shopbtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            shopbtn.selected = YES;
            shoplable.backgroundColor = tarbarrossred;
        }
    }
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, lineYY, kScreenWidth, 1)];
    line.backgroundColor = RGBCOLOR_I(229, 229, 229);
    [self.selectBackView addSubview:line];
    
    //点赞
    CGFloat btnwith = kScreenWidth/3;
    self.fabulousBtn = [[UIButton alloc]init];
    self.fabulousBtn.frame=CGRectMake(btnwith*2+(btnwith-ZOOM6(160))/2,self.selectBackView.frame.size.height/2-ZOOM(60)/2,ZOOM6(160), ZOOM(60));
    self.fabulousBtn.imageEdgeInsets = UIEdgeInsetsMake(0,ZOOM6(10),0.0f,0);
    self.fabulousBtn.titleEdgeInsets = UIEdgeInsetsMake(0,ZOOM6(20),0.0f,0);
    self.fabulousBtn.selected=model.applaud_status;
    [self.fabulousBtn setImage:[UIImage imageNamed:@"topic_icon_xihuan"] forState:UIControlStateNormal];
    [self.fabulousBtn setImage:[UIImage imageNamed:@"topic_icon_xihuan_pre"] forState:UIControlStateSelected];
    self.fabulousBtn.selected==NO?[self.fabulousBtn setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal]:[self.fabulousBtn setTitleColor:tarbarrossred forState:UIControlStateSelected];
    self.fabulousBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.fabulousBtn setTitle:[NSString stringWithFormat:@"%d",(int)model.applaud_num] forState:UIControlStateNormal];
    self.fabulousBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.fabulousBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.fabulousBtn setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
    self.fabulousBtn.clipsToBounds=YES;
    self.fabulousBtn.tag=9999;
    self.fabulousBtn.layer.borderColor=kbackgrayColor.CGColor;
    [self.fabulousBtn addTarget:self action:@selector(fabulousclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBackView addSubview:self.fabulousBtn];

    //分割线
    CGFloat spacewith = kScreenWidth/3;
    for(int i =0; i<2;i++)
    {
        UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(spacewith*(i+1),(CGRectGetHeight(self.selectBackView.frame)-ZOOM6(40))/2, 1, ZOOM6(40))];
        linelabel.backgroundColor = RGBCOLOR_I(229, 229, 229);
        [self.selectBackView addSubview:linelabel];
    }

}

#pragma mark 全部评论 只看楼主 切换
- (void)click:(UIButton*)sender
{
    for(int i =0 ;i<2;i++)
    {
        UIButton *btn = (UIButton*)[self.selectBackView viewWithTag:3333+i];
        UILabel *lab = (UILabel*)[self.selectBackView viewWithTag:4444+i];
        
        if(btn.tag == sender.tag)
        {
            [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            lab.backgroundColor = tarbarrossred;
            
        }else{
            
            [btn setTitleColor:RGBCOLOR_I(62, 62, 62) forState:UIControlStateNormal];
            lab.backgroundColor = [UIColor clearColor];
        }
    }
    
    NSInteger tag = sender.tag-3333;
    if(self.selectBlock)
    {
        self.selectBlock(tag);
    }
}

- (void)fabulousclick:(UIButton*)sender
{
    int applaud_num = [self.fabulousBtn.titleLabel.text intValue];
       
    if(self.fabulousBlock)
    {
        self.fabulousBlock(applaud_num);
    }
}
@end
