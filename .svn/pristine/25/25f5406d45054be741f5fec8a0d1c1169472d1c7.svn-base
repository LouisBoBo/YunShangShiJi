//
//  TaskSharePopView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/7/31.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TaskSharePopView.h"
#import "GlobalTool.h"
#import "IndianaPopModel.h"
#import "IndianPopTableViewCell.h"
#import "NavgationbarView.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.m"
#import "IndianaPublicModel.h"
#import "YFShareModel.h"
#define codeYY (kScreenHeight - ZOOM6(960))/2
#define CodeViewHeigh ZOOM6(960)

@implementation TaskSharePopView
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
        [self creaPopview];
        [self creatData];
    }
    
    return self;
}

- (void)creatData
{
    [self shareData];
}
- (void)shareData
{
    self.tixianShareBtn.userInteractionEnabled = YES;
    //获取用户分享的次数及获得的提现额度
    self.shareMarkLab.text = [NSString stringWithFormat:@"%zd",[Signmanager SignManarer].everyShareCount-[Signmanager SignManarer].shareTixianCount];
    self.duobaaoMarkLab.text = [NSString stringWithFormat:@"%zd",[Signmanager SignManarer].takFinishCount-[Signmanager SignManarer].AlreadyFinishCount];
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
        _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(60), 0, CGRectGetWidth(_shareInvitationBackView.frame)-ZOOM6(60)*2, CodeViewHeigh)];
        _ShareInvitationCodeView.layer.cornerRadius = 5;
        _ShareInvitationCodeView.clipsToBounds = YES;
        _ShareInvitationCodeView.backgroundColor = [UIColor whiteColor];
        
        //标题
//        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(30), CGRectGetWidth(_ShareInvitationCodeView.frame), ZOOM6(50))];
//        titlelabel.textColor = RGBCOLOR_I(62, 62, 62);
//        titlelabel.text = @"活动详情";
//        titlelabel.backgroundColor = [UIColor clearColor];
//        titlelabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
//        titlelabel.textAlignment = NSTextAlignmentCenter;
//        titlelabel.clipsToBounds = YES;
//        titlelabel.userInteractionEnabled = YES;
//        [_ShareInvitationCodeView addSubview:titlelabel];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
//        [titlelabel addGestureRecognizer:tap];
        
        
        UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_ShareInvitationCodeView.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)/4)];
        headimage.image = [UIImage imageNamed:@"share_top_100"];
        [_ShareInvitationCodeView addSubview:headimage];
        headimage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
        [headimage addGestureRecognizer:tap];
        
        //关闭按钮
        CGFloat btnwidth = IMGSIZEW(@"invite_icon_close");
        _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _canclebtn.frame=CGRectMake(CGRectGetWidth(_ShareInvitationCodeView.frame)-btnwidth-ZOOM(30), ZOOM6(20), btnwidth, btnwidth);
        [_canclebtn setImage:[UIImage imageNamed:@"invite_icon_close"] forState:UIControlStateNormal];
        _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
        _canclebtn.layer.cornerRadius=btnwidth/2;
        [_canclebtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [_ShareInvitationCodeView addSubview:_canclebtn];
        
        [self creatRewardview];//弹框内容
        [self creatShareView];//分享平台
    }
    return _ShareInvitationCodeView;
}

#pragma mark 分享说明-1
- (void)creatRewardview
{
//    NSString *title = [NSString stringWithFormat:@"2.每分享%zd次微信群或好友（只可分享给不同群或好友，否则只记1次），即可得到%zd元钱提现额度。",[Signmanager SignManarer].everyShareCount,[Signmanager SignManarer].everyShareRaward];
    
    CGFloat money = [Signmanager SignManarer].takFinishCount*[Signmanager SignManarer].everyShareRaward;
    NSString *title = [NSString stringWithFormat:@"点下方分享按钮，分享%zd次美衣或赚钱小任务到微信群。任意从未来过衣蝠的新朋友点击后，每%zd人点击，你可得%zd元提现现金。今日%.2f元封顶。",[Signmanager SignManarer].takFinishCount,[Signmanager SignManarer].everyShareCount,[Signmanager SignManarer].everyShareRaward,money];
    
    NSArray *dataArr =@[@"1、分享赢提现任务可直接得提现现金哦。",title,@"3、你更可得到分享邀请来的新好友账户余额与提现成功金额25%的奖励。每位好友最高100元余额，50元提现。"];
    [self.discriptionData addObjectsFromArray:dataArr];
    
//    [self httpGetTixianShare];
    
    [_ShareInvitationCodeView addSubview:self.discriptionTableView];
}

#pragma mark 分享平台
- (void)creatShareView
{
    CGFloat with = CGRectGetWidth(_ShareInvitationCodeView.frame);
    CGFloat heigh = ZOOM6(180);
    CGFloat sharespace = (with-ZOOM6(150)*2)/3;
    CGFloat titlespace = (with-ZOOM6(150)*2)/3;
    self.shareview = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.discriptionTableView.frame)+ZOOM6(30), with, heigh)];
    
    //分享平台
    NSArray *imageArray = @[@"icon_weinxinqun",@"share_tixian_1元"];
    NSArray *titleArray = @[@"分享",@"去提现"];
    for (int i=0; i<titleArray.count; i++) {
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        shareBtn.frame = CGRectMake(sharespace + (ZOOM6(150)+sharespace)*i,0, ZOOM6(150), ZOOM6(100));
        shareBtn.tag = 9000+i;
        shareBtn.tintColor = [UIColor clearColor];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(25), 0, ZOOM6(100), ZOOM6(100))];
        imageview.image = [UIImage imageNamed:imageArray[i]];
        imageview.userInteractionEnabled = YES;
        [shareBtn addSubview:imageview];
        
        UILabel *marklab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(80), 0, ZOOM6(40), ZOOM6(40))];
        marklab.clipsToBounds = YES;
        marklab.backgroundColor = tarbarrossred;
        marklab.text = @"0";
        marklab.tag = 7000+i;
        marklab.textColor = [UIColor whiteColor];
        marklab.font = [UIFont systemFontOfSize:ZOOM6(24)];
        marklab.textAlignment = NSTextAlignmentCenter;
        marklab.layer.cornerRadius = CGRectGetHeight(marklab.frame)/2;
        
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        titleBtn.frame = CGRectMake(titlespace + (ZOOM6(150)+titlespace)*i,CGRectGetMaxY(shareBtn.frame)+ZOOM6(20), ZOOM6(150), ZOOM6(60));
        titleBtn.tag = 8000+i;
        titleBtn.layer.cornerRadius = 3;
        titleBtn.layer.borderWidth = 0.5;
        titleBtn.layer.borderColor = RGBCOLOR_I(255, 63, 139).CGColor;
        [titleBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:RGBCOLOR_I(255, 63, 139) forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
        
        if (i==0) {
            
            //判断设备是否安装微信
            if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                titleBtn.hidden=YES;
            }
            [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
            [titleBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
            self.tixianShareBtn = titleBtn;
            [imageview addSubview:self.shareMarkLab = marklab];
        }else if (i==1)
        {
            [shareBtn addTarget:self action:@selector(tixianClick:) forControlEvents:UIControlEventTouchUpInside];
            [titleBtn addTarget:self action:@selector(tixianClick:) forControlEvents:UIControlEventTouchUpInside];
            
            marklab.text = @"0";
            [imageview addSubview:self.duobaaoMarkLab = marklab];
        }
        
        [self.shareview addSubview:shareBtn];
        [self.shareview addSubview:titleBtn];
    }
    
    UILabel *bottomview = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shareview.frame)+ZOOM6(10), CGRectGetWidth(_ShareInvitationCodeView.frame), ZOOM6(100))];
    bottomview.textAlignment = NSTextAlignmentCenter;
    bottomview.text = @"分享到3个群后，\n拿到提现奖励的机率高达98%！";
    bottomview.numberOfLines = 0;
    bottomview.textColor = tarbarrossred;
    bottomview.font = [UIFont systemFontOfSize:ZOOM6(28)];
    
    [_ShareInvitationCodeView addSubview:self.shareview];
    [_ShareInvitationCodeView addSubview:bottomview];
}

#pragma mark 分享赢提现规则
- (void)httpGetTixianShare
{
    NSString *url= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"responseObject = %@", responseObject);
        
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if(responseObject[@"fxtx"] != nil)
            {
                if(responseObject[@"fxtx"][@"text"] !=nil)
                {
                    [self.discriptionData removeAllObjects];
                    if(responseObject[@"fxtx"][@"text"][@"t0"])
                    {
                        [self.discriptionData addObject:[NSString stringWithFormat:@"1.%@",responseObject[@"fxtx"][@"text"][@"t0"]]];
                    }
                    if(responseObject[@"fxtx"][@"text"][@"t1"])
                    {
                        NSString *text = [NSString stringWithFormat:@"2.%@",responseObject[@"fxtx"][@"text"][@"t1"]];
                        if(text.length > 0)
                        {
                            text = [text stringByReplacingOccurrencesOfString:@"10次" withString:[NSString stringWithFormat:@"%zd次",[Signmanager SignManarer].everyShareCount]];
                            text = [text stringByReplacingOccurrencesOfString:@"1元" withString:[NSString stringWithFormat:@"%zd元",[Signmanager SignManarer].everyShareRaward]];
                        }
                        
                        [self.discriptionData addObject:text];
                    }
                    if(responseObject[@"fxtx"][@"text"][@"t2"])
                    {
                        [self.discriptionData addObject:[NSString stringWithFormat:@"2.%@",responseObject[@"fxtx"][@"text"][@"t2"]]];
                    }
                    
                    for(int i=0; i<self.discriptionData.count; i++)
                    {
                        NSString *title = self.discriptionData[i];
                        popViewHeigh += ([self getRowHeight:title fontSize:ZOOM6(28)]+ZOOM6(10));
                    }
                    
                    _ShareInvitationCodeView.frame = CGRectMake(ZOOM6(70), 0, CGRectGetWidth(_shareInvitationBackView.frame)-ZOOM6(70)*2, popViewHeigh+ZOOM6(100)+ZOOM6(230));
                    _discriptionTableView.frame = CGRectMake(0, ZOOM6(80), CGRectGetWidth(_ShareInvitationCodeView.frame), CGRectGetHeight(_ShareInvitationCodeView.frame)-ZOOM6(280));
                    _shareview.frame = CGRectMake(0,CGRectGetHeight(_ShareInvitationCodeView.frame)-ZOOM6(230), CGRectGetWidth(_ShareInvitationCodeView.frame), ZOOM6(180));
                    [self.discriptionTableView reloadData];

                }
            }else{
                [MBProgressHUD show:@"获取数据异常" icon:nil view:self];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
- (UIView*)tabfootView
{
    CGFloat width = CGRectGetWidth(_ShareInvitationCodeView.frame);
    UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, width-2*ZOOM6(20), width/1.73)];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(footview.frame), CGRectGetHeight(footview.frame))];
    imageview.image = [UIImage imageNamed:@"biaoge-mini"];
    [footview addSubview:imageview];
    return footview;
}
- (UITableView*)discriptionTableView
{
    if(_discriptionTableView == nil)
    {
        CGFloat headheigh = CGRectGetWidth(_ShareInvitationCodeView.frame)/4+ZOOM6(20);
        CGFloat imagewidth = CGRectGetWidth(_ShareInvitationCodeView.frame);
        CGFloat imageHeigh = CGRectGetHeight(_ShareInvitationCodeView.frame)-headheigh-ZOOM6(340);
        
        _discriptionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headheigh, imagewidth, imageHeigh) style:UITableViewStylePlain];
        _discriptionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _discriptionTableView.scrollEnabled = YES;
        _discriptionTableView.delegate= self;
        _discriptionTableView.dataSource = self;
        _discriptionTableView.tableFooterView = [self tabfootView];
        [_ShareInvitationCodeView addSubview:_discriptionTableView];
        
//        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
//        _discriptionTableView.rowHeight = UITableViewAutomaticDimension;
//        _discriptionTableView.estimatedRowHeight = 30;

    }
    return _discriptionTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigh = 0;
    if(tableView == _discriptionTableView)
    {
        NSString *title = self.discriptionData[indexPath.row];
        heigh = [self getRowHeight:title fontSize:ZOOM6(28)];
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
    if(tableView == _discriptionTableView)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = self.discriptionData[indexPath.row];
        
        if(indexPath.row == 1)
        {
            cell.textLabel.textColor = tarbarrossred;
        }else{
            cell.textLabel.textColor = RGBCOLOR_I(125, 125, 125);
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:ZOOM6(26)];
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark 关闭弹框
- (void)cancleClick
{
    [self remindViewHiden];
}
#pragma mark 选择分享的平台
-(void)shareClick:(UIButton*)sender
{
    if(dayShareCount > [DataManager sharedManager].shareToDayNum)
    {
        [MBProgressHUD show:@"你当日的分享次数过于频繁，请48小时后再来分享。" icon:nil view:self];
        return;
    }
    if(sender.tag == 9000 || sender.tag == 8000)
    {
        if(self.weixinBlock)
        {
            self.weixinBlock();
        }
    }
}
#pragma mark 提现
- (void)tixianClick:(UIButton*)sender
{
    if(self.tixianBlock)
    {
        self.tixianBlock();
    }
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
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(_ShareInvitationCodeView.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
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

- (NSMutableArray*)RedcentData
{
    if(_RedcentData == nil)
    {
        _RedcentData = [NSMutableArray array];
    }
    return _RedcentData;
}
- (NSMutableArray*)duobaoData
{
    if(_duobaoData == nil)
    {
        _duobaoData = [NSMutableArray array];
    }
    return _duobaoData;
}

@end
