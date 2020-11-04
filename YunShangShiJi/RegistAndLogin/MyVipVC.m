//
//  MyVipVC.m
//  YunShangShiJi
//
//  Created by yssj on 2016/11/17.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "MyVipVC.h"
#import "GlobalTool.h"
#import "TaskCollectionVC.h"

#define powerColor RGBA(254, 206, 92, 1)
#define powerLightColor RGBA(223, 223, 223, 1)

@interface MyVipVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *progressView;
    CALayer *progressLayer;
    
    UIImageView *userVip;
    
    NSMutableArray *vipNameArr;
    NSMutableArray *vipNumArr;
    NSArray *vipImgArr;
}
@property (nonatomic,strong)UITableView *myTable;
@property (nonatomic,strong)NSMutableArray *tableData;

@end

@implementation MyVipVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    vipNameArr = [NSMutableArray array];vipNumArr = [NSMutableArray array];
    NSArray *gradeKeyValue = [[NSUserDefaults standardUserDefaults]objectForKey:@"gradeKeyValue"];
    [gradeKeyValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr=[(NSString *)obj componentsSeparatedByString:@","];
        [vipNameArr addObject:[NSString stringWithFormat:@"%@会员",arr[1]]];
        [vipNumArr addObject:arr[0]];
    }];
//    vipNameArr=@[@"普通会员",@"青铜会员",@"白银会员",@"黄金会员"];
//    vipNumArr=@[@"0",@"40",@"100",@"300",@"500"];

    vipImgArr=@[@"icon_vip_nor",@"icon_vip_Bronze",@"icon_vip_silver",@"icon_vip_gold"];
    self.tableData=[NSMutableArray arrayWithObjects:
                    @"1.什么是活力值？\n活力值是进行“每日必做任务”的前提条件，每做一个必做任务，需要消耗1点活力值。活力值为0后，将不能在进行“每日必做任务”",
                    @"2.如何获得活力值？\n活力值需要购买商品（抽奖除外）才能补充，商品订单实付金额=活力值，例如：实付100元商品将会获得100点成长值。\n注：用户签收商品后，成长值才会到账，若是发生退货退款，退货退款商品奖励的成长值将会被扣除",
                    @"3.什么是每日领券特权？\n每日领券特权是指用户每日登录衣蝠后，将会获得相应的抵用券，抵用券直接发放到用户账户，可用于购买商品时抵扣商品售价。",
                    @"4.什么是任务提现特权？\n任务提现特权是指用户在每日任务中获得的现金提现的资格，只有“青铜”、“白银”、“黄金”资格的会员才可以提现任务的现金奖励喔~", nil];
    
    [self setNavigationItemLeft:@"我的会员"];
    [self setFootView];
    [self.view addSubview:self.myTable];
    
    
    [self setProgerss:[DataManager sharedManager].vipGrade];
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSMutableString *str = _tableData[indexPath.row];
    NSArray *arr = [str componentsSeparatedByString:@"\n"];
    
    UIFont *titlefont = [UIFont systemFontOfSize:ZOOM6(32)];
    NSString *titlestr = [NSString stringWithFormat:@"%@",arr[0]];
    NSString *detailTextStr =
    arr.count==3?
    [NSString stringWithFormat:@"%@\n%@\n%@",arr[0],arr[1],arr[2]]:
    [NSString stringWithFormat:@"%@\n%@",arr[0],arr[1]];
    
    cell.detailTextLabel.text = detailTextStr;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.textColor=kSubTitleColor;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
    
    //lable的行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cell.detailTextLabel.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    
    
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cell.detailTextLabel.text length])];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value: kMainTitleColor range:NSMakeRange(0, titlestr.length)];
    
    [attributedString1 addAttribute:NSFontAttributeName value:titlefont range:NSMakeRange(0, titlestr.length)];
    if (arr.count==3) {
        NSString *str = [NSString stringWithFormat:@"%@",arr[2]];
        [attributedString1 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM6(24)],NSForegroundColorAttributeName:kTextColor} range:NSMakeRange(detailTextStr.length-str.length, str.length)];
    }
    
    [cell.detailTextLabel setAttributedText:attributedString1];
    [cell.detailTextLabel sizeToFit];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20+[NSString heightWithString:_tableData[indexPath.row] font:[UIFont systemFontOfSize:ZOOM6(34)] constrainedToWidth:kScreenWidth];
}


- (void)setProgerss:(NSInteger) progressNum {
//    progressNum=3;[DataManager sharedManager].vitality=500;
    [userVip setImage:[UIImage imageNamed:vipImgArr[progressNum]]];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat progressLayerWidth=(kScreenWidth-ZOOM6(40)*2-ZOOM6(90))/vipNumArr.count;
//        CGFloat distance = progressNum+1>=vipNumArr.count
//                         ? ([DataManager sharedManager].vitality-[vipNumArr[progressNum]integerValue])
//                         : [vipNumArr[progressNum+1]integerValue]-[vipNumArr[progressNum]integerValue];
//       CGFloat width = ([DataManager sharedManager].vitality-[vipNumArr[progressNum]integerValue])/distance*progressLayerWidth;
        progressNum=[DataManager sharedManager].vitality==[vipNumArr[progressNum]integerValue]?progressNum:progressNum+1;
        [UIView animateWithDuration:2.5 animations:^{
            progressLayer.frame=CGRectMake(0, 0, progressLayerWidth*progressNum, 2);
            for (int i=0; i<=progressNum; i++) {
                UIView *circle=(UIView *)[progressView viewWithTag:10+i];
                circle.backgroundColor=powerColor;
            }
        }];
//    });
   
}
- (void)FootBtnClick:(UIButton*)sender {
    MyLog(@"补充活力值");
    TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
    vc.typeID = [NSNumber numberWithInt:6];
    vc.typeName = @"热卖";
    vc.title = @"热卖";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setFootView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-ZOOM(200), kScreenWidth, ZOOM(200))];
    [self.view addSubview:view];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor=kNavLineColor;
    [view addSubview:line];
    
    UIButton *FootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FootBtn.frame=CGRectMake(kZoom6pt(15), ZOOM(32), kScreenWidth-kZoom6pt(15)*2, view.frame.size.height-ZOOM(32)*2);
    [FootBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FootBtn setTitle:@"补充活力值" forState:UIControlStateNormal];
    [FootBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateNormal];
    FootBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOMPT(18)];
    [FootBtn addTarget:self action:@selector(FootBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    FootBtn.layer.cornerRadius = 3;
    FootBtn.layer.masksToBounds = YES;
    [view addSubview:FootBtn];
}
- (UIView *)tableHeader {
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(470)*2)];
    
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(490))];
    bgImg.image=[UIImage imageNamed:@"bg_vip"];
    UIImageView *userImg=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(130))/2, ZOOM6(40), ZOOM6(130), ZOOM6(130))];
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/headImgae%@.png",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    userImg.image=[[UIImage alloc] initWithContentsOfFile:aPath];
    userImg.layer.cornerRadius=ZOOM6(130)/2;
    userImg.layer.borderColor=[UIColor whiteColor].CGColor;
    userImg.layer.borderWidth=2;
    userImg.clipsToBounds=YES;
    CGFloat userVipWidth=ZOOM6(40);
    userVip=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(userImg.frame)-userVipWidth, CGRectGetMaxY(userImg.frame)-userVipWidth, userVipWidth, userVipWidth)];
    userVip.contentMode=UIViewContentModeScaleAspectFit;
    UILabel *userName=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(userImg.frame)+ZOOM6(0), kScreenWidth, 21)];
    userName.textColor=[UIColor whiteColor];
    userName.font=[UIFont systemFontOfSize:ZOOM6(24)];
    userName.text=[[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME];
    userName.textAlignment=NSTextAlignmentCenter;
    UILabel *power=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(userName.frame)+ZOOM6(0), kScreenWidth, 21)];
    power.textAlignment=NSTextAlignmentCenter;
    power.textColor=powerColor;
    power.font=[UIFont systemFontOfSize:ZOOM6(30)];
    power.text=[NSString stringWithFormat:@"活力值：%zd",[DataManager sharedManager].vitality];
    
    UILabel *progressLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(40), CGRectGetHeight(bgImg.frame)-ZOOM6(100), ZOOM6(90), 20)];
    progressLabel.text=@"活力值";
    progressLabel.textAlignment=NSTextAlignmentLeft;
    progressLabel.textColor=[UIColor whiteColor];
    progressLabel.font=[UIFont systemFontOfSize:ZOOM6(20)];
    [bgImg addSubview:progressLabel];
    
    CGFloat progressWidth=(kScreenWidth-ZOOM6(40)*2-ZOOM6(90))/vipNumArr.count;
    progressView=[[UIView alloc]initWithFrame:CGRectMake(progressLabel.width+ZOOM6(40), progressLabel.y+9, kScreenWidth-ZOOM6(40)*2-ZOOM6(90), 2)];
    progressView.backgroundColor=RGBA(223, 223, 223, 1);

    progressLayer=[CALayer layer];
    progressLayer.backgroundColor=powerColor.CGColor;
    progressLayer.frame=CGRectMake(0, 0, 0, 2);
    [progressView.layer addSublayer:progressLayer];
    
    for (int i=0; i<vipNumArr.count; i++) {
        UIView *circle=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 6, 6)];
        circle.center=CGPointMake(progressWidth*i, 1);
        circle.backgroundColor=powerLightColor;
        circle.layer.cornerRadius=3;
        circle.tag=10+i;
        [progressView addSubview:circle];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(progressView.x-20+i*progressWidth, progressView.y+3, 40, 20)];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        label.text=vipNumArr[i];
        label.font=[UIFont systemFontOfSize:ZOOM6(24)];
        [bgImg addSubview:label];
    }
    
    for (int i=0; i<vipNameArr.count; i++) {
        CGFloat height=ZOOM6(60);
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(progressView.x+i*progressWidth, progressView.y-ZOOM6(70)-height, progressWidth, ZOOM6(70))];
        img.contentMode=UIViewContentModeScaleAspectFit;
        img.image=[UIImage imageNamed:vipImgArr[i]];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(img.x, progressView.y-height, img.width, height)];
        lable.text=vipNameArr[i];
        lable.textColor=[UIColor whiteColor];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.font=[UIFont systemFontOfSize:ZOOM6(24)];
        [bgImg addSubview:img];
        [bgImg addSubview:lable];
    }
    
    [bgImg addSubview:userImg];
    [bgImg addSubview:userVip];
    [bgImg addSubview:userName];
    [bgImg addSubview:power];
    [bgImg addSubview:progressView];
    [header addSubview:bgImg];
    
    UILabel *vipTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgImg.frame)+ZOOM6(40), kScreenWidth, 20)];
    vipTitle.text=@"会员权益";
    vipTitle.textColor=kMainTitleColor;
    vipTitle.textAlignment=NSTextAlignmentCenter;
    vipTitle.font=[UIFont systemFontOfSize:ZOOM6(36)];
    [header addSubview:vipTitle];
    UIImageView *vipImg=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(40), CGRectGetMaxY(vipTitle.frame)+ZOOM6(20), kScreenWidth-ZOOM6(80), kScreenWidth*450/1065)];
    vipImg.image=[UIImage imageNamed:@"会员权益"];
    vipImg.contentMode=UIViewContentModeScaleAspectFit;
    [header addSubview:vipImg];
    
//    bgImg.backgroundColor=DRandomColor;vipImg.backgroundColor=DRandomColor;
    return header;
}

#pragma 懒加载
- (UITableView *)myTable {
    if (_myTable==nil) {
        _myTable=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-ZOOM(200)) style:UITableViewStylePlain];
        _myTable.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTable.dataSource=self;
        _myTable.delegate=self;
        _myTable.tableHeaderView=[self tableHeader];
    }
    return _myTable;
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
