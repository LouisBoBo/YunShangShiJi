//
//  CrazyStyleViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/9/13.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CrazyStyleViewController.h"
#import "TFSearchViewController.h"
#import "TFScreenViewController.h"
#import "TFLedBrowseCollocationShopVC.h"
#import "TFLedBrowseShopViewController.h"
#import "TFActivityShopVC.h"
#import "GlobalTool.h"
#import "SqliteManager.h"
#import "DefaultImgManager.h"
#import "TaskCollectionVC.h"
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
@interface CrazyStyleCell : UITableViewCell
@property (nonatomic, strong) UIImageView *backImg;
@property (nonatomic, strong) UILabel *nameLabel;
@end
@implementation CrazyStyleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _backImg = [[UIImageView alloc] initWithFrame:CGRectMake(ZOOMPT(8), 0, kScreenWidth-2*ZOOMPT(8), ZOOMPT(210))];
        _backImg.backgroundColor = RGBCOLOR_I(239, 239, 239);
        _backImg.layer.cornerRadius = ZOOM6(10);
        _backImg.clipsToBounds = YES;
        _backImg.userInteractionEnabled = YES;
        _backImg.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_backImg];
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

@interface CrazyStyleViewController ()

@end

@implementation CrazyStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadView];
    [self creatTableviw];
    [self creaData];
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
    titlelable.text=@"疯狂新衣节";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
}

- (void)creatTableviw
{
    [self.view addSubview:self.myTableView];
}

- (void)creaData
{
    
    NSDictionary *parameter = @{@"type": @"6"};
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_shop_queryOption parameter:parameter caches:YES cachesTimeInterval:0*TFMinute token:NO success:^(id data, Response *response) {
        [self.dataArr removeAllObjects];
        
        for (NSDictionary *dic in data[@"crazyMonday"]) {
            TFShoppingM *model=[TFShoppingM yy_modelWithJSON:dic];
            [self.dataArr addObject:model];
        }

        if (self.dataArr.count) {
            [self.myTableView reloadData];
        }

    } failure:^(NSError *error) {
        
    }];

}

- (UIView *)headview;
{
    if(_headview == nil)
    {
        _headview = [[UIView alloc]init];
        _headview.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
        
        UIImageView *headImage = [[UIImageView alloc]init];
        headImage.frame = CGRectMake(ZOOMPT(8), ZOOMPT(8), kScreenWidth-2*ZOOMPT(8), kScreenWidth-2*ZOOMPT(8));
//        headImage.image = [UIImage imageNamed:@"banana顶部"];
        [headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@sign_in/crazy/crazyPic.jpg",[NSObject baseURLStr_Upy]]]];
                   
        headImage.layer.cornerRadius = ZOOM6(10);
        headImage.clipsToBounds = YES;
        
        [_headview addSubview:headImage];
    }
    return _headview;
}
- (UITableView *)myTableView {
    if (_myTableView==nil) {
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) style:UITableViewStylePlain];
        _myTableView.backgroundColor = RGBCOLOR_I(239, 239, 239);
        _myTableView.dataSource=self;
        _myTableView.delegate=self;
        _myTableView.rowHeight = ZOOMPT(218);
        _myTableView.tableHeaderView = self.headview;
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[CrazyStyleCell class] forCellReuseIdentifier:@"CrazyStyleCell"];
    }
    return _myTableView;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CrazyStyleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CrazyStyleCell"];
    cell.backgroundColor = RGBCOLOR_I(239, 239, 239);
    TFShoppingM *model=self.dataArr[indexPath.row];
    NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@!450",[NSObject baseURLStr_Upy],model.url];
    [cell.backImg sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:DefaultImg(cell.backImg.size)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TFShoppingM *model=self.dataArr[indexPath.row];
    SqliteManager *manager = [SqliteManager sharedManager];
    NSString *BannerID=[NSString stringWithFormat:@"%@",model.option_type];
    ShopTagItem *item = [manager getSignShopBannerForId:BannerID];
    
    [self gotovc:item];
}

- (void)gotovc:(ShopTagItem*)shopitem
{
    NSString * valueStr = shopitem.value;
    if([valueStr isEqualToString:@"collection=shop_activity"])//活动商品
    {
        TFActivityShopVC *vc = [[TFActivityShopVC alloc]init];
        vc.bannerImage = shopitem.banner;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([valueStr isEqualToString:@"collection=collocation_shop"])//新版搭配
    {
        TFLedBrowseCollocationShopVC *vc = [[TFLedBrowseCollocationShopVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([valueStr hasPrefix:@"type2"])//小外套 连衣裙
    {
        if (shopitem.ID != nil) {
            NSArray *valueArr = [shopitem.value componentsSeparatedByString:@"="];
            NSString *typeid = valueArr.count>=2?valueArr[1]:@"11";
            
            TFSearchViewController *svc = [[TFSearchViewController alloc] init];
            svc.parentID = typeid;
            svc.shopTitle = shopitem.tag_name;
            svc.bannerImage = shopitem.banner;
            svc.isCrazy = YES;
            svc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:svc animated:YES];
        }
    }else if ([valueStr hasPrefix:@"favorite"] || [valueStr hasPrefix:@"fix_price"] ||[valueStr hasPrefix:@"style"] || [valueStr rangeOfString:@"tag_info"].length>0 || [valueStr hasPrefix:@"type1"])//筛选
    {
        if(valueStr != nil)
        {
            TFScreenViewController *screen = [[TFScreenViewController alloc]init];
            screen.muStr = valueStr;
            screen.index = 1;
            screen.titleText = shopitem.tag_name;
            screen.bannerImage = shopitem.banner;
            screen.comefrom = @"任务";
            screen.hidesBottomBarWhenPushed=YES;
            
            if([valueStr hasPrefix:@"type1"])
            {
                NSArray *arr = [valueStr componentsSeparatedByString:@"="];
                if(arr.count>=2)
                {
                    screen.index = 4;
                    screen.type1 = arr[1];
                    screen.type_name = shopitem.tag_name;
                }
            }
            [self.navigationController pushViewController:screen animated:YES];
        }
    }else if([valueStr isEqualToString:@"type_name=热卖&notType=true"])//热卖
    {
        TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
        vc.typeID = [NSNumber numberWithInt:6];
        vc.typeName = @"热卖";
        vc.title = @"热卖";
        vc.isbrowse = YES;
        vc.hidesBottomBarWhenPushed = YES;
        vc.bannerImage = shopitem.banner;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        TFLedBrowseShopViewController *lbVC = [[TFLedBrowseShopViewController alloc] init];
        lbVC.title = shopitem.tag_name;
        lbVC.bannerImage = shopitem.banner;
        lbVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:lbVC animated:YES];
    }
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (TFTopShopsVM*)tfShopsModel
{
    if(_tfShopsModel == nil)
    {
        _tfShopsModel = [[TFTopShopsVM alloc]init];
    }
    return _tfShopsModel;
}

- (NSMutableArray*)dataArr
{
    if(_dataArr == nil)
    {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
