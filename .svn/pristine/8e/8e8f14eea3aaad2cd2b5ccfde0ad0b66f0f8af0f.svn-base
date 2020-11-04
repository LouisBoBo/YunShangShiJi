//
//  GoldViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 16/10/8.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "GoldViewController.h"
#import "HYJIntelgralDetalViewController.h"
#import "GoldCouponsManager.h"
#import "GoldCouponModel.h"
#import "GlobalTool.h"
#import "NSDate+Helper.h"
#import "WXApi.h"

@interface GoldViewController ()<WXApiDelegate>

@end

@implementation GoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadView];
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    if([GoldCouponsManager goldcpManager].gold_is_open == YES)
    {
        //系统时间
        [NSDate systemCurrentTime:^(long long time) {
            
            if (time > 0) {
                _pubtime = 0;
                _nowtime = [NSString stringWithFormat:@"%lld",time];
                
                [self loadTime];
            }
        }];

    }
}
- (void)creatHeadView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"金币";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIButton* discriptionBtn=[[UIButton alloc]init];
    discriptionBtn.frame=CGRectMake(kApplicationWidth-ZOOM6(180), 23, ZOOM6(160), 40);
    discriptionBtn.centerY = View_CenterY(headview);
    [discriptionBtn setTitle:@"积分明细" forState:UIControlStateNormal];
    discriptionBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    discriptionBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(30)];
    [discriptionBtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    discriptionBtn.tag=1111;
    [discriptionBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:discriptionBtn];
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, headview.frame.size.height-1, headview.frame.size.width, 1)];
    hView.backgroundColor = RGBCOLOR_I(220,220,220);
    [headview addSubview:hView];
}

- (void)creatUI
{
    UIView *integralview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, ZOOM6(400))];
    UIImageView *integralimage = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(140)*1.43)/2, ZOOM6(60), ZOOM6(140)*1.43, ZOOM6(140))];
    integralimage.image = [UIImage imageNamed:@"icon_-jinbi_mingxi"];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(integralimage.frame)+ZOOM6(20), kScreenWidth-ZOOM6(20)*2, ZOOM6(30))];
    lab1.text = @"当前金币(个)";
    lab1.font = [UIFont systemFontOfSize:ZOOM6(28)];
    lab1.textColor = RGBCOLOR_I(62, 62, 62);
    lab1.textAlignment = NSTextAlignmentCenter;
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(lab1.frame)+ZOOM6(10), kScreenWidth-ZOOM6(20)*2, ZOOM6(72))];
    lab2.text = self.jifen;
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.font = [UIFont systemFontOfSize:ZOOM6(72)];
    lab2.textColor = tarbarrossred;
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetHeight(integralview.frame)-ZOOM6(60), kScreenWidth - ZOOM6(20)*2, ZOOM6(40))];
    lab3.textColor = tarbarrossred;
    lab3.font = [UIFont systemFontOfSize:ZOOM6(30)];
    lab3.text = @" ";
    lab3.textAlignment = NSTextAlignmentCenter;
    self.timerLab = lab3;
    
    [self.view addSubview:integralview];
    [integralview addSubview:integralimage];
    [integralview addSubview:lab1];
    [integralview addSubview:lab2];
    [integralview addSubview:lab3];
    
    
    //金币使用规则
    NSString *rule = @"金币使用规则：\n1.金币使用不限最低数量，1个金币就可开始抵用。最高每单可使用600金币。\n2.100金币=1元。\n3.金币为积分签到任务完成后奖励，有效期24小时，金币失效后积分恢复为原有数额。";
    CGFloat ruleHeigh = [self getRowHeight:rule fontSize:ZOOM6(36)];
    
    UILabel *rulelab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(30), CGRectGetMaxY(integralview.frame), kScreenWidth-ZOOM6(30)*2, ruleHeigh+ZOOM6(30))];
    rulelab.text = rule;
    rulelab.numberOfLines = 0;
    rulelab.textColor = RGBCOLOR_I(125, 125, 125);
    rulelab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    
    //lable的行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:rulelab.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:ZOOM6(10)];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [rulelab.text length])];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_I(62, 62, 62) range:NSMakeRange(0, 7)];
    [rulelab setAttributedText:attributedString1];
    
    [self.view addSubview:rulelab];
    
    //立即使用金币
    UIButton *goldbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goldbutton.frame = CGRectMake(ZOOM6(30), CGRectGetMaxY(rulelab.frame)+ZOOM6(20), kScreenWidth-2*ZOOM6(30), ZOOM6(88));
    goldbutton.backgroundColor = tarbarrossred;
    goldbutton.layer.cornerRadius = 5;
    goldbutton.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    [goldbutton setTitle:@"立即使用金币" forState:UIControlStateNormal];
    [goldbutton setTintColor:[UIColor whiteColor]];
    [goldbutton addTarget:self action:@selector(usegold) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goldbutton];
}

#pragma mark 积分明细
- (void)edit
{
    HYJIntelgralDetalViewController *vc = [[HYJIntelgralDetalViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.jifen = self.jifen;
    vc.index = 0;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark 使用金币
- (void)usegold
{
    MyLog(@"使用金币");
    
    Mtarbar.selectedIndex=0;
    [self.navigationController popToRootViewControllerAnimated:NO];

}

#pragma mark 金币开启倒计时
- (void)loadTime {
    
    [_mytimer invalidate];
    _mytimer = nil;

    _mytimer = [NSTimer weakTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];
    
}

#pragma mark 倒计时
- (void)timerFireMethod
{
    if(self.nowtime !=nil)
    {
        _pubtime ++;
    }
    
    NSString *endtime = [NSString stringWithFormat:@"%lld",[GoldCouponsManager goldcpManager].gold_end_date];
//    endtime = @"1476996009965";
    
    NSArray*timeArray= [MyMD5 timeCountDown:_mytimer Nowtime:_nowtime Endtime:endtime Count:_pubtime];
    
    NSString *timestr;
    if(timeArray.count)
    {
        if([timeArray[0] intValue]==0&&[timeArray[1] intValue]==0
           &&[timeArray[2] intValue]==0&&[timeArray[3] intValue]==0)
        {
            [_mytimer invalidate];
            _mytimer = nil;

            timestr = [NSString stringWithFormat:@"距离金币失效还剩： %@ 小时 %@ 分 %@ 秒",@"0",@"0",@"0"];
    
        }else{
            timestr = [NSString stringWithFormat:@"距离金币失效还剩： %@ 小时 %@ 分 %@ 秒",timeArray[1],timeArray[2],timeArray[3]];
        }
    }
    
    self.timerLab.text = timestr;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(40), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    
    return height;
}

- (void)dealloc
{
    [_mytimer invalidate];
    _mytimer = nil;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
