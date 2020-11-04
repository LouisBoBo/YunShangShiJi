//
//  TFMakeMoneySecretViewController.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFMakeMoneySecretViewController.h"

@interface TFMakeMoneySecretViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic , strong) NSMutableArray *dataSource;
@end

@implementation TFMakeMoneySecretViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"赚钱小秘密"];
    
    [self setupUI];
    
    [self getData];
}

- (void)setupUI
{
    ESWeakSelf;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
//    self.tableView.tableFooterView = self.footerView;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(__weakSelf.view).offset(Height_NavBar);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight-Height_NavBar));
    }];
    
}

- (void)getData
{
    NSArray *contentArray = @[@"分享美衣到朋友圈、QQ空间后，来围观的小伙伴将会自动成为您的粉丝，粉丝在衣蝠下单购买后，您将获得商品价·10%的现金奖励。",
                             @"衣蝠根据您选择的喜好，每日自动推荐新款，您可以挑选自己喜欢或者适合朋友的美衣，进行分享。只要每天坚持分享美衣，得到现金奖励的机会就越多噢~\n\n例如，朋友圈里只要有20个小伙伴，每人在衣蝠消费500元，您就能得到1000元的现金奖励！"];
    [self.dataSource addObjectsFromArray:contentArray];
    
    [self.tableView reloadData];
    
}

#pragma mark tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imgV = [UIImageView new];
        imgV.tag = 200;
        [cell.contentView addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(cell.contentView).offset(ZOOM6(20));
            make.size.mas_equalTo(CGSizeMake(ZOOM6(40), ZOOM6(40)));
        }];
        
        UILabel *contentLab = [UILabel new];
        contentLab.tag = 201;
        contentLab.textColor = RGBCOLOR_I(125, 125, 125);
        contentLab.font = kFont6px(30);
        contentLab.numberOfLines = 0;
        [cell.contentView addSubview:contentLab];
        
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgV.mas_right).offset(ZOOM6(12));
            make.top.equalTo(cell.contentView).offset(ZOOM6(20));
            make.right.equalTo(cell.contentView).offset(-ZOOM6(20));
            make.bottom.equalTo(cell.contentView).offset(-ZOOM6(20));
        }];
        
        
    }
    
    UIImageView *imgV  = (UIImageView *)[cell.contentView viewWithTag:200];
    UILabel *contentLab = (UILabel *)[cell.contentView viewWithTag:201];
    
    [contentLab preferredMaxLayoutWidth];
    imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"makmoney_%ld", (long)indexPath.row+1]];
    contentLab.text = self.dataSource[indexPath.row];
    
    if(indexPath.row == 1)
    {
        NSMutableAttributedString *newstr ;
        
        newstr = [[NSMutableAttributedString alloc]initWithString:contentLab.text];
        
        NSString *str1 = @"衣蝠根据您选择的喜好，每日自动推荐新款，您可以挑选自己喜欢或者适合朋友的美衣，进行分享。只要每天坚持分享美衣，得到现金奖励的机会就越多噢~\n\n";
        NSString *str2 = @"例如，朋友圈里只要有20个小伙伴，每人在衣蝠消费500元，您就能得到1000元的现金奖励！";
        [newstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:170/255.0 blue:0 alpha:1] range:NSMakeRange(str1.length, str2.length)];
        [contentLab setAttributedText:newstr];
    }

    return cell;
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,kScreenWidth,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,kScreenWidth,0,0)];
    }
}

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
    }
    
    return _imgV;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        UIImage *img = [UIImage imageNamed:@"makmoney_xiaomiji"];
        CGFloat W_img = kScreenWidth;
        CGFloat H_img =  W_img * img.size.height / img.size.width  ;
        
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, H_img + ZOOM6(30));
        [_headerView addSubview:self.imgV];
        self.imgV.image = img;
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.and.top.equalTo(_headerView);
            make.height.mas_equalTo(H_img);
        }];
        
    }
    return _headerView;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [UIView new];
        NSString *string = @"例如，朋友圈里只要有20个小伙伴，每人在衣蝠消费500元，您就能得到1000元的现金奖励！";
        CGSize sizeString = [string boundingRectWithSize:CGSizeMake(kScreenWidth -ZOOM6(72)-ZOOM6(20), 1000)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:ZOOM6(30)]}
                                                 context:nil].size;
        CGFloat H_contentLab = ceil(sizeString.height);
        
        _footerView.frame = CGRectMake(0, 0, kScreenWidth, H_contentLab);
        
        UILabel *lab = [UILabel new];
        lab.textColor = [UIColor colorWithRed:255/255.0 green:170/255.0 blue:0 alpha:1];
        lab.font = kFont6px(30);
        lab.numberOfLines = 0;
        lab.text = string;
        [_footerView addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_footerView).offset(ZOOM6(72));
            make.right.equalTo(_footerView).offset(-ZOOM6(20));
            make.top.equalTo(_footerView);
            make.height.mas_equalTo(H_contentLab);
        }];
        
        
    }
    return _footerView;
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
