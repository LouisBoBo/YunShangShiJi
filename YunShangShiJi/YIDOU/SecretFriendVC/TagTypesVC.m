//
//  TagTypesVC.m
//  YunShangShiJi
//
//  Created by yssj on 2017/2/20.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TagTypesVC.h"
#import "SqliteManager.h"

@interface TagTypesVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *firstArr;
@property (nonatomic,strong)NSMutableArray *secondArr;

@end

@implementation TagTypesVC

- (NSMutableArray *)tagArr {
    if (_tagArr==nil) {
        _tagArr=[NSMutableArray array];
    }
    return _tagArr;
}
- (NSMutableArray *)secondArr {
    if (_secondArr==nil) {
        _secondArr=[NSMutableArray array];
    }
    return _secondArr;
}
- (UITableView *)tableview {
    if (_tableview==nil) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) style:UITableViewStyleGrouped];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableview.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableview.rowHeight=50;
        
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:self.type==TagTypeArrow?@"一级分类":@"二级分类"];
    self.firstArr=[NSMutableArray array];
//    self.tagArr=[NSMutableArray array];
    
    if (self.type==TagTypeArrow) {
        /*
        self.tagArr=@[@"流行趋势",@"上衣",@"裤子",@"裙子",@"套装"];
        NSArray *typeArr=@[@"0",@"2",@"4",@"3",@"7"];
        self.firstArr=typeArr;
        
        SqliteManager *manager = [SqliteManager sharedManager];
        for (int i=0; i<typeArr.count; i++) {
//            NSArray *arr =[manager getTypeTagItemForSuperIdWithHomePage:[NSString stringWithFormat:@"%@",typeArr[i]]];
            NSArray *arr = [manager getShopTagItemForSuperId:@"0"];

            [self.secondArr addObject:arr];
        }
        */

        
        SqliteManager *manager = [SqliteManager sharedManager];
        NSArray *arr = [manager getShopTypeItemForSuperId:@"0"];
        for (ShopTypeItem *item in arr) {
            if (![item.type_name isEqualToString:@"特卖"]&&![item.type_name isEqualToString:@"热卖"]&&![item.type_name isEqualToString:@"上新"]) {
                [self.tagArr addObject:item.type_name];
                [self.firstArr addObject:item.ID];
                [self.secondArr addObject:[manager getShopTypeItemForSuperId:item.ID]];
            }
        }
        
    }
    
    [self.view addSubview:self.tableview];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tagArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType= self.type==TagTypeArrow? UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
    }
    
    if (self.type==TagTypeArrow) {
        cell.textLabel.text=[NSString stringWithFormat:@"%@",self.tagArr[indexPath.row]];
    }else {
        ShopTypeItem *item=self.tagArr[indexPath.row];
        cell.textLabel.text=[NSString stringWithFormat:@"%@",item.type_name];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type==TagTypeArrow) {
        TagTypesVC *vc=[TagTypesVC new];
        vc.type=TagTypeNone;
        vc.tagArr=self.secondArr[indexPath.row];
        kWeakSelf(self);
        vc.didSelectBlock = ^(NSString *str,NSString *str2){
            if (weakself.didSelectBlock) {
                weakself.didSelectBlock([NSString stringWithFormat:@"%@-%@",self.firstArr[indexPath.row],str],[NSString stringWithFormat:@"%@-%@",self.tagArr[indexPath.row],str2]);
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ShopTypeItem *item=self.tagArr[indexPath.row];
        NSString *text=item.ID;
        if (self.didSelectBlock) {
            self.didSelectBlock([NSString stringWithFormat:@"%@",text],[NSString stringWithFormat:@"%@",item.type_name]);
        }
        for (UIViewController *view in self.navigationController.viewControllers) {
            if ([view isKindOfClass:NSClassFromString(@"TFPublishDress")]) {
                [self.navigationController popToViewController:view animated:YES];
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
  
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) [tableView setSeparatorInset:edgeInsets];
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) [tableView setLayoutMargins:edgeInsets];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) [cell setSeparatorInset:edgeInsets];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) [cell setLayoutMargins:edgeInsets];
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
