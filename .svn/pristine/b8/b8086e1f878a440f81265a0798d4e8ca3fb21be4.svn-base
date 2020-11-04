//
//  TopheaderView.m
//  TestStickHeader
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 liqi. All rights reserved.
//

#import "TopheaderView.h"
#import "TopicPublicModel.h"
#import "UIImageView+WebCache.h"
#import "TopicTagsModel.h"
#import "SqliteManager.h"
#import "GlobalTool.h"
#import "MyMD5.h"
@implementation TopheaderView
- (instancetype)initWithFrame:(CGRect)frame Data:(TdetailsModel *)model
{
    if(self = [super initWithFrame:frame])
    {
        self.model = model;
        [self creatMainView];
    }
    return self;
}

- (void)creatMainView
{
    self.headerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.headerBackView];
    
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), ZOOM6(30), ZOOM6(80), ZOOM6(80))];
    headImage.clipsToBounds = YES;
    NSURL *url = nil;
    if ([self.model.head_pic hasPrefix:@"http"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.head_pic]];
    } else {
        if ([self.model.head_pic hasPrefix:@"/"]) {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],[self.model.head_pic substringFromIndex:1]]];
        } else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.model.head_pic]];
        }
    }
    [headImage sd_setImageWithURL:url];
    headImage.layer.cornerRadius = CGRectGetWidth(headImage.frame)/2;
    [self.headerBackView addSubview:headImage];
    
    //加v
    if (!self.userVipIco) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ZOOM6(70),ZOOM6(80), ZOOM6(30), ZOOM6(30))];
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = ZOOM6(30) * 0.5;
        imageV.image = [UIImage imageNamed:@"V_red"];
        imageV.hidden=YES;
        [self.headerBackView addSubview:_userVipIco = imageV];
    }
    self.userVipIco.hidden=self.model.v_ident.integerValue==0;
    self.userVipIco.image=self.model.v_ident.integerValue==1?[UIImage imageNamed:@"V_red"]:[UIImage imageNamed:@"V_blue"];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+ZOOM6(20), ZOOM6(25), ZOOM6(400), ZOOM6(50))];
    titlelabel.textColor = RGBCOLOR_I(62, 62, 62);
    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    titlelabel.text = self.model.nickname;
    if (self.model.nickname.length>8) {
        titlelabel.text=[self.model.nickname substringToIndex:8];
    }
    [self.headerBackView addSubview:titlelabel];
    
    UILabel *timelabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(titlelabel.frame), CGRectGetMaxY(titlelabel.frame), ZOOM6(400), ZOOM6(30))];
    timelabel.textColor = RGBCOLOR_I(168, 168, 168);
    timelabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
    
    NSString *location = @"";
    if(self.model.location ==nil || [self.model.location isEqualToString:@""])
    {
        location = @"来自喵星";
    }else{
        if(self.model.location.length > 8 )
        {
            self.model.location = [self.model.location stringByReplacingOccurrencesOfString:@" " withString:@""];
            self.model.location = [NSString stringWithFormat:@"%@...",[self.model.location substringToIndex:8]];
        }
        location = self.model.location;
    }
//    NSString *date = [MyMD5 timeWithTimeIntervalString:self.model.send_time];
    NSString *date = [MyMD5 themecompareCurrentTime:self.model.send_time];
    if(!date)
    {
        date = [MyMD5 timeWithTimeIntervalString:self.model.send_time];
    }

    timelabel.text = [NSString stringWithFormat:@"%@   %@",location,date];
    [self.headerBackView addSubview:timelabel];
    
    self.followbutton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM6(180), ZOOM6(50), ZOOM6(160), ZOOM6(60))];
    self.followbutton.selected = self.model.attention_status==1?YES:NO;
    
    NSString *userid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];
    NSString *theme_user_id = [NSString stringWithFormat:@"%@",self.model.user_id];
    if([theme_user_id isEqualToString:userid])//是楼主
    {
        self.followbutton.selected = YES;
        self.followbutton.hidden = YES;
    }else{
        self.followbutton.hidden = NO;
    }
    [self.followbutton setImage:[UIImage imageNamed:@"topic_but_ygz"] forState:UIControlStateSelected];
    [self.followbutton setImage:[UIImage imageNamed:@"icon_+gzmy"] forState:UIControlStateNormal];
    [self.followbutton addTarget:self action:@selector(followClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerBackView addSubview:self.followbutton];
    
//    self.tagsArray = self.model.tagsArray;
//    CGFloat tagviewH = self.tagsArray.count>0?ZOOM6(60):0;
//    CGFloat tagviewY = self.tagsArray.count>0?ZOOM6(20):0;
//    self.tagsView = [[UIScrollView alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(headImage.frame)+tagviewY, kScreenWidth-2*ZOOM6(20), tagviewH)];
//    self.tagsView.userInteractionEnabled = YES;
//    self.tagsView.showsVerticalScrollIndicator = FALSE;
//    self.tagsView.showsHorizontalScrollIndicator = FALSE;
//
//    CGFloat btnwith = 0;
//    CGFloat YY = 0;
//    for(int i=0; i <self.tagsArray.count; i++)
//    {
//        TopicTagsModel *tagmodel = self.tagsArray[i];
//    
//        btnwith = tagmodel.width;
//        UIButton *tagbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        tagbtn.frame = CGRectMake(YY, 0, btnwith, ZOOM6(50));
//        tagbtn.tag = 90000+i;
//        tagbtn.layer.cornerRadius = 2;
//        
//        tagmodel.is_show?[tagbtn setBackgroundColor:RGBCOLOR_I(255, 239, 229)]:[tagbtn setBackgroundColor:RGBCOLOR_I(240, 240, 240)];
//        tagmodel.is_show? [tagbtn setTintColor:tarbarrossred]:[tagbtn setTintColor:RGBCOLOR_I(125, 125, 125)];
//        NSString *title = [NSString stringWithFormat:@"%@",tagmodel.title];
//        [tagbtn setTitle:title forState:UIControlStateNormal];
//        tagbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
//        [tagbtn addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.tagsView addSubview:tagbtn];
//        
//        YY +=btnwith+ZOOM6(20);
//    }
//    
//    self.tagsView.contentSize = CGSizeMake(YY, 0);
//    [self.headerBackView addSubview:self.tagsView];
    
//    NSString *title =@"";
//    if(self.model.title.length>0)
//    {
//        title = [NSString stringWithFormat:@"#%@# %@",self.model.title,self.model.content];
//    }else{
//        title = [NSString stringWithFormat:@"%@",self.model.content];
//    }
//    CGFloat labheigh = [self getRowHeight:title fontSize:ZOOM6(32)];
//    self.discriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(self.tagsView.frame), kScreenWidth-2*ZOOM6(20), labheigh)];
//    self.discriptionLabel.textColor = RGBCOLOR_I(62, 62, 62);
//    self.discriptionLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
//    self.discriptionLabel.text = title;
//    self.discriptionLabel.numberOfLines = 0;
//    [self.headerBackView addSubview:self.discriptionLabel];
//    
//    NSMutableAttributedString *mutab = [[NSMutableAttributedString alloc]initWithString:self.discriptionLabel.text];
//    if(self.model.title.length>0)
//    {
//        [mutab addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, self.model.title.length+2)];
//    }
//    [self.discriptionLabel setAttributedText:mutab];
}

- (void)tagClick:(UIButton*)sender
{
    NSInteger tag = sender.tag - 90000;
    kSelfWeak;
    if(self.tagBlock)
    {
        weakSelf.tagBlock (tag,sender.titleLabel.text);
    }
}
- (void)followClick:(UIButton*)sender
{
    NSInteger type =0;
    if(sender.selected)//取消关注
    {
        type = 2;
    }else{//关注
        type = 1;
    }
    kSelfWeak;
    if(self.followBlock)
    {
        weakSelf.followBlock(type);
    }
}

#pragma mark 获取文本高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM6(20), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    
    if(height < ZOOM6(50))
    {
        return  ZOOM6(50);
    }else{
        return height;
    }
    return 0;

}

@end
