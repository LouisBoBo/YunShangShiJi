//
//  InviteFriendsVC.m
//  YunShangShiJi
//
//  Created by yssj on 2016/10/12.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "InviteFriendsVC.h"
#import "GlobalTool.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "DShareManager.h"
#import "QRCodeVC.h"
#import "Signmanager.h"
#import "TaskSignModel.h"
#import "UIImage+CFQRcode.h"
#import "ProduceImage.h"

#define kInfoViewColor   [UIColor colorWithRed:255/255.0 green:244/255.0 blue:227/255.0 alpha:1.0]
#define kInviteColor   [UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1.0]
#define kPopColor [UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:1.0]

#define kApi_FansMap @"user/getFansMap?"//邀请好友粉丝数据

static NSString *InviteCell=@"Cell";

@interface InviteFriendsVC ()<UITableViewDelegate,UITableViewDataSource> {
    UIImageView *userImg;
    UILabel *userName;
    UILabel *userMoney;
    UILabel *userFuns;
    UILabel *textLabel;
    
    UIView *_Popview;
    UIView *_InvitationCodeView;
    UIButton *_canclebtn; //弹框关闭按钮
}
@property (strong, nonatomic) UITableView *myTable;
@property (strong, nonatomic) NSMutableArray *FansArr;

@end

@interface InviteModel : NSObject
@property (nonatomic,copy)NSString *headImg;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *money;
@end

@interface InviteFriendsCell : UITableViewCell
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *moneyLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)receiveModel:(InviteModel *)model;
@end



@implementation InviteFriendsVC

- (void)viewDidDisappear:(BOOL)animated {
    if (_Popview) {
        [self tapClick];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.view addSubview:self.myTable];
    [self setFootView];
    [self setNavgationView];
    
//    [self loadUserInfo:@"0" withUserFans:@"0"];
    
    [self FansData];
    [self httpGetFans];
}
- (void)httpGetFans {
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_FansMap caches:NO cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            [self loadUserInfo:data[@"money"] withUserFans:data[@"fans"] text:data[@"remark"]];
        } else {
            //            [MBProgressHUD showError:response.message];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 懒加载
- (UITableView *)myTable {
    if (nil == _myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-ZOOM(200)) style:UITableViewStylePlain];
        _myTable.dataSource = self;
        _myTable.delegate = self;
        _myTable.separatorColor=kTableLineColor;
        _myTable.tableHeaderView=[self myTableHeadView];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        line.backgroundColor=kTableLineColor;
        _myTable.tableFooterView=line;
    }
    return _myTable;
}
- (void)FansData {
   NSArray *arr = [NSString userImgArrRandomProduce];
    for (NSString *headImg in arr) {
        InviteModel *model=[[InviteModel alloc]init];
        model.name=[NSString stringWithFormat:@"%@ 获得奖励",[NSString userNameRandomProduce]];
        model.headImg=[NSString stringWithFormat:@"defaultcommentimage/%@",headImg];
        model.money=[NSString stringWithFormat:@"%.1f元",arc4random()%198+1+(arc4random()%10)/10.];
        [self.FansArr addObject:model];
    }
}
- (NSMutableArray *)FansArr {
    if (nil == _FansArr) {
        _FansArr = [NSMutableArray array];
    }
    return _FansArr;
}
- (UIView *)myTableHeadView {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kZoom6pt(270))];
    
    textLabel = [[UILabel alloc]init];
    textLabel.textColor = kInviteColor;
    NSString *string=@"邀请好友成功后，好友将成为你的粉丝，粉丝从赚钱任务提现多少钱（好友做任务后未提现，你的奖励也将暂时冻结在“账户明细—返现”中），你也将获得同样的奖励（每位粉丝最高5元）。邀请好友越多，获得的奖励也就越多，上不封顶哦~";
//    [textLabel setAttributedText:[NSString paragraphLineSpaceAttrWithString:string lineSpace:2]];
    textLabel.text=string;
    textLabel.numberOfLines=0;
    textLabel.font=[UIFont systemFontOfSize:kZoom6pt(14)];
    [headView addSubview:textLabel];
    
    UIView *userInfoView = [[UIView alloc]init];
    userInfoView.backgroundColor=kInfoViewColor;
    userImg = [[UIImageView alloc]init];
    userImg.clipsToBounds = YES;
    userImg.layer.cornerRadius = kZoom6pt(40)/2;
    userName = [self labelWithTextColor:kInviteColor andFontSize:kZoom6pt(15)];
    userMoney = [self labelWithTextColor:tarbarrossred andFontSize:kZoom6pt(21)];
    UILabel *userMoneySub = [self labelWithTextColor:kInviteColor andFontSize:kZoom6pt(15)];
    userMoneySub.text=@"累计粉丝奖励";
    userFuns=[self labelWithTextColor:tarbarrossred andFontSize:kZoom6pt(21)];
    UILabel *userFunsSub=[self labelWithTextColor:kInviteColor andFontSize:kZoom6pt(15)];
    userFunsSub.text=@"粉丝人数";
    
    UIView *line1=[[UIView alloc]init];
    line1.backgroundColor=kTableLineColor;
    [userInfoView addSubview:line1];
    UIView *line2=[[UIView alloc]init];
    line2.backgroundColor=kTableLineColor;
    [userInfoView addSubview:line2];
    
    [userInfoView addSubview:userImg];
    [userInfoView addSubview:userName];
    [userInfoView addSubview:userMoney];
    [userInfoView addSubview:userMoneySub];
    [userInfoView addSubview:userFuns];
    [userInfoView addSubview:userFunsSub];
    [headView addSubview:userInfoView];
    
    UILabel *tableTitle=[self labelWithTextColor:kInviteColor andFontSize:kZoom6pt(16)];
    tableTitle.text=@"奖励动态";
    [headView addSubview:tableTitle];
    
    [tableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@kZoom6pt(-5));
        make.left.equalTo(textLabel);
    }];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kZoom6pt(15));
        make.top.equalTo(@kZoom6pt(25));
        make.right.equalTo(@kZoom6pt(-15));
    }];
    [userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel.mas_bottom).offset(kZoom6pt(25));
        make.left.right.equalTo(textLabel);
        make.height.equalTo(@kZoom6pt(80));
    }];
    [userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@kZoom6pt(10));
        make.width.height.equalTo(@kZoom6pt(40));
//        make.left.equalTo(@kZoom6pt(20));
        make.centerX.equalTo(userName);
    }];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(userInfoView).offset(-kZoom6pt(10));
        make.left.equalTo(@0);
        make.width.equalTo(@kZoom6pt(80));
    }];
    [userMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userImg);
        make.centerX.equalTo(userMoneySub);
        make.width.equalTo(userMoneySub);
    }];
    [userMoneySub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userName);
        make.left.equalTo(line1.mas_right);
        make.width.equalTo(@kZoom6pt(130));
    }];
    [userFuns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userImg);
        make.right.equalTo(@0);
        make.width.equalTo(userMoneySub);
    }];
    [userFunsSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userName);
        make.centerX.equalTo(userFuns);
        make.width.equalTo(userMoneySub);
    }];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((kScreenWidth-kZoom6pt(290))));
        make.top.equalTo(userImg);
        make.bottom.equalTo(userName);
        make.width.equalTo(@0.5);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((kScreenWidth-kZoom6pt(160))));
        make.top.equalTo(line1);
        make.bottom.equalTo(line1);
        make.width.equalTo(line1);
    }];
    
    return headView;
}

- (void)loadUserInfo:(NSString *)userFansMoney withUserFans:(NSString *)userFans text:(NSString *)text {
    NSString *defaultPic = [[NSUserDefaults standardUserDefaults] objectForKey:USER_HEADPIC];

    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    UIImage *imgFromUrl=[[UIImage alloc] initWithContentsOfFile:aPath];
    
    //defaultPic  %@",defaultPic);
    if (imgFromUrl!=nil) { //判断用户是否登陆
        userImg.image = imgFromUrl;
    } else {
        if ([defaultPic hasPrefix:@"http://"]) {
            [userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",defaultPic]]];
        } else
            [userImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],defaultPic]]];
        //2.缓存图片到沙盒
        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
        NSData *imgData = UIImagePNGRepresentation(userImg.image);
        [imgData writeToFile:aPath atomically:YES];
    }
    
    userName.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME]];
    userMoney.text=[NSString stringWithFormat:@"%.2f元",[userFansMoney floatValue]];
    userFuns.text=[NSString stringWithFormat:@"%@人",userFans];
    
    if(text)
        textLabel.text=[NSString stringWithFormat:@"%@",text];
}

- (UILabel *)labelWithTextColor:(UIColor *)color andFontSize:(CGFloat)fontSize{
    UILabel *label=[[UILabel alloc]init];
    label.textColor=color;
    label.font=[UIFont systemFontOfSize:fontSize];
    label.textAlignment=NSTextAlignmentCenter;
    return label;
}

#pragma mark - UITableView  dataSource  delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kZoom6pt(60);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.FansArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InviteFriendsCell *cell = [InviteFriendsCell cellWithTableView:tableView];
//    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
//    UIImage *imgFromUrl=[[UIImage alloc] initWithContentsOfFile:aPath];
//    cell.imgView.image=imgFromUrl;

    InviteModel *model=self.FansArr[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.headImg]]];
    cell.moneyLabel.text=model.money;
    cell.nameLabel.text=model.name;
    return cell;
}
-(void)viewDidLayoutSubviews
{
    if ([self.myTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.myTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)setNavgationView {
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"邀请有礼";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height, kApplicationWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [headview addSubview:line];
    
}
- (void)goBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setFootView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-ZOOM(200), kScreenWidth, ZOOM(200))];
    [self.view addSubview:view];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor=kNavLineColor;
    [view addSubview:line];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame=CGRectMake(kZoom6pt(15), ZOOM(32), kScreenWidth-kZoom6pt(15)*2, view.frame.size.height-ZOOM(32)*2);
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setTitle:@"邀请好友" forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOMPT(18)];
    [submitBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    [view addSubview:submitBtn];
}

- (void)bottomBtnClick:(UIButton *)btn {
    [self popView];
}

#pragma mark - 弹框
- (void)popView
{
    _Popview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
    _Popview.userInteractionEnabled = YES;
    UIButton *bgButton = [[UIButton alloc] init];
    bgButton.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [bgButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    [_Popview addSubview:bgButton];
    [self.view addSubview:_Popview];
    
    //弹框内容
   _InvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(120), (kScreenHeight - ZOOM6(620))/2, kScreenWidth-ZOOM(120)*2, ZOOM6(620))];
    _InvitationCodeView.backgroundColor=[UIColor whiteColor];
    _InvitationCodeView.clipsToBounds = YES;
    _InvitationCodeView.layer.cornerRadius = 5;
    [_Popview addSubview:_InvitationCodeView];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _InvitationCodeView.frame.size.width, ZOOM6(80))];
    bgImg.backgroundColor=tarbarrossred;
    [_InvitationCodeView addSubview:bgImg];
    
    //标题
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgImg.frame), CGRectGetHeight(bgImg.frame))];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont systemFontOfSize:ZOOM(57)];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = @"邀请方式";
    [_InvitationCodeView addSubview:titlelabel];
    

    UILabel *remindLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImg.frame)+ZOOM6(50), _InvitationCodeView.frame.size.width, ZOOM6(120))];
//    remindLabel.backgroundColor=DRandomColor;
    remindLabel.textColor=kPopColor;
    remindLabel.text=@"温馨提示\n衣蝠为时尚女装平台，仅可邀请时尚\n爱美的女性成为粉丝才能获得奖励哟~";
    remindLabel.textAlignment=NSTextAlignmentCenter;
    remindLabel.numberOfLines=3;
    remindLabel.font=[UIFont systemFontOfSize:ZOOM6(28)];
    [_InvitationCodeView addSubview:remindLabel];
    UIButton *QCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    QCodeBtn.frame=CGRectMake(ZOOM6(60), _InvitationCodeView.frame.size.height-ZOOM6(50)-ZOOM6(80), CGRectGetWidth(_InvitationCodeView.frame)-ZOOM6(120), ZOOM6(80));
    QCodeBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(30)];
    [QCodeBtn setTitle:@"面对面扫二维码" forState:UIControlStateNormal];
    [QCodeBtn setTitleColor:kPopColor forState:UIControlStateNormal];
    [QCodeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    QCodeBtn.tag=105;
    QCodeBtn.layer.cornerRadius=3;
    QCodeBtn.layer.borderWidth=0.5;
    QCodeBtn.layer.borderColor=kPopColor.CGColor;
    [_InvitationCodeView addSubview:QCodeBtn];
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"icon_close1");
   _canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth-ZOOM(10), 0, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"icon_close1"] forState:UIControlStateNormal];
    _canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    _canclebtn.layer.cornerRadius=btnwidth/2;
    [_canclebtn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    _canclebtn.frame=CGRectMake(CGRectGetWidth(_InvitationCodeView.frame)-btnwidth-ZOOM(10), (CGRectGetHeight(bgImg.frame)-btnwidth)/2, btnwidth, btnwidth);
    [_canclebtn setImage:[UIImage imageNamed:@"qiandao_icon_close"] forState:UIControlStateNormal];
    [_InvitationCodeView addSubview:_canclebtn];
    
    CGFloat BtnWidth=ZOOM6(100);
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        [_InvitationCodeView addSubview:[self setBtnFrame:CGRectMake(ZOOM6(60) , remindLabel.bottom+ZOOM6(50), BtnWidth, BtnWidth)withTag:100]];
        [_InvitationCodeView addSubview:[self setBtnFrame:CGRectMake((_InvitationCodeView.frame.size.width-BtnWidth)/2 , remindLabel.bottom+ZOOM6(50), BtnWidth, BtnWidth)withTag:101]];

    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        [_InvitationCodeView addSubview:[self setBtnFrame:CGRectMake(_InvitationCodeView.frame.size.width-BtnWidth-ZOOM6(60) , remindLabel.bottom+ZOOM6(50), BtnWidth, BtnWidth)withTag:102]];
    }
    
    //弹框弹出
    _InvitationCodeView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _InvitationCodeView.alpha = 0.5;
    
    _Popview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//    [UIView animateWithDuration:0.5 animations:^{
//        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
//        _InvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
//        _InvitationCodeView.alpha = 1;
//    } completion:^(BOOL finish) {
//        
//    }];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        _InvitationCodeView.transform = CGAffineTransformMakeScale(1, 1);
        _InvitationCodeView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
-(UIButton *)setBtnFrame:(CGRect)frame withTag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    btn.tag=tag;
//        btn.backgroundColor=DRandomColor;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ZOOM6(100), ZOOM6(100))];
    img.contentMode=UIViewContentModeScaleAspectFit;
    [btn addSubview:img];
    UILabel *BtnTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, img.frame.size.height, frame.size.width, 30)];
    BtnTitle.font=[UIFont systemFontOfSize:ZOOM(44)];
    BtnTitle.textColor=kSubTitleColor;
    BtnTitle.textAlignment=NSTextAlignmentCenter;
    [btn addSubview:BtnTitle];
    
    switch (tag) {
        case 101:
            BtnTitle.text=@"朋友圈";
            [img setImage:[UIImage imageNamed:@"邀请好友_朋友圈"]];
            break;
        case 102:
            BtnTitle.text=@"QQ";
            [img setImage:[UIImage imageNamed:@"邀请好友_QQ"]];
            break;
        case 100:
            BtnTitle.text=@"微信";
            [img setImage:[UIImage imageNamed:@"微信授权图标"]];
            break;
        default:
            break;
    }
    return btn;
}
-(void)btnClick:(UIButton *)Sender{
    switch (Sender.tag) {
        case 101:{
            [self tapClick];
            MyLog(@"朋友圈");
            
            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app shardk];
            
           __strong NSString *title=@"每日做简单小任务快速赚钱";
           __strong NSString *subTitle=@"更有万款美衣1折起";
            [UIImage qrImageWithString:[NSString stringWithFormat:@"%@view/download/6.html?realm=%@",[NSString baseH5ShareURLStr],[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]] size:CGRectGetWidth(self.view.frame)*0.4 completion:^(UIImage *image) {
                ProduceImage *QRImgView=[[ProduceImage alloc]init];
                UIImage *QRImg=[QRImgView QRImageWithBgImg:[UIImage imageNamed:@"分享单宫图bg.jpg"] withQRCodeImage:image withTitle:title WithSubTitle:subTitle];
                [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:QRImg WithShareType:@"InviteFriends"];
            }];
            
            kSelfWeak;
            [DShareManager share].ShareSuccessBlock = ^{
                [MBProgressHUD showSuccess:@"分享成功" toView:weakSelf.view];
                if(![Signmanager SignManarer].share_isFinish)
                {
                    [TaskSignModel getTaskHttp:[Signmanager SignManarer].share_indexid Day:[Signmanager SignManarer].share_day Success:^(id data) {
                        TaskSignModel *model = data;
                        if(model.status == 1){
                            //                        [self setTaskPopMindView:Task_addCartSuccess];
                            [Signmanager SignManarer].share_isFinish = YES;
                            
                            //标记此任务完成
                            [Signmanager SignManarer].task_isfinish = YES;
                        }
                    }];
                }
            };
            [DShareManager share].ShareFailBlock = ^{
                [MBProgressHUD showError:@"分享失败" toView:weakSelf.view];
            };
            
        }
            break;
        case 102:{
            [self tapClick];
            MyLog(@"QQ空间");
            
            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app shardk];
            [[DShareManager share] shareAppWithType:ShareTypeQQSpace View:nil Image:[UIImage imageNamed:@"分享链接缩略图.jpg"] WithShareType:@"InviteFriends"];
            kSelfWeak;
            [DShareManager share].ShareSuccessBlock = ^{
                [MBProgressHUD showSuccess:@"分享成功" toView:weakSelf.view];
                if(![Signmanager SignManarer].share_isFinish)
                {
                    [TaskSignModel getTaskHttp:[Signmanager SignManarer].share_indexid Day:[Signmanager SignManarer].share_day Success:^(id data) {
                        TaskSignModel *model = data;
                        if(model.status == 1){
                            //                        [self setTaskPopMindView:Task_addCartSuccess];
                            [Signmanager SignManarer].share_isFinish = YES;
                            //标记此任务完成
                            [Signmanager SignManarer].task_isfinish = YES;
                        }
                    }];
                }
            };
            [DShareManager share].ShareFailBlock = ^{
                [MBProgressHUD showError:@"分享失败" toView:weakSelf.view];
            };
            
        }
            break;
        case 100:{
            [self tapClick];
            MyLog(@"微信");

            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app shardk];
            [[DShareManager share] shareAppWithType:ShareTypeWeixiSession View:nil Image:[UIImage imageNamed:@"分享链接缩略图.jpg"] WithShareType:@"InviteFriends"];
            kSelfWeak;
            [DShareManager share].ShareSuccessBlock = ^{
                [MBProgressHUD showSuccess:@"分享成功" toView:weakSelf.view];
                if(![Signmanager SignManarer].share_isFinish)
                {
                    [TaskSignModel getTaskHttp:[Signmanager SignManarer].share_indexid Day:[Signmanager SignManarer].share_day Success:^(id data) {
                        TaskSignModel *model = data;
                        if(model.status == 1){
                            //                        [self setTaskPopMindView:Task_addCartSuccess];
                            [Signmanager SignManarer].share_isFinish = YES;
                            //标记此任务完成
                            [Signmanager SignManarer].task_isfinish = YES;
                        }
                    }];
                }
            };
            [DShareManager share].ShareFailBlock = ^{
                [MBProgressHUD showError:@"分享失败" toView:weakSelf.view];
            };
            
        }
            break;
        case 105:{
            MyLog(@"面对面扫码");
            if(![Signmanager SignManarer].share_isFinish)
            {
                [TaskSignModel getTaskHttp:[Signmanager SignManarer].share_indexid Day:[Signmanager SignManarer].share_day Success:^(id data) {
                    TaskSignModel *model = data;
                    if(model.status == 1){
                        //                        [self setTaskPopMindView:Task_addCartSuccess];
                        [Signmanager SignManarer].share_isFinish = YES;
                        //标记此任务完成
                        [Signmanager SignManarer].task_isfinish = YES;
                    }
                }];
            }
            QRCodeVC *view=[[QRCodeVC alloc]init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        default:
            break;
    }

}
-(void)tapClick
{
    [_canclebtn removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        _Popview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        _InvitationCodeView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        _InvitationCodeView.alpha = 0;
    } completion:^(BOOL finish) {
        [_Popview removeFromSuperview];
        _Popview = nil;
    }];
    
}
@end








@implementation InviteModel
@end

@implementation InviteFriendsCell

- (UIImageView *)imgView {
    if (nil == _imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.clipsToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)nameLabel {
    if (nil == _nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = kSubTitleColor;
        _nameLabel.font = [UIFont systemFontOfSize:kZoom6pt(12)];
    }
    return _nameLabel;
}

- (UILabel *)moneyLabel {
    if (nil == _moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.textColor = tarbarrossred;
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.font = [UIFont systemFontOfSize:kZoom6pt(15)];
    }
    return _moneyLabel;
}

- (void)receiveModel:(InviteModel *)model {
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@!180",[NSObject baseURLStr_Upy],model.headImg]];

    [self.imgView sd_setImageWithURL:imgUrl];
    self.moneyLabel.text=[NSString stringWithFormat:@"%@元",model.money];
    self.nameLabel.text=[NSString stringWithFormat:@"%@ 获得奖励",model.name];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.moneyLabel];
    self.imgView.layer.cornerRadius=kZoom6pt(40)/2;
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kZoom6pt(15));
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@kZoom6pt(40));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(kZoom6pt(10));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@kZoom6pt(-15));
        make.top.equalTo(self.nameLabel);
        make.width.equalTo(@kZoom6pt(80));
    }];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    InviteFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:InviteCell];
    if (nil == cell) {
        cell = [[InviteFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:InviteCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end

