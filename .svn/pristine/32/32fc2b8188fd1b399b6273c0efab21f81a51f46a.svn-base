//
//  BrandMakerDetailVC.m
//  YunShangShiJi
//
//  Created by yssj on 2017/2/15.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BrandMakerDetailVC.h"
#import "WaterFLayout.h"
#import "WaterFlowCell.h"
#import "GlobalTool.h"
#import "TFShoppingVM.h"
#import "ShopDetailViewController.h"

@interface BrandMakerHeader : UICollectionReusableView
@property(nonatomic,strong)UIImageView *headImgView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIView *labelView;
@property (nonatomic, strong) UIView *moreView;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, copy) dispatch_block_t moreBtnBlock;

@end
@implementation BrandMakerHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        _headImgView = [[UIImageView alloc]init];
        _headImgView.frame = CGRectMake(0,0, kScreenWidth,ZOOM6(360));
//        _headImgView.backgroundColor=DRandomColor;
        [self addSubview:_headImgView];
        
        _labelView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headImgView.frame), kScreenWidth, ZOOM6(160))];
        _labelView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_labelView];
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, kScreenWidth-ZOOM6(40), ZOOM6(160))];
        _nameLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
        _nameLabel.numberOfLines=0;
        _nameLabel.textColor=kSubTitleColor;
        _nameLabel.text=@"优选精品的商品按照含有当前品牌标签的商品的上新时间来排，按商品上架时间排序，离当前时间最近的放在最前面";
        [_labelView addSubview:_nameLabel];
        
        _moreView = [UIView new];
        _moreView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_moreView];
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.backgroundColor=[UIColor whiteColor];//tarbarrossred;
        _moreBtn.titleLabel.font = kFont6px(28);
        [_moreBtn setImage:[UIImage imageNamed:@"icon_zhankai"] forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:@"icon_shouqi"] forState:UIControlStateSelected];
        [_moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        [_moreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
//        _moreBtn.backgroundColor=tarbarrossred;

        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_moreBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_moreBtn setTitleColor:kSubTitleColor forState:UIControlStateSelected];
        [_moreView addSubview:_moreBtn];
        [_moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
      
        _label=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(_labelView.frame), kScreenWidth-ZOOM6(40), ZOOM6(80))];
        _label.textColor=tarbarrossred;
        _label.textAlignment=NSTextAlignmentCenter;
        _label.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _label.text=@"—— 优选精品 ——";
        [self addSubview:_label];
    }
    return self;
}
- (void)moreBtnClick:(UIButton *)sender {
    
    kSelfWeak;
    if (weakSelf.moreBtnBlock) {
        weakSelf.moreBtnBlock();
    }
}
- (void)layoutSubviews {
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(ZOOM6(360)));
    }];
    [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImgView.mas_bottom);
        make.left.equalTo(@(0));
        make.width.equalTo(_headImgView.mas_width);
    }];

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(ZOOM6(20)));
        make.bottom.equalTo(@(-ZOOM6(20)));
        make.left.equalTo(@(ZOOM6(20)));
        make.right.equalTo(@(-ZOOM6(20)));
    }];
    [_moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labelView.mas_bottom);
//        make.bottom.equalTo(@(-ZOOM6(20)));
        make.left.right.offset(0);
        make.height.offset(ZOOM6(70));
    }];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(kScreenWidth/2-40);
        make.width.offset(80);
        make.height.offset(ZOOM6(50));
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(_moreView.mas_bottom);
        make.left.right.equalTo(@(0));
        make.height.equalTo(@(ZOOM6(80)));
    }];
    
}

@end

@interface BrandMakerDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIImageView *headview;
    UIButton *backbtn;
    UILabel *titlelable;
    bool moreSelected;
}
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic, assign)int page;
@property (nonatomic, strong)NSMutableArray *waterFlowDataArray;
@property (nonatomic, strong) TFShoppingVM *viewModel;
@property (nonatomic, assign) CGFloat reduceMoney;
@property (nonatomic, copy)   NSString * shop_deduction;
@property (nonatomic, strong) NSNumber *isVip;
@property (nonatomic, strong) NSNumber *maxType;
@end

@implementation BrandMakerDetailVC

- (NSMutableArray *)waterFlowDataArray {
    if (_waterFlowDataArray == nil) {
        _waterFlowDataArray = [[NSMutableArray alloc] init];
    }
    
    return _waterFlowDataArray;
}
- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        flowLayout.minimumColumnSpacing=5;
        flowLayout.minimumInteritemSpacing=5;
        flowLayout.columnCount=2;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = kBackgroundColor;
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        // Register cell classes
        [self.collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];

        [_collectionView registerClass:[BrandMakerHeader class] forSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView"];
    }
    return _collectionView;
}
- (void)leftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setNavigationItemLeft:(NSString *)title {
    
    headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
//    headview.image=[UIImage imageNamed:@"导航背景"];
    headview.image = [UIImage imageNamed:@"zhezhao"];
    [self.view addSubview:headview];
    
    headview.userInteractionEnabled=YES;
    
    backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.frame=CGRectMake(-10, 20, 80, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateHighlighted];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    //    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
    
    titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(46, 0, headview.frame.size.width-46*2, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
//    titlelable.text= title;
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment= NSTextAlignmentCenter;
    [headview addSubview:titlelable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.page=1;
    moreSelected = NO;
    
    [self.view addSubview:self.collectionView];
    kSelfWeak;
    [self.collectionView addFooterWithCallback:^{
        weakSelf.page++;
        [weakSelf httpGetDataAnimation:NO];
    }];

    [self setNavigationItemLeft:self.shopItem.class_name];
    
//    [self httpGetDataAnimation:NO];
    [self setData];
}
- (void)setData
{
    kSelfWeak;
    [self.viewModel netWorkGetBrowsePageListWithReduceMoneySuccess:^(NSDictionary *data, Response *response) {
        if(response.status == 1)
        {
            weakSelf.reduceMoney = [data[@"one_not_use_price"] floatValue];
            weakSelf.shop_deduction = data[@"shop_deduction"];
            weakSelf.isVip = data[@"isVip"];
            weakSelf.maxType = data[@"maxType"];
        }
        
        [self httpGetDataAnimation:NO];
    } failure:^(NSError *error) {
        
    }];
}
- (void)httpGetDataAnimation:(BOOL)animationBl
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr;
    
    
    if (token != nil) {
        urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?token=%@&version=%@&supp_label_id=%@&pager.curPage=%d&pager.pageSize=10&notType=false",[NSObject baseURLStr],token,VERSION,self.shopItem.ID,self.page];
    } else {
        
        urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?version=%@&supp_label_id=%@&pager.curPage=%d&pager.pageSize=10&notType=false",[NSObject baseURLStr],VERSION,self.shopItem.ID,self.page];
    }
    
    NSString *URL = [MyMD5 authkey:urlStr];
    //    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (animationBl) {
        [[Animation shareAnimation] CreateAnimationAt:self.view];
    }
    
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.view withTag:99999];
        MyLog(@"全部 res = %@",responseObject);
        [self.collectionView footerEndRefreshing];   //停止刷新
        [self.collectionView headerEndRefreshing];   //停止刷新
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                if (self.page == 1) { //上拉
                    [self.waterFlowDataArray removeAllObjects];
                    [self.collectionView reloadData];
                }
                NSArray *arr = responseObject[@"listShop"];
                
                //全部 count = %d", (int)arr.count);
                
                if (arr.count == 0&&self.waterFlowDataArray.count == 0) {
                    CGRect frame = CGRectMake(0, kNavigationheightForIOS7+ZOOM6(600), self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7-ZOOM6(600));
                    
                    [self createBackgroundView:self.view andTag:9999 andFrame:frame withImgge:nil andText:nil];
                } else {
                    [self clearBackgroundView:self.view withTag:9999];
                    
                    for (NSDictionary *dic in arr) {
                        ShopDetailModel *sModel = [[ShopDetailModel alloc] init];
                        [sModel setValuesForKeysWithDictionary:dic];
                        [self.waterFlowDataArray addObject:sModel];
                    }
                    
                    
                    Response *responseObj=[Response yy_modelWithJSON:responseObject];
                    if (self.waterFlowDataArray.count >= responseObj.pager.rowCount && self.page > 1 && arr.count == 0) {
                        NavgationbarView *nv = [[NavgationbarView alloc] init];
                        [nv showLable:@"没有更多商品了哦~" Controller:self];
                    }
                    
                    
                    //刷新数据
                    [self.collectionView reloadData];
                }
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.collectionView footerEndRefreshing];   //停止刷新
        [self.collectionView headerEndRefreshing];   //停止刷新
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        CGRect frame = CGRectMake(0, kNavigationheightForIOS7+ZOOM6(600), self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7-ZOOM6(600));
        [self createBackgroundView:self.view andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];

}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]init];
    ShopDetailModel *model=self.waterFlowDataArray[indexPath.row];
    WaterFlowCell *cell = (WaterFlowCell*)[collectionView cellForItemAtIndexPath:indexPath];
    shopdetail.bigimage=cell.shop_pic.image;
    shopdetail.shop_code=model.shop_code;
    shopdetail.stringtype = @"订单详情";
    [self.navigationController pushViewController:shopdetail animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.waterFlowDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    WaterFlowCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.bottomView_new.layer.borderWidth = 1;
//    cell.bottomView_new.layer.borderColor = kBackgroundColor.CGColor;
//    cell.selectBtn.hidden = YES;
    
    WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    cell.selectBtn.hidden = YES;
    ShopDetailModel *model=self.waterFlowDataArray[indexPath.row];
    
    model.isVip = self.isVip;
    model.maxType = self.maxType.stringValue;
    model.shop_deduction = self.shop_deduction;
    model.reduceMoney = self.reduceMoney;
    [cell receiveDataModel:model];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:WaterFallSectionHeader]) {
       BrandMakerHeader * headerView =(BrandMakerHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], self.shopItem.pic]]];
        headerView.nameLabel.text=self.shopItem.remark;
        if ([NSString heightWithString:self.shopItem.remark font:[UIFont systemFontOfSize:ZOOM6(28)] constrainedToWidth:kScreenWidth-ZOOM6(40)]>ZOOM6(120)) {
            headerView.nameLabel.lineBreakMode=NSLineBreakByClipping;
        }else {
//            headerView.nameLabel.lineBreakMode=NSLineBreakByWordWrapping;
        }
        kSelfWeak;
        kWeakSelf(headerView);
        weakheaderView.moreBtn.selected = moreSelected;

        headerView.moreBtnBlock = ^ {
            [UIView performWithoutAnimation:^{
                kSelfStrong;
                strongSelf->moreSelected = !strongSelf->moreSelected;

                [collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];

            }];
        };
        return headerView;
    }
    return nil;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{

    if ([NSString heightWithString:self.shopItem.remark font:[UIFont systemFontOfSize:ZOOM6(28)] constrainedToWidth:kScreenWidth-ZOOM6(40)]>ZOOM6(110)&&moreSelected==NO) {
        return  ZOOM6(550)+ZOOM6(110);
    }else{
        return ZOOM6(550)+[NSString heightWithString:self.shopItem.remark font:[UIFont systemFontOfSize:ZOOM6(28)] constrainedToWidth:kScreenWidth-ZOOM6(40)];

    }
  
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (kScreenWidth-15)/2.0;
    CGFloat H = imgH*W/imgW;
    
    CGSize size = CGSizeMake(W, H+5);
    return size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    headview.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:scrollView.contentOffset.y/64];

    titlelable.text=scrollView.contentOffset.y>=64?[NSString stringWithFormat:@"%@制造商",self.shopItem.class_name]:@"";
    headview.image=[UIImage imageNamed:scrollView.contentOffset.y>=64?@"导航背景":@"zhezhao"];
    [backbtn setImage:[UIImage imageNamed:scrollView.contentOffset.y>=64?@"返回按钮_正常":@"icon_fanhui"] forState:UIControlStateNormal];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TFShoppingVM *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[TFShoppingVM alloc] init];
    }
    return _viewModel;
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
