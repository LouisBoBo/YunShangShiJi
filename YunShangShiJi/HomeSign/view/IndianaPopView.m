//
//  IndianaPopView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/6/28.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "IndianaPopView.h"
#import "GlobalTool.h"
#import "IndianaPopModel.h"
#import "IndianPopTableViewCell.h"
#import "NavgationbarView.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.m"
#import "IndianaPublicModel.h"
#import "YFShareModel.h"
#define codeYY (kScreenHeight - ZOOM6(940))/2
#define CodeViewHeigh ZOOM6(940)


@implementation IndianaPopView
{
    CGFloat shareimageYY ;
    NSString *str3;
    NSString *str4;
    
    BOOL is_rdecent;      //是否是一分钱夺宝
    int changeCount;      //参与次数
    int dayShareCount;    //当天分享的次数
    int recordshareCount;
    int recordduobaoCount;
    
}

- (instancetype)initWithFrame:(CGRect)frame Price:(NSString *)se_price
{
    if(self = [super initWithFrame:frame])
    {
        self.se_price = se_price;
        [self creaPopview];
        [self creatData];
    }
    
    return self;
}

- (void)creatData
{
    [self shareData];
    
    NSString *price = [NSString stringWithFormat:@"￥%.1f",self.se_price.floatValue];
    NSString *se_price = [NSString stringWithFormat:@"-￥%.2f",self.se_price.floatValue-0.01];
    NSArray *titltArr = @[@"结算",@"参与次数",@"应付总额",@"分享抵扣",@"还需支付"];
    NSArray *contentArr = @[@"取消",@"1",price,se_price,@"￥0.01"];
    for(int i=0;i<titltArr.count;i++)
    {
        IndianaPopModel *model = [[IndianaPopModel alloc]init];
        model.title = titltArr[i];
        model.content = contentArr[i];
        [self.RedcentData addObject:model];
    }
    
    for(int i=0;i<3;i++)
    {
        IndianaPopModel *model = [[IndianaPopModel alloc]init];
        model.title = titltArr[i];
        model.content = contentArr[i];
        [self.duobaoData addObject:model];
    }
}

- (void)shareData
{
    //获取用户分享的状态
    [IndianaPublicModel getShareStatuesuccess:^(id data) {
        IndianaPublicModel *model = data;
        if(model.status == 1)
        {
            dayShareCount = model.scDay.intValue;
            
            NSString* sharetoNum = [NSString stringWithFormat:@"%zd",[DataManager sharedManager].shareToNum];
            NSString *shareCount = [NSString stringWithFormat:@"%zd",sharetoNum.integerValue-model.sc.integerValue];
            self.shareMarkLab.text = model.sc.intValue==0?sharetoNum:shareCount;
            self.duobaaoMarkLab.text = [NSString stringWithFormat:@"%@",model.oc];
            
            UIButton *titleBtn = (UIButton*)[_ShareInvitationCodeView viewWithTag:8001];
            titleBtn.alpha = self.duobaaoMarkLab.text.intValue>0?1:0.5;//透明度
        }
    }];
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
    
    [_SharePopview addSubview:[self shareOrderView]];
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
        headimage.image = [UIImage imageNamed:@"share_top-150"];
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

//下弹框内容
- (UIView*)shareOrderView
{
    if(!_ShareInvitationOrderView)
    {
        _ShareInvitationOrderView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_SharePopview.frame)+ZOOM6(50), CGRectGetWidth(_SharePopview.frame), ZOOM6(600))];
        _ShareInvitationOrderView.backgroundColor = [UIColor whiteColor];
        
        [_ShareInvitationOrderView addSubview:self.orderTableView];
        
        _confirmView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_ShareInvitationOrderView.frame)-ZOOM6(100), kScreenWidth, ZOOM6(100))];
        _confirmView.backgroundColor = [UIColor whiteColor];
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _confirmBtn.frame = CGRectMake(ZOOM6(20), (CGRectGetHeight(_confirmView.frame)-ZOOM6(80))/2, CGRectGetWidth(_ShareInvitationOrderView.frame)-ZOOM6(20)*2, ZOOM6(80));
        _confirmBtn.backgroundColor = tarbarrossred;
        _confirmBtn.layer.cornerRadius=3;

        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmView addSubview:_confirmBtn];
        [_ShareInvitationOrderView addSubview:_confirmView];
    }
    return _ShareInvitationOrderView;
}
#pragma mark 分享说明-1
- (void)creatRewardview
{
    NSArray *dataArr =@[@"1.每分享3次给微信群或好友（只可分享给不同群或好友，否则只记1次），即可以1分钱参与一次原价2元的抽奖。分享次数越多，参与次数越多，你的中奖率就越高。",@"2、你更可得到分享邀请来的新好友账户余额与提现成功金额25%的奖励。每位好友最高100元余额，50元提现。"];
    [self.discriptionData addObjectsFromArray:dataArr];
    [_ShareInvitationCodeView addSubview:self.discriptionTableView];
}
#pragma mark 分享平台
- (void)creatShareView
{
    CGFloat with = CGRectGetWidth(_ShareInvitationCodeView.frame);
    CGFloat heigh = ZOOM6(180);
    CGFloat sharespace = (with-ZOOM6(150)*3)/4;
    CGFloat titlespace = (with-ZOOM6(150)*3)/4;
    UIView *shareview = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.discriptionTableView.frame)+ZOOM6(40), with, heigh)];
    
    //分享平台
    NSString *price = [NSString stringWithFormat:@"%@元钱抽奖",self.se_price];
    NSArray *imageArray = @[@"icon_weinxinqun",@"yifen_duobao-",@"newtask_icon_duobao"];
    NSArray *titleArray = @[@"分享",@"1分钱抽奖",price];
    for (int i=0; i<3; i++) {
        
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
            
            marklab.text = [NSString stringWithFormat:@"%d",[DataManager sharedManager].shareToNum];
            [imageview addSubview:self.shareMarkLab = marklab];
        }else if (i==1)
        {
            [shareBtn addTarget:self action:@selector(duobaoClick:) forControlEvents:UIControlEventTouchUpInside];
            [titleBtn addTarget:self action:@selector(duobaoClick:) forControlEvents:UIControlEventTouchUpInside];
            
            marklab.text = @"0";
            [imageview addSubview:self.duobaaoMarkLab = marklab];
            
            titleBtn.alpha = self.duobaaoMarkLab.text.intValue>0?1:0.5;//透明度
        }
        else{
            [shareBtn addTarget:self action:@selector(duobaoClick:) forControlEvents:UIControlEventTouchUpInside];
            [titleBtn addTarget:self action:@selector(duobaoClick:) forControlEvents:UIControlEventTouchUpInside];
        }
       
        [shareview addSubview:shareBtn];
        [shareview addSubview:titleBtn];
    }
    
    UILabel *bottomview = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shareview.frame)+ZOOM6(20), CGRectGetWidth(_ShareInvitationCodeView.frame), ZOOM6(100))];
    bottomview.textAlignment = NSTextAlignmentCenter;
    bottomview.text = @"分享到3个群后，\n拿到提现奖励的机率高达98%！";
    bottomview.numberOfLines = 0;
    bottomview.textColor = tarbarrossred;
    bottomview.font = [UIFont systemFontOfSize:ZOOM6(28)];
    
    [_ShareInvitationCodeView addSubview:shareview];
    [_ShareInvitationCodeView addSubview:bottomview];
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
        CGFloat imageHeigh = CGRectGetHeight(_ShareInvitationCodeView.frame)-headheigh-ZOOM6(360);
        
        _discriptionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headheigh, imagewidth, imageHeigh) style:UITableViewStylePlain];
        _discriptionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _discriptionTableView.delegate= self;
        _discriptionTableView.dataSource = self;
        _discriptionTableView.tableFooterView = [self tabfootView];
        [_ShareInvitationCodeView addSubview:_discriptionTableView];
    }
    return _discriptionTableView;
}

- (UITableView*)orderTableView
{
    if(_orderTableView == nil)
    {
        CGFloat imagewidth = CGRectGetWidth(_ShareInvitationOrderView.frame);
        CGFloat imageHeigh = ZOOM6(500);
        
        _orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, imagewidth, imageHeigh) style:UITableViewStylePlain];
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderTableView.scrollEnabled = NO;
        _orderTableView.delegate= self;
        _orderTableView.dataSource = self;
        [_ShareInvitationOrderView addSubview:_orderTableView];
        
        [_orderTableView registerNib:[UINib nibWithNibName:@"IndianPopTableViewCell" bundle:nil] forCellReuseIdentifier:@"Popcell"];
    }
    return _orderTableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigh = 0;
    if(tableView == _discriptionTableView)
    {
        NSString *title = self.discriptionData[indexPath.row];
        heigh = [self getRowHeight:title fontSize:ZOOM6(28)];
    }else{
        heigh = ZOOM6(100);
    }
    return heigh;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _discriptionTableView)
    {
        return self.discriptionData.count;
    }else{
        if(is_rdecent == YES)
        {
            return _RedcentData.count;
        }else{
            return _duobaoData.count;
        }
        return 0;
    }
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
        cell.textLabel.textColor = RGBCOLOR_I(125, 125, 125);
        cell.textLabel.font = [UIFont systemFontOfSize:ZOOM6(26)];
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        IndianPopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Popcell"];
        if(!cell)
        {
            cell = [[IndianPopTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Popcell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        IndianaPopModel *model;
        if(is_rdecent == YES)
        {
            model = self.RedcentData[indexPath.row];
            
            [cell refreshData:model Max:self.duobaaoMarkLab.text.intValue>1?(self.duobaaoMarkLab.text.intValue<20?self.duobaaoMarkLab.text.intValue:20):1];
        }else{
            model = self.duobaoData[indexPath.row];
            [cell refreshData:model Max:[Signmanager SignManarer].IndianaSurplusCount<200?[Signmanager SignManarer].IndianaSurplusCount:200];
        }
        
        cell.cancleBlock = ^{
            [UIView animateWithDuration:0.5 animations:^{
                
                _shareInvitationBackView.frame = CGRectMake(ZOOM(40), codeYY, kScreenWidth-ZOOM(40)*2, CodeViewHeigh);
                _ShareInvitationOrderView.frame = CGRectMake(0, CGRectGetHeight(_SharePopview.frame)+ZOOM6(50), CGRectGetWidth(_SharePopview.frame), ZOOM6(600));
                
            } completion:^(BOOL finish) {
                
            }];
        };
        
        cell.numberBlock = ^(NSInteger num){
            if(is_rdecent == YES)
            {
                long long count = [DataManager sharedManager].shareToDayNum/[DataManager sharedManager].shareToNum;
                if(num >= count)
                {
                    [MBProgressHUD show:[NSString stringWithFormat:@"一次最多只能参与%zd次哦~",count] icon:nil view:self];
                }else{
                    if(num >= [Signmanager SignManarer].IndianaSurplusCount)
                    {
                        recordshareCount++;
                        recordshareCount>1?[MBProgressHUD show:@"剩余参与次数不足~" icon:nil view:self]:nil;
                    }
                    else if(num >= self.duobaaoMarkLab.text.intValue)
                    {
                        recordshareCount++;
                        recordshareCount>1?[MBProgressHUD show:@"你的参与次数不足~" icon:nil view:self]:nil;
                    }else{
                        recordshareCount=0;
                    }
                }
            }else{
                if(num >= [Signmanager SignManarer].IndianaSurplusCount)
                {
                    recordshareCount++;
                    recordshareCount>1?[MBProgressHUD show:@"剩余参与次数不足~" icon:nil view:self]:nil;
                }
                else if(num >= 200)
                {
                    recordduobaoCount++;
                    recordduobaoCount>1?[MBProgressHUD show:@"一次最多只能参与200次哦~" icon:nil view:self]:nil;
                }else{
                    recordduobaoCount=0;
                }
            }
            
            if(is_rdecent == YES)
            {
                IndianaPopModel *sharemodel2 = self.RedcentData[2];
                CGFloat price2 = self.se_price.floatValue*num;
                sharemodel2.content = [NSString stringWithFormat:@"￥%.1f",price2];
                
                IndianaPopModel *sharemodel3 = self.RedcentData[3];
                CGFloat price3 = (self.se_price.floatValue-0.01)*num;
                sharemodel3.content = [NSString stringWithFormat:@"￥%.2f",price3];
                
                IndianaPopModel *sharemodel4 = self.RedcentData[4];
                CGFloat price4 = 0.01*num;
                sharemodel4.content = [NSString stringWithFormat:@"￥%.2f",price4];
            }else{
                IndianaPopModel *duobaomodel = self.duobaoData[2];
                CGFloat price = self.se_price.floatValue*num;
                duobaomodel.content = [NSString stringWithFormat:@"￥%.1f",price];
            }
            model.content = [NSString stringWithFormat:@"%zd",num];
            [self.orderTableView reloadData];
        };
        return cell;
    }
    return nil;
}

#pragma mark 确定
- (void)confirmClick:(UIButton*)sender
{
    NSString *se_price = @"";
    NSString *num = @"";
    NSString *ReductionPrice = @"";
    
    if(is_rdecent == YES)
    {
        IndianaPopModel *sharemodel = self.RedcentData[1];
        num = sharemodel.content;
        se_price = @"0.01";
        
        ReductionPrice = [NSString stringWithFormat:@"%.2f",(self.se_price.floatValue-se_price.floatValue)*num.floatValue];

    }else{
        IndianaPopModel *sharemodel = self.duobaoData[1];
        num = sharemodel.content;
        se_price = self.se_price;
        ReductionPrice = nil;
    }

    if(self.confirmOrderBlock)
    {
        self.confirmOrderBlock(se_price,num,ReductionPrice);
    }
    [self disapper];
}
#pragma mark 关闭弹框
- (void)cancleClick
{
    [self disapper];
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
        //埋点
        [YFShareModel getShareModelWithKey:@"duobao" type:StatisticalTypeIndianaShareClick tabType:StatisticalTabTypeIndiana success:nil];
        if(self.weixinBlock)
        {
            self.weixinBlock();
        }
    }
}

#pragma mark 夺宝
- (void)duobaoClick:(UIButton*)sender
{
    CGFloat moveheigh = 0;
    CGFloat OrderViewheigh = 0;
    if(sender.tag == 9001 || sender.tag == 8001)
    {
        //埋点
        [YFShareModel getShareModelWithKey:@"duobao" type:StatisticalTypeIndianaCentParticipate tabType:StatisticalTabTypeIndiana success:nil];
        if(self.duobaaoMarkLab.text.intValue>0)
        {
            moveheigh = ZOOM6(280);
            OrderViewheigh = ZOOM6(600);
            is_rdecent = YES;
            [self.orderTableView reloadData];
        }else{
            
            NSString *message = [NSString stringWithFormat:@"你的1分钱抽奖次数不足哦。再分享%d次即可赢得一次1分抽奖的机会，现在就去分享吧",self.shareMarkLab.text.intValue];
            
            [MBProgressHUD show:message icon:nil view:self];
            
            return;
        }
    }else{
        //埋点
        [YFShareModel getShareModelWithKey:@"duobao" type:StatisticalTypeIndianaTwoParticipate tabType:StatisticalTabTypeIndiana success:nil];
        
        moveheigh = ZOOM6(100);
        OrderViewheigh = ZOOM6(400);
        is_rdecent = NO;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _shareInvitationBackView.frame = CGRectMake(ZOOM(40), codeYY-moveheigh, kScreenWidth-ZOOM(40)*2, CodeViewHeigh);
        _ShareInvitationOrderView.frame = CGRectMake(0, CGRectGetHeight(_SharePopview.frame)-OrderViewheigh, CGRectGetWidth(_SharePopview.frame), OrderViewheigh);
        _confirmView.frame = CGRectMake(0, OrderViewheigh-ZOOM6(100), kScreenWidth, ZOOM6(100));
    } completion:^(BOOL finish) {
        is_rdecent==NO?[self.orderTableView reloadData]:nil;
    }];

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
        
        _shareInvitationBackView.frame = CGRectMake(ZOOM(40), codeYY, kScreenWidth-ZOOM(40)*2, CodeViewHeigh);
        _ShareInvitationOrderView.frame = CGRectMake(0, CGRectGetHeight(_SharePopview.frame)+ZOOM6(50), CGRectGetWidth(_SharePopview.frame), ZOOM6(600));
        
    } completion:^(BOOL finish) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _SharePopview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            _shareInvitationBackView.transform = CGAffineTransformMakeScale(0.25, 0.25);
            _shareInvitationBackView.alpha = 0;
            
        } completion:^(BOOL finish) {
            
            [self removeFromSuperview];
        }];
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
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(_discriptionTableView.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    
    return height+ZOOM6(15);
}

-(CGFloat)getRowWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat width = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    
    return width;
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
