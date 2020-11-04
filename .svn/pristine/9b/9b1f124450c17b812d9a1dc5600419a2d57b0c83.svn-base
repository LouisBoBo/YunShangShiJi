//
//  TixianSharePopview.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/9/2.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TixianSharePopview.h"
#import "GlobalTool.h"
#import "AFHTTPRequestOperationManager.h"
@implementation TixianSharePopview
{
    CGFloat shareimageYY ;
    NSString *str3;
    NSString *str4;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
//        [self httpActivityRule];
        [self creaPopview];
    }
    
    return self;
}

- (void)creaPopview
{
    _SharePopview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    
    _SharePopview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _SharePopview.userInteractionEnabled = YES;
    
    CGFloat invitcodeYY = (kScreenHeight - ZOOM6(1000))/2+ZOOM6(30);
    CGFloat ShareInvitationCodeViewHeigh = ZOOM6(1000);
    
    //弹框最底层
    _shareInvitationBackView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(30), invitcodeYY, kScreenWidth-ZOOM(30)*2, ShareInvitationCodeViewHeigh)];
    [_SharePopview addSubview:_shareInvitationBackView];
    
    //左右两个按钮
    CGFloat width = IMAGEW(@"icon_left");
    _leftgobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftgobtn.frame = CGRectMake(0, (CGRectGetHeight(_shareInvitationBackView.frame)-width)/2, width, width);
    [_leftgobtn setImage:[UIImage imageNamed:@"icon_left"] forState:UIControlStateNormal];
    _leftgobtn.hidden = YES;
    
    _rightgobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightgobtn.frame = CGRectMake(CGRectGetWidth(_shareInvitationBackView.frame)-width, (CGRectGetHeight(_shareInvitationBackView.frame)-width)/2, width, width);
    [_rightgobtn setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
    _rightgobtn.hidden = NO;
    
    [_shareInvitationBackView addSubview:_leftgobtn];
    [_shareInvitationBackView addSubview:_rightgobtn];
    
    //弹框内容
    _ShareInvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(70), 0, CGRectGetWidth(_shareInvitationBackView.frame)-ZOOM6(70)*2, ShareInvitationCodeViewHeigh)];
    _ShareInvitationCodeView.layer.cornerRadius = 5;
    _ShareInvitationCodeView.clipsToBounds = YES;
    _ShareInvitationCodeView.backgroundColor = [UIColor whiteColor];
    [_shareInvitationBackView addSubview:_ShareInvitationCodeView];
    
//    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _ShareInvitationCodeView.frame.size.width, ZOOM6(100))];
//    bgImg.backgroundColor=tarbarrossred;
//    [_ShareInvitationCodeView addSubview:bgImg];
    
//    //标题
//    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgImg.frame), CGRectGetHeight(bgImg.frame))];
//    titlelabel.textColor = [UIColor whiteColor];
//    titlelabel.text = @"分享完成赚钱任务";
//    titlelabel.backgroundColor = [UIColor clearColor];
//    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(40)];
//    titlelabel.textAlignment = NSTextAlignmentCenter;
//    titlelabel.clipsToBounds = YES;
//    titlelabel.userInteractionEnabled = YES;
//    [_ShareInvitationCodeView addSubview:titlelabel];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
//    [titlelabel addGestureRecognizer:tap];
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_ShareInvitationCodeView.frame), CGRectGetWidth(_ShareInvitationCodeView.frame)/4)];
    headimage.image = [UIImage imageNamed:@"share_top-200"];
    [_ShareInvitationCodeView addSubview:headimage];
    headimage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
    [headimage addGestureRecognizer:tap];

    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"invite_icon_close");
    
    _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_ShareInvitationCodeView.frame)-btnwidth-ZOOM(30), ZOOM6(30), btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"invite_icon_close"] forState:UIControlStateNormal];
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [_ShareInvitationCodeView addSubview:_canclebtn];
    
    
    //弹框内容
    [self finishContent:nil];
    
    [self addSubview:_SharePopview];
    
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

- (void)finishContent:(NSString*)type
{
//    CGFloat headimageY = ZOOM6(60);
//    CGFloat headimageY = CGRectGetWidth(_ShareInvitationCodeView.frame)/4;
    
//    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(20, headimageY, CGRectGetWidth(_ShareInvitationCodeView.frame)-40, ZOOM6(40))];
//    titlelab.textColor = tarbarrossred;
//    titlelab.textAlignment = NSTextAlignmentCenter;
//    titlelab.font = [UIFont systemFontOfSize:ZOOM(51)];
//    [_ShareInvitationCodeView addSubview:titlelab];
  
//    CGFloat imageviewYY = CGRectGetMaxY(titlelab.frame);
    
    CGFloat imageviewYY = CGRectGetWidth(_ShareInvitationCodeView.frame)/4;
    _Myscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,imageviewYY, CGRectGetWidth(_ShareInvitationCodeView.frame), CGRectGetHeight(_ShareInvitationCodeView.frame)-imageviewYY-ZOOM6(20)-ZOOM6(200))];
    _Myscrollview.contentSize = CGSizeMake(CGRectGetWidth(_ShareInvitationCodeView.frame)*2, 0);
    _Myscrollview.pagingEnabled = YES;
    _Myscrollview.delegate = self;
    _Myscrollview.userInteractionEnabled = YES;
    _Myscrollview.showsHorizontalScrollIndicator = FALSE;
    [_ShareInvitationCodeView addSubview:_Myscrollview];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((CGRectGetWidth(_Myscrollview.frame)-100)/2, CGRectGetHeight(_Myscrollview.frame)+imageviewYY+ZOOM6(10), 100, 10)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 2;
    _pageControl.currentPageIndicatorTintColor = tarbarrossred;
    _pageControl.pageIndicatorTintColor = RGBCOLOR_I(197, 197, 197);
    [_ShareInvitationCodeView addSubview:_pageControl];
    
    for(int i = 0;i<2;i++)
    {
        _scbackview = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_Myscrollview.frame)*i, -2, CGRectGetWidth(_Myscrollview.frame), CGRectGetHeight(_Myscrollview.frame))];
        
        if(i==0)
        {
            [self creatRewardview];
        }else if (i==1)
        {
            [_scbackview addSubview:[self creatscImageview]];
        }else{
            [_scbackview addSubview:[self creatscImageview]];
        }
        
        [_Myscrollview addSubview:_scbackview];
    }
    
    shareimageYY = CGRectGetMaxY(_pageControl.frame);
    
    [self creatShareView];
}

#pragma mark 大图-3
- (UIImageView*)creatscImageview
{
    CGFloat imagewidth = CGRectGetWidth(_scbackview.frame);
    CGFloat imageheigh = imagewidth/0.83;
    
    UIImageView *bigimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imagewidth, imageheigh)];
    
    //1-5随机数
    int i = arc4random() % 5+1 ;
    bigimageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"task_%02d.jpg",i]];
    bigimageview.contentMode = UIViewContentModeScaleAspectFit;
    bigimageview.clipsToBounds = YES;
    return bigimageview;
    
}

#pragma mark 分享说明-2
- (UIView*)creatDiscriptionView
{
    UIView *discriptionview = [[UIView alloc]initWithFrame:CGRectMake(0, ZOOM6(20), CGRectGetWidth(_scbackview.frame), CGRectGetHeight(_scbackview.frame)-ZOOM6(20))];
    
    CGFloat discriptionYY = ZOOM6(20);
    CGFloat discriptionWW = ZOOM6(120);
    for(int i =0;i<3;i++)
    {
        UILabel *discriptionlabel = [[UILabel alloc]init];
        discriptionlabel.numberOfLines = 0;
        discriptionlabel.textColor = RGBCOLOR_I(125, 125, 125);
        discriptionlabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        
        UIImageView *titleimage = [[UIImageView alloc] init];
        
        if(i==0)
        {
            discriptionlabel.text = @"分享商品成功后，来围观并成功加入衣蝠的小伙伴将会成为你的粉丝";
            titleimage.image = [UIImage imageNamed:@"q-1"];
        }else if (i==1)
        {
            discriptionWW = ZOOM6(150);
            discriptionYY += ZOOM6(120);
            discriptionlabel.text = @"粉丝每次在衣蝠购买美衣，你将可以从平台得到商品售价10%的现金奖励";
            titleimage.image = [UIImage imageNamed:@"q-2"];
        }
        else{
            discriptionWW = ZOOM6(250);
            discriptionYY += ZOOM6(150);
            discriptionlabel.textColor = tarbarrossred;
            discriptionlabel.text = @"例如:\n朋友圈里有20个小伙伴在衣蝠消费500元，你就能得到1000元的现金奖励，小回报们同时也能得到相应的优惠。快号召小伙伴们下载衣蝠APP吧。";
        }
        
        discriptionlabel.frame = CGRectMake(ZOOM6(80), discriptionYY, CGRectGetWidth(discriptionview.frame)-ZOOM6(80)-ZOOM6(40), discriptionWW);
        titleimage.frame = CGRectMake(ZOOM6(20), discriptionYY+ZOOM6(20), ZOOM6(40), ZOOM6(40));
        
        [discriptionview addSubview:discriptionlabel];
        [discriptionview addSubview:titleimage];
    }
    
    return discriptionview;
}

- (void)httpActivityRule {
    NSString *url= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

    kSelfWeak;
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject!=nil) {
            kSelfStrong;
            if(responseObject[@"jzjl"][@"n2"] != nil)
            {
                strongSelf->str3 =responseObject[@"jzjl"][@"n2"];
            }else{
                strongSelf->str3 = @"1元";
            }
            if(responseObject[@"jzjl"][@"n3"] != nil)
            {
                strongSelf->str4 = responseObject[@"jzjl"][@"n3"];
            }else{
                strongSelf->str4 = @"0.1元";
            }
            
        }
        
//        [weakSelf creaPopview];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
  
}
#pragma mark 分享说明-1
- (void)creatRewardview
{
//    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ZOOM6(60), CGRectGetWidth(_scbackview.frame), ZOOM6(40))];
//    titlelabel.textAlignment = NSTextAlignmentCenter;
//    titlelabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
//    titlelabel.textColor = tarbarrossred;
//    titlelabel.text = @"*分享商品 *好友购买 *我拿奖励";
//    [_scbackview addSubview:titlelabel];
    
    //国片 描述文字 按钮
    NSArray *dataArr =@[@"1.分享微信群，邀请家人，朋友或同事来衣蝠。",@"2.好友每次消费，你可得10%奖励金。",@"3.分享到3个以上微信群，拿到奖励金的概率提升200%。",@"4.坚持分享30天，拿到200元+奖励金的概率高达98%。"];
    [self.discriptionData addObjectsFromArray:dataArr];
    [_scbackview addSubview:self.discriptionTableView];
    
//    //了解更多
//    UILabel *discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.discriptionTableView.frame), CGRectGetWidth(_ShareInvitationCodeView.frame), ZOOM6(80))];
//    discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(30)];
//    discriptionlab.textColor = RGBCOLOR_I(125, 125, 125);
//    discriptionlab.textAlignment = NSTextAlignmentCenter;
//    discriptionlab.text = @"快号召小伙伴们来围观\n下载衣蝠APP吧。";
//    discriptionlab.numberOfLines = 0;
//    [_scbackview addSubview:discriptionlab];
    
//    CGFloat tislabWith = [self getRowWidth:@"了解更多" fontSize:ZOOM6(30)] + ZOOM6(70);
//    
//    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    moreBtn.frame = CGRectMake((CGRectGetWidth(_ShareInvitationCodeView.frame)-tislabWith)/2-ZOOM6(20), CGRectGetMaxY(discriptionlab.frame)+ZOOM6(10), tislabWith, ZOOM6(30));
//    [moreBtn addTarget:self action:@selector(moretap) forControlEvents:UIControlEventTouchUpInside];
//    [moreBtn setTintColor:tarbarrossred];
//    [moreBtn setTitle:@"了解更多" forState:UIControlStateNormal];
//    moreBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
//    [_scbackview addSubview:moreBtn];
    
    UILabel *bottomlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.discriptionTableView.frame)+ZOOM6(50), CGRectGetWidth(_scbackview.frame), ZOOM6(70))];
    bottomlabel.textAlignment = NSTextAlignmentCenter;
    bottomlabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
    bottomlabel.numberOfLines = 0;
    bottomlabel.textColor = tarbarrossred;
    bottomlabel.text = @"分享到3个群后，\n拿到现金奖励机率高达98%！";
    [_scbackview addSubview:bottomlabel];

    
    
//    UIImageView *moreimg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(moreBtn.frame)-ZOOM6(30), 0, ZOOM6(30), ZOOM6(30))];
//    moreimg.image = [UIImage imageNamed:@"shop-go-"];
//    [moreBtn addSubview:moreimg];
    
}
#pragma mark 分享平台
- (void)creatShareView
{
    
    CGFloat with = CGRectGetWidth(_ShareInvitationCodeView.frame);
    
    UIView *shareview = [[UIView alloc]initWithFrame:CGRectMake(0,shareimageYY+ZOOM6(10), with, CGRectGetHeight(_ShareInvitationCodeView.frame)-shareimageYY-ZOOM6(50))];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, with, ZOOM6(30))];
    titlelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
    titlelab.textColor = RGBCOLOR_I(125, 125, 125);
    titlelab.textAlignment = NSTextAlignmentCenter;
//    titlelab.text = @"分享到";
    [shareview addSubview:titlelab];
    
    //    CGFloat titleYY =0;
    //分享平台
    for (int i=0; i<1; i++) {
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        shareBtn.frame = CGRectMake(ZOOM6(200)*i+(with-ZOOM6(300))/2,CGRectGetMaxY(titlelab.frame), ZOOM6(100), ZOOM6(100));
        
        shareBtn.frame = CGRectMake((with-ZOOM6(420))/2,CGRectGetMaxY(titlelab.frame), ZOOM6(420), ZOOM6(88));
        shareBtn.tag = 9000+i;
        shareBtn.tintColor = [UIColor clearColor];
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                
                //判断是否有微信
                
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"分享到微信群"] forState:UIControlStateNormal];
            }else {
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
            }
            
        }else if (i==1){
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
            {
                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
            }else{
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
            }
            
        }
        [shareview addSubview:shareBtn];
    }
    
    [_ShareInvitationCodeView addSubview:shareview];
}
- (UIView*)tabfootView
{
    CGFloat width = CGRectGetWidth(_ShareInvitationCodeView.frame);
    CGFloat heigh = width/1.73;
    UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, width-2*ZOOM6(20), heigh+ZOOM6(20))];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, ZOOM6(20), CGRectGetWidth(footview.frame), heigh)];
    imageview.image = [UIImage imageNamed:@"biaoge-mini"];
    [footview addSubview:imageview];
    return footview;
}

- (UITableView*)discriptionTableView
{
    if(_discriptionTableView == nil)
    {
        CGFloat imagewidth = CGRectGetWidth(_scbackview.frame);
//        CGFloat imageHeigh = imagewidth/5;
        
        _discriptionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ZOOM6(20), imagewidth, ZOOM6(350)) style:UITableViewStylePlain];
        _discriptionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _discriptionTableView.delegate= self;
        _discriptionTableView.dataSource = self;
//        _discriptionTableView.tableFooterView = [self tabfootView];
        [_scbackview addSubview:_discriptionTableView];
    }
    return _discriptionTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.discriptionData[indexPath.row];
    CGFloat heigh = [self getRowHeight:title fontSize:ZOOM6(30)];
    return heigh;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.discriptionData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = self.discriptionData[indexPath.row];
        cell.textLabel.textColor = RGBCOLOR_I(125, 125, 125);
        
        NSArray *findStrArr = @[@"2元提现现金",@"提升200%",@"18元任务红包"];
        NSMutableAttributedString *nsmutable = [[NSMutableAttributedString alloc]initWithString:cell.textLabel.text];
        for(int i =0; i < findStrArr.count; i++)
        {
            NSString * findstr = findStrArr[i];
            NSRange range = [cell.textLabel.text rangeOfString:findstr];
            if(range.length >0)
            {
                [nsmutable addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, findstr.length)];
            }
            
            [nsmutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(28)] range:NSMakeRange(0, cell.textLabel.text.length)];
            [cell.textLabel setAttributedText:nsmutable];
        }
        
    
        cell.textLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

#pragma mark 关闭弹框
- (void)cancleClick
{
    [self disapper];
}

#pragma mark 选择分享的平台
-(void)shareClick:(UIButton*)sender
{
    if(sender.tag == 9000)
    {
        if(self.weixinBlock)
        {
            self.weixinBlock();
        }
    }else{
        
        if(self.friendBlock)
        {
            self.friendBlock();
        }
    }
    [self disapper];
}

#pragma mark 了解更多
- (void)moretap
{
    if(self.moreunderstandBlock)
    {
        self.moreunderstandBlock();
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    if(sView == _Myscrollview)
    {
        int from = (int)_Myscrollview.contentOffset.x ;
        int to = (int)_ShareInvitationCodeView.frame.size.width;
        int index = from/to;
        _pageControl.currentPage = index;
        
        if(index == 0)
        {
            _leftgobtn.hidden = YES;
            _rightgobtn.hidden = NO;
        }else if (index == 1)
        {
            _leftgobtn.hidden = NO;
            _rightgobtn.hidden = YES;
        }else if (index == 2)
        {
            _leftgobtn.hidden = YES;
            _rightgobtn.hidden = NO;
        }
    }
}

#pragma mark 获取文字高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    text = [text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(_discriptionTableView.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    
    return height+ZOOM6(15);
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

- (NSMutableArray*)discriptionData
{
    if(_discriptionData == nil)
    {
        _discriptionData = [NSMutableArray array];
    }
    return _discriptionData;
}


@end
