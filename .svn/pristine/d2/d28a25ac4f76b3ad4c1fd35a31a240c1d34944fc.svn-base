//
//  DBCenterViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/10/26.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "DBCenterViewController.h"
#import "GlobalTool.h"
#import "CollectionHeaderView.h"
#import "MembershipViewController.h"
#import "WithdrawalsViewController.h"
#import "TFIncomeStatisticsViewController.h"
#import "DistributionRegistViewController.h"
#import "PartnerCardViewController.h"

#import "AFNetworking.h"
#import "MyMD5.h"
#import "DistributionModel.h"
#import "UIImageView+WebCache.h"
#import "NavgationbarView.h"
#import "DShareManager.h"
#import "AppDelegate.h"
#import "ProduceImage.h"
#import "LoginViewController.h"

#define USER_H5ShareApp @"share/900_900_3_IOS.png"

@interface DBCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DShareManagerDelegate>{
    
    NSArray *_btnImgArray;
    NSArray *_titleArray;
    NSArray *_subTitleArray;
    NSMutableArray *_btnRedStringArray;
    CollectionHeaderView *_headerView;
    DistributionModel *_distributionmodel;
    UIView *_Popview;                               //邀请界面
    UILabel *_invitationNum;                         //邀请码
}
@property (strong, nonatomic)UICollectionView *collectionView;
@property (nonatomic, strong)NavgationbarView *showMsg;
@property (nonatomic, strong)UIImage *shareAppImg;
@property (nonatomic, copy)NSString *visityCode;

@end

@implementation DBCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    _btnImgArray = @[@"收益统计",@"会员",@"分销订单",@"邀请码-1"];
    _titleArray = @[@"收益统计",@"我的会员",@"分销订单",@"我的卡号"];
    _subTitleArray = @[@"元",@"个伙伴",@"张订单",@"卡号详情"];
    _btnRedStringArray = [NSMutableArray array];
    

    [self creatNavgationView];
    [self creatCollectionView];
    
    [self httpData];
    [self httpInvitationCode];
    [self httpGetShareImage];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(momneyChange:) name:@"changeMoney" object:nil];
}
-(void)momneyChange:(NSNotification *)note
{
    [self httpData];
}
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type
{
    NavgationbarView *nv = [[NavgationbarView alloc] init];
    if ([type isEqualToString:@"DBcenter"]) {
        if (shareStatus == 1) {
            [nv showLable:@"分享成功" Controller:self];
        } else if (shareStatus == 2) {
            [nv showLable:@"分享失败" Controller:self];
        } else if (shareStatus == 3) {
//            [nv showLable:@"分享取消" Controller:self];
        }
    }
}

- (void)httpGetShareImage
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], USER_H5ShareApp];
    //url = %@", url);
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject!=nil) {
            NSData *imgData = UIImagePNGRepresentation(responseObject);
            self.shareAppImg = [UIImage imageWithData:imgData];
        }
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
    
}


-(void)creatNavgationView
{
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kScreenWidth/2, headview.frame.size.height/2+10);
    titlelable.text= @"超级合伙人";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kScreenWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [headview addSubview:line];
}
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatCollectionView
{
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(_collectionView.frame.size.width, ZOOM(570));  //设置head大小
//    flowLayout.
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:RGBCOLOR_I(244,244,244)];
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.view addSubview:self.collectionView];
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        _headerView =(CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        _headerView.backgroundColor = [UIColor whiteColor];
//        _headerView.headImgView.backgroundColor=DRandomColor;
        _headerView.headImgView.contentMode=UIViewContentModeScaleAspectFit;
        if ([_distributionmodel.user_pic hasPrefix:@"http://"]) {
            [_headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_distributionmodel.user_pic]]];
        }else{
            [_headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], _distributionmodel.user_pic]]];
            
        }

        _headerView.nameLabel.text=_distributionmodel.user_name;
        _headerView.timeLabel.text=[NSString stringWithFormat:@"加入时间:%@",[MyMD5 getTimeToShowWithTimestamp:_distributionmodel.user_add_date]];
        
//        NSString *str = _distributionmodel.two_freeze_balance;
//        if (str == nil) {
//            str=@"0.00";
//        }
//        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"冻结佣金:%.2f元",str.floatValue]];
//        NSRange redRange = NSMakeRange([[noteStr string]rangeOfString:@":"].location+1,  str.length);
//        [noteStr addAttributes:@{NSForegroundColorAttributeName:tarbarrossred,NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:redRange];
//        [_headerView.freezeMoneyLabel setAttributedText:noteStr];
        
        NSString *str3 = _distributionmodel.depositMoneySuccessSum;
        if (str3 == nil||[str3 isEqualToString:@"0"]) {
            str3=@"0.00";
        }
        NSMutableAttributedString *noteStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已提现:%.2f元",str3.floatValue]];
        NSRange redRange3 = NSMakeRange([[noteStr3 string]rangeOfString:@":"].location+1,  str3.length);
        [noteStr3 addAttributes:@{NSForegroundColorAttributeName:tarbarrossred,NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:redRange3];
        [_headerView.depositMoneySuccessSumLabel setAttributedText:noteStr3];
        
//        NSString *str2 = _distributionmodel.two_balance;
//        if (str2==nil) {
//            str2=@"0.00";
//        }
//        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"可提现佣金:%.2f元",str2.floatValue]];
//        NSRange redRange2 = NSMakeRange([[noteStr2 string]rangeOfString:@":"].location+1,  str2.length);
//        [noteStr2 addAttributes:@{NSForegroundColorAttributeName:tarbarrossred,NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:redRange2];
//        [_headerView.availableMoneyLabel setAttributedText:noteStr2];

        _headerView.allMoneyLabel.text=_distributionmodel.two_balance;
        

        [_headerView.arrowBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        [_headerView.arrowBtn addTarget:self action:@selector(arrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        reusableview = _headerView;

        return reusableview;
    }
    return reusableview;
}

-(void)arrowBtnClick:(UIButton *)sender
{
    //arrowBtnClick  ");
    WithdrawalsViewController *view = [[WithdrawalsViewController alloc]init];
    view.model=_distributionmodel;
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    
    UIImageView *btnImg = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(160),ZOOM(30), cell.frame.size.width-ZOOM(160)*2, cell.frame.size.width-ZOOM(160)*2)];
    btnImg.image = [UIImage imageNamed:_btnImgArray[indexPath.row]];
//    btnImg.backgroundColor=DRandomColor;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btnImg.frame)+ZOOM(32), cell.frame.size.width, 21)];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:ZOOM(45)];
    titleLabel.textColor=kTitleColor;
    titleLabel.text=_titleArray[indexPath.row];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+ZOOM(10), titleLabel.frame.size.width, titleLabel.frame.size.height)];
    label.textColor = RGBCOLOR_I(102, 102, 102);
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:ZOOM(40)];
//    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if (_btnRedStringArray.count!=0 && indexPath.row<3) {
       [label setAttributedText:[self changString:_btnRedStringArray[indexPath.row] withString:_subTitleArray
         [indexPath.row]]];
        
    }else
        label.text=[NSString stringWithFormat:@"%@",_subTitleArray[indexPath.row]];

    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:btnImg];
    [cell.contentView addSubview:titleLabel];
    [cell.contentView addSubview:label];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}
-(NSMutableAttributedString *)changString:(NSString *)str withString:(NSString *)str2
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str,str2]];
    NSRange redRange = NSMakeRange(0, str.length);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:tarbarrossred,NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:redRange];
    
    return noteStr;
}
#pragma mark - UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame)*0.5-1, CGRectGetWidth(self.collectionView.frame)*0.5*0.8-1);
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
////    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

#pragma mark - UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
//    cell.backgroundColor = [UIColor greenColor];
    switch (indexPath.row) {
        case 0:
        {
            TFIncomeStatisticsViewController *tfIncome = [[TFIncomeStatisticsViewController alloc]init];
            tfIncome.model=_distributionmodel;
            [self.navigationController pushViewController:tfIncome animated:YES];
        }
            break;
        case 1:
        {
            MembershipViewController *membershipView = [[MembershipViewController alloc]init];
            membershipView.membersType=MembersGroup;
            [self.navigationController pushViewController:membershipView animated:YES];
        }
            break;
        case 2:
        {
            MembershipViewController *membershipView = [[MembershipViewController alloc]init];
            membershipView.membersType=MembersOrder;
            [self.navigationController pushViewController:membershipView animated:YES];
            
        }
            break;
        case 3:
        {
//            [self creatPopView];
            PartnerCardViewController *partnercard = [[PartnerCardViewController alloc]init];
            partnercard.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:partnercard animated:YES];
            
        }
            break;
        case 4:
        {
            DistributionRegistViewController *regist = [[DistributionRegistViewController alloc]init];
            regist.statu = @"商家信息审核通过";
            regist.businessDictionary = self.businessDictionary;
            [self.navigationController pushViewController:regist animated:YES];
        }
            break;
        default:
            break;
    }
    
    //item======%ld",(long)indexPath.item);
    //row=======%ld",(long)indexPath.row);

}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(void)httpData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString*token=[user objectForKey:USER_TOKEN];
    NSString *url=[NSString stringWithFormat:@"%@merchantAlliance/merchanMain?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    
    [manager GET:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //%@",responseObject);
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] integerValue]==1) {
                
                _distributionmodel = [[DistributionModel alloc]init];
                if (responseObject[@"two_balance"]==nil ||[[NSString stringWithFormat:@"%@", responseObject[@"two_balance"]] isEqualToString:@"<null>"]) {
                    _distributionmodel.two_balance = @"0.00" ;
                }else
                    _distributionmodel.two_balance = [NSString stringWithFormat:@"%.2f",[responseObject[@"two_balance"] floatValue]] ;
                
                _distributionmodel.user_add_date = [NSString stringWithFormat:@"%@",responseObject[@"user_add_date"]];
                _distributionmodel.user_pic = [NSString stringWithFormat:@"%@",responseObject[@"user_pic"]];
                _distributionmodel.user_name = [NSString stringWithFormat:@"%@",responseObject[@"user_name"]];
                _distributionmodel.twbAll = [NSString stringWithFormat:@"%.2f",[responseObject[@"twbAll"] floatValue]];
                _distributionmodel.orderCount = [NSString stringWithFormat:@"%@",responseObject[@"orderCount"]];
                if (responseObject[@"two_freeze_balance"]==nil ||[[NSString stringWithFormat:@"%@", responseObject[@"two_freeze_balance"] ]isEqualToString:@"<null>"]) {
                    _distributionmodel.two_freeze_balance = @"0.00";
                    
                }else
                    _distributionmodel.two_freeze_balance = [NSString stringWithFormat:@"%.2f",[responseObject[@"two_freeze_balance"]floatValue]];
                
                _distributionmodel.juniorUserCount = [NSString stringWithFormat:@"%@",responseObject[@"juniorUserCount"]];
                
                _btnRedStringArray = [NSMutableArray arrayWithObjects:_distributionmodel.twbAll,[NSString stringWithFormat:@"%@",_distributionmodel.juniorUserCount],[NSString stringWithFormat:@"%@",_distributionmodel.orderCount], nil];
                
                _distributionmodel.depositMoneySuccessSum=[NSString stringWithFormat:@"%@",responseObject[@"depositMoneySuccessSum"]];
            }else{
                
//                UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:responseObject[@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                [alter show];
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
            //            [_showMsg showLable:responseObject[@"message"] Controller:self];
            
            
            [_collectionView reloadData];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_showMsg showLable:@"网络开小差啦,请检查网络" Controller:self];
        
        
        
    }];
}
-(void)tapClick
{
    [_Popview removeFromSuperview];
}
/*******************  推广邀请码  ****************/
-(void)creatPopView
{
    _Popview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenHeight)];
//    _Popview.backgroundColor = [[UIColor colorWithRed:60/255.0 green:61/255.0 blue:62/255.0 alpha:0.8] colorWithAlphaComponent:0.7];
    _Popview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
//    [_Popview addGestureRecognizer:tap];
    
    
    UIView *InvitationCodeView = [[UIView alloc]initWithFrame:CGRectMake(ZOOM(60), ZOOM(160), kScreenWidth-ZOOM(60)*2, kScreenHeight-ZOOM(160)*2)];
    InvitationCodeView.backgroundColor=[UIColor whiteColor];
    InvitationCodeView.layer.cornerRadius=30;
    InvitationCodeView.clipsToBounds = YES;
    [_Popview addSubview:InvitationCodeView];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, InvitationCodeView.frame.size.width, InvitationCodeView.frame.size.height/4)];
    bgImg.backgroundColor=DRandomColor;
    bgImg.image = [UIImage imageNamed:@"背景(1)"];
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgImg.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(30, 30)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = bgImg.bounds;
//    maskLayer.path = maskPath.CGPath;
//    bgImg.layer.mask = maskLayer;
    [InvitationCodeView addSubview:bgImg];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(CGRectGetWidth(InvitationCodeView.frame)-40, 10, 30, 30);
//    btn.backgroundColor=[UIColor whiteColor];
    [btn setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
    btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    btn.layer.cornerRadius=15;
    [btn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    [InvitationCodeView addSubview:btn];
    
    CGFloat appImgWidth = InvitationCodeView.frame.size.width/6;
    UIImageView *appImg = [[UIImageView alloc]initWithFrame:CGRectMake((InvitationCodeView.frame.size.width-appImgWidth)/2, bgImg.frame.size.height-appImgWidth/2, appImgWidth, appImgWidth)];
//    appImg.backgroundColor=DRandomColor;
    appImg.contentMode=UIViewContentModeScaleAspectFit;
    [appImg setImage:[UIImage imageNamed:@"Icon"]];
    [InvitationCodeView addSubview:appImg];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(appImg.frame)+ZOOM(50), InvitationCodeView.frame.size.width, ZOOM(85))];
    title.text=@"衣蝠～会赚钱的女装APP";
    title.textAlignment=NSTextAlignmentCenter;
    title.font = kFont6px(34);
    [InvitationCodeView addSubview:title];
    UILabel *subTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame)+ZOOM(20), InvitationCodeView.frame.size.width, ZOOM(85))];
    subTitle.text=@"还等什么?快来下载吧!";
    subTitle.textColor= RGBCOLOR_I(102, 102, 102);
    subTitle.textAlignment=NSTextAlignmentCenter;
    subTitle.font = kFont6px(34);
    [InvitationCodeView addSubview:subTitle];
    
    NSString *st1 = @"邀请码";
    NSString *st2 = self.visityCode;
    
    
    CGSize size1 = [st1 boundingRectWithSize:CGSizeMake(1000, ZOOM(85)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont6px(34)} context:nil].size;
    
    CGSize size2 = [st2 boundingRectWithSize:CGSizeMake(1000, ZOOM(85)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont6px(34)} context:nil].size;
    
    CGFloat M = (int)ZOOM(40);
    CGFloat m_center = (int)ZOOM(15);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(InvitationCodeView.frame)-size1.width-size2.width-M-m_center)/2.0, CGRectGetMaxY(subTitle.frame)+ZOOM(100), size1.width+size2.width+M+m_center, ZOOM(85))];
    [InvitationCodeView addSubview:bgView];
    
    UILabel *invitation = [[UILabel alloc]initWithFrame:CGRectMake(0,0, size1.width, ZOOM(85))];
    invitation.text=@"邀请码";
    invitation.textAlignment= NSTextAlignmentRight;
    invitation.font = kFont6px(34);
    [bgView addSubview:invitation];
    
    _invitationNum = [[UILabel alloc]initWithFrame:CGRectMake(size1.width+m_center,0, size2.width+M, ZOOM(85))];
    _invitationNum.backgroundColor=RGBCOLOR_I(238, 162, 216);
    _invitationNum.textColor=[UIColor whiteColor];
    _invitationNum.textAlignment = NSTextAlignmentCenter;
    _invitationNum.text = self.visityCode;
    _invitationNum.font = kFont6px(34);
    [bgView addSubview:_invitationNum];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(InvitationCodeView.frame)*0.25, CGRectGetMaxY(bgView.frame)+ZOOM(100), CGRectGetWidth(InvitationCodeView.frame)*0.5, 1)];
    lineView.backgroundColor = lineGreyColor;
    [InvitationCodeView addSubview:lineView];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"微信", @"朋友圈", nil];
    
    CGFloat Mg = ZOOM(67);
    CGFloat M_lr = ZOOM(250);
    
    CGFloat W_btn = (CGRectGetWidth(InvitationCodeView.frame)-M_lr*2-Mg*(titleArr.count-1))/(titleArr.count);
    
    for (int i = 0; i<titleArr.count; i++) {
        CGFloat x = M_lr+i*Mg+i*W_btn;
        CGFloat y = CGRectGetMaxY(lineView.frame)+ZOOM(150);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, W_btn, W_btn);
        [btn setImage:[UIImage imageNamed:titleArr[i]] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        [InvitationCodeView addSubview:btn];
    }
    
    [_Popview addSubview:InvitationCodeView];
//    [[UIApplication sharedApplication].keyWindow addSubview:_Popview];

    [self.view addSubview:_Popview];

}

- (void)shareBtnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 100: {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                if (self.shareAppImg == nil) {
                    [self httpGetShareImage];
                } else {
                    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    [app shardk];
                    
                    ProduceImage *pi = [[ProduceImage alloc] init];
                   UIImage *img = [pi getH5Image:self.shareAppImg withQRCodeImage:nil withText:self.visityCode];
                    
                    
                    DShareManager *ds = [DShareManager share];
                    ds.delegate = self;
                    [ds shareAppWithType:ShareTypeWeixiSession withImageShareType:@"DBcenter" withImage:img];
                }
                
            } else {
                [self.showMsg showLable:@"没有安装微信" Controller:self];
                sender.userInteractionEnabled = NO;
                
                UIButton *btn = (UIButton *)[_Popview viewWithTag:101];
                btn.userInteractionEnabled = NO;
                
            }
            
        }
            break; 
            
        case 101: {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                if (self.shareAppImg == nil) {
                    [self httpGetShareImage];
                } else {
                    AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    [app shardk];
                    
                    ProduceImage *pi = [[ProduceImage alloc] init];
                   UIImage *img = [pi getH5Image:self.shareAppImg withQRCodeImage:nil withText:self.visityCode];
                    
                    DShareManager *ds = [DShareManager share];
                    ds.delegate = self;
                    [ds shareAppWithType:ShareTypeWeixiTimeline withImageShareType:@"DBcenter" withImage:img];
                }
                
            } else {
                [self.showMsg showLable:@"没有安装微信" Controller:self];
                sender.userInteractionEnabled = NO;
                
                UIButton *btn = (UIButton *)[_Popview viewWithTag:100];
                btn.userInteractionEnabled = NO;
            }
        }
            break;
            
        case 102: {
            
        }
            break;
        case 103:
            
            break;
        default:
            break;
    }
}

#pragma mark - 获取邀请码
- (void)httpInvitationCode
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    NSString *token = [user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@inviteCode/getInviteCode?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                //            _invitationNum = [NSString stringWithFormat:@"%@",responseObject[@"inviteCode"]];
                self.visityCode = [NSString stringWithFormat:@"%@",responseObject[@"inviteCode"]];
                
            }
            else if(str.intValue == 10030){//没登录状态
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }

            else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc] init];
                [mentionview showLable:@"网络异常，请稍后重试" Controller:self];
            }
            
            [[Animation shareAnimation] stopAnimationAt:self.view];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NavgationbarView *)showMsg
{
    if (_showMsg == nil) {
        _showMsg = [[NavgationbarView alloc] init];
    }
    return _showMsg;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
