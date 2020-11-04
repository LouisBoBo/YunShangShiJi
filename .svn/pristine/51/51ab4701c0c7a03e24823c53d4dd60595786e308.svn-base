//
//  CollocationDetailViewController.m
//  XLPlainFlowLayoutDemo
//
//  Created by hebe on 15/7/30.
//  Copyright (c) 2015年 ___ZhangXiaoLiang___. All rights reserved.
//

#import "CollocationDetailViewController.h"
#import "ReusableView.h"
#import "XLPlainFlowLayout.h"
#import "GlobalTool.h"
#import "CollectionHeaderView.h"
#import "YFDPImageView.h"
#import "DefaultImgManager.h"
#import "UIImageView+WebCache.h"
#import "CollocationDetailModel.h"
#import "ShareShopModel.h"
#import "WaterFlowCell.h"
#import "DPAddShopVC.h"

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "TFLoginView.h"

#import "DShareManager.h"
#import "ProduceImage.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "QRCodeGenerator.h"
#import "MJRefresh.h"
#import "NavgationbarView.h"
#import "MBProgressHUD.h"
#import "ShopCarCountModel.h"
#import "ShopCarManager.h"
#import "ShareAnimationView.h"
#import "UIView+Animation.h"
#import "ShareImageModel.h"
#import "TFMakeMoneySecretViewController.h"
#import "NewShoppingCartViewController.h"
#import "ShopDetailSecretViewController.h"
#import "ContactKefuViewController.h"
#import "CollecLikeTaskVC.h"
#import "TFShareRewardDetailVC.h"
#import "TypeShareModel.h"
#import "WXApi.h"
#define USER_H5ShareApp @"share/900_900_3_IOS.png"
//#define HEAD_VIEWHEIGH ZOOM6(650) 

#define HEAD_VIEWHEIGH [[UIScreen mainScreen] bounds].size.width
#define BACK_VIEWHEIGH ZOOM6(400)
#define DISC_LABHEIGH ZOOM6(90)
#define SHAREMODELVIEW_HEIGH ZOOM6(500)
#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
static NSString * const isFirstLedBroweCollocationDetail = @"isFirstLedBroweCollocationDetailId";
@interface CollocationDetailViewController ()< YFDPImageViewDelegate,WXApiDelegate,MiniShareManagerDelegate>
@property (strong, nonatomic) UIButton * backbtn;
@property (strong, nonatomic) UIButton * messagebtn;
@property (strong, nonatomic) UIView *backview;
@property (strong, nonatomic) UIImageView * siimage;
@property (strong, nonatomic) UILabel *discriptionlab;
@property (strong, nonatomic) UIButton *stopBtn;
@property (strong, nonatomic) UIImageView *stopImage;
@property (strong, nonatomic) UIView *relevantView;
@property (strong, nonatomic) UIView *sectionView;
//购物车角标
@property (strong, nonatomic) UILabel *marklable;
//加入购物车倒计时
@property (strong, nonatomic) UILabel *daojishilab;
//分享弹框
@property (strong, nonatomic) UIView *shareModelview;
@property (strong, nonatomic) UIImageView *shareBigimgview;

@property (strong, nonatomic) CollectionHeaderView *headerView;
@property (nonatomic, strong) YFDPImageView *heardImgView;
@property (strong, nonatomic) CollocationDetailModel *detailModel;
@property (strong, nonatomic) XLPlainFlowLayout *layout;
@property (strong, nonatomic) ShareAnimationView *aView; //分享动画

@end

@implementation CollocationDetailViewController
{
    UIStatusBarStyle _currentStatusBarStyle;
    
    //列表数据源
    NSMutableArray *_dataArray;
    NSMutableArray *_dataLeftArray;
    NSMutableArray *_dataRightArray;
    NSMutableDictionary * _dataDic;
    
    //商品分类数据源
    NSMutableArray *_shopDirvelArr;
    
    //列表头
    CollectionHeaderView *_headerView;
    
    //当tableview滑动到某一位置view定置
    UIView *_MOBLEview;
    
    CGFloat _pubheigh;
    int _selectCount;
    BOOL _isselect;
    BOOL _isMove;
    
    int _pubIndex;
    const char *_sql_stmt;
    
    ShareShopModel *_shareModel;
    
    ShopDetailModel *_ShopModel;
    
    CollocationDetailModel *_detailModel;
    
    int _pubtime;
    NSTimer *_mytimer;
    
    CGFloat _moveHeigh;
    
    UIImageView *qdnImgView;
    UIImageView *qdaImgView;

}
static NSString *cellID = @"cellID";
static NSString *headerID = @"headerID";
static NSString *firstheaderID = @"HeaderView";
static NSString *footerID = @"footerID";

-(instancetype)init
{
    _layout = [XLPlainFlowLayout new];
    _layout.itemSize = CGSizeMake(100, 100);

    [_layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    _layout.minimumLineSpacing=0;
    _layout.minimumInteritemSpacing=0;
    
    _layout.naviHeight = 20.0+44;
    return [self initWithCollectionViewLayout:_layout];
    
}

- (void)dealloc {
    NSLog(@"%@释放了", self.class);
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

//    int cart1= (int)[ShopCarManager sharedManager].s_count ;
    int cart2= (int)[ShopCarManager sharedManager].p_count ;
    
    self.marklable.text=[NSString stringWithFormat:@"%d",cart2>99?99:cart2];
    
    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:ShareAnimationTime];
    NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
    if (time == nil || ![time isEqualToString:currTime]) {
        [_aView animationStart:YES];
    } else {
        [_aView animationStart:NO];
    }

}
- (void)getShopCart
{
    [ShopCarCountModel getShopCarCountWithSuccess:^(id data) {
        ShopCarCountModel *model = data;
        if (model.status == 1&&model.cart_count>0) {
            self.marklable.hidden = NO;
            self.marklable.text=[NSString stringWithFormat:@"%ld",(long)model.cart_count];
            if (model.s_deadline - model.s_time > 0) {
                _pubtime = 0;
                _detailModel.c_time = [NSString stringWithFormat:@"%lld", model.s_deadline];
                _detailModel.s_time = [NSString stringWithFormat:@"%lld", model.s_time];
                if (_isMove == NO) {
                    [self addpop:nil];
                }
            }
        } else {
            
            if(_isMove == YES)
            {
                UIButton *shopbtn = (UIButton*)[self.view viewWithTag:4001];
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    shopbtn.frame=CGRectMake(shopbtn.frame.origin.x+10,0, shopbtn.frame.size.width, 50);
                    _isMove = NO;
                    
                } completion:^(BOOL finished) {
                    
                    _daojishilab.hidden = YES;
                    
                }];
                
            }
            
            //关闭定时器
            [_mytimer invalidate];

            self.marklable.hidden = YES;
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _pubheigh = BACK_VIEWHEIGH;
    
    [self creatData];
    
    [self creatDataAnimation];
    
    [self creatCollectionView];

    [self creatHeadview];
    
    [self creatFootView];
    
    [self shopRequest];
    
    [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@",@"搭配购详情页"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Collocationsharesuccess:) name:@"Collocationsharesuccess" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Collocationsharefail:) name:@"CollocationShopsharefail" object:nil];
}

#pragma mark 数据处理
- (void)creatData
{
    _shopData = [NSArray array];
    _pages = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    _dataLeftArray = [NSMutableArray array];
    _dataRightArray = [NSMutableArray array];
    _dataDic = [NSMutableDictionary dictionary];
    _detailModel = [[CollocationDetailModel alloc]init];
}

#pragma mark 列表
-(void)creatCollectionView
{
    CGFloat StatusBarHeigh = 0;
    if(kIOSVersions<=7.0 )
    {
        StatusBarHeigh = 20;
    }
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, kApplicationHeight+kUnderStatusBarStartY - StatusBarHeigh);

    self.collectionView.backgroundColor = kBackgroundColor;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
    
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:headerID];
    
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];

//    上下拉刷新
    
    __weak CollocationDetailViewController *myController = self;
    [self.collectionView addHeaderWithCallback:^{
        __strong typeof(myController) strongSelf = myController;
        [strongSelf -> _dataArray removeAllObjects];
        [strongSelf shopRequest];
    }];
    
    
}

#pragma mark 创建导航条
-(void)creatHeadview
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor clearColor];
    headview.image = [UIImage imageNamed:@"zhezhao"];
    
    headview.tag = 3838;
    [self.view addSubview:headview];
    
    headview.userInteractionEnabled=YES;
    
    _backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _backbtn.frame=CGRectMake(-10, Height_NavBar-57, 80, 44);
    _backbtn.centerY = View_CenterY(headview);
    [_backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:_backbtn];
    
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    
    CGFloat scale = 2;
    CGFloat imagescale = 1;
    
    //分享
    _messagebtn=[[UIButton alloc]init];
    _messagebtn.frame =CGRectMake(kApplicationWidth-SE(19)-IMGSIZEW(@"shop_lxkf-")-ZOOM(20), 18, IMGSIZEW(@"shop_lxkf-")*scale, IMGSIZEH(@"shop_lxkf-")*scale);
    _messagebtn.centerY = View_CenterY(headview);
    _messagebtn.backgroundColor = [UIColor clearColor];
    [_messagebtn addTarget:self action:@selector(messageclick:) forControlEvents:UIControlEventTouchUpInside];
    
    _siimage = [[UIImageView alloc]initWithFrame:CGRectMake((_messagebtn.frame.size.width-IMGSIZEW(@"shop_lxkf-")*imagescale)/2, 13, IMGSIZEW(@"shop_lxkf-")*imagescale, IMGSIZEH(@"shop_lxkf-")*imagescale)];
    _siimage.image = [UIImage imageNamed:@"shop_lxkf-"];
    
    [_messagebtn addSubview:_siimage];
    
    [self.view addSubview:_messagebtn];
    
}

#pragma mark - YFDPImageViewDelegate
- (NSInteger)numberOfTag {
    return _shopData.count;
}

- (void)tagButton:(HBTagButton *)tagBtn tagForRowAtindex:(NSInteger)index
{
    NSDictionary *dic = _shopData[index];
    
    [tagBtn setTitle:@"sjfsjljflsjfl"
               price:nil
              origin:CGPointMake([dic[@"shop_x"] floatValue],[dic[@"shop_y"] floatValue])
               isImg:NO
               ispic:NO
                type:index%2];

}

- (void)tagBtn:(YFTagButton *)tagBtn tagForRowAtindex:(NSInteger)index {
    NSDictionary *dic = _shopData[index];
    
//    CGFloat price = [dic[@"shop_se_price"] floatValue] - [dic[@"kickback"] intValue];
    CGFloat price = [dic[@"shop_se_price"] floatValue];
    [tagBtn setTitle:dic[@"shop_name"]
               price:[NSString stringWithFormat:@"¥%.1f",price]
              origin:CGPointMake([dic[@"shop_x"] floatValue],[dic[@"shop_y"] floatValue])
               isImg:![dic[@"option_flag"] integerValue]
               ispic:[dic[@"option_flag"] integerValue]
                type:index%2];
    
}

- (void)imageView:(YFDPImageView *)imageView didSelectRowAtIndex:(NSInteger)index {
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"首页搭配图坐标" success:^(id data, Response *response) {
    } failure:^(NSError *error) {
    }];
    
    NSDictionary *dic = _shopData[index];
    [self gotoDetail:dic[@"shop_code"]];
}

#pragma mark **************UICollectionView***********
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {

        NSString *text =  _detailModel.collocation_remark;
        
        CGFloat heigh = [self getRowHeight:text fontSize:ZOOM6(24)];
        
        if(heigh < DISC_LABHEIGH)
        {
            
            _moveHeigh = HEAD_VIEWHEIGH+BACK_VIEWHEIGH-ZOOM6(60)-(DISC_LABHEIGH-heigh);
            
            return CGSizeMake(kScreenWidth, HEAD_VIEWHEIGH+BACK_VIEWHEIGH-ZOOM6(60)-(DISC_LABHEIGH-heigh));
        }
        
         _moveHeigh = HEAD_VIEWHEIGH+_pubheigh;
        
        return CGSizeMake(kScreenWidth, HEAD_VIEWHEIGH+_pubheigh);
    }else{
        return CGSizeMake(0, 44);
    }
    
    return CGSizeZero;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if(section == 0)
    {
        return 0;

    } else{
        
        if(_dataArray.count)
        {
            NSArray *data = _dataArray[_pubIndex];
            
            return data.count;
        }

    }
    return 0;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WaterFlowCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    cell.selectBtn.hidden = YES;
    
    if(_dataArray.count)
    {
        NSArray *data = _dataArray[_pubIndex];
        ShopDetailModel *model=data[indexPath.item];
        [cell receiveDataModel2:model];
    }
    return cell;

}

#pragma mark UICollectionView---section
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind != UICollectionElementKindSectionHeader)
            return nil;
    if(indexPath.section == 0)
    {
        _headerView =(CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        [_headerView addSubview:self.heardImgView];
        NSString *st = kDevice_Is_iPhone6Plus?@"!450":@"!382";
        [_heardImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],_collcationModel.collocation_pic,st]] placeholderImage:DefaultImg(_heardImgView.size)];
        [_headerView addSubview:[self creatBackView]];
        [_heardImgView reloadData];
        
        return _headerView;
    }else{
        ReusableView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        [header receiveWithNames:[self getShopType] pubIndex:_pubIndex targe:self action:@selector(shopclick:)];
        return header;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(XLPlainFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (kScreenWidth-15)/2.0;
    CGFloat H = imgH*W/imgW;
    
    CGSize size = CGSizeMake(W, H+5);
    
    return size;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyLog(@"商品 = %d",(int)indexPath.row);
    NSArray *data = _dataArray[_pubIndex];
    ShopDetailModel *model=data[indexPath.item];

    
    ShopDetailViewController *detail=[[ShopDetailViewController alloc] init];
    detail.stringtype = @"订单详情";
    detail.shop_code = model.shop_code;
    
    detail.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark *****************UI界面************************
#pragma mark 大图
#pragma mark - getter
- (YFDPImageView *)heardImgView {
    
    if (nil == _heardImgView) {
        _heardImgView = [[YFDPImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth,HEAD_VIEWHEIGH) isTriangle:NO isShade:NO isTitle:NO];
        _heardImgView.backgroundColor = [UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1.0];
        _heardImgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _heardImgView.contentMode = UIViewContentModeScaleAspectFill;
        _heardImgView.clipsToBounds = YES;
        _heardImgView.delegate = self;
    }
    return _heardImgView;
}

- (void)gotoDetail:(NSString*)shop_code
{
    ShopDetailViewController *detail=[[ShopDetailViewController alloc] init];
    
    if([self.stringtype isEqualToString:@"签到领现金"])
    {
        /**< 签到新增 */
        detail.stringtype = self.stringtype;
        detail.rewardType = self.rewardType;
        detail.rewardValue = self.rewardValue;
        detail.Browsedic = self.Browsedic;
        detail.currTimeCount = self.currTimeCount;
        detail.showGetMoneyWindow = self.showGetMoneyWindow;
        detail.browseCount = self.browseCount;
        detail.index_id = self.index_id;
        detail.index_day = self.index_day;
        detail.rewardCount = self.rewardCount;
        
        kWeakSelf(self);
        detail.browseCountBlock = ^() {
            if (weakself.browseCountBlock) {
                weakself.browseCountBlock(shop_code);
            }
        };
    }else{
        detail.stringtype = @"订单详情";
    }
    
    detail.shop_code = shop_code;
    detail.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark 大图下面的文字
- (UIView*)creatBackView
{
    CGFloat pubheigh = _pubheigh - BACK_VIEWHEIGH;
    
    [_backview removeFromSuperview];
    _backview = [[UIView alloc]initWithFrame:CGRectMake(0, HEAD_VIEWHEIGH, kScreenWidth, _pubheigh)];
    _backview.backgroundColor = [UIColor whiteColor];
    
    CGFloat discriptionlabYY =0;
    for(int i =0;i<2;i++)
    {
        UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40), ZOOM6(30)+ZOOM6(30)*i, kScreenWidth - 2*ZOOM(40), ZOOM6(30))];
        titlelable.textAlignment = NSTextAlignmentCenter;
        if(i==0)
        {
            titlelable.font = [UIFont systemFontOfSize:ZOOM6(30)];
            titlelable.text = _detailModel.collocation_name;
            titlelable.textColor = RGBCOLOR_I(62, 62, 62);
        }else{
            titlelable.font = [UIFont systemFontOfSize:ZOOM6(20)];
            if(_detailModel.add_time !=nil)
            {
                NSString *addtime = [MyMD5 getTimeToShowWithTimestampHour:_detailModel.add_time];
                titlelable.text = addtime;
            }
            titlelable.textColor = RGBCOLOR_I(168, 168, 168);
            
            discriptionlabYY = CGRectGetMaxY(titlelable.frame);
        }
        
        [_backview addSubview:titlelable];
    }
    
    //描述
    _discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40),discriptionlabYY+ZOOM6(20), kScreenWidth - 2*ZOOM(40), DISC_LABHEIGH+pubheigh)];
    _discriptionlab.textColor = RGBCOLOR_I(62, 62, 62);
    _discriptionlab.font = [UIFont systemFontOfSize:ZOOM6(24)];
    _discriptionlab.text = _detailModel.collocation_remark;
    _discriptionlab.numberOfLines = 0;
    [_backview addSubview:_discriptionlab];
    
    _discriptionlab.text = [_discriptionlab.text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    _discriptionlab.text = [_discriptionlab.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    CGFloat discriptionlabHeigh = [self getRowHeight:_discriptionlab.text fontSize:ZOOM6(24)];
    CGFloat stopBtnHeigh = 0;
    if(discriptionlabHeigh > DISC_LABHEIGH)
    {
        stopBtnHeigh = ZOOM6(50);
        
        //收起按钮
        
        CGFloat stopBtnWidth = ZOOM6(160);
        [_stopBtn removeFromSuperview];
        _stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _stopBtn.frame = CGRectMake((kScreenWidth - stopBtnWidth)/2, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(30), stopBtnWidth, stopBtnHeigh);
        [_stopBtn setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
        _stopBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(24)];
        [_stopBtn addTarget:self action:@selector(stopclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_stopImage removeFromSuperview];
        _stopImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_stopBtn.frame)-IMAGEW(@"icon_shouqi")-ZOOM6(40), (CGRectGetHeight(_stopBtn.frame)-IMAGEW(@"icon_shouqi"))/2, IMAGEW(@"icon_shouqi"), IMAGEW(@"icon_shouqi"))];
        if(_isselect == YES)
        {
            [_stopBtn setTitle:@"收起" forState:UIControlStateNormal];
            _stopImage.image = [UIImage imageNamed:@"icon_shouqi"];
        }else{
            [_stopBtn setTitle:@"展开" forState:UIControlStateNormal];
            _stopImage.image = [UIImage imageNamed:@"icon_zhankai"];
            
        }
        [_stopBtn addSubview:_stopImage];
        
        NSDictionary *attributes1 = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM6(24)]};
        CGSize strSize = [_stopBtn.titleLabel.text boundingRectWithSize:CGSizeMake(300, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes1 context:nil].size;
        
        CGFloat totalLen = strSize.width + IMAGEW(@"icon_shouqi");
        CGFloat titleRightInset = (CGRectGetWidth(_stopBtn.frame)- totalLen) / 2;
        
        [_stopBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -IMAGEW(@"icon_shouqi"), 0, titleRightInset)];
        
        [_backview addSubview:_stopBtn];
        
        
        //相关商品
        _relevantView = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_stopBtn.frame)+ZOOM6(30), kScreenWidth, ZOOM6(80))];
        
    }else{
        
        _relevantView = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(_discriptionlab.frame)+discriptionlabHeigh+ZOOM6(60), kScreenWidth, ZOOM6(80))];
        
    }
    
    _relevantView.backgroundColor = kBackgroundColor;
    _relevantView.userInteractionEnabled = YES;
    _relevantView.clipsToBounds = YES;
    [_backview addSubview:_relevantView];
    
    UILabel *lableline = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(220))/2, ZOOM6(80)/2, ZOOM6(220), 1)];
    lableline.backgroundColor = tarbarrossred;
    [_relevantView addSubview:lableline];
    
    UILabel *shoplab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(160))/2, 0, ZOOM6(160), CGRectGetHeight(_relevantView.frame))];
    shoplab.backgroundColor = kBackgroundColor;
    shoplab.text = @"相关商品";
    shoplab.textColor = RGBCOLOR_I(255, 63, 139);
    shoplab.font = [UIFont systemFontOfSize:ZOOM6(30)];
    shoplab.textAlignment = NSTextAlignmentCenter;
    [_relevantView addSubview:shoplab];
    
     _backview.frame = CGRectMake(0, HEAD_VIEWHEIGH, kScreenWidth, CGRectGetMaxY(_relevantView.frame));

    
    return _backview;
}

#pragma mark 商品分类条

#pragma mark 获取商品分类
- (NSMutableArray*)getShopType
{
    if(_shopDirvelArr.count)
    {
        if(_detailModel.type_relation_ids !=nil)
        {
            NSMutableArray *nameArray = [NSMutableArray array];
            NSMutableString *idstr = [NSMutableString stringWithString:_detailModel.type_relation_ids];
            
            NSArray *arr = [idstr componentsSeparatedByString:@","];
            if(arr.count)
            {
                for(int i =0;i<arr.count;i++)
                {
                    NSString *nameid = arr[i];
                    for(NSDictionary *dic in _shopDirvelArr)
                    {
                        if([dic[@"id"] isEqualToString:nameid])
                        {
                            if(dic[@"name"]!=nil)
                            {
                                [nameArray addObject:dic[@"name"]];
                            }
                        }
                    }
                }
            }
            
            return nameArray;
        }
    }
    
    return 0;
}
#pragma mark 商品分类切换
- (void)shopclick:(UIButton*)sender
{
    
    for(int i =0 ;i<2;i++)
    {
        UIButton *btn = (UIButton*)[_sectionView viewWithTag:3333+i];
        UILabel *lab = (UILabel*)[_sectionView viewWithTag:4444+i];
        
        if(btn.tag == sender.tag)
        {
            [btn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            lab.backgroundColor = tarbarrossred;
            
            
        }else{
            
            [btn setTitleColor:RGBCOLOR_I(62, 62, 62) forState:UIControlStateNormal];
            lab.backgroundColor = [UIColor clearColor];
        }
    }
    
    _pubIndex = (int)sender.tag - 3333;
    
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }];
}

#pragma mark 收起 展开
- (void)stopclick:(UIButton*)sender
{
    if(_isselect == NO)
    {
        CGFloat labheigh = [self getRowHeight:_discriptionlab.text fontSize:ZOOM6(26)];
        
        _discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40),_discriptionlab.frame.origin.y, kScreenWidth - 2*ZOOM(40), labheigh)];
        
        _stopBtn.frame = CGRectMake((kScreenWidth - ZOOM6(120))/2, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(30), ZOOM6(120), ZOOM6(50));
        
        _stopImage.image = [UIImage imageNamed:@"icon_shouqi"];
        
        _relevantView = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_stopBtn.frame)+ZOOM6(30), kScreenWidth, ZOOM6(80))];
        
        _backview.frame = CGRectMake(_backview.frame.origin.x, _backview.frame.origin.y, _backview.frame.size.width, BACK_VIEWHEIGH +(labheigh-DISC_LABHEIGH));
        
        _pubheigh = BACK_VIEWHEIGH +(labheigh-DISC_LABHEIGH);
        
        _isselect = YES; 
        
        
    }else{
        
        CGFloat labheigh = DISC_LABHEIGH;
        
        _discriptionlab = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(40),_discriptionlab.frame.origin.y, kScreenWidth - 2*ZOOM(40), labheigh)];
        
        _stopBtn.frame = CGRectMake((kScreenWidth - ZOOM6(120))/2, CGRectGetMaxY(_discriptionlab.frame)+ZOOM6(30), ZOOM6(120), ZOOM6(50));
        _stopImage.image = [UIImage imageNamed:@"icon_zhankai"];
        
        _relevantView = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_stopBtn.frame)+ZOOM6(30), kScreenWidth, ZOOM6(80))];
        
        _backview.frame = CGRectMake(_backview.frame.origin.x, _backview.frame.origin.y, _backview.frame.size.width, BACK_VIEWHEIGH +(labheigh-DISC_LABHEIGH));
        
        _pubheigh = BACK_VIEWHEIGH;
        
        _isselect = NO;
        
    }
    
    
    [self.collectionView reloadData];
    
}

#pragma mark 创建脚底视图
-(void)creatFootView
{
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    footView.backgroundColor=[UIColor whiteColor];
    footView.tag = 8181;
    [self.view addSubview:footView];
    
    [self.view bringSubviewToFront:footView];
    
    NSArray *arr=[NSArray alloc];
    arr=@[@"搭配购"];
    
    
//    CGFloat likebtn = ZOOM(100*3.4);
    CGFloat likebtn = kScreenWidth/4;
    
    
    //分割线
    UILabel *butlable1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth-likebtn*2, 1)];
    butlable1.backgroundColor=kBackgroundColor;
    
    UILabel *butlable2=[[UILabel alloc]initWithFrame:CGRectMake(likebtn, 1, 1, 49)];
    butlable2.backgroundColor=kBackgroundColor;
    
    
    [footView addSubview:butlable1];
    [footView addSubview:butlable2];
    
    
    //分享 购物车
    for(int i=0;i<2;i++)
    {
        
        UIButton *shopbtn= [[UIButton alloc]init];
        shopbtn.frame=CGRectMake(likebtn*i,0, likebtn, 50);
        shopbtn.tintColor=[UIColor blackColor];
        shopbtn.tag=4000+i;
        
        [footView addSubview:shopbtn];
        
        UIImageView *shopimageview=[[UIImageView alloc] init];
        UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, likebtn, 20)];
        titlelable.textAlignment=NSTextAlignmentCenter;
        titlelable.font=[UIFont systemFontOfSize:ZOOM(34)];
        titlelable.textColor=kTextColor;
        
        if(i==0)
        {
            
            shopimageview.frame=CGRectMake((likebtn-IMGSIZEW(@"shop_fenxiang-"))/2, 8, IMGSIZEW(@"shop_fenxiang-"), IMGSIZEH(@"shop_fenxiang-"));
            shopimageview.image=[UIImage imageNamed:@"shop_fenxiang-"];
            shopimageview.contentMode=UIViewContentModeScaleAspectFit;
            
            titlelable.text=@"分享";
            
            shopbtn.selected = NO;
            
            _aView = [[ShareAnimationView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [shopimageview addSubview:_aView];
            NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:ShareAnimationTime];
            NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
            if (time == nil || ![time isEqualToString:currTime]) {
                [_aView animationStart:YES];
            } else {
                [_aView animationStart:NO];
            }
            
        }else{
            shopimageview.frame=CGRectMake((likebtn-IMGSIZEW(@"shop_gwc-"))/2, 8, IMGSIZEW(@"shop_gwc-"), IMGSIZEH(@"shop_gwc-"));
            shopimageview.image=[UIImage imageNamed:@"shop_gwc-"];
            shopimageview.contentMode=UIViewContentModeScaleAspectFit;
            
            titlelable.text=@"购物车";
            
            //购物车角标
            self.marklable=[[UILabel alloc]initWithFrame:CGRectMake(15, -5, 16, 16)];
            self.marklable.backgroundColor=tarbarrossred;
            
//            int cart1= (int)[ShopCarManager sharedManager].s_count ;
            int cart2= (int)[ShopCarManager sharedManager].p_count ;
            if(cart2<1)
            {
                self.marklable.hidden=YES;
            }
            self.marklable.text=[NSString stringWithFormat:@"%d",cart2];
            
            self.marklable.clipsToBounds=YES;
            self.marklable.layer.cornerRadius=8;
            self.marklable.textColor=[UIColor whiteColor];
            self.marklable.textAlignment=NSTextAlignmentCenter;
            self.marklable.font=[UIFont systemFontOfSize:8];
    
            [shopimageview addSubview:self.marklable];
            
            
            _daojishilab = [[UILabel alloc]initWithFrame:CGRectMake(shopbtn.frame.size.width-ZOOM6(70), 5, ZOOM6(70), 40)];
            _daojishilab.hidden = NO;
            _daojishilab.text = @"";
            _daojishilab.font = [UIFont systemFontOfSize:ZOOM6(24)];
            _daojishilab.textAlignment = NSTextAlignmentCenter;
            _daojishilab.textColor = tarbarrossred;
            [shopbtn addSubview:_daojishilab];
        }
        
        [shopbtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [shopbtn addSubview:shopimageview];
        [shopbtn addSubview:titlelable];
        
    }
    
    CGFloat Shopbtnwidh=(kApplicationWidth-likebtn*2);
    CGFloat contactbtnXX = likebtn*2;
    
    for(int i=0;i<arr.count;i++)
    {
        UIButton *contactbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        contactbtn.frame=CGRectMake(contactbtnXX, 0, Shopbtnwidh, 50);
        
        contactbtn.tintColor=tarbarrossred;
//        [contactbtn setTitle:arr[i] forState:UIControlStateNormal];
        contactbtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(50)];
        contactbtn.tag=3000+i;
        [contactbtn addTarget:self action:@selector(contactClick:) forControlEvents:UIControlEventTouchUpInside];
        if(i==0)
        {
            contactbtn.backgroundColor=tarbarrossred;
            [contactbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            UILabel *buylable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(contactbtn.frame), CGRectGetHeight(contactbtn.frame))];
            NSString *dpZheKou = [[NSUserDefaults standardUserDefaults]objectForKey:@"dpZheKou"];
            NSString *text = [NSString stringWithFormat:@"搭配购\n下单立享%.1f折优惠",dpZheKou.floatValue*10];//@"任意2件商品\n可享受搭配购9折优惠";
            buylable.text = text;//@"搭配购\n下单立享9折优惠";
            buylable.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
            buylable.font = [UIFont systemFontOfSize:ZOOM(50)];
            buylable.numberOfLines = 0;
            buylable.textAlignment = NSTextAlignmentCenter;
            [contactbtn addSubview:buylable];
            
            NSMutableAttributedString *noteStr ;
            if(buylable.text)
            {
                noteStr = [[NSMutableAttributedString alloc]initWithString:buylable.text];
            }
            NSString *str = [NSString stringWithFormat:@"下单立享%.1f折优惠",dpZheKou.floatValue*10]; //@"下单立享9折优惠";
            
            //设置行间距
            NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle1 setLineSpacing:3];
            [noteStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
            [paragraphStyle1 setAlignment:NSTextAlignmentCenter];
            
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.8f] range:NSMakeRange(3, str.length+1)];
            [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(24)] range:NSMakeRange(3, str.length+1)];
            [buylable setAttributedText:noteStr];
            
        }
        
        [footView addSubview:contactbtn];
    }
    
}

#pragma mark 搭配购
- (void)contactClick:(UIButton*)sender
{
    MyLog(@"搭配购");
    
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self ToLoginView];
        
        return;
    }

    DPAddShopVC *vc = [[DPAddShopVC alloc] initWithShopCodes:_shopCodes pairedCode:_collocationCode detaiModel:_detailModel];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 定时器
- (void)addpop:(NSString*)type
{
    
    _pubtime = 0;
    
    UIButton *shopbtn = (UIButton*)[self.view viewWithTag:4001];
    
    _daojishilab.hidden = NO;
    
    //加购物车成功倒计时
    _mytimer= [NSTimer weakTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod1:) userInfo:nil repeats:YES];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if(_isMove == NO)
        {
            shopbtn.frame=CGRectMake(shopbtn.frame.origin.x-10,0, shopbtn.frame.size.width, 50);
            _isMove = YES;
        }
    } completion:^(BOOL finished) {
        
        
    }];

}
#pragma mark 加购物车成功倒计时
- (void)timerFireMethod1:(NSTimer*)time
{
    
    _pubtime ++;
    
    NSString *endtimestring=[NSString stringWithFormat:@"%@",_detailModel.c_time];
    NSString *nowtimestring=[NSString stringWithFormat:@"%@",_detailModel.s_time];
    
    NSString *endtime=[MyMD5 getTimeToShowWithTimestamp:endtimestring];
    NSString *nowtime=[MyMD5 getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%f",[nowtimestring doubleValue]+_pubtime*1000]];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSDate *compareDate=[formatter dateFromString:endtime];//目标时间
    NSDate *nowDate=[formatter dateFromString:nowtime];//开始时间
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:nowDate toDate:compareDate options:0];//计算时间差
    
    NSString* min=[NSString stringWithFormat:@"%ld",(long)[d minute]];
    NSString* sec=[NSString stringWithFormat:@"%ld",(long)[d second]];
    
    
    if( min.intValue < 1 && sec.intValue < 1)
    {
        //关闭定时器
        [_mytimer invalidate];
        
        min = @"0"; sec = @"0";
        
        
        _daojishilab.hidden = YES;
        
        UIButton *shopbtn = (UIButton*)[self.view viewWithTag:4001];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            shopbtn.frame=CGRectMake(shopbtn.frame.origin.x+10,0, shopbtn.frame.size.width, 50);
            _isMove = NO;
        } completion:^(BOOL finished) {
            
            self.marklable.hidden=YES;
            
        }];
        
        
    }else{
        
        _daojishilab.text = [NSString stringWithFormat:@"%02d:%02d",min.intValue,sec.intValue];
        
    }
    
    
}


#pragma mark *****************分享*******************

#pragma mark 分享  购物车
-(void)share:(UIButton*)sender
{
    if(sender.tag == 4000)//分享
    {
        [MobClick event:SHOP_SHARE];
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        NSString *token = [userdefaul objectForKey:USER_TOKEN];
        
        if(token == nil)
        {
            [self ToLoginView];
            
            return;
        }
        
        NSString *currTime = [MyMD5 getCurrTimeString:@"year-month-day"];
        [[NSUserDefaults standardUserDefaults] setObject:currTime forKey:ShareAnimationTime];
        [_aView animationStart:NO];

        //弹出分享视图
        
        if(sender.selected == NO)
        {
            [self getShareImage];
        }
        
        
    }else{//购物车
        
        [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"搭配购详情页购物车" success:^(id data, Response *response) {
        } failure:^(NSError *error) {
        }];
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        NSString *token = [userdefaul objectForKey:USER_TOKEN];
        
        if(token == nil)
        {
            [self ToLoginView];
            
            return;
        }
        
        NewShoppingCartViewController *shoppingcart =[[NewShoppingCartViewController alloc]init];
//        WTFCartViewController *shoppingcart =[[WTFCartViewController alloc]init];
        [self.navigationController pushViewController:shoppingcart animated:YES];
        
    }
    
}

- (void)getShareImage
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *imagestr = [user objectForKey:SHARE_LIFE_IMAGE];
    if(imagestr == nil)
    {
        imagestr = @"Daisy_12";
        [user setObject:@"Daisy_12" forKey:SHARE_LIFE_IMAGE];
    }
    
    [ShareImageModel getShareImageSuccess:^(ShareImageModel *data) {
        
        NSString *imageurl;
        if(data.status  == 1)
        {
            if(data.data !=nil)
            {
                imageurl = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],data.data[@"pic"]];
                
                [user setObject:imageurl forKey:SHARE_LIFE_IMAGE];
            }
        }else{
            
            imageurl = imagestr;
        }
        
        [self creatShareModelView:imageurl];
    }];
}

#pragma mark 分享视图
- (void)creatShareModelView:(NSString*)imageurl
{
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, kApplicationHeight+kUnderStatusBarStartY)];
    backview.tag=9797;
    
    
    //    UITapGestureRecognizer *viewtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapperview:)];
    //    [backview addGestureRecognizer:viewtap];
    //    backview.userInteractionEnabled = YES;
    
    [self.view addSubview:backview];
    
    _shareModelview = [[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+30, kApplicationWidth, SHAREMODELVIEW_HEIGH)];
    _shareModelview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_shareModelview];
    
    
    //生活图片
    _shareBigimgview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(570))/2, -ZOOM6(900), ZOOM6(570), ZOOM6(800))];
       
    if([imageurl hasPrefix:@"http"])
    {
        [_shareBigimgview sd_setImageWithURL:[NSURL URLWithString:imageurl]];
    }else{
        _shareBigimgview.image = [UIImage imageNamed:imageurl];
    }
    
    [self.view addSubview:_shareBigimgview];
    
    
    UIView *shareBaseView = [[UIView alloc]initWithFrame:CGRectMake(0,ZOOM6(60), kScreenWidth, SHAREMODELVIEW_HEIGH+kUnderStatusBarStartY)];
    shareBaseView.backgroundColor = [UIColor whiteColor];
    [_shareModelview addSubview:shareBaseView];
    
    //奖励文字
    CGFloat titlelable1Y = ZOOM(20);
    UILabel *titlelable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, titlelable1Y, kApplicationWidth-20, 20)];
    
    CGFloat shop_se_price =0;
    if( _detailModel.collocation_shop.count)
    {
        for(NSDictionary *dic in _detailModel.collocation_shop)
        {
            CGFloat price = [dic[@"shop_se_price"] floatValue];
            shop_se_price +=  [[NSString stringWithFormat:@"%.1f",price*0.1] floatValue];
        
//            shop_se_price +=  [dic[@"shop_se_price"] floatValue]*0.1;
        }
    }

//    titlelable1.text = [NSString stringWithFormat:@"分享美衣赚%.1f元零花钱",shop_se_price];
    titlelable1.text = @"分享美衣赢50元提现额度";
    titlelable1.frame=CGRectMake(0, titlelable1Y+ZOOM(20), kScreenWidth-2*ZOOM(20), 30);
    titlelable1.textAlignment = NSTextAlignmentCenter;
    titlelable1.font = [UIFont systemFontOfSize:ZOOM6(40)];
    titlelable1.textColor = RGBCOLOR_I(125, 125, 125);
    titlelable1.clipsToBounds=YES;
    [shareBaseView addSubview:titlelable1];
    
    NSMutableAttributedString *noteStr ;
    if(titlelable1.text)
    {
        noteStr = [[NSMutableAttributedString alloc]initWithString:titlelable1.text];
    }
    NSString *str = [NSString stringWithFormat:@"%@元",@"50"];
    
    [noteStr addAttribute:NSForegroundColorAttributeName value:tarbarrossred range:NSMakeRange(5, str.length)];
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(60)] range:NSMakeRange(5, str.length-1)];
    [titlelable1 setAttributedText:noteStr];
    
    //赚钱小秘密
    UIButton *SecretBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    SecretBtn.frame = CGRectMake(CGRectGetMaxX(titlelable1.frame)-ZOOM6(120), CGRectGetMinY(titlelable1.frame)-ZOOM(10), 50, CGRectGetHeight(titlelable1.frame)+ZOOM(40));
    [SecretBtn addTarget:self action:@selector(moretap) forControlEvents:UIControlEventTouchUpInside];
    [shareBaseView addSubview:SecretBtn];
    
    CGFloat imageHeigh = 20;
    UIImageView *secretImage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(SecretBtn.frame)-imageHeigh)/2, (CGRectGetHeight(SecretBtn.frame)-imageHeigh)/2, imageHeigh, imageHeigh)];
    secretImage.image = [UIImage imageNamed:@"shop_wenhao_red"];
    [SecretBtn addSubview:secretImage];
    
    //记录弹出时间（每天只弹一次）
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *record = [user objectForKey:SECRETDATE];
    if([[MyMD5 compareDate:record] isEqualToString:@"昨天"] || record==nil )
    {
        qdnImgView = secretImage;
        qdaImgView = [[UIImageView alloc] initWithFrame:secretImage.frame];
        qdaImgView.image = [UIImage imageNamed:@"shop_wenhao"];
        qdaImgView.layer.opacity = 0;
        [SecretBtn addSubview:qdaImgView];
        
        [qdnImgView opacityStatus:YES time:2 fromValue:1 toValue:0];
        [qdaImgView opacityStatus:YES time:2 fromValue:0 toValue:1];
    }
    NSArray *titleArray = @[@"微信群",@"朋友圈",@"QQ空间"];
    CGFloat dismissbtnYY =0;
    //分享平台
    for (int i=0; i<3; i++) {
        
        CGFloat space = (kScreenWidth - ZOOM6(300) -ZOOM6(90)*2)/2;
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        shareBtn.frame = CGRectMake((space+ZOOM6(100))*i+ZOOM6(90),CGRectGetMaxY(titlelable1.frame)+ZOOM6(40), ZOOM6(100), ZOOM6(100));
        
        shareBtn.frame = CGRectMake((kScreenWidth-ZOOM6(420))/2, CGRectGetMaxY(titlelable1.frame)+ZOOM6(50), ZOOM6(420), ZOOM6(88));
        shareBtn.tag = 9000+i;
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *sharetitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shareBtn.frame)-20, CGRectGetMaxY(shareBtn.frame)+ZOOM6(10), CGRectGetWidth(shareBtn.frame)+40, 0)];
        sharetitle.text = titleArray[i];
        sharetitle.textColor = RGBCOLOR_I(168, 168, 168);
        sharetitle.font = [UIFont systemFontOfSize:ZOOM6(24)];
        sharetitle.textAlignment = NSTextAlignmentCenter;
        
        dismissbtnYY = CGRectGetMaxY(sharetitle.frame);
        
        if (i==0) {//微信好友
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                
                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"分享到微信群"] forState:UIControlStateNormal];
                
            }else {
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
                
            }
            
        }else if (i==1){//微信朋友圈
            
            //判断设备是否安装微信
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
                
                //判断是否有微信
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
                //******
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
            }else {
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
                
            }
        }else{//QQ空间
            
            
            //判断设备是否安装QQ
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
            {
                //判断是否有qq
                
                
                [shareBtn setBackgroundImage:[UIImage imageNamed:@"qq空间-1"] forState:UIControlStateNormal];
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
            }else{
                
                shareBtn.userInteractionEnabled=NO;
                shareBtn.hidden=YES;
                sharetitle.hidden = YES;
            }
            
        }
//        [shareBaseView addSubview:sharetitle];
        [shareBaseView addSubview:shareBtn];
        
    }
    
    
    //取消按钮
    UIButton *dismissbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dismissbtn.frame = CGRectMake(ZOOM6(90), dismissbtnYY+ZOOM6(50), kScreenWidth-ZOOM6(90)*2, ZOOM6(80));
    dismissbtn.layer.borderColor = RGBCOLOR_I(125, 125, 125).CGColor;
    dismissbtn.layer.borderWidth = 1;
    dismissbtn.layer.cornerRadius = 5;
    [dismissbtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
    dismissbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    [dismissbtn setTitle:@"取消" forState:UIControlStateNormal];
    [dismissbtn addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
    [shareBaseView addSubview:dismissbtn];
    
    backview.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
        
        _shareModelview.frame=CGRectMake(0, kApplicationHeight-SHAREMODELVIEW_HEIGH+kUnderStatusBarStartY, kApplicationWidth, SHAREMODELVIEW_HEIGH);
        
        _shareBigimgview.frame=CGRectMake(_shareBigimgview.frame.origin.x, ZOOM6(60), _shareBigimgview.frame.size.width, _shareBigimgview.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}

#pragma mark 了解更多
- (void)moretap
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *record = [user objectForKey:SECRETDATE];
    if([[MyMD5 compareDate:record] isEqualToString:@"昨天"] || record==nil )
    {
        [qdnImgView opacityStatus:NO time:2 fromValue:0 toValue:1];
        [qdaImgView opacityStatus:NO time:2 fromValue:0 toValue:1];
        [user setObject:[NSDate date] forKey:SECRETDATE];
    }
    
    if([_detailModel.collocation_shop[0] count])
    {
        ShopDetailSecretViewController *secret = [[ShopDetailSecretViewController alloc]init];
        secret.shop_code = _detailModel.collocation_shop[0][@"shop_code"];
        [self.navigationController pushViewController:secret animated:YES];
    }
    
    
//    CollecLikeTaskVC *taskvc = [[CollecLikeTaskVC alloc]init];
//    taskvc.TaskFinishBlock = ^{
//        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
//        [mentionview showLable:@"分享成功" Controller:self];
//    };
//    [self.navigationController pushViewController:taskvc animated:YES];
}

- (void)dismissShareView
{
    UIButton * shopbtn = (UIButton*)[self.view viewWithTag:4001];
    shopbtn.selected = NO;
    
    [self disapperShare];
    
}


#pragma mark 分享弹框消失
- (void)disapperview:(UITapGestureRecognizer*)tap
{
    UIButton * shopbtn = (UIButton*)[self.view viewWithTag:4000];
    shopbtn.selected = NO;

    [self disapperShare];
}

- (void)disapperShare
{
    [_messagebtn becomeFirstResponder];
    
    if(_shareModelview)
    {
        
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        
    
        [UIView animateWithDuration:0.5 animations:^{
            
            backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ZOOM(680));
            
            _shareBigimgview.frame=CGRectMake(_shareBigimgview.frame.origin.x, -ZOOM6(900),_shareBigimgview.frame.size.width , _shareBigimgview.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [backview removeFromSuperview];
            [_shareModelview removeFromSuperview];
        }];
        
    }
    
}


#pragma mark 选择分享的平台
-(void)shareClick:(UIButton*)sender
{
    if(_shareModelview)
    {
        
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ZOOM(680));
            
            _shareBigimgview.frame=CGRectMake(_shareBigimgview.frame.origin.x, -ZOOM6(900),_shareBigimgview.frame.size.width , _shareBigimgview.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [backview removeFromSuperview];
            [_shareModelview removeFromSuperview];
            
            //获取商品链接
            [self shopRequest:(int)sender.tag];
        }];
        
    }
    
}

#pragma mark 获取商品链接请求
- (void)shopRequest:(int)tag
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *realm = [user objectForKey:USER_ID];
    NSString *token = [user objectForKey:USER_TOKEN];
    
    [DataManager sharedManager].key = _detailModel.collocation_code;
    
//    NSString *url=[NSString stringWithFormat:@"%@shop/getpShopLink?version=%@&p_code=%@&realm=%@&token=%@&share=%@&getPShop=true",[NSObject baseURLStr],VERSION,_ShopModel.shop_code,realm,token,@"2"];
    
     NSString *url=[NSString stringWithFormat:@"%@collocationShop/querypic?version=%@&code=%@&realm=%@&token=%@&isPic=true",[NSObject baseURLStr],VERSION,_detailModel.collocation_code,realm,token];
    
    NSString *URL=[MyMD5 authkey:url];
    
    
    [MBProgressHUD showMessage:@"分享加载中，稍等哟~" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
        [MBProgressHUD hideHUDForView:self.view];
        
        _messagebtn.userInteractionEnabled = YES;

        if (responseObject!=nil) {
            
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)
            {
                
                _shareModel=[ShareShopModel alloc];
                _shareModel.shopUrl=responseObject[@"link"];
                
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                
                if(responseObject[@"pic"])
                {
                    [userdefaul setObject:[NSString stringWithFormat:@"%@",responseObject[@"pic"]] forKey:SHOP_PIC];
                }
        
                if(responseObject[@"link"])
                {
                    if([responseObject[@"link"] hasPrefix:@"http"])
                    {
                        [userdefaul setObject:[NSString stringWithFormat:@"%@",responseObject[@"link"]] forKey:QR_LINK];
                    }else{
                        [userdefaul setObject:[NSString stringWithFormat:@"http://%@",responseObject[@"link"]] forKey:QR_LINK];
                    }
                }
                
                if( _detailModel.collocation_shop.count)
                {
                   CGFloat shop_se_price =0;
                    
                    for(NSDictionary *dic in _detailModel.collocation_shop)
                    {
                        shop_se_price +=  [dic[@"shop_se_price"] floatValue];
                        break;
                    }
                    
                    [userdefaul setObject:[NSString stringWithFormat:@"%f",shop_se_price] forKey:SHOP_PRICE];
                }
                
                if( [responseObject[@"link"] isEqualToString:@"null"] || !responseObject[@"link"])
                {
                    [MBProgressHUD hideHUDForView:self.view];
                    
                    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                    [mentionview showLable:@"数据获取异常，稍后重试" Controller:self];
                    
                    return;
                }
                
                NSArray *codeArr = [_shopCodes componentsSeparatedByString:@","];
                if(codeArr.count < 2)
                {
                    return;
                }
                
                [TypeShareModel getTypeCodeWithShop_code:codeArr[0] success:^(TypeShareModel *data) {
                    
                    if(data.status == 1 && data.type2 != nil)
                    {
                        SqliteManager *manager = [SqliteManager sharedManager];
                        TypeTagItem *item = [manager getSuppLabelItemForId:data.supp_label_id];
                        
                        if(item != nil)
                        {
                            NSString *brand = item.class_name;
                            if(brand.length)
                            {
                                [userdefaul setObject:[NSString stringWithFormat:@"%@",brand] forKey:SHOP_BRAND];
                            }
                        }
                        [userdefaul setObject:[NSString stringWithFormat:@"%@",data.type2] forKey:SHOP_TYPE2];
                        [self gotoshare:tag];
                    }
                    
                }];

            }
            
            else{
                [MBProgressHUD hideHUDForView:self.view];
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:@"网络异常，请稍后重试" Controller:self];
            }
            
            
        }
    
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        //网络连接失败");
        
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    
    
}
//小程序分享回调
- (void)MinihareManagerStatus:(MINISHARESTATE)shareStatus withType:(NSString *)type
{
    NSString *sstt = @"";
    switch (shareStatus) {
        case MINISTATE_SUCCESS:
            sstt = @"分享成功";
            break;
        case MINISTATE_FAILED:
            sstt = @"分享失败";
            break;
        case MINISTATE_CANCEL:
            sstt = @"分享取消";
            break;
        default:
            break;
    }
   
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:sstt Controller:self];
}
-(void)gotoshare:(int)sharetag
{
    //配置分享平台信息
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app shardk];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    NSString *shop_pic=[user objectForKey:SHOP_PIC];
    NSString *shopprice =[user objectForKey:SHOP_PRICE];
    NSString *qrlink = [user objectForKey:QR_LINK];
    NSString *shop_brand = [user objectForKey:SHOP_BRAND];
    NSString *realm = [user objectForKey:USER_ID];
    if(shop_brand == nil || [shop_brand isEqualToString:@"(null)"] || [shop_brand isEqual:[NSNull null]])
    {
        shop_brand = @"衣蝠";
    }
    NSString *type2 = [user objectForKey:SHOP_TYPE2];
    if(sharetag==9000)//微信好友
    {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            
//            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
//            [MBProgressHUD hideHUDForView:self.view];
//            
//            [[DShareManager share] shareAppWithType:ShareTypeWeixiSession View:nil Image:shopimage WithShareType:@"Collocationdetail"];
//        });
    
        MiniShareManager *minishare = [MiniShareManager share];
        
        NSString *image = [NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],shop_pic];
        NSString *title = [minishare taskrawardHttp:type2 Price:shopprice Brand:shop_brand];
        NSString *path  = [NSString stringWithFormat:@"/pages/shouye/detail/collocationDetail/collocationDetail?code=%@&user_id=%@",_detailModel.collocation_code,realm];
        
        minishare.delegate = self;
        [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:title Discription:nil WithSharePath:path];
    }
    else if (sharetag==9001)//微信朋友圈
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
            if(shopimage == nil)
            {
                NavgationbarView *mentionview = [[NavgationbarView alloc]init];
                [mentionview showLable:@"数据获取异常" Controller:self];
                
                return ;
            }

            [MBProgressHUD hideHUDForView:self.view];
            
            //直接创建二维码图像
            UIImage *qrpicimage = [QRCodeGenerator qrImageForString:qrlink imageSize:165];
            
            NSData *data = UIImagePNGRepresentation(qrpicimage);
            NSString *st = [NSString stringWithFormat:@"%@/Documents/abc.png", NSHomeDirectory()];
            [data writeToFile:st atomically:YES];
            
            UIImage *shopImage = [YFDPImageView dpImageWidthImage:shopimage datas:_shopData];
            ProduceImage *pi = [[ProduceImage alloc] init];
            UIImage *newimg = [pi getImage:shopImage withQRCodeImage:qrpicimage withText:@"Collocationdetail" withPrice:shopprice WithTitle:_detailModel.collocation_name];
            MyLog(@"newimg = %@",newimg);

            int shareCount = [[user objectForKey:ShareCount] intValue];
            int shareType = shareCount %2==0?1:2;
            UIImage *pubImage;
            if(shareType == 1)//分享图片
            {
                pubImage = newimg;
            }else{
                pubImage = shopimage;
            }
            
            [DShareManager share].taskValue = shareType;
            [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:pubImage WithShareType:@"Collocationdetail"];
        });
        
    
    }else if (sharetag==9002)//QQ空间
    {
        [MBProgressHUD hideHUDForView:self.view];
        
        [[DShareManager share] shareAppWithType:ShareTypeQQSpace View:nil Image:nil WithShareType:@"Collocationdetail"];
    }
    
    
    if(_shareModelview )
    {
        
        UIView *backview = (UIView*)[self.view viewWithTag:9797];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
            
            _shareModelview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, ZOOM(680));
            
            _shareBigimgview.frame=CGRectMake(_shareBigimgview.frame.origin.x, -ZOOM6(900),_shareBigimgview.frame.size.width , _shareBigimgview.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [backview removeFromSuperview];
            _messagebtn.selected=NO;
            
            [_shareModelview removeFromSuperview];
        }];
        
        UIButton * shopbtn = (UIButton*)[self.view viewWithTag:4000];
        shopbtn.selected = NO;

    }
    
}

#pragma mark 分享成功回调
- (void)Collocationsharesuccess:(NSNotification*)note
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享成功" Controller:self];
}

#pragma mark 分享失败回调
- (void)Collocationsharefail:(NSNotification*)note
{
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    [mentionview showLable:@"分享失败" Controller:self];
}

#pragma mark 联系客服
- (void)messageclick:(UIButton*)sender
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    if(token == nil)
    {
        [self ToLoginView];
        
        return;
    }
    
    MyLog(@"联系卖家");
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString* suppid = [user objectForKey:PTEID];
    
    
    [self Message:suppid];
    
}

#pragma mark 聊天
-(void)Message:(NSString*)suppid
{
    // begin 赵官林 2016.5.26（功能：联系客服）
//        [self messageWithSuppid:suppid title:nil model:_ShopModel detailType:self.detailType imageurl:_newimage];
    // end
    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    suppid = [user objectForKey:PTEID];
//    //    suppid = @"915";
//
//    EMConversation *conversation;
//
//    ChatViewController *chatController;
//    NSString *title = suppid;
//
//    NSString *chatter = conversation.chatter;
//
//    //////////////////////////////////////////以后要删除
//    chatter=suppid;
//
//    chatController = [[ChatViewController alloc] initWithChatter:chatter conversationType:conversation.conversationType];
//    chatController.collcationmodel = _detailModel;
//    chatController.detailtype = @"搭配购";
//
////    chatController.delelgate = self;
//    chatController.title = title;
//
//    if ([[RobotManager sharedInstance] getRobotNickWithUsername:chatter]) {
//        chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:chatter];
//    }
//
//    [self presentViewController:chatController animated:YES completion:^{
//
//
//    }];
    
    ContactKefuViewController *contact = [[ContactKefuViewController alloc]init];
    contact.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contact animated:YES];
}

- (void)ToLoginView
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = 1000;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark 获取文字高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    text = [text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(40), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    
    return height;
}

#pragma mark *****************网络*******************
#pragma mark 详情
- (void)shopRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url=[NSString stringWithFormat:@"%@/collocationShop/queryUnLogin?version=%@&code=%@",[NSObject baseURLStr],VERSION,self.collocationCode];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MyLog(@"responseObject = %@",responseObject);
        
        [self.collectionView headerEndRefreshing];
        
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                
                if(responseObject[@"shop"] !=nil)
                {
                    _detailModel.add_time = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"add_time"]];
                    _detailModel.collocation_code = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"collocation_code"]];
                    _detailModel.collocation_name = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"collocation_name"]];
                    _detailModel.collocation_pic = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"collocation_pic"]];
                    _detailModel.collocation_remark = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"collocation_remark"]];
                    _detailModel.type = [NSString stringWithFormat:@"%@", responseObject[@"shop"][@"type"]];
                    _detailModel.collocation_shop = responseObject[@"shop"][@"collocation_shop"];
                    _detailModel.attrList = responseObject[@"shop"][@"attrList"];
                    _detailModel.type_relation_ids = [NSString stringWithFormat:@"%@",responseObject[@"shop"][@"type_relation_ids"]];
                    
                    if(_collcationModel == nil)
                    {
                        
                        _collcationModel = [[CollocationModel alloc] init];
                        
                        _collcationModel.collocation_name = _detailModel.collocation_name;
                        _collcationModel.collocation_code = _detailModel.collocation_code;
                        _collcationModel.collocation_pic = _detailModel.collocation_pic;
                        _collcationModel.collocation_shop = _detailModel.collocation_shop;
                        _collcationModel.type = [NSNumber numberWithInt:[_detailModel.type intValue]];
                        
                        if(_shopCodes == nil)
                        {
                            
                            NSMutableArray *codes = [NSMutableArray array];
                            for(NSDictionary *dic in _collcationModel.collocation_shop){
                                if(dic !=nil)
                                {
                                    NSString *shopcode = dic[@"shop_code"];
                                    if(shopcode !=nil)
                                    {
                                        [codes addObject:shopcode];
                                    }
                                }
                            }
                            
                            _shopCodes = [codes componentsJoinedByString:@","];
                        }

                    }
                    
                    
                }
                
                if ([_collcationModel.type intValue] !=2) {
                    _shopData = _detailModel.collocation_shop;
                    NSDictionary *
                    CollocationShopDic = [_shopData firstObject];
                    CollocationShopModel *sModel = [[CollocationShopModel alloc] init];
                    [sModel setValuesForKeysWithDictionary:CollocationShopDic];
                    
                    if ([self.pushType isEqualToString:@"TFLedBrowseCollocationShopVC"]) {
                        if (![[NSUserDefaults standardUserDefaults] objectForKey:isFirstLedBroweCollocationDetail]) {
                            [NSObject delay:0.1 completion:^{
                                [self showWelComeViewFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width) model:sModel];
                            }];
                            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:isFirstLedBroweCollocationDetail];
                        }
                        
                        
                    }
                }
                
                
            }else if (statu.intValue == 10030)
            {
                LoginViewController *login=[[LoginViewController alloc]init];
                login.tag = 1000;
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
            }
            else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
            
        }
        
        
        [self allListRequest];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.collectionView footerEndRefreshing];
        [self.collectionView headerEndRefreshing];
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
}


#pragma 全部分类数据
- (void)allListRequest
{
    NSString *typeid;
    
    if(_detailModel.type_relation_ids !=nil)
    {
        NSMutableString *idstr = [NSMutableString stringWithString:_detailModel.type_relation_ids];
        
        NSArray *arr = [idstr componentsSeparatedByString:@","];
        
        for (int i =0; i<arr.count; i++) {
            typeid = arr[i];
            
            [self goList:typeid];
        }
        
    }else{
        return;
    }
    
}

- (void)goList:(NSString*)typeid
{
    
    NSMutableArray *data = [NSMutableArray array];
//    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url;
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    
    url=[NSString stringWithFormat:@"%@collocationShop/queryShopList?version=%@&code=%@&token=%@&type_id=%@",[NSObject baseURLStr],VERSION,self.collocationCode,token,typeid];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                NSArray *arr=responseObject[@"listShop"];
                
                for(NSDictionary *dic in arr)
                {
                    
                    ShopDetailModel *model=[[ShopDetailModel alloc]init];
                    
                    model.def_pic=[NSString stringWithFormat:@"%@",dic[@"def_pic"]];
                    model.kickback=[NSString stringWithFormat:@"%@",dic[@"kickback"]];
                    model.shop_code=[NSString stringWithFormat:@"%@",dic[@"shop_code"]];
                    model.shop_name=[NSString stringWithFormat:@"%@",dic[@"shop_name"]];
                    model.shop_se_price=[NSString stringWithFormat:@"%@",dic[@"shop_se_price"]];
                    //加
                    model.shop_price = [NSString stringWithFormat:@"%@",dic[@"shop_price"]];
                    model.supp_label = [NSString stringWithFormat:@"%@",dic[@"supp_label"]];
                    
                    [data addObject:model];
                }
                
                if(data.count)
                {

                    [_dataDic setObject:data forKey:typeid];
                    
                }
                
        
            }else{
                
                NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                [mentionview showLable:message Controller:self];
            }
            
        }
        
       
        //处理数据
        NSMutableString *idstr = [NSMutableString stringWithString:_detailModel.type_relation_ids];
        
        NSArray *arr = [idstr componentsSeparatedByString:@","];
        
        if([_dataDic allValues].count == arr.count)
        {
            for(int k =0; k<arr.count; k++)
            {
                NSArray *dataArr = [_dataDic objectForKey:arr[k]];
                
                if(dataArr.count)
                {
                    [_dataArray addObject:dataArr];
                }
            }

        }
        
        //刷新界面
        if(arr.count == _dataArray.count)
        {
            UIButton *contactbtn = (UIButton*)[self.view viewWithTag:3000];
            //如果搭配商品flg都是1则都不是搭配商品
            NSMutableArray *flgArr = [NSMutableArray array];
            for (int i = 0; i < _detailModel.collocation_shop.count; i++) {
                NSDictionary *dic = _detailModel.collocation_shop[i];
                if([dic[@"option_flag"] intValue]==1)
                {
                    [flgArr addObject:dic[@"option_flag"]];
                }
            }
            if(flgArr.count == _detailModel.collocation_shop.count)
            {
                contactbtn.backgroundColor=RGBCOLOR_I(196, 196, 196);
                [contactbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                contactbtn.enabled = NO;
            } else {
                contactbtn.backgroundColor=tarbarrossred;
                contactbtn.enabled = YES;
            }
            [self.collectionView reloadData];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
    }];
    
}



- (void)creatDataAnimation
{
    _shopDirvelArr = [NSMutableArray array];
    
    _shopDirvelArr= [self FindDataForTPYEDB:@"0"];
    
    if(_shopDirvelArr.count)
    {
        
    }
}

#pragma mark - *****************数据库查找*******************

- (void)closeDB
{
    if (AttrcontactDB) {
        sqlite3_close(AttrcontactDB);
        AttrcontactDB = 0x00;
        
    }
    
}

-(BOOL)OpenDb
{
    if(AttrcontactDB)
    {
        return YES;
    }
    
    BOOL result=NO;
    
    /*根据路径创建数据库并创建一个表contact(id nametext addresstext phonetext)*/
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"attr.db"]];
    
    //    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //    if ([filemgr fileExistsAtPath:_databasePath] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &AttrcontactDB)==SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt;
            
            sql_stmt=_sql_stmt;
            if (sqlite3_exec(AttrcontactDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK)
            {
                
                result= YES;
            }
        }
        else
        {
            result= NO;
        }
    }
    
    
    return YES;
}

-(NSMutableArray *)FindDataForTPYEDB:(NSString *)findStr
{
    
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,address,phone,ico,sequence,isshow,groupflag from TYPDB where address=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *ico = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    NSString *sequence = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    NSString *isShow = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                    NSString *groupflag = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                    
                    [mudic setValue:ID forKey:@"id"];
                    [mudic setValue:name forKey:@"name"];
                    [mudic setValue:ico forKey:@"ico"];
                    [mudic setValue:sequence forKey:@"sequence"];
                    [mudic setValue:isShow forKey:@"isShow"];
                    [mudic setValue:groupflag forKey:@"groupFlag"];
                    
                    
                    [muArr addObject:mudic];
                    
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
        
    }
    
    return muArr;
}


#pragma mark ****************UIScrollViewdelegate********************
#pragma mark tableview表头顶置
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //让导航条渐变色
    UIImageView *headview=(UIImageView*)[self.view viewWithTag:3838];
    
    if(scrollView.contentOffset.y > 50 ){
        
        
        [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui_black"] forState:UIControlStateNormal];
        
        _siimage.image = [UIImage imageNamed:@"lianxikefu-black"];
        
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
        headview.image = [UIImage imageNamed:@""];
        headview.backgroundColor = [UIColor whiteColor];
        headview.alpha = scrollView.contentOffset.y/ZOOM(450*3.4);
        
    }else if (scrollView.contentOffset.y <= 50 && scrollView.contentOffset.y >= 0){
        
        [_backbtn setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
        
        
        _siimage.image = [UIImage imageNamed:@"shop_lxkf-"];
        
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
       
        headview.backgroundColor = [UIColor clearColor];
        headview.image = [UIImage imageNamed:@"zhezhao"];
        
        [UIView animateWithDuration:1.0 animations:^{
            
            headview.alpha = 1;
            
            
        } completion:^(BOOL finished) {
            
            
        }];
    }
    
    
  
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    //隐藏footview
    UIView *footview = (UIView *)[self.view viewWithTag:8181];
    footview.clipsToBounds =YES;
    footview.userInteractionEnabled=YES;
    
    //上滑隐藏footview 下滑显示
    if(translation.y>0)
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            footview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
    }else if(translation.y<0){
        
        [UIView animateWithDuration:0.3 animations:^{
            
            footview.frame=CGRectMake(0, kApplicationHeight+30, kApplicationWidth, footview.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
    }else{
        
        footview.hidden=NO;
        
    }
    
    
    _moveHeigh = scrollView.contentOffset.y;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if(!decelerate){
        
        //这里写上停止时要执行的代码
    
        UIView *footview = (UIView *)[self.view viewWithTag:8181];
        footview.clipsToBounds =YES;
        footview.userInteractionEnabled=YES;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            footview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50);
            
        } completion:^(BOOL finished) {
            
            
        }];
        
    }
    
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidDisappear:(BOOL)animated
{
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)showWelComeViewFrame:(CGRect)frame model:(CollocationShopModel *)model
{
    if (!model) {
        return;
    }
    
    CollocationShopModel *sModel = model;
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIView *backgroundV = [[UIView alloc] initWithFrame:keyWindow.bounds];
    backgroundV.backgroundColor = [UIColor clearColor];
    backgroundV.tag = 2008;
    [keyWindow addSubview:backgroundV];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRClick:)];
    [backgroundV addGestureRecognizer:tapGR];
    
    [UIView animateWithDuration:0.5 animations:^{
        backgroundV.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finish) {
        
    }];
    
    UIView *cellV = [[UIView alloc] init];
    cellV.backgroundColor = [UIColor clearColor];
    cellV.frame = frame;
    [backgroundV addSubview:cellV];
    
    CGFloat scale = kScreen_Width/375;
    YFTagsView *tagView = [[YFTagsView alloc] initWithFrame:CGRectMake(-20*scale, -12*scale, 25*scale, 24*scale) Type:YFTagsViewTypeLeft];
    tagView.userInteractionEnabled = NO;
    tagView.frame = CGRectMake(-20*scale, -12*scale, 25*scale, 24*scale);
    CGPoint point = CGPointMake(168*scale,110*scale);
    CGFloat maxWidth = point.x + 5*scale;
    
    tagView.type = YFTagsViewTypeLeft;
    tagView.maxWidth = maxWidth;
    tagView.isImage = YES;
    tagView.isHighlight = YES;
    tagView.title = sModel.shop_name?:@"";
    
    tagView.right = cellV.width*sModel.shop_x+5*scale;
    tagView.centerY = cellV.height*sModel.shop_y;
    [cellV addSubview:tagView];
    
    UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tagBtn.frame = tagView.frame;
    tagBtn.backgroundColor = [UIColor clearColor];
    [tagBtn addTarget:self action:@selector(tagBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cellV addSubview:tagBtn];
    
    UIImage *image = [UIImage imageNamed:@"ledBrowse_shoushi"];
    CGFloat image_W = tagView.width*1.5;
    CGFloat image_H = [UIImage imageConvertHeightWithImage:image fromWidth:image_W];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(-tagView.left, tagView.bottom, image_W, image_H)];
    imageV.centerX = tagView.centerX;
    imageV.image = image;
    [cellV addSubview:imageV];
    
    UIImage *knowImage = [UIImage imageNamed:@"ledBrowse_but_i-know"];
    CGFloat knowImage_H = [UIImage imageConvertHeightWithImage:knowImage fromWidth:image_W];
    
    UIButton *knowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [knowBtn setImage:knowImage forState:UIControlStateNormal];
    knowBtn.frame = CGRectMake(0, 0, image_W, knowImage_H);
    knowBtn.bottom = kScreen_Height-ZOOM6(280);
    knowBtn.centerX = kScreen_Width*0.5;
    [knowBtn addTarget:self action:@selector(knowBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backgroundV addSubview:knowBtn];
}

- (void)tagBtnClick
{
    [self hideTheWelComeVAniamtion:NO];
    
    NSDictionary *
    CollocationShopDic = [_shopData firstObject];
    CollocationShopModel *sModel = [[CollocationShopModel alloc] init];
    [sModel setValuesForKeysWithDictionary:CollocationShopDic];
    [self pushShopDetailShopCode:sModel.shop_code row:0];
}

- (void)knowBtnClick
{
    [self hideTheWelComeVAniamtion:YES];
}

- (void)tapGRClick:(UITapGestureRecognizer *)sender
{
    [self hideTheWelComeVAniamtion:YES];
}

- (void)hideTheWelComeVAniamtion:(BOOL)isAnimation
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *backgroundV = [keyWindow viewWithTag:2008];
    if (!isAnimation) {
        [backgroundV removeFromSuperview];
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        backgroundV.alpha = 0;
    } completion:^(BOOL finish) {
        [backgroundV removeFromSuperview];
    }];
}
- (void)pushShopDetailShopCode:(NSString *)shopCode row:(NSInteger)row
{
    NSLog(@"%@",shopCode);
    ShopDetailViewController *detail=[[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
    detail.shop_code = shopCode;
    
    detail.stringtype = self.stringtype;
    detail.rewardType = self.rewardType;
    detail.rewardValue = self.rewardValue;
    detail.Browsedic = self.Browsedic;
    detail.browseCount = self.browseCount;

    detail.currTimeCount = self.currTimeCount;
    detail.showGetMoneyWindow = self.showGetMoneyWindow;
    
    kWeakSelf(self);
    detail.browseCountBlock = ^() {
        if (weakself.browseCountBlock) {
            weakself.browseCountBlock(shopCode);
        }
    };
    
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
