//
//  MoreBrandsMakerVC.m
//  YunShangShiJi
//
//  Created by yssj on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "MoreBrandsMakerVC.h"
#import "BrandMakerDetailVC.h"

@interface BrandsMakerCell : UITableViewCell
@property (nonatomic, strong) UIImageView *backImg;
@property (nonatomic, strong) UILabel *nameLabel;
@end
@implementation BrandsMakerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(360))];
        _backImg.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:_backImg];
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

@interface MoreBrandsMakerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation MoreBrandsMakerVC

- (UIView *)tableFooter {
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(100))];
    label.text=@"—— 更多优质供应商正在洽谈中 ——";
    label.textColor=tarbarrossred;
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:ZOOM6(24)];
    return label;
}
- (UITableView *)tableView {
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.rowHeight=ZOOM6(370);
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[BrandsMakerCell class] forCellReuseIdentifier:@"BrandsMakerCell"];
        _tableView.tableFooterView=[self tableFooter];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemLeft:@"所有人气品牌"];
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrandsMakerCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BrandsMakerCell"];
    TypeTagItem *item = self.dataArr[indexPath.row];
    [cell.backImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], item.pic]]];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BrandMakerDetailVC *view=[BrandMakerDetailVC new];
    TypeTagItem *item = self.dataArr[indexPath.row];
    view.shopItem=item;
    [self.navigationController pushViewController:view animated:YES];
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
