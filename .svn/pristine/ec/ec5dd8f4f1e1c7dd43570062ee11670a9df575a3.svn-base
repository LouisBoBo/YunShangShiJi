//
//  CrazyMondayActivityVC.m
//  YunShangShiJi
//
//  Created by yssj on 2017/1/5.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CrazyMondayActivityVC.h"
#import "TaskCollectionVC.h"
#import "TFActivityShopVC.h"
#import "TFCollocationViewController.h"
#import "CrazyStyleViewController.h"

#define CrazyMondayBgColor RGBA(252, 3, 222, 1)

NSString *ReusableCell = @"ReusableCell";

@interface CrazyMondayActivityVC ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_infoArr;
    
    UIButton *FootBtn;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation CrazyMondayActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _infoArr = [NSMutableArray arrayWithObjects: @[@"1.疯狂新衣节下单支付成功立即获得额度抽奖机会，抽奖次数为平日的两倍。\n例如：平日购买100元商品赠送衣豆可以抽奖10次，疯狂新衣节购买100元商品将可获赠20次抽奖机会。",
                                                   @"2.疯狂新衣节当天使用抽奖次数抽奖的中奖率100%，衣豆抽奖为正常中奖概率。",
                                                   @"3.疯狂新衣节使用抽奖机会抽奖获得的提现额度将到订单完结(不可退款退货)才可解冻至可提现额度。",
                                                   @"4.如果订单期间发生退款，疯狂新衣节当天所获得的所有冻结额度将会被扣除。",
                                                   @"5.疯狂新衣节获得的抽奖机会务必全部使用完，23:59以后将会自动取消当日所有订单获赠的抽奖机会。",
                                                   ],nil]
    ;
   
    [self setNavigationItemLeft:@"活动详情"];
    [self setFootView];
    
    [self.view addSubview:self.tableView];

}
- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:false];
}
#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _infoArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_infoArr[section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ReusableCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ReusableCell];
        cell.backgroundColor=[UIColor clearColor];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor=[UIColor whiteColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    NSString *str=_infoArr[indexPath.section][indexPath.row];
    NSMutableAttributedString * attributedString1 = [NSString getOneColorInLabel:str strs:@[@"例如：平日购买100元商品赠送衣豆可以抽奖10次，疯狂新衣节购买100元商品将可获赠20次抽奖机会",@"（不可退款退货）",@"务必全部使用完"] Color:[UIColor yellowColor] fontSize:ZOOM6(28)];
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];

    [cell.detailTextLabel setAttributedText:attributedString1];
    
    [cell.detailTextLabel sizeToFit];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return
    [NSString heightWithString:_infoArr[indexPath.section][indexPath.row] font:[UIFont systemFontOfSize:ZOOM6(32)] constrainedToWidth:kScreenWidth]+20;
}
#pragma mark --懒加载
- (UITableView *)tableView {
    if (nil==_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-ZOOM(200)) style:UITableViewStylePlain];
        _tableView.backgroundColor=CrazyMondayBgColor;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView=[self tableHeader];
    }
    return _tableView;
}
- (UIView *)tableHeader {
    CGFloat height=kScreenWidth*1000/750;
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height+ZOOM6(100))];
    UIImageView *headerIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    [headerIMG setImage:[UIImage imageNamed:@"monday_bg_hdxq"]];
    headerIMG.backgroundColor=[UIColor whiteColor];
    [header addSubview:headerIMG];
    
    UILabel *remind=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(260))/2, CGRectGetMaxY(headerIMG.frame)+ZOOM6(30), ZOOM6(260), ZOOM6(70))];
    remind.text=@"活动规则";
    remind.font=[UIFont boldSystemFontOfSize:ZOOM6(40)];
    remind.textColor=[UIColor whiteColor];
    remind.textAlignment=NSTextAlignmentCenter;
    remind.backgroundColor=CrazyMondayBgColor;
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(ZOOM6(42), CGRectGetMidY(remind.frame), kScreenWidth-ZOOM6(42)*2, 2)];
    line.backgroundColor=[UIColor whiteColor];
    [header addSubview:line];
    [header addSubview:remind];

    return header;
}
- (void)setFootView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-ZOOM(200), kScreenWidth, ZOOM(200))];
    [self.view addSubview:view];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor=kNavLineColor;
    [view addSubview:line];
    
    FootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FootBtn.frame=CGRectMake(kZoom6pt(15), ZOOM(32), kScreenWidth-kZoom6pt(15)*2, view.frame.size.height-ZOOM(32)*2);
    [FootBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FootBtn setTitle:@"获取抽奖机会" forState:UIControlStateNormal];
    [FootBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateNormal];
    FootBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOMPT(18)];
    [FootBtn addTarget:self action:@selector(FootBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    FootBtn.layer.cornerRadius = 3;
    FootBtn.layer.masksToBounds = YES;
    [view addSubview:FootBtn];
}
- (void)FootBtnClick:(UIButton *)btn {
    
//    [self shoppinggo:[DataManager sharedManager].mondayValue];
    
    CrazyStyleViewController *vc = [[CrazyStyleViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//购买几件商品
- (void)shoppinggo:(NSString*)dataStr
{
    NSString *value1 = dataStr;
    
    if([value1 isEqualToString:@"type_name=热卖&notType=true"])//热卖
    {
        TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
        vc.typeID = [NSNumber numberWithInt:6];
        vc.typeName = @"热卖";
        vc.title = @"热卖";
        vc.is_jingxi = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([value1 isEqualToString:@"collection=shop_activity"])//活动商品
    {
        TFActivityShopVC *vc = [[TFActivityShopVC alloc]init];
        vc.isMonday = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([value1 isEqualToString:@"collection=collocation_shop"])//搭配
    {
        TFCollocationViewController *testVC = [[TFCollocationViewController alloc] init];
        testVC.typeName = @"搭配";
        testVC.pushType = PushTypeSign;
        testVC.isFinish = YES;
        testVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:testVC animated:YES];
    }else if ([value1 isEqualToString:@"collection=csss_shop"])//专题
    {
        TFCollocationViewController *subVC = [[TFCollocationViewController alloc] init];
        subVC.page = 0;
        subVC.typeName = @"专题";
        subVC.typeID = [NSNumber numberWithInt:2];
        subVC.isFinish = YES;
        subVC.pushType = PushTypeSign;
        subVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subVC animated:YES];
        
    }else if ([value1 isEqualToString:@"collection=shop_home"])//首页
    {
        Mtarbar.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    else if ([value1 isEqualToString:@"collection=shopping_page"])//购物界面
    {
        Mtarbar.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    else{//其它合集(热卖)
        
        TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
        vc.typeID = [NSNumber numberWithInt:6];
        vc.typeName = @"热卖";
        vc.title = @"热卖";
        vc.is_jingxi = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
