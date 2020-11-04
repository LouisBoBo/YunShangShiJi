//
//  TFShareRewardDetailVC.m
//  ;
//
//  Created by jingaiweiyi on 16/9/23.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "TFShareRewardDetailVC.h"
#import "RewardV.h"
#import "TFTableViewService.h"

#import "TFMyWalletViewController.h"
@interface TFShareRewardDetailVC () <UITableViewDelegate, UITableViewDataSource>
{
    CGFloat Margin;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UICollectionView *headImageCollectionView;
@property (nonatomic, strong) UILabel *fansNumberLab;
@property (nonatomic, strong) RewardV *rewardV1;
@property (nonatomic, strong) RewardV *rewardV2;

@property (nonatomic, strong) HeadImageVM *headImageVM;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation TFShareRewardDetailVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"额外奖励详情"];
    
    Margin = ZOOM6(30);
    
    [self setupUI];
    
}

- (void)setupUI
{
    [self.view addSubview:self.tableView];

    [self setupHeaderView];
    
    [self setData];
}

- (void)sizeHeaderToFit
{
    UIView *header = self.tableView.tableHeaderView;
    
    [header setNeedsLayout];
    [header layoutIfNeeded];
    
    CGFloat height = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = header.frame;
    
    frame.size.height = height;
    header.frame = frame;
    
    self.tableView.tableHeaderView = header;
}

- (void)httpData
{
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_slb_query parameter:nil caches:NO cachesTimeInterval:0*TFMinute token:YES success:^(id data, Response *response) {
        MyLog(@"data: %@", data);
        
        if (response.status == 1) {
            NSNumber *bro_count = data[@"bro_count"];
            NSNumber *fans_count = data[@"fans_count"];
            NSArray *pic_list = data[@"pic_list"];
            
            if (kUnNilAndNULL(bro_count)) {
                [self updatebroCount:[NSString stringWithFormat:@"%@", bro_count]];
            }
            if (kUnNilAndNULL(fans_count)) {
                [self updatefansCount:[NSString stringWithFormat:@"%@", fans_count]];
                NSString *text = [NSString stringWithFormat:@"已有%@人成为你的新粉丝", fans_count];
                NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:text];
                [attText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(2, text.length-10)];
                self.fansNumberLab.attributedText = attText;
                
            }
            
            if (kUnNilAndNULL(pic_list)) {
                [self.headImageVM.headImageService.dataSource removeAllObjects];
                for (NSString *st in pic_list) {
                    HeadImageM *model = [[HeadImageM alloc] init];
                    model.pic = st;
                    [self.headImageVM.headImageService.dataSource addObject:model];
                }
                [self.headImageCollectionView reloadData];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)setupHeaderView
{
    
//    [self.backgroundView addSubview:self.rewardV1];
    
//    [self.backgroundView addSubview:self.headImageCollectionView];
    
//    [self.backgroundView addSubview:self.fansNumberLab];

    [self.backgroundView addSubview:self.rewardV2];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = ZOOM6(8);
    [button setTitle:@"查看余额" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    [button setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(204, 20, 93)] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:button];

    button.frame = CGRectMake(0.5*(CGRectGetWidth(self.backgroundView.frame)-ZOOM6(320)), self.rewardV2.bottom+ZOOM6(80), ZOOM6(320), ZOOM6(88));


    UILabel *desLab = [UILabel new];
    desLab.textColor = RGBCOLOR_I(62, 62, 62);
    desLab.font = kFont6px(30);
    desLab.text = @"活动说明：";
    [self.backgroundView addSubview:desLab];
    desLab.frame = CGRectMake(Margin, button.bottom+ZOOM6(80), ZOOM6(200), ZOOM6(45));
    
    CGRect frame = self.backgroundView.frame;
    frame.size.height = desLab.bottom;
    self.backgroundView.frame = frame;
    self.tableView.tableHeaderView = self.backgroundView;
}

- (void)buttonClick
{
    TFMyWalletViewController *vc = [[TFMyWalletViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updatefansCount:(NSString *)fansCount
{
    NSArray *numberArray = @[@"10", @"25", @"50", @"90", @"150", @"225"];
    NSArray *moneyArray = @[@"2", @"3", @"5", @"8", @"12", @"15"];
    NSMutableArray *rewardM1 = [NSMutableArray array];
    for (int i = 0; i<numberArray.count; i++) {
        RewardM *model = [[RewardM alloc] init];
        model.number = [NSString stringWithFormat:@"+%@", numberArray[i]];
        model.desText = @"粉丝";
        model.islingqu = [fansCount intValue]>=[numberArray[i] intValue]?YES: NO;
        model.money = moneyArray[i];
        
        [rewardM1 addObject:model];
    }
    self.rewardV1.titleText = @"新增粉丝现金奖励";
    self.rewardV1.cellItemArray = rewardM1;
    [self.rewardV1 layoutSubviews];
}

- (void)updatebroCount:(NSString *)broCount
{
    NSArray *numberArray = @[@"50", @"100", @"200", @"500", @"800", @"1200"];
    NSArray *moneyArray = @[@"2", @"3", @"5", @"8", @"12", @"15"];
    NSMutableArray *rewardM2 = [NSMutableArray array];
    for (int i = 0; i<numberArray.count; i++) {
        RewardM *model = [[RewardM alloc] init];
        model.number = [NSString stringWithFormat:@"+%@", numberArray[i]];;
        model.desText = @"浏览";
        model.islingqu = [broCount intValue]>=[numberArray[i] intValue]?YES: NO;
        model.money = moneyArray[i];
        
        [rewardM2 addObject:model];
    }
    self.rewardV2.titleText = @"好友浏览数现金奖励";
    self.rewardV2.cellItemArray = rewardM2;
    [self.rewardV2 layoutSubviews];
}


- (void)setData
{
    // 浏览数// 粉丝数
 
    [self updatefansCount:@"0"];
    [self updatebroCount:@"0"];
    
    // 列表说明
//    NSArray *array = @[
//                       @"签到分享或普通商品分享只要好友点击浏览，累计次数达到要求即可领取现金。",
//                       @"好友查看分享即算是一次浏览，同一用户多次浏览同一商品只记一次浏览数。",
//                       @"现金奖励自动发放到余额账户。",
//                       @"活动数据每7天清零一次。"];
    NSArray *array = @[ @"赚钱任务分享或普通商品分享只要好友点击浏览，累计次数达到要求即可领取现金。",
                        @"好友查看分享即算是一次浏览，同一用户多次浏览同一商品只记一次浏览数。",
                        @"现金奖励自动发放到余额账户。",
                        @"浏览数据每7天清零一次。"];
    self.dataSource = [NSMutableArray arrayWithArray:array];
    [self.tableView reloadData];
    
    [self httpData];
}

- (void)updateData
{
    
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *contentLab = [UILabel new];
        contentLab.tag = 200;
        contentLab.textColor = RGBCOLOR_I(125, 125, 125);
        contentLab.font = [UIFont systemFontOfSize:ceil(ZOOM6(30))];
        contentLab.numberOfLines = 0;
        [cell.contentView addSubview:contentLab];
        
        [cell layoutIfNeeded];
        
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(ZOOM6(30));
            make.right.equalTo(cell.contentView.mas_right).offset(-ZOOM6(30));
            
            make.top.equalTo(cell.contentView.mas_top).offset(floor(ZOOM6(10)));
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(-floor(ZOOM6(10)));
        }];
        
    }

    UILabel *contentLab = (UILabel *)[cell.contentView viewWithTag:200];
    contentLab.text = [NSString stringWithFormat:@"%ld.%@", (long)indexPath.row+1, self.dataSource[indexPath.row]];
    
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
#pragma mark - 懒加载

- (RewardV *)rewardV1
{
    if (!_rewardV1) {
        CGFloat W = kScreen_Width-2*Margin;
        _rewardV1 = [[RewardV alloc] initWithFrame:CGRectMake(Margin, self.backgroundView.top+ZOOM6(40), W, ZOOM6(340))];
//        _rewardV1.backgroundColor = COLOR_RANDOM;

    }
    return _rewardV1;
}

- (RewardV *)rewardV2
{
    if (!_rewardV2) {
        CGFloat W = kScreen_Width-2*Margin;
//        _rewardV2 = [[RewardV alloc] initWithFrame:CGRectMake(Margin, self.fansNumberLab.bottom+ZOOM6(80), W, ZOOM6(340))];
        //
        _rewardV2 = [[RewardV alloc] initWithFrame:CGRectMake(Margin, self.backgroundView.top+ZOOM6(40), W, ZOOM6(340))];
//        _rewardV2.backgroundColor = COLOR_RANDOM;
        
    }
    return _rewardV2;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreen_Width, kScreen_Height-Height_NavBar)];
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

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, ZOOM6(1200))];
    }
    return _backgroundView;
}

- (UICollectionView *)headImageCollectionView
{
    if (!_headImageCollectionView) {
        CGFloat W = kScreen_Width-2*Margin;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = ZOOM6(16);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _headImageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(Margin, self.rewardV1.bottom+ZOOM6(40), W+Margin, ZOOM6(70)) collectionViewLayout:flowLayout];
        _headImageCollectionView.delegate = self.headImageVM.headImageService;
        _headImageCollectionView.dataSource = self.headImageVM.headImageService;
        _headImageCollectionView.scrollsToTop = NO;
        _headImageCollectionView.backgroundColor = [UIColor whiteColor];
        _headImageCollectionView.showsHorizontalScrollIndicator = NO;
        
        /**< 必须要先注册 */
        [_headImageCollectionView registerClass:[TFHeadImageServiceCell class] forCellWithReuseIdentifier:@"headImageServiceCellId"];
        
        [self.headImageVM.headImageService cellForItemAtIndexPathBlock:^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath) {
         
            HeadImageM *model = self.headImageVM.headImageService.dataSource[indexPath.item];
            TFHeadImageServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headImageServiceCellId" forIndexPath:indexPath];
            
            
            NSString *imageUrl;
            if ([model.pic hasPrefix:@"http"]) {
                imageUrl = [NSString stringWithFormat:@"%@", model.pic];
            } else {
                imageUrl = [NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], model.pic];
            }

            [cell.imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            return cell;
        }];
        
        [self.headImageVM.headImageService sizeForItemAtIndexPathBlock:^CGSize(UICollectionView *collectionView, UICollectionViewLayout *collectionViewLayout, NSIndexPath *indexPath) {
            return CGSizeMake(ZOOM6(70), ZOOM6(70));
        }];
    }
    return _headImageCollectionView;
}

- (HeadImageVM *)headImageVM
{
    if (!_headImageVM) {
        _headImageVM = [HeadImageVM new];
        
    }
    return _headImageVM;
}

- (UILabel *)fansNumberLab
{
    if (!_fansNumberLab) {
        CGFloat W = CGRectGetWidth(self.backgroundView.frame)-2*Margin;
        _fansNumberLab = [[UILabel alloc] initWithFrame:CGRectMake(Margin, self.headImageCollectionView.bottom+ZOOM6(20), W, ZOOM6(35))];
        _fansNumberLab.textColor = RGBCOLOR_I(125, 125, 125);
//        _fansNumberLab.textColor = COLOR_ROSERED;
        _fansNumberLab.font = kFont6px(24);
        _fansNumberLab.textAlignment = NSTextAlignmentCenter;
        NSString *text = @"已有0人成为你的新粉丝";
        NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:text];
        [attText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(2, text.length-10)];
        _fansNumberLab.attributedText = attText;
        
    }
    return _fansNumberLab;
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

#pragma mark - VM


@implementation HeadImageVM
- (instancetype)init
{
    if (self = [super init]) {
    
    }
    return self;
}

- (void)handleDataWithSuccess:(void (^)(NSArray *haedImageArray, Response *response))success failure:(void(^)(NSError *error))failure
{

}

- (TFCollectionViewService *)headImageService
{
    if (!_headImageService) {
        _headImageService = [[TFCollectionViewService alloc] init];
    }
    return _headImageService;
}




@end

#pragma mark - M
@implementation HeadImageM

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

#pragma mark - image cell

@implementation TFHeadImageServiceCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ZOOM6(70), ZOOM6(70))];
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = ZOOM6(70)*0.5;
    imageV.backgroundColor = RGBCOLOR_I(240, 240, 240);
    [self.contentView addSubview:_imageV = imageV];

}

@end

