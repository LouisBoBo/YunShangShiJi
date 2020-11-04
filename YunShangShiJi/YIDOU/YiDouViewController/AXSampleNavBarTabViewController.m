//
//  AXSampleNavBarTabViewController.m
//  StretchableHeaderTabViewExample
//

#import "AXSampleNavBarTabViewController.h"

#import "GlobalTool.h"
//VC
#import "YDTableViewController.h"
#import "AXSampleSwipableHeaderView.h"
#import "TaskCollectionVC.h"
#import "TFWithdrawCashViewController.h"
#import "LuckdrawViewController.h"
//View
#import "CFPopView.h"
#import "TFPopBackgroundView.h"
#import "VitalityModel.h"

@interface AXSampleNavBarTabViewController ()

@property (nonatomic,strong)NSArray *titleArr;

@property (nonatomic,strong)UIView *mainView;

//衣豆明细
@property (nonatomic,strong)UIImageView *headImg;
@property (nonatomic,strong)UILabel *yidouLabel;
@property (nonatomic,strong)UILabel *yidouNum;
@property (nonatomic,strong)UILabel *otherNum;

//额度明细
@property (nonatomic,strong)UILabel *allMoney;
@property (nonatomic,strong)UILabel *otherMoney;
@property (nonatomic,strong)UILabel *rightMoney;
@property (nonatomic,strong)UIButton *GoBtn;
@property (nonatomic, strong) UILabel *overLabel;
@property (nonatomic, strong) UILabel *canWithCashLabel;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@property (assign,nonatomic)float peas;                  //可用衣豆 总金额
@property (assign,nonatomic)float peas_freeze;             //冻结衣豆
@property (assign,nonatomic)float freezeMoney;              //冻结额度
@property (assign,nonatomic)float extract;

@end

@implementation AXSampleNavBarTabViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//  if (self) {
//      self.automaticallyAdjustsScrollViewInsets=NO;
//    AXSampleSwipableHeaderView *headerView = [[AXSampleSwipableHeaderView alloc] init];
//      
//    self.headerView = headerView;
//
//      [self addChildViewControllers];
//      
////    YDTableViewController *sub1ViewCon = [[YDTableViewController alloc] init];
////    YDTableViewController *sub2ViewCon = [[YDTableViewController alloc] init];
////    YDTableViewController *sub3ViewCon = [[YDTableViewController alloc] init];
////    YDTableViewController *sub4ViewCon = [[YDTableViewController alloc] init];
////    NSArray *viewControllers = @[sub1ViewCon, sub2ViewCon, sub3ViewCon, sub4ViewCon];
////    self.viewControllers = viewControllers;
//  }
//  return self;
//}

- (instancetype)initWithType:(YDPageVCType)type peas:(float)peas peas_freeze:(float)peas_freeze extract:(float)extract freezeMoney:(float)freezeMoney {
    if (self = [super init]) {
        _type = type;
        _peas = peas;
        _peas_freeze = peas_freeze;
        _freezeMoney=freezeMoney;
        _extract = extract;
       
        if ([UIDevice currentDevice].systemVersion.doubleValue>=11.0) {
        }else
            self.automaticallyAdjustsScrollViewInsets=NO;

        AXSampleSwipableHeaderView *headerView = [[AXSampleSwipableHeaderView alloc] init];
        
        self.headerView = headerView;
        
        self.tabBar.tabBarButtonFont=[UIFont systemFontOfSize:ZOOM6(32)];
        [self addChildViewControllers];
    }
    return self;
}

- (void)addChildViewControllers {
    NSMutableArray *arr=[NSMutableArray array];
    for (int i=0; i<self.titleArr.count; i++) {
        YDTableViewController *tableVC=[[YDTableViewController alloc]init];
        tableVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.titleArr[i] image:nil tag:0];
        tableVC.type=_type;
        [tableVC reloadData:i];
        [arr addObject:tableVC];
    }
    self.viewControllers=[arr copy];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headerView.minimumOfHeight = Height_NavBar;
    self.headerView.maximumOfHeight =  _type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage) ? ZOOM6(310)+40+63 :ZOOM6(324)+kZoom6pt(13)*2+ZOOM6(85)+10+63;//ZOOM6(310)+40+63;
    self.bottomInset = _type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage ) ? ZOOM(200) : 0;
    
    AXSampleSwipableHeaderView *headerView = (id)self.headerView;
    [headerView addSubview:self.mainView];
    
    if (_type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage)) {
        [self.mainView addSubview:self.headImg];
        [self.mainView addSubview:self.yidouLabel];
        [self.mainView addSubview:self.yidouNum];
        [self.mainView addSubview:self.otherNum];
        [self setFootView];

    }else{
//        [self.mainView addSubview:self.allMoney];
//        [self.mainView addSubview:self.otherMoney];
//        [self.mainView addSubview:self.rightMoney];
//        [self.mainView addSubview:self.GoBtn];
        [self setMainUI];
    }

    [self setNavgationView];

    if (_type==YDPageVCTypeYidouFromMessage || _type==YDPageVCTypeMoney ) {
        [self httpGetData];
    }
}

#pragma mark -衣豆明细
- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-ZOOM6(65), ZOOM6(80), ZOOM6(130), ZOOM6(74))];
        [_headImg setImage:[UIImage imageNamed:@"yidou"]];
//        _headImg.backgroundColor=DRandomColor;
    }
    return _headImg;
}
- (UILabel *)yidouLabel {
    if (!_yidouLabel) {
        _yidouLabel=[[UILabel alloc]initWithFrame:CGRectMake( kScreenWidth/2-100, CGRectGetMaxY(self.headImg.frame)+ZOOM6(20), 200, 20)];
        _yidouLabel.text=@"当前可用衣豆";
        _yidouLabel.textColor=kMainTitleColor;
        _yidouLabel.font=[UIFont systemFontOfSize:ZOOM6(28)];
        _yidouLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _yidouLabel;
}
- (UILabel *)yidouNum {
    if (!_yidouNum) {
        _yidouNum=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, CGRectGetMaxY(self.yidouLabel.frame)+ZOOM6(10), 200, ZOOM6(80))];
        _yidouNum.text=[NSString stringWithFormat:@"%.0f",self.peas];
        _yidouNum.font=[UIFont boldSystemFontOfSize:ZOOM6(72)];
        _yidouNum.textColor=tarbarrossred;
        _yidouNum.textAlignment=NSTextAlignmentCenter;
    }
    return _yidouNum;
}
- (UILabel *)otherNum {
    if (!_otherNum) {
        _otherNum=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-100, CGRectGetMaxY(self.yidouNum.frame)+ZOOM6(10), 200, 20)];
        _otherNum.text=[NSString stringWithFormat:@"(冻结衣豆:%.0f)",self.peas_freeze];
        _otherNum.font=[UIFont systemFontOfSize:ZOOM6(28)];
        _otherNum.textColor=kSubTitleColor;
        _otherNum.textAlignment=NSTextAlignmentCenter;
    }
    return _otherNum;
}
#pragma mark -额度明细
- (UILabel *)labelWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 1;
    label.textColor = color;
    label.font = font;
    label.text = text;
    return label;
}
- (void)setMainUI {
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, ZOOM6(324))];
//    [self addSubview:_topView = topView];
    // 左边
    UIView *contentLeftView = [[UIView alloc] initWithFrame:CGRectZero];
    [_mainView addSubview:contentLeftView];
    UILabel *titleLabel = [self labelWithText:@"我的余额" color:kTextColor font:[UIFont systemFontOfSize:ZOOM6(30)]];
    [contentLeftView addSubview:titleLabel];
    
   _overLabel = [self labelWithText:[NSString stringWithFormat:@"%.2f",_peas] color:tarbarrossred font:[UIFont boldSystemFontOfSize:ZOOM6(72)]];
    [contentLeftView addSubview:_overLabel];
    
    [contentLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ZOOM6(224));
        make.width.mas_equalTo(kScreen_Width * 0.5);
        make.left.top.equalTo(@0);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.mas_equalTo(ZOOM6(60));
    }];
    
    [_overLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(titleLabel.mas_bottom);
    }];
    
    // 右边
    UIView *contentRightView = [[UIView alloc] initWithFrame:CGRectZero];
    [_mainView addSubview:contentRightView];
    UILabel *titleLabel2 = [self labelWithText:@"冻结余额" color:kTextColor font:[UIFont systemFontOfSize:ZOOM6(30)]];
    [contentRightView addSubview:titleLabel2];
    
   _canWithCashLabel = [self labelWithText:[NSString stringWithFormat:@"%.2f",_peas_freeze] color:tarbarrossred font:[UIFont boldSystemFontOfSize:ZOOM6(72)]];
    [contentRightView addSubview:_canWithCashLabel];
    
    [contentRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentLeftView.mas_centerY);
        make.size.equalTo(contentLeftView);
        make.right.equalTo(@0);
    }];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.mas_equalTo(ZOOM6(60));
    }];
    
    [_canWithCashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(titleLabel2.mas_bottom);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = lineGreyColor;
    [_mainView addSubview:line];
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.textColor = kMainTitleColor;
    leftLabel.font = kFont6px(30);
    leftLabel.text = @"提现额度";
    [_mainView addSubview:leftLabel];
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.textColor = kMainTitleColor;
    rightLabel.font = kFont6px(30);
    rightLabel.text = @"提现冻结";
    [_mainView addSubview:rightLabel];
    _leftLabel = leftLabel;
    _rightLabel = rightLabel;
    
    NSString *str3 = [NSString stringWithFormat:@"%.2f",_extract];
    NSString *str4 = [NSString stringWithFormat:@"%.2f",_freezeMoney];
    NSString *string = [NSString stringWithFormat:@"提现额度：%@",str3];
    NSString *string2 = [NSString stringWithFormat:@"提现冻结：%@",str4];
    [leftLabel setAttributedText:[NSString getOneColorInLabel:string ColorString:str3 Color:tarbarrossred font:kFont6px(30)]];
    [rightLabel setAttributedText:[NSString getOneColorInLabel:string2 ColorString:str4 Color:tarbarrossred font:kFont6px(30)]];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.mas_equalTo(ZOOM6(224));
        //        make.top.equalTo(contentLeftView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(@0);
        make.width.mas_equalTo(kScreen_Width * 0.5);
        make.height.mas_equalTo(ZOOM6(100));
    }];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.right.equalTo(@0);
        make.width.mas_equalTo(kScreen_Width * 0.5);
        make.height.mas_equalTo(ZOOM6(100));
    }];
//    _leftLabel = leftLabel;
//    _rightLabel = rightLabel;
    
    // 线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ZOOM6(324)-0.5, self.view.width, 0.5)];
    lineView.backgroundColor = lineGreyColor;
    [_mainView addSubview:lineView];
    
    
    UIButton *cashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cashBtn setBackgroundColor:tarbarrossred];
    [cashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cashBtn setTitle:@"提 现" forState:UIControlStateNormal];
    [cashBtn addTarget:self action:@selector(toCash) forControlEvents:UIControlEventTouchUpInside];
    cashBtn.clipsToBounds = YES;
    cashBtn.layer.cornerRadius = kZoom6pt(5);
    [_mainView addSubview:cashBtn];
    self.GoBtn = cashBtn;
    
    [cashBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_top).offset(kZoom6pt(13));
        make.left.mas_equalTo(kZoom6pt(15));
        make.right.mas_equalTo(kZoom6pt(-15));
        make.height.mas_equalTo(ZOOM6(85));
    }];
}
/*
- (UILabel *)allMoney {
    if (!_allMoney) {
        _allMoney=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), (self.headerView.maximumOfHeight-63-ZOOM6(20)-ZOOM6(140))/2-20, 130, 30)];
        _allMoney.textAlignment=NSTextAlignmentCenter;
        _allMoney.textColor=tarbarrossred;
//        _allMoney.backgroundColor=DRandomColor;
        _allMoney.font=[UIFont systemFontOfSize:ZOOM6(54)];
        _allMoney.text=[NSString stringWithFormat:@"%.2f",self.peas];
//        [_allMoney setAttributedText:[NSString getOneColorInLabel:@"50.85总余额" ColorString:@"50.85" Color:tarbarrossred fontSize:ZOOM6(54)]];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(_allMoney.x, CGRectGetMaxY(_allMoney.frame), _allMoney.width, 20)];
        label.textColor=kSubTitleColor;
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"总余额";
        label.font=[UIFont systemFontOfSize:ZOOM6(28)];
        [self.mainView addSubview:label];
    }
    return _allMoney;
}
- (UILabel *)otherMoney {
    if (!_otherMoney) {
        _otherMoney=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2, (self.headerView.maximumOfHeight-63-ZOOM6(20)-ZOOM6(140))/2-20, 150, 30)];
        _otherMoney.textAlignment=NSTextAlignmentCenter;
        _otherMoney.textColor=tarbarrossred;
//        _otherMoney.backgroundColor=DRandomColor;
        _otherMoney.font=[UIFont systemFontOfSize:ZOOM6(54)];
        _otherMoney.text=[NSString stringWithFormat:@"%.2f",self.peas_freeze];
//        [_otherMoney setAttributedText:[NSString getOneColorInLabel:@"50.85可提现" ColorString:@"50.85" Color:tarbarrossred fontSize:ZOOM6(54)]];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(_otherMoney.x, CGRectGetMaxY(_otherMoney.frame), _otherMoney.width, 20)];
        label.textColor=kSubTitleColor;
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"可提现";
        label.font=[UIFont systemFontOfSize:ZOOM6(28)];
        [self.mainView addSubview:label];
    }
    return _otherMoney;
}
- (UILabel *)rightMoney {
    if (!_rightMoney) {
        _rightMoney=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-150, (self.headerView.maximumOfHeight-63-ZOOM6(20)-ZOOM6(140))/2-20, 150, 30)];
        _rightMoney.textAlignment=NSTextAlignmentCenter;
        _rightMoney.textColor=tarbarrossred;
        _rightMoney.font=[UIFont systemFontOfSize:ZOOM6(54)];
        _rightMoney.text=[NSString stringWithFormat:@"%.2f",self.freezeMoney];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(_rightMoney.x, CGRectGetMaxY(_rightMoney.frame), _rightMoney.width, 20)];
        label.textColor=kSubTitleColor;
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"冻结额度";
        label.font=[UIFont systemFontOfSize:ZOOM6(28)];
        [self.mainView addSubview:label];
    }
    return _rightMoney;
}
- (UIButton *)GoBtn {
    if (!_GoBtn) {
        _GoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _GoBtn.frame=CGRectMake(ZOOM6(20), (self.headerView.maximumOfHeight-63-ZOOM6(20)-ZOOM6(120)), kScreenWidth-ZOOM6(40), ZOOM6(100));
        _GoBtn.backgroundColor=tarbarrossred;
        _GoBtn.layer.cornerRadius=5;
        _GoBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(42)];
        [_GoBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_GoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_GoBtn addTarget:self action:@selector(toCash) forControlEvents:UIControlEventTouchUpInside];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, _GoBtn.y-ZOOM6(20), kScreenWidth, 0.5)];
        line.backgroundColor=lineGreyColor;
        [self.mainView addSubview:line];
    }
    return _GoBtn;
}
*/
- (UIView *)mainView {
    if (!_mainView) {
        _mainView=[[UIView alloc]init];
        _mainView.backgroundColor=[UIColor whiteColor];
        _mainView.translatesAutoresizingMaskIntoConstraints=NO;
        [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.headerView.maximumOfHeight-63]];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake( 0, self.headerView.maximumOfHeight-63-ZOOM6(20), kScreenWidth, ZOOM6(20))];
        line.backgroundColor=kTableLineColor;
        [_mainView addSubview:line];
    }
    return _mainView;
}
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = _type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage) ? @[@"消耗",@"增加",@"冻结"] : @[@"新增提现",@"已提现",@"冻结提现"];
    }
    return _titleArr;
}
- (void)setNavgationView {
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kScreenWidth/2, headview.frame.size.height/2+10);
    titlelable.text = _type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage) ? @"衣豆明细" : @"提现明细";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM(42)-100, 25, 100, 30)];
    rightLabel.centerY = View_CenterY(headview);
    rightLabel.text= _type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage) ? @"衣豆说明" : @"额度说明";
    rightLabel.font = [UIFont systemFontOfSize:ZOOM6(32)];
    rightLabel.textColor=RGBCOLOR_I(125, 125, 125);
    rightLabel.textAlignment = NSTextAlignmentRight;
    [headview addSubview:rightLabel];
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(kScreenWidth-ZOOM(42)-100, 25, 100, 30);
    rightBtn.centerY = View_CenterY(headview);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:rightBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height, kScreenWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [headview addSubview:line];
    
    
    /******  响应点击事件 ******/
    AXSampleSwipableHeaderView *headerView = (id)self.headerView;
    headerView.interactiveSubviews=
         _type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage) ? @[backbtn,rightBtn]
                                  : @[backbtn,rightBtn,self.GoBtn];

}
- (void)setFootView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-ZOOM(200), kScreenWidth, ZOOM(200))];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor=kNavLineColor;
    [view addSubview:line];
    
    UIButton *FootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FootBtn.frame=CGRectMake(kZoom6pt(15), ZOOM(32), kScreenWidth-kZoom6pt(15)*2, view.frame.size.height-ZOOM(32)*2);
    [FootBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FootBtn setTitle:@"获取衣豆" forState:UIControlStateNormal];
    [FootBtn setBackgroundImage:[UIImage imageWithColor:tarbarrossred] forState:UIControlStateNormal];
    FootBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOMPT(18)];
    [FootBtn addTarget:self action:@selector(FootBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    FootBtn.layer.cornerRadius = 3;
    FootBtn.layer.masksToBounds = YES;
    [view addSubview:FootBtn];
    
}

#pragma mark -BtnClick
- (void)changeSelectedIndex:(NSInteger)selectedIndex {
    [super changeSelectedIndex:selectedIndex];
    MyLog(@"%zd",selectedIndex);
    [(YDTableViewController *)self.selectedViewController reloadData:selectedIndex];
}
- (void)toCash {
    NSString *usertype = [[NSUserDefaults standardUserDefaults] objectForKey:USER_CLASSIFY];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if([usertype isEqualToString:@"0"]||[usertype isEqualToString:@"1"]||[usertype isEqualToString:@"2"])//提现引导
    {
        if(token.length > 8) {
//            [self popViewWithDrawCashGuide];
            [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台
                
            }];
            
            TFWithdrawCashViewController *VC = [[TFWithdrawCashViewController alloc] init];
            VC.bindNameAndIdenfBlock = ^(NSInteger sguidance) {
                
            };
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else {
        TFWithdrawCashViewController *cash = [[TFWithdrawCashViewController alloc]init];
        [self.navigationController pushViewController:cash animated:YES];
    }
}
#pragma mark 提现引导
- (void)popViewWithDrawCashGuide {
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    popView.rightText = @"下一步";
    popView.title = @"提现引导";
    UIView *contentV = [[UIView alloc] init];
    popView.contentView = contentV;

    UILabel *contentLabel = [UILabel new];
    NSString *text = @"欢迎加入衣蝠，为了让新用户能快速体验提现功能，我们特意在你的提现可提现额度中存入了1.00元现金，现在可以立即提现了哦~";
    contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
    contentLabel.font = kFont6px(28);
    contentLabel.numberOfLines = 0;
    contentLabel.text = text;
    [contentV addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(contentV);
    }];

    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    [contentV setNeedsLayout];

    [popView showCancelBlock:^{

        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台

        }];
    } withConfirmBlock:^{

        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台

        }];

        TFWithdrawCashViewController *VC = [[TFWithdrawCashViewController alloc] init];
        VC.bindNameAndIdenfBlock = ^(NSInteger sguidance) {

        };
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } withNoOperationBlock:^{

        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台

        }];
    }];
}
- (void)FootBtnClick:(UIButton *)sender {
    MyLog(@"FootBtnClick");
    TaskCollectionVC *vc = [[TaskCollectionVC alloc]init];
    vc.typeID = [NSNumber numberWithInt:6];
    vc.typeName = @"热卖";
    vc.title = @"热卖";
    vc.is_jingxi = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goBack:(UIButton *)sender {
    if (_type==YDPageVCTypeYidouFromMessage&&sender==nil) {
        LuckdrawViewController *vc=[[LuckdrawViewController alloc]init];
        vc.is_fromMessage=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else
        [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBtnClick {
    MyLog(@"rightBtnClick");
    CFPopView *view=[[CFPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) textStr:_type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage)?@"如何获得衣豆?": @"提现额度说明" leftBtnStr:@"知道了" rightBtnStr:@"抽提现额度" popType:CFPopTypeWhite];
    [view show];
    [view setLeftBlock:^{
        
    } withRightBlock:^{
        [self goBack:nil];
    }];
}
- (void)reloadDataMainView {
    self.yidouNum.text=[NSString stringWithFormat:@"%.0f",self.peas];
    self.otherNum.text=[NSString stringWithFormat:@"(冻结衣豆:%.0f)",self.peas_freeze];

}
- (void)httpGetData
{
    //获取余额
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/myWallet?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
              

                if (_type==YDPageVCTypeMoney) {
                    double balance = [[NSString stringWithFormat:@"%@", responseObject[@"balance"]]floatValue]; // 总余额
                    double extract = [[NSString stringWithFormat:@"%@", responseObject[@"extract"]]floatValue]; // 可提现余额
                    double freeze_balance = [[NSString stringWithFormat:@"%@", responseObject[@"freeze_balance"]]floatValue];
                    double ex_free = [[NSString stringWithFormat:@"%@", responseObject[@"ex_free"]]floatValue];
                    
                    _overLabel.text = [NSString stringWithFormat:@"%.2f",balance];
                    _canWithCashLabel.text = [NSString stringWithFormat:@"%.2f",freeze_balance];
                    
                    NSString *str3 = [NSString stringWithFormat:@"%.2f",extract];
                    NSString *str4 = [NSString stringWithFormat:@"%.2f",ex_free];
                    NSString *string = [NSString stringWithFormat:@"提现额度：%@",str3];
                    NSString *string2 = [NSString stringWithFormat:@"提现冻结：%@",str4];
                    [_leftLabel setAttributedText:[NSString getOneColorInLabel:string ColorString:str3 Color:tarbarrossred font:kFont6px(30)]];
                    [_rightLabel setAttributedText:[NSString getOneColorInLabel:string2 ColorString:str4 Color:tarbarrossred font:kFont6px(30)]];
                }else{
                    _peas = [[NSString stringWithFormat:@"%@",responseObject[@"peas"]] intValue];
                    _peas_freeze = [[NSString stringWithFormat:@"%@",responseObject[@"peas_free"]] intValue];
                    [self reloadDataMainView];
                }
                
                
            } else {
                //                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
    
}
- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}


@end