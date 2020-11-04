//
//  FightIndianaPopView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/7/31.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "FightIndianaPopView.h"
#import "GlobalTool.h"
#import "IndianaPopModel.h"
#import "IndianPopTableViewCell.h"
#import "NavgationbarView.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.m"
#import "IndianaPublicModel.h"
#import "YFShareModel.h"
#define codeYY (kScreenHeight - ZOOM6(500))/2
#define CodeViewHeigh ZOOM6(500)

@implementation FightIndianaPopView
{
    CGFloat shareimageYY;
    CGFloat popViewHeigh;
    NSString *str3;
    NSString *str4;
    
    int changeCount;      //参与次数
    int dayShareCount;    //当天分享的次数
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
//        [self httpActivityRule];
        
        NSArray *rules = @[@"1、参加拼团且成功的用户，即可参与抽奖。",@"2、每个商品需要的团数不同。团数满后立即开奖。",@"3、成功组团后即得一个幸运号码，开奖时随机抽取一个号码中奖。",@"4、中奖团每人均可领取本奖品。活动结束后中奖商品3天内发货。"];
        [self.discriptionData addObjectsFromArray:rules];
        [self creaPopview];
    }
    
    return self;
}

- (void)creaPopview
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    [self addSubview:_SharePopview];
    
    //弹框最底层
    _shareInvitationBackView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(40), codeYY, kScreenWidth-ZOOM(40)*2, CodeViewHeigh)];
    [_SharePopview addSubview:_shareInvitationBackView];
    
    [_shareInvitationBackView addSubview:[self shareCodeView]];
    
    _shareInvitationBackView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _shareInvitationBackView.alpha = 0.5;
    _SharePopview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _shareInvitationBackView.transform = CGAffineTransformMakeScale(1, 1);
        _shareInvitationBackView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
    }];
}

//上弹框内容
- (UIView*)shareCodeView
{
    if(!_ShareInvitationCodeView)
    {
        _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(70), 0, CGRectGetWidth(_shareInvitationBackView.frame)-ZOOM6(70)*2, CodeViewHeigh)];
        _ShareInvitationCodeView.layer.cornerRadius = 5;
        _ShareInvitationCodeView.clipsToBounds = YES;
        _ShareInvitationCodeView.backgroundColor = [UIColor whiteColor];
        
        //标题
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(40), CGRectGetWidth(_ShareInvitationCodeView.frame), ZOOM6(60))];
        titlelabel.textColor = RGBCOLOR_I(62, 62, 62);
        titlelabel.text = @"活动规则";
        titlelabel.backgroundColor = [UIColor clearColor];
        titlelabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        titlelabel.textAlignment = NSTextAlignmentCenter;
        titlelabel.clipsToBounds = YES;
        titlelabel.userInteractionEnabled = YES;
        [_ShareInvitationCodeView addSubview:titlelabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
        [titlelabel addGestureRecognizer:tap];
        
        //关闭按钮
        CGFloat btnwidth = IMGSIZEW(@"TFWXWithdrawals_weixintixian_close_icon");
        _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _canclebtn.frame=CGRectMake(CGRectGetWidth(_ShareInvitationCodeView.frame)-btnwidth-ZOOM6(30), ZOOM6(30), btnwidth, btnwidth);
        [_canclebtn setImage:[UIImage imageNamed:@"TFWXWithdrawals_weixintixian_close_icon"] forState:UIControlStateNormal];
        _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
        _canclebtn.layer.cornerRadius=btnwidth/2;
        [_canclebtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [_ShareInvitationCodeView addSubview:_canclebtn];
        
        [_ShareInvitationCodeView addSubview:self.discriptionTableView];
    }
    return _ShareInvitationCodeView;
}


#pragma mark 夺宝规则
- (void)httpActivityRule
{
    NSString *url= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"responseObject = %@", responseObject);
        
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if(responseObject[@"ptdbgz"] != nil)
            {
                NSDictionary *dic2 = responseObject[@"ptdbgz"][@"text"];
                if(dic2 !=nil)
                {
                    if(dic2[@"t0"] != nil)
                    {
                        [self.discriptionData addObject:[NSString stringWithFormat:@"1、%@",dic2[@"t0"]]];
                    }
                    if(dic2[@"t1"] != nil)
                    {
                        [self.discriptionData addObject:[NSString stringWithFormat:@"2、%@",dic2[@"t1"]]];
                    }
                    if(dic2[@"t2"] != nil)
                    {
                        [self.discriptionData addObject:[NSString stringWithFormat:@"3、%@",dic2[@"t2"]]];
                    }
                    if(dic2[@"t3"] != nil)
                    {
                        [self.discriptionData addObject:[NSString stringWithFormat:@"4、%@",dic2[@"t3"]]];
                    }
                    if(dic2[@"t4"] != nil)
                    {
                        [self.discriptionData addObject:[NSString stringWithFormat:@"5、%@",dic2[@"t4"]]];
                    }
                    if(dic2[@"t5"] != nil)
                    {
                        [self.discriptionData addObject:[NSString stringWithFormat:@"6、%@",dic2[@"t5"]]];
                    }
                    
                    [self creaPopview];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (UITableView*)discriptionTableView
{
    if(_discriptionTableView == nil)
    {
        CGFloat imagewidth = CGRectGetWidth(_ShareInvitationCodeView.frame);
        CGFloat imageHeigh = CGRectGetHeight(_ShareInvitationCodeView.frame)-ZOOM6(150);
        
        _discriptionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ZOOM6(100), imagewidth, imageHeigh) style:UITableViewStylePlain];
        _discriptionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _discriptionTableView.scrollEnabled = YES;
        _discriptionTableView.delegate= self;
        _discriptionTableView.dataSource = self;
        [_ShareInvitationCodeView addSubview:_discriptionTableView];
    }
    return _discriptionTableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigh = 0;
    if(tableView == _discriptionTableView)
    {
        NSString *title = self.discriptionData[indexPath.row];
        heigh = [self getRowHeight:title fontSize:ZOOM6(26)]+ZOOM6(10);
    }
    return heigh;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _discriptionTableView)
    {
        return self.discriptionData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.discriptionData[indexPath.row];
    cell.textLabel.textColor = RGBCOLOR_I(125, 125, 125);
    cell.textLabel.font = [UIFont systemFontOfSize:ZOOM6(26)];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 关闭弹框
- (void)cancleClick
{
    [self remindViewHiden];
}
- (void)disapper
{
    if(self.tapHideMindBlock)
    {
        self.tapHideMindBlock();
    }
}
#pragma mark 弹框消失
- (void)remindViewHiden
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _shareInvitationBackView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _shareInvitationBackView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
    }];
}

#pragma mark 获取文字高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    text = [text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    //文字高度
    CGFloat height = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(_ShareInvitationCodeView.frame.size.width-2*ZOOM6(30), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    
    return height+ZOOM6(15);
}

- (NSMutableArray*)discriptionData
{
    if(_discriptionData == nil)
    {
        _discriptionData = [NSMutableArray array];
    }
    return _discriptionData;
}

@end
