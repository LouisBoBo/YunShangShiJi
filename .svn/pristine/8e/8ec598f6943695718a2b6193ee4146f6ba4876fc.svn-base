//
//  ContendTreasuresAreaVC.m
//  YunShangShiJi
//
//  Created by YF on 2017/8/2.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "ContendTreasuresAreaVC.h"
#import "WaterFLayout.h"
#import "TFShoppingM.h"
#import "IndianaDetailViewController.h"
#import "OneIndianaDetailViewController.h"
#import "FightIndianaDetailViewController.h"
#import "DefaultImgManager.h"
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]

#pragma mark - 1️⃣➢➢➢ TreasureCollectionCell
@interface TreasureCollectionCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *shopName;
@property (nonatomic, strong) UILabel *shopPrice;
@property (nonatomic, strong) UILabel *num;
@property (nonatomic, strong) UIProgressView *numProgress;
@property (nonatomic, strong) UIButton *btn;
- (void)reloadModel:(TFShoppingM *)model;
@end

@implementation TreasureCollectionCell
- (void)reloadModel:(TFShoppingM *)model {
    NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_code]];
    NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
    NSString *pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_code,model.def_pic];

    NSString *picSize;

    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }

    //!280
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize]];

    [self.headImg setImageWithURL:imgUrl placeholderImage:DefaultImg(self.headImg.bounds.size) progress:^(float downloaderProgress) {
    } completed:^{
    }];

    self.shopName.text = model.shop_name;
    self.num.text = [NSString stringWithFormat:@"已有%d人正在参与",model.involved_people_num?[model.involved_people_num intValue]:0];
    self.numProgress.progress = [model.involved_people_num doubleValue]/[model.active_people_num doubleValue];

}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {

    [self.contentView addSubview:self.headImg];
    [self.contentView addSubview:self.icon];

    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.shopName];
    [self.bottomView addSubview:self.num];
    [self.bottomView addSubview:self.numProgress];
    [self.bottomView addSubview:self.btn];

//    self.headImg.backgroundColor = DRandomColor;
//    self.shopName.backgroundColor = DRandomColor;
//    self.num.backgroundColor = DRandomColor;
//    self.numProgress.progress = 0.3f;
//    self.shopName.text = @"iPhone7 plus 玫瑰金 128G 特奖";
//    self.num.text = @"已有1235人正在参与";

    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(ZOOM6(10));
        make.width.height.offset(ZOOM6(94));
    }];

    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
//        make.left.top.width.equalTo(self.contentView);
//        make.bottom.equalTo(self.bottomView.mas_top);
    }];


    [self.numProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.btn);
        make.height.offset(ZOOM6(12));
        make.left.equalTo(self.shopName);
//        make.right.equalTo(self.btn.mas_left).offset(-ZOOM6(10));
        make.width.offset(ZOOM6(200));
    }];
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.numProgress.mas_top);
        make.top.equalTo(self.btn);
        make.left.right.equalTo(self.numProgress);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView).offset(-ZOOM6(20));
        make.width.offset(ZOOM6(120));
        make.right.offset(-ZOOM6(10));
        make.height.offset(ZOOM6(15)*3);
    }];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.btn.mas_top).offset(-ZOOM6(20));
        make.left.offset(ZOOM6(10));
        make.right.offset(-ZOOM6(10));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.contentView);
        make.top.equalTo(self.shopName.mas_top).offset(-ZOOM6(20));
    }];

}
- (UIImageView *)icon {
    if (nil == _icon) {
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed:@"indiana_抽奖"]];
        [_icon setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _icon;
}
- (UIImageView *)headImg {
    if (nil == _headImg) {
        _headImg = [[UIImageView alloc]init];
    }
    return _headImg;
}
- (UIView *)bottomView {
    if (nil == _bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
- (UILabel *)shopName {
    if (nil == _shopName) {
        _shopName = [[UILabel alloc]init];
        _shopName.textColor = kMainTitleColor;
        _shopName.font = kFont6px(24);
    }
    return _shopName;
}
- (UILabel *)shopPrice {
    if (nil == _shopPrice) {
        _shopPrice = [[UILabel alloc]init];
        _shopPrice.textColor = tarbarrossred;
        _shopPrice.font = [UIFont boldSystemFontOfSize:ZOOM6(28)];
    }
    return _shopPrice;
}
- (UILabel *)num {
    if (nil == _num) {
        _num = [[UILabel alloc]init];
        _num.textColor = tarbarrossred;
        _num.font = kFont6px(20);
    }
    return _num;
}
- (UIProgressView *)numProgress {
    if (nil == _numProgress) {
        _numProgress = [[UIProgressView alloc]init];
        //甚至进度条的风格颜色值，默认是蓝色的
        _numProgress.progressTintColor=tarbarrossred;
        //表示进度条未完成的，剩余的轨迹颜色,默认是灰色
        _numProgress.trackTintColor =[UIColor whiteColor];
        _numProgress.progressViewStyle=UIProgressViewStyleDefault;
        _numProgress.layer.borderWidth = 1;
        _numProgress.layer.borderColor = tarbarrossred.CGColor;
    }
    return _numProgress;
}
- (UIButton *)btn {
    if (nil == _btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"立即参与" forState:UIControlStateNormal];
        [_btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
        _btn.titleLabel.font = kFont6px(22);
        _btn.layer.cornerRadius = 3;
        _btn.layer.borderWidth = 1;
        _btn.layer.borderColor = tarbarrossred.CGColor;
        _btn.userInteractionEnabled = NO;
    }
    return _btn;
}
@end

@interface TreasureCollectionCell2 : TreasureCollectionCell
@end
@implementation TreasureCollectionCell2
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self.bottomView addSubview:self.shopPrice];
        [self.icon setImage:[UIImage imageNamed:@"夺宝专区_0元团"]];

        [self.shopName mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.shopPrice.mas_top).offset(-ZOOM6(10));
            make.left.offset(ZOOM6(10));
            make.right.offset(-ZOOM6(10));
        }];
        [self.shopPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.btn.mas_top).offset(-ZOOM6(10));
            make.left.right.equalTo(self.shopName);
        }];

    }
    return self;
}
- (void)reloadModel:(TFShoppingM *)model {
    [super reloadModel:model];
    self.num.text = [NSString stringWithFormat:@"已有%d团正在参与",model.involved_people_num?[model.involved_people_num intValue]:0];
    if (model.shop_se_price) {
        self.shopPrice.text = [NSString stringWithFormat:@"¥%.1f",model.shop_se_price.floatValue];
    }else
        self.shopPrice.text = [NSString stringWithFormat:@"¥%.1f",model.shop_price.floatValue];
}
@end

#pragma mark - 1️⃣➢➢➢ ContendTreasuresAreaVC
@interface ContendTreasuresAreaVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation ContendTreasuresAreaVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;

    [self setNavigationItemLeft: self.type==TreasuresType_GroupShop ? @"拼团抽奖专区" : @"抽奖专区"];
    [self createUI];

    [self httpData];

    kSelfWeak;
    [self.collectionView addHeaderWithCallback:^{
        kSelfStrong;
        strongSelf.page = 1;
        [strongSelf httpData];
    }];

    //加上拉刷新
    [self.collectionView addFooterWithCallback:^{
        kSelfStrong;
        strongSelf.page++;
        [strongSelf httpData];
    }];
}


- (NSMutableArray *)dataArr {
    if (nil == _dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)createUI
{
    WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    flowLayout.minimumColumnSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = RGBCOLOR_I(244,244,244);
    [self.view addSubview:self.collectionView];

    [self.collectionView registerClass:self.type == TreasuresType_GroupShop ? [TreasureCollectionCell2 class] : [TreasureCollectionCell class] forCellWithReuseIdentifier:@"TreasureCollectionCell"];

}

#pragma mark - 数据
- (void)httpData {
    //新增参数：ShopTypeEnum  String          indiana   //夺宝商品，indiana_one //额度夺宝商品,     indiana_group   //拼团夺宝商品

    NSString *ShopTypeEnum;// = _type == TreasuresType_Shop ? @"indiana" : @"indiana_one";
    if (_type == TreasuresType_Shop) {
        ShopTypeEnum =  @"indiana";
    }else if (_type == TreasuresType_GroupShop)
        ShopTypeEnum =  @"indiana_group";
    else
        ShopTypeEnum =  @"indiana_one";

    NSString *url = [NSString stringWithFormat:@"shop/queryIndianaList?curPage=%zd&ShopTypeEnum=%@&",self.page,ShopTypeEnum];
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:url caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];   //停止刷新
        [self.collectionView ffRefreshHeaderEndRefreshing];
        if (response.status == 1) {
            if (self.page == 1) { //上拉
                [self.dataArr removeAllObjects];
            }
            NSDictionary *arr = data[@"data"];
            for (NSDictionary *dic in arr) {
                TFShoppingM *model = [[TFShoppingM alloc]init];
                model.shop_code = dic[@"shop_code"];
                model.shop_name = dic[@"shop_name"];
                model.def_pic = dic[@"def_pic"];
                model.active_people_num = dic[@"active_people_num"];
                model.involved_people_num = dic[@"involved_people_num"];
                model.shop_price = [NSNumber numberWithFloat:[dic[@"shop_price"]floatValue] *0.1];
                model.shop_se_price = dic[@"shop_se_price"];
                [self.dataArr addObject:model];
            }
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        [self.collectionView footerEndRefreshing];   //停止刷新
        [self.collectionView ffRefreshHeaderEndRefreshing];
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TreasureCollectionCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TreasureCollectionCell" forIndexPath:indexPath];

    TFShoppingM *model = self.dataArr[indexPath.row];

    if (_type == TreasuresType_edu) {
        cell.icon.hidden = YES;
    }

    [cell reloadModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imgH = 900;
    CGFloat imgW = 600;

    CGFloat W = (kScreenWidth-18)/2.0;
    CGFloat H = imgH*W/imgW;

    CGSize size = CGSizeMake(W, H+5);

    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFShoppingM *model = self.dataArr[indexPath.row];

    if (self.type == TreasuresType_GroupShop) {
        FightIndianaDetailViewController *india = [[FightIndianaDetailViewController alloc]init];
        india.shop_code = model.shop_code;
        india.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:india animated:YES];
    }else if(self.type == TreasuresType_Shop)
    {
        IndianaDetailViewController *india = [[IndianaDetailViewController alloc]init];
        india.shop_code = model.shop_code;
        india.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:india animated:YES];
    }else{
        OneIndianaDetailViewController *india = [[OneIndianaDetailViewController alloc]init];
        india.shop_code = model.shop_code;
        india.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:india animated:YES];
    }
}

@end
