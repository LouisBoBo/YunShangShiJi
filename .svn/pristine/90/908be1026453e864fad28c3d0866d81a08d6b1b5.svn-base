//
//  FunsSuspensionView.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/9/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "FunsSuspensionView.h"
#import "GlobalTool.h"
@implementation FunsSuspensionView

- (instancetype)initWithFrame:(CGRect)frame HeadImageUrl:(NSString *)headImageurl NickName:(NSString *)nickname UserType:(int)type Money:(float)money MentionCount:(int)mentioncount
{
    if(self = [super initWithFrame:frame])
    {
        self.headImageurl = headImageurl;
        self.nickname = nickname;
        self.usertype = type;
        self.money = money;
        self.mentionCount = mentioncount;
        
        self.layer.cornerRadius = frame.size.height / 2;
        self.backgroundColor = RGBCOLOR_I(64, 73, 93);
        self.alpha = 0.9;
        
        [self creatMainView];
    }
    
    return self;
}

- (void)creatMainView
{
    UIImageView * headimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    headimage.image = [UIImage imageNamed:@""];
    headimage.layer.cornerRadius = self.frame.size.height / 2;
    headimage.clipsToBounds = YES;
    [self addSubview:headimage];
    
    UILabel *nicklabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(headimage.frame)+5, 0, self.frame.size.width-CGRectGetWidth(headimage.frame)-10, CGRectGetHeight(headimage.frame))];
    nicklabel.textColor = RGBCOLOR_I(255, 253, 253);
    nicklabel.text = @"";
    nicklabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
    [self addSubview:nicklabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(funsClick:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    //昵称
    NSString *nickname = @"";
    NSString *title = @"";
    NSString *pp = @"";

    if(self.usertype == 1)//粉丝
    {
        nickname = self.nickname;
        title = @"成为你的粉丝";
        
    }else if (self.usertype == 2)//奖励
    {
        nickname = self.nickname;
        title = @"获得分享额外奖励";
    
    }else if (self.usertype==3) {
        nickname = self.nickname;
        pp=[NSString stringWithFormat:@"%.2f",self.money];
        title = [NSString stringWithFormat:@"通过赚钱任务赚了%@元",pp];
    }else if (self.usertype==4)
    {
        nickname = self.nickname;
        pp=[NSString stringWithFormat:@"%.2f",self.money];
        title = [NSString stringWithFormat:@"获得提现额度%@元",pp];
    }
    else//虚拟
    {
        //头像
        NSString *tt = [NSString userHeadRandomProduce];
        self.headImageurl = [NSString stringWithFormat:@"defaultcommentimage/%@",tt];
        
        nickname  = [NSString userNameRandomProduce];
        pp=[NSString stringWithFormat:@"%.2f",arc4random()%78+20+(arc4random()%100)*0.05];
        NSArray *titleArr = @[[NSString stringWithFormat:@"通过赚钱任务赚了%@元",pp],[NSString stringWithFormat:@"分享美衣获得%@元额外奖励",pp],[NSString stringWithFormat:@"获得提现额度%@元",pp],[NSString stringWithFormat:@"获得提现额度%@元",pp]];
        title = titleArr[arc4random()%titleArr.count];
        
//        title = @"完成签到任务获得2元奖励";
//        pp = @"2";
//        if(self.mentionCount % 2 == 0)
//        {
//            NSArray * arr = @[@"2",@"4",@"7",@"10",@"12",@"15",@"18",@"20",@"23",@"28",@"30",@"32",@"35",@"37",@"40",@"45",@"53",@"65",@"78",@"80",@"90"];
//            int i = arc4random()% (arr.count-1);
//            title = [NSString stringWithFormat:@"分享美衣获得%@元额外奖励",arr[i]];
//            pp = arr[i];
//        }
        
    }
    
    nicklabel.text = [NSString stringWithFormat:@"%@%@",nickname,title];
    
    nicklabel.frame=CGRectMake(CGRectGetWidth(headimage.frame)+5, 0, [self getRowWidth:nicklabel.text fontSize:ZOOM6(28)] + self.frame.size.height + 20-CGRectGetWidth(headimage.frame)-10, CGRectGetHeight(headimage.frame));
    
    NSMutableAttributedString *noteStr ;
    if(nicklabel.text)
    {
        noteStr = [[NSMutableAttributedString alloc]initWithString:nicklabel.text];
    }
    
    [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(0, nickname.length)];
    
    NSRange range = [title rangeOfString:pp];
    if(range.length>0)
    {
        [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(range.location + nickname.length, range.length)];
    }
    [nicklabel setAttributedText:noteStr];

    if([self.headImageurl hasPrefix:@"http"])
    {
        [headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.headImageurl]]];
    }else{
        [headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.headImageurl]]];
    }

    [self setRemindIsShow:nicklabel.text];
}

- (void)funsClick:(UITapGestureRecognizer*)tap
{
    if(self.funsClickBlock)
    {
        self.funsClickBlock();
    }
}
#pragma mark 框显示
- (void)setRemindIsShow:(NSString*)titletext
{
    CGFloat width = [self getRowWidth:titletext fontSize:ZOOM6(28)] + self.frame.size.height + 20;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = CGRectMake(ZOOM(40), 105, width, ZOOM6(70));
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(setRemindIsHidden) withObject:nil afterDelay:3];
    }];

}

#pragma mark 框隐藏
- (void)setRemindIsHidden
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = CGRectMake(ZOOM(40)-kScreenWidth, 105, self.frame.size.width, ZOOM6(70));
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

-(CGFloat)getRowWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat width;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    else{
        
    }
    
    return width;
}
- (void)dealloc
{
    NSLog(@"释放了");
}
@end
