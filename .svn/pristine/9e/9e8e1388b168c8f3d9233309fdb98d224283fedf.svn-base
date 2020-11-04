//
//  BrandAndStyleChoseVC.m
//  YunShangShiJi
//
//  Created by yssj on 2017/4/10.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BrandAndStyleChoseVC.h"
#import "NewPublishThemeAndDressVC.h"
#import "RelationShopViewController.h"

#import "BrandStyleView.h"
#import "MultilevelMenu.h"
#import "BrandTextFieldView.h"
#import "SqliteManager.h"

#import "WaterFallFlowViewModel.h"

@interface BrandAndStyleChoseVC ()<UITableViewDataSource,UITableViewDelegate,BrandStyleDelegate>
{
    UIButton *setbtn;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *BSDataArr;
@property (nonatomic,strong)NSArray *leftArr;


@property (nonatomic,strong)NSString *brandID;
@property (nonatomic,strong)NSString *styleID;
@property (nonatomic,strong)NSString *type1;
@property (nonatomic,strong)NSString *type2;
//@property (nonatomic,strong)NSString *shop_code;


@property (strong, nonatomic) WaterFallFlowViewModel *viewModel;   //数据模型

@end

@implementation BrandAndStyleChoseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self creatData];
    
    self.titleArr=@[@"品牌(必填)",@"风格类目(必填)"];
    [self.view addSubview:self.tableView];
    [self setNavigationItemLeftAndRight];
    
  
}
- (void)creatData {
    self.viewModel = [[WaterFallFlowViewModel alloc] init];
    kSelfWeak;
    [self.viewModel getData:^{
        weakSelf.leftArr = self.viewModel.dataArray[1];
    } Fail:^{
       
    }];
    
}
- (void)showBrandStyleView {
    BrandStyleView* BSView=[[BrandStyleView alloc]initWithData:self.BSDataArr];
    BSView.leftData=self.leftArr;
    BSView.delegate=self;
    [BSView show];
}
- (void)showBrandTextFieldView {
//    NSArray *arr=@[@"1234567890",@"击的菜单",@"三宝饿",@"粉丝 v 梦想从",@"大脸猫聪明",@"从肯出来喝咖啡的理念",@"从事讷"];
    SqliteManager *manager = [SqliteManager sharedManager];
    NSArray *arr = [manager getAllForBrandsItem];
    BrandTextFieldView *bt=[[BrandTextFieldView alloc]initWithData:arr];
    kSelfWeak;
    bt.confirmBlock = ^(NSString *str,NSString *ID) {
        MyLog(@"%@ %@",str,ID);
        weakSelf.brandStr=str;
        weakSelf.brandID=ID;
        [weakSelf reloadRow:0 withStr:str];
        [weakSelf changeDoneBtnState];
    };
    [bt show];
}
#pragma mark BrandStyleDelegate
- (void)leftMenuSelectLeft:(NSInteger)left right:(id)right info:(id)info {
    MyLog(@"%zd  %@ %@",left,right,info);
    self.styleID=[NSString stringWithFormat:@"%@",right];
    self.styleStr=[NSString stringWithFormat:@"%@",info];
//    [self reloadRow:1 withStr:self.styleStr];
    [self changeDoneBtnState];
}
- (void)rightMenuSelectLeft:(NSInteger)left right:(NSInteger)right info:(id)info {
    MyLog(@"%zd  %zd %@",left,right,info);
    self.type1=[NSString stringWithFormat:@"%zd",left];
    self.type2=[NSString stringWithFormat:@"%zd",right];
    self.styleStr=[NSString stringWithFormat:@"%@ %@",self.styleStr,info];
    [self reloadRow:1 withStr:self.styleStr];
    [self changeDoneBtnState];
}
- (void)reloadRow:(NSInteger)row withStr:(NSString *)str {
    NSInteger section = _sectionType==Section_AllType?1:0;
    [self.detailArr replaceObjectAtIndex:row withObject:str];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL isShop = indexPath.section==0&&(_sectionType==Section_AllType||_sectionType==Section_ShopType);

    if (isShop) {
        RelationShopViewController *vc=[[RelationShopViewController alloc]init];
        kSelfWeak;
        vc.selectShopBlock = ^(NSString *shopBrand,NSNumber *shopBrandID,NSString *shop_code){
            NSString *brandId=[NSString stringWithFormat:@"%zd",[shopBrandID integerValue]];
            if (shopBrand==nil||[shopBrand containsString:@"null"]) {
                shopBrand=@"";
            }
            if (weakSelf.tagMsgblock) {
                weakSelf.tagMsgblock(shopBrand,weakSelf.styleStr,brandId, weakSelf.styleID, weakSelf.type1, weakSelf.type2,shop_code);
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.row==0) {
        [self showBrandTextFieldView];
    }else if (indexPath.row==1) {
        [self showBrandStyleView];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return ZOOM6(20);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionType==Section_AllType?2:1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_sectionType==Section_AllType) {
        return section?2:1;
    }else if (_sectionType==Section_NormalType)
        return 2;
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.textColor=kMainTitleColor;
        cell.detailTextLabel.textColor=kMainTitleColor;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font=[UIFont systemFontOfSize:ZOOM6(28)];
        cell.detailTextLabel.font=[UIFont systemFontOfSize:ZOOM6(28)];
    }
    BOOL isShop = indexPath.section==0&&(_sectionType==Section_AllType||_sectionType==Section_ShopType);
    cell.textLabel.text=isShop?@"从商品库添加商品":self.titleArr[indexPath.row];
    cell.detailTextLabel.text=isShop?@"":self.detailArr[indexPath.row];
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins=UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar) style:UITableViewStylePlain];
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(20))];
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorColor=kTableLineColor;
        _tableView.rowHeight=ZOOM6(120);
    }
    return _tableView;
}
- (NSMutableArray *)detailArr {
    if (!_detailArr) {
        _detailArr=[NSMutableArray arrayWithObjects:@"",@"", nil];
    }
    return _detailArr;
}
- (NSArray *)BSDataArr {
    if (_BSDataArr==nil) {
        SqliteManager *manager = [SqliteManager sharedManager];
        NSMutableArray * firstArray = [NSMutableArray array];
        NSMutableArray * item2Arr = [NSMutableArray array];
        NSArray *arr = [manager getShopTypeItemForSuperId:@"0"];
        for (ShopTypeItem *item in arr) {
            if (![item.type_name isEqualToString:@"特卖"]&&![item.type_name isEqualToString:@"热卖"]&&![item.type_name isEqualToString:@"上新"]) {
                [firstArray addObject:item];
                [item2Arr addObject:[manager getShopTypeItemForSuperId:item.ID]];
            }
        }
        NSMutableArray *name2Arr = [NSMutableArray array];
        [item2Arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *itemArr=obj;
            NSMutableArray *arr2=[NSMutableArray array];
            [itemArr enumerateObjectsUsingBlock:^(id  _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
                ShopTypeItem *item2=obj2;
                [arr2 addObject:item2];
            }];
            [name2Arr addObject:arr2];
        }];
        NSMutableArray * lis = [NSMutableArray arrayWithCapacity:0];
        //测试数据：
        /*
        NSMutableArray * nameArray = [NSMutableArray arrayWithObjects:
                                      @"热搜榜",
                                      @"红酒馆",
                                      @"白酒馆",
                                      @"洋酒馆",
                                      @"滋补品",
                                      nil];
        NSArray * items = @[
                            @[@"节日送礼",@"婚庆用酒"],
                            @[@"闺蜜聚会",@"小资生活",@"商务宴请",@"高端派对"],
                            @[@"名优白酒",@"闺蜜聚会",@"小资生活",@"商务宴请",@"高端派对"],
                            @[@"名优白酒",@"闺蜜聚会",@"小资生活",@"商务宴请",@"高端派对"],
                            @[@"名优白酒",@"闺蜜聚会",@"小资生活",@"商务宴请",@"高端派对",@"名优白酒",@"闺蜜聚会",@"小资生活",@"商务宴请",@"高端派对"]
                            ];
        */
        
        NSInteger countMax= firstArray.count;
        
        for (int i=0; i<countMax; i++) {
            
            ShopTypeItem *item = firstArray[i];
            rightMeun * meun=[[rightMeun alloc] init];
            meun.meunName = item.type_name;
            meun.ID = item.ID;
            
            NSMutableArray * sub=[NSMutableArray arrayWithCapacity:0];
            rightMeun * menu1=[[rightMeun alloc] init];
            [sub addObject:menu1];
            
            NSMutableArray *zList=[NSMutableArray arrayWithCapacity:0];
            for ( int z=0; z <[name2Arr[i]count]; z++) {
                ShopTypeItem *item2=name2Arr[i][z];
                rightMeun * meun2=[[rightMeun alloc] init];
                meun2.meunName= item2.type_name;
                meun2.ID=item2.ID;
                [zList addObject:meun2];
            }
            menu1.nextArray=zList;
            
            meun.nextArray=sub;
            [lis addObject:meun];
        }
        
        _BSDataArr=lis;
    }
    return _BSDataArr;
}
- (void)setNavigationItemLeftAndRight{
    
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 80, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    //    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [backbtn setTitle:@"上一步" forState:UIControlStateNormal];
    [backbtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
    [headview addSubview:backbtn];
    
    setbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    setbtn.frame=CGRectMake(kScreenWidth-80, 20, 80, 44);
    setbtn.centerY = View_CenterY(headview);
    [setbtn addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //    [setbtn setImage:[UIImage imageNamed:@"消息按钮_正常"] forState:UIControlStateNormal];
    //    [setbtn setImage:[UIImage imageNamed:@"消息按钮_高亮"] forState:UIControlStateHighlighted];
    [setbtn setTitle:@"完成" forState:UIControlStateNormal];
    [setbtn setTitleColor:kNavLineColor forState:UIControlStateNormal];
    [setbtn setTitleColor:tarbarrossred forState:UIControlStateSelected];
    [headview addSubview:setbtn];
    [self changeDoneBtnState];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
}
- (void)changeDoneBtnState {
    NSString *str1 = [self.detailArr objectAtIndex:0];
    NSString *str2 = [self.detailArr objectAtIndex:1];
//    self.brandStr=str1;self.styleStr=str2;
    setbtn.selected=str1.length&&str2.length;
}
- (void)rightBarButtonClick:(UIButton *)sender {
    
    if (setbtn.selected) {
//        NewPublishThemeAndDressVC *vc=[[NewPublishThemeAndDressVC alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        if (self.tagMsgblock) {
            self.tagMsgblock(self.brandStr,self.styleStr,self.brandID, self.styleID, self.type1, self.type2,nil);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
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
