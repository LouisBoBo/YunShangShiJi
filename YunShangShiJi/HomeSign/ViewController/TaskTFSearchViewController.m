//
//  TFSearchViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/18.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TaskTFSearchViewController.h"
#import "PopoverView.h"
#import "TFShoppingViewController.h"
#import "Animation.h"
#import "TFPopBackgroundView.h"
#import "CollectionImageHeaderView.h"
#import "DefaultImgManager.h"

//#define BottomHeight 30
#define HeadHeight ZOOM6(60)
#define BtnMargin ZOOM6(20)

@interface TaskTFSearchViewController ()<PopoverViewDelegate>
{
    CGFloat BottomHeight;
}
@property (nonatomic, assign)int page;

//@property (nonatomic, strong)UIImageView *navigationView;

@property (nonatomic, strong)UIScrollView *headScrollView;
@property (nonatomic, strong)UILabel *headLabel;
@property (nonatomic, strong)UIScrollView *bottomScrollView;
@property (nonatomic, copy) NSString *appendingStr;
@property (nonatomic, copy) NSString *notType;
@property (nonatomic, strong) MenuButtonView *menuButtonView;
@property (nonatomic, strong) UIView *headerTimerView;
@property (nonatomic, strong) UIButton *explainBtn;
@property (nonatomic, strong) UILabel *messageLab;
@end

@implementation TaskTFSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [super setNavigationItemLeft:@"搜索"];
    
    self.notType=@"false";
    [self setNavigationItem];
    
    
    
    [self getData];
    
    [self setupUI];
    
    if ([self.dataStatistics hasPrefix:@"风格"]) {
        [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@列表页", self.dataStatistics];
    } else if ([self.dataStatistics isEqualToString:@"搜索结果商品点击"]) {
         [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@列表页", self.shopTitle];
    }
    
}


- (void)viewDidAppear:(BOOL)animated
{
    if (self.MainViewStatusNormal) {
        self.MainViewStatusNormal();
    }
}

- (void)viewDidDisappear:(BOOL)animated
{

}


-(void)viewWillAppear:(BOOL)animated
{
    if (self.MainViewStatusNormal) {
        [self tabBarStatusToRight];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{

}

- (void)getData
{
    BottomHeight = ZOOM6(60);
    
    NSArray *typeArr = [self FindDataForTPYEDB:self.parentID];

    MyLog(@"parentID: %@, typeArr: %@", self.parentID, typeArr);
    
    NSDictionary *dic = @{@"name":@"全部",@"id":@"999",@"group":@"aa"};
    
    [self.type3Arr addObject:dic];
    
    NSMutableArray *sortArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<[typeArr[0] count]; i++) {
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
        NSArray *nameArr = typeArr[1];
        NSArray *idArr = typeArr[0];
        NSArray *groupArr = typeArr[2];
        [muDic setValue:nameArr[i] forKey:@"name"];
        [muDic setValue:idArr[i] forKey:@"id"];
        [muDic setObject:groupArr[i] forKey:@"group"];
        
        
        [sortArr addObject:muDic];
    }
    
//    MyLog(@"sortArr = %@", sortArr);
    if (sortArr.count > 0) {
        for (int i = 0; i< sortArr.count-1; i++) {
            for (int j = 0; j<sortArr.count-i-1; j++) {
                NSDictionary *dic1 = sortArr[j];
                NSDictionary *dic2 = sortArr[j+1];
                
                if ([dic1[@"group"] compare:dic2[@"group"] options:NSCaseInsensitiveSearch] == NSOrderedDescending) {
                    [sortArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
                
            }
        }
        

    }
    for (NSDictionary *dic in sortArr) {
        [self.type3Arr addObject:dic];
        [self.noChooseArr addObject:dic];
    }
    
    self.page = 1;
    
    [self httpGetDataAnimation:YES];
    
}

#pragma mark - collection
- (void)setupUI
{
    ESWeakSelf;
    self.bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth-0*2, BottomHeight)];
    self.bottomScrollView.showsHorizontalScrollIndicator = NO;
    
    if(self.isbrowse)
    {
        [self addHeaderTimerView];
    }else{
        [self.view addSubview:self.bottomScrollView];
    }
    
    CGFloat W = 0;
    
    NSMutableArray *WArr = [NSMutableArray array];
    CGFloat WW = 0;
    for (NSDictionary *dic in self.type3Arr) {
        NSString *name = dic[@"name"];
        CGSize size = [name boundingRectWithSize:CGSizeMake(1000, BottomHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]} context:nil].size;
        W = size.width+ZOOM(67);
        WW = W+WW;
        [WArr addObject:[NSNumber numberWithFloat:W]]; //求出了view
    }
    self.bottomScrollView.contentSize = CGSizeMake(WW+(self.type3Arr.count+1)*BtnMargin, BottomHeight);
    
    for (int i = 0; i<self.type3Arr.count; i++) {
        NSDictionary *dic=  self.type3Arr[i];
        
        CGFloat X = BtnMargin;
        for (int j = 0; j<=i-1; j++) {
            X = X+[WArr[j] floatValue];
        }
        X = X+i*BtnMargin;
        
        CGFloat W = [WArr[i] floatValue];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(X, 0, W, BottomHeight);
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
        btn.layer.cornerRadius = BottomHeight/2;
        btn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
        
        btn.tag = [dic[@"id"] intValue];
        
        [btn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:RGBACOLOR_F(0.5,0.5,0.5,0.6) forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:dic[@"name"] forState:UIControlStateNormal];
        [self.bottomScrollView addSubview:btn];
        
        if ([dic[@"id"] intValue] == 999) {
            btn.selected = YES;
            btn.layer.borderWidth = 0;
            btn.userInteractionEnabled = NO;
        }
        
    }
    
    
    CGFloat H_V = ZOOM6(70);
    
    /**
     瀑布流
     */
    WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    flowLayout.minimumColumnSpacing = 5;
    flowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+BottomHeight+H_V, kScreenWidth, kScreenHeight-kNavigationheightForIOS7-BottomHeight-H_V) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = RGBCOLOR_I(244,244,244);
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
    [self.collectionView registerClass:[CollectionImageHeaderView class] forSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView"];
    
    self.page = 1;
    //加下拉刷新
    [self.collectionView addHeaderWithCallback:^{
        //
        __weakSelf.page = 1;
        __weakSelf.notType=@"false";

        if (__weakSelf.chooseArr.count == 0) {
            [__weakSelf httpGetDataAnimation:NO];
        } else {
            [__weakSelf httpGetTyepDataRequest:__weakSelf.chooseArr andAnimation:NO];
        }
    }];
    //加上拉刷新
    [self.collectionView addFooterWithCallback:^{
        __weakSelf.page++;
        if (__weakSelf.chooseArr.count == 0) {
            [__weakSelf httpGetDataAnimation:NO];
        } else {
            [__weakSelf httpGetTyepDataRequest:__weakSelf.chooseArr andAnimation:NO];
        }
    }];
    
    
    [self.view addSubview:self.menuButtonView];
    [self.menuButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(self.isbrowse)
        {
            make.top.equalTo(__weakSelf.headerTimerView.mas_bottom);
        }else{
            make.top.equalTo(__weakSelf.bottomScrollView.mas_bottom);
        }
        make.left.right.equalTo(__weakSelf.view);
        make.height.mas_equalTo(H_V);
    }];
    
    [self.menuButtonView setMenuBtnClickBlock:^(NSInteger btnClickIndex) {
        
        [__weakSelf httpSelectIndex:btnClickIndex];
    }];
    [self.menuButtonView show];
}

- (void)addHeaderTimerView
{
    [self.view addSubview:self.headerTimerView];
    
    ESWeakSelf;
    [_headerTimerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(__weakSelf.navigationView.mas_bottom);
        make.left.right.equalTo(__weakSelf.view);
        make.height.mas_equalTo(ZOOM6(60));
    }];
}

- (UIView *)headerTimerView
{
    if (!_headerTimerView) {
        _headerTimerView = [UIView new];
        _headerTimerView.backgroundColor = RGBCOLOR_I(62, 62, 62);
        CGFloat W_img = ZOOM6(140);
        
        UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [explainBtn setTitleColor:RGBCOLOR_I(255, 231, 24) forState:UIControlStateNormal];
        [explainBtn setTitle:@"任务说明" forState:UIControlStateNormal];
        explainBtn.titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(24)];
        explainBtn.backgroundColor = RGBCOLOR_I(255, 89, 79);
        [explainBtn addTarget:self action:@selector(explainBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_headerTimerView addSubview:_explainBtn = explainBtn];
        [explainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.and.right.equalTo(_headerTimerView);
            make.width.mas_equalTo(W_img);
        }];
        
        UIImageView *imgV = [UIImageView new];
        imgV.image = [UIImage imageNamed:@"browse_icon_tongzhi"];
        [_headerTimerView addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_headerTimerView.mas_centerY);
            make.left.mas_equalTo(ZOOM6(10));
            make.size.mas_equalTo(CGSizeMake(ZOOM6(30), ZOOM6(30)));
        }];
        
        
        UILabel *messageLab = [UILabel new];
        messageLab.font = [UIFont boldSystemFontOfSize:ZOOM6(24)];
        messageLab.textColor = RGBCOLOR_I(168, 168, 168);
        messageLab.textAlignment = NSTextAlignmentCenter;
        [_headerTimerView addSubview:_messageLab = messageLab];
        [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(_headerTimerView);
            make.right.equalTo(explainBtn.mas_left);
            make.left.equalTo(imgV.mas_right).offset(ZOOM6(10));
        }];
        messageLab.text = @"亲，任务奖励就藏在这些商品详情页里噢，快去领取吧~";
    }
    return _headerTimerView;
}
- (void)explainBtnClick
{
    [MobClick event:BrowseShop_ExplainButton];
    [self showPopView];
}
- (void)showPopView
{
    TFPopBackgroundView *popBackgV = [[TFPopBackgroundView alloc] initWithTitle:nil message:@"任务奖励就藏在商品里面噢~" showCancelBtn:NO leftBtnText:nil rightBtnText:@"知道啦~"];
    popBackgV.textAlignment = NSTextAlignmentCenter;
    [popBackgV setCancelBlock:^{
        
    } withConfirmBlock:^{
        
    } withNoOperationBlock:^{
        
    }];
    
    [popBackgV show];
    
}

- (void)btnAddClick:(UIButton *)sender
{
    //Add -> self.chooseArr = %@",self.chooseArr);
    sender.selected = !sender.selected;
    
    if (sender.tag!=999) {

        UIButton *btn = (UIButton *)[self.bottomScrollView viewWithTag:999];
        btn.selected = NO;
        btn.userInteractionEnabled = YES;
        btn.layer.borderColor = [RGBACOLOR_F(0.5,0.5,0.5,0.4) CGColor];
        btn.layer.borderWidth = 1.0f;
        btn.layer.cornerRadius = btn.frame.size.height/2;
        
        sender.userInteractionEnabled = NO;
        

        if (sender.selected == YES) {
            [sender setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateSelected];
            sender.layer.borderWidth = 0.0f;
            sender.layer.cornerRadius = sender.frame.size.height/2;
        }
        
        NSDictionary *dicc;
        for (NSDictionary *dic in self.type3Arr) {
            if ([dic[@"id"] intValue] == sender.tag) {
                dicc = dic;
                break;
            }
        }
        

        for (NSDictionary *dic in self.type3Arr) {
            if ([dic[@"group"] isEqualToString:dicc[@"group"]] && ![dic[@"id"] isEqualToString:dicc[@"id"]]) {
                UIButton *btn = (UIButton *)[self.bottomScrollView viewWithTag:[dic[@"id"] intValue]];
                [btn setBackgroundImage:[UIImage imageWithColor:RGBCOLOR_I(220,220,220)] forState:UIControlStateSelected];
                btn.selected = YES;
                btn.layer.borderWidth = 0.0f;
                btn.userInteractionEnabled = NO;
                
                [btn setTitleColor:RGBCOLOR_I(241,241,241) forState:UIControlStateSelected];
                
            }
        }
        
        [self refreshAddBtn:dicc];
        
    } else {
        
        if (sender.selected == YES) {
            
            sender.userInteractionEnabled = NO;
            
            sender.layer.borderWidth = 0.0f;
            sender.layer.cornerRadius = sender.frame.size.height/2;

            
            for (UIView *view in self.headScrollView.subviews) {
                [view removeFromSuperview];
            }
            
            for (NSDictionary *dic in self.chooseArr) {
                [self refreshBottomBtn:dic];
            }
            
            [self.chooseArr removeAllObjects];
            [self.noChooseArr removeAllObjects];
            
            NSArray *arr = [self.type3Arr subarrayWithRange:NSMakeRange(1, self.type3Arr.count-1)];
            [self.noChooseArr addObjectsFromArray:arr];
            
            self.headScrollView.hidden = YES;
            self.headLabel.hidden = NO;
            [self refreshHeadBtn];
        }
    }
    
}
- (void)btnSubClick:(UIButton *)sender
{
    NSDictionary *dicc;
    for (NSDictionary *dic in self.chooseArr) {
        if ([dic[@"id"] intValue] == sender.tag) {
            dicc = dic;
            break;
        }
    }
    [self refreshSubBtn:dicc];
}
- (void)refreshAddBtn:(NSDictionary *)dic
{
    [self.chooseArr addObject:dic];
    [self.noChooseArr removeObject:dic];

    
    self.headLabel.hidden = YES;
    self.headScrollView.hidden = NO;

    for (UIView *view in self.headScrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    [self refreshHeadBtn];
}

- (void)refreshSubBtn:(NSDictionary *)dic
{
    [self refreshBottomBtn:dic];
    
    [self.chooseArr removeObject:dic];
    [self.noChooseArr addObject:dic];
    
    
    if (self.chooseArr.count == 0) {
        self.headScrollView.hidden = YES;
        self.headLabel.hidden = NO;
        

        UIButton *btn = (UIButton *)[self.bottomScrollView viewWithTag:999];
        btn.layer.borderWidth = 0;
        btn.selected = YES;
        btn.userInteractionEnabled = NO;
        self.bottomScrollView.contentOffset = CGPointMake(0, 0);
    }
    [self refreshHeadBtn];
}

- (void)refreshBottomBtn:(NSDictionary *)dic
{
    for (UIButton *btn in self.bottomScrollView.subviews) {
        if (btn.tag == [dic[@"id"] intValue]) {
            [btn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateSelected];
            btn.selected = NO;
            btn.userInteractionEnabled = YES;
            btn.layer.masksToBounds = YES;
            btn.layer.borderWidth = 1.0f;
            btn.layer.cornerRadius = btn.frame.size.height/2;
            break;
        }
    }
    
    for (NSDictionary *dicc in self.noChooseArr) {
        if ([dicc[@"group"] isEqualToString:dic[@"group"]]) {
            UIButton *btn = (UIButton *)[self.bottomScrollView viewWithTag:[dicc[@"id"] intValue]];
            [btn setBackgroundImage:[UIImage imageWithColor:COLOR_ROSERED] forState:UIControlStateSelected];
            btn.selected = NO;
            btn.userInteractionEnabled = YES;
            btn.layer.masksToBounds = YES;
            btn.layer.borderWidth = 1.0f;
            btn.layer.cornerRadius = btn.frame.size.height/2;

        }
    }
    
}

- (void)refreshHeadBtn
{
    //http -> self.chooseArr = %@",self.chooseArr);
    
    CGFloat iv_margin = 5;
    CGFloat iv_W = HeadHeight-iv_margin*2;
    CGFloat iv_H = iv_W;
    
    for (UIView *view in self.headScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    NSMutableArray *WArr = [NSMutableArray array];
    CGFloat WW = 0;
    for (NSDictionary *dic in self.chooseArr) {
        NSString *name = dic[@"name"];
       CGSize size = [name boundingRectWithSize:CGSizeMake(1000, HeadHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:(15)]} context:nil].size;
        CGFloat W = size.width+3*iv_margin+iv_W;
        WW = W+WW;
        [WArr addObject:[NSNumber numberWithFloat:W]]; //求出了view
    }
    
    self.headScrollView.contentSize = CGSizeMake(WW+self.chooseArr.count*BtnMargin, HeadHeight);
    
    for (int i = 0; i<self.chooseArr.count; i++) {
        NSDictionary *dic=  self.chooseArr[i];
        CGFloat X = 0;
        for (int j = 0; j<=i-1; j++) {
            X = X+[WArr[j] floatValue];
        }
        X = X+i*BtnMargin;
        
        CGFloat W = [WArr[i] floatValue];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(X, 0, W, HeadHeight)];
        view.backgroundColor = RGBCOLOR_I(152,152,152);
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = HeadHeight/2;
        [self.headScrollView addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(iv_margin, 0, W-3*iv_margin, HeadHeight)];
        label.text = dic[@"name"];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:(15)];
//        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(view.frame.size.width-iv_W-iv_margin, iv_margin, iv_W, iv_H)];
        iv.userInteractionEnabled = YES;
        iv.backgroundColor = [UIColor whiteColor];
        iv.image = [UIImage imageNamed:@"xx.jpg"];
        iv.layer.masksToBounds = YES;
        iv.layer.cornerRadius = iv_W/2;
        [view addSubview:iv];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, W, HeadHeight);
        btn.tag = [dic[@"id"] intValue];
        [btn addTarget:self action:@selector(btnSubClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    if (self.chooseArr.count == 0) {
        self.page = 1;
        [self httpGetDataAnimation:YES];
        
    } else {
        self.page = 1;
        [self httpGetTyepDataRequest:self.chooseArr andAnimation:YES];
        
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:WaterFallSectionHeader]) {
        CollectionImageHeaderView * headerView =(CollectionImageHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [headerView.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!450", [NSObject baseURLStr_Upy], self.bannerImage]]placeholderImage:[[DefaultImgManager sharedManager] defaultImgWithSize:headerView.frame.size]];
        return headerView;
    }

    return [UICollectionReusableView new];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{
    return self.bannerImage.length ? kScreenWidth/1.7 : 0;
}
//一个分区的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.waterFlowDataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    cell.selectBtn.hidden = YES;
    ShopDetailModel *model=self.waterFlowDataArray[indexPath.row];
    //    cell.backgroundColor = RGBCOLOR_I(22,22,22);
    [cell receiveDataModel:model];
    return cell;
}

//大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ShopDetailModel *model=self.waterFlowDataArray[indexPath.row];
//    CGFloat imgH = 0;
//    CGFloat imgW = 0;
//    
//    CGFloat H = 0;
//    CGFloat W = 0;
    
//    NSString *st = [model.def_pic substringToIndex:model.def_pic.length-4];
//    
//    NSArray *comArr = [st componentsSeparatedByString:@"_"];
//    //    //comArr = %@",comArr);
//    if (comArr.count>2) {
//        imgH = [comArr[2] floatValue];
//        imgW = [comArr[1] floatValue];
//    }
//    
//    W = (kScreenWidth-2)/2;
//    if (imgW!=0) {
//        H = W*imgH/imgW;
//    } else {
//        H = 0;
//    }
    
    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (kScreenWidth-18)/2.0;
    CGFloat H = imgH*W/imgW;
    CGSize size = CGSizeMake(W, H+5);
    
    return size;
}
//点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataStatistics.length) {
        if ([self.dataStatistics isEqualToString:@"搜索结果商品点击"]) { //直接点击目录
            [TFStatisticsClickVM handleDataWithPageType:nil withClickType:[NSString stringWithFormat:@"%@列表页商品图片", self.shopTitle] success:nil failure:nil];
        } else if([self.dataStatistics hasPrefix:@"风格"]) { // 风格
            [TFStatisticsClickVM handleDataWithPageType:nil withClickType:[NSString stringWithFormat:@"%@列表页商品图片", self.dataStatistics] success:nil failure:nil];
        }
    }
    
    WaterFlowCell *cell = (WaterFlowCell*)[collectionView cellForItemAtIndexPath:indexPath];
    UIImage *image= cell.shop_pic.image;
    
    ShopDetailModel *model=self.waterFlowDataArray[indexPath.row];
    ShopDetailViewController *detail=[[ShopDetailViewController alloc]init];
    detail.shop_code=model.shop_code;
    detail.bigimage = image;
    
    detail.typeID = self.typeID;
    detail.typeName = self.typeName;
    detail.stringtype = @"筛选搜索";
    
    if(self.randomNum > 0)
    {
        detail.stringtype = @"签到领现金";
        detail.index_id = self.index;
        detail.index_day = self.day;
        detail.rewardCount = self.rewardCount;
        detail.rewardType = self.rewardType;
        detail.rewardValue = self.rewardValue;
        detail.Browsedic = self.Browsedic;
        detail.browseCount = self.browseCount;
        detail.currTimeCount = self.currTimeCount;
        
        if ((self.browseCount == self.randomNum) && !self.showGetMoneyWindow) {
            detail.showGetMoneyWindow = YES;
        }
        ESWeakSelf;
        detail.browseCountBlock = ^() {
            if (![__weakSelf.selectShopArray containsObject:model.shop_code]) {
                if (self.browseCount == self.randomNum) {
                    self.showGetMoneyWindow = YES;
                }
                __weakSelf.browseCount++; //计数
                [__weakSelf.selectShopArray addObject:model.shop_code];
                
            }
            
        };

    }
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
}

#pragma mark - 请求

- (void)httpGetDataAnimation:(BOOL)animationBl
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr;
    
    
    if (token != nil) {
        if([self.comefrom isEqualToString:@"任务"])
        {
        
        }else{
            urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?token=%@&version=%@&type2=%@&pager.curPage=%d&pager.pageSize=10&%@&notType=%@",[NSObject baseURLStr],token,VERSION,self.parentID,self.page,self.appendingStr,self.notType];
        }
        
    } else {
        
        if([self.comefrom isEqualToString:@"任务"])
        {
            
        }else{
            urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?version=%@&type2=%@&pager.curPage=%d&pager.pageSize=10&%@&notType=%@",[NSObject baseURLStr],VERSION,self.parentID,self.page,self.appendingStr,self.notType];
        }

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
        //全部 res = %@",responseObject);
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
                    CGFloat bannerImgHeight = self.bannerImage.length?ZOOM6(360):0;

                    CGRect frame = CGRectMake(0, kNavigationheightForIOS7+BottomHeight+ZOOM6(70)+bannerImgHeight, self.view.frame.size.width, kScreenHeight-BottomHeight-kNavigationheightForIOS7-ZOOM6(70)-bannerImgHeight);
                    
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
        
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        CGFloat bannerImgHeight = self.bannerImage.length?ZOOM6(360):0;

        CGRect frame = CGRectMake(0, kNavigationheightForIOS7+BottomHeight+ZOOM6(70)+bannerImgHeight, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7-BottomHeight-ZOOM6(70)-bannerImgHeight);
        [self createBackgroundView:self.view andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];

}

- (void)httpGetTyepDataRequest:(NSArray *)arr andAnimation:(BOOL)animationBl
{
    
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        [muArr addObject:dic[@"id"]];
    }

    NSString *idStr = [muArr componentsJoinedByString:@","];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr;
    
    if (token != nil) {
        urlStr = [NSString stringWithFormat:@"%@shop/queryCondition?token=%@&version=%@&type2=%@&type3s=%@&pager.curPage=%d&pager.pageSize=10&%@&notType=true",[NSObject baseURLStr],token,VERSION,self.parentID,idStr,self.page,self.appendingStr];
    } else {
        
        urlStr = [NSString stringWithFormat:@"%@shop/queryConUnLogin?token=%@&version=%@&type2=%@&type3s=%@&pager.curPage=%d&pager.pageSize=10&%@&notType=true",[NSObject baseURLStr],token,VERSION,self.parentID,idStr,self.page,self.appendingStr];
    }
    
    if (animationBl) {
        [[Animation shareAnimation] CreateAnimationAt:self.view];
    }
    

    
    NSString *URL = [MyMD5 authkey:urlStr];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.view withTag:99999];
        //分类 res = %@",responseObject);
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
                
                //分类 count = %d", (int)arr.count);
                
                if (arr.count == 0&&self.waterFlowDataArray.count == 0) {
                    CGFloat bannerImgHeight = self.bannerImage.length?ZOOM6(360):0;

                    CGRect frame = CGRectMake(0, kNavigationheightForIOS7+BottomHeight+ZOOM6(70)+bannerImgHeight, self.view.frame.size.width, kScreenHeight-BottomHeight-kNavigationheightForIOS7-ZOOM6(70)-bannerImgHeight);
                    
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
         
         [[Animation shareAnimation] stopAnimationAt:self.view];
         
        [self.collectionView footerEndRefreshing];   //停止刷新
        [self.collectionView headerEndRefreshing];   //停止刷新
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
         CGFloat bannerImgHeight = self.bannerImage.length?ZOOM6(360):0;

        CGRect frame = CGRectMake(0, kNavigationheightForIOS7+BottomHeight+bannerImgHeight, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7-BottomHeight-bannerImgHeight);
        [self createBackgroundView:self.view andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];

}

#pragma mark - 数据库操作
- (void)closeDB
{
    if (AttrcontactDB) {
        sqlite3_close(AttrcontactDB);
        AttrcontactDB = 0x00;
        
    }
}

//开启数据库
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
            //            if([self.Sqlitetype isEqualToString:@"attr"])
            {
                sql_stmt = "CREATE TABLE IF NOT EXISTS ATTDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            }
            //            if([self.Sqlitetype isEqualToString:@"type"])
            {
                
                sql_stmt = "CREATE TABLE IF NOT EXISTS TYPDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            }
            //            if([self.Sqlitetype isEqualToString:@"tag"])
            {
                sql_stmt = "CREATE TABLE IF NOT EXISTS TAGDB(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT,PHONE TEXT)";
            }
            
            if (sqlite3_exec(AttrcontactDB, sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
                
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

// 查询三级分类
-(NSArray *)FindDataForTPYEDB:(NSString *)findStr
{
    NSMutableArray *idArr=[NSMutableArray array];
    NSMutableArray *nameArr=[NSMutableArray array];
     NSMutableArray *groupArr=[NSMutableArray array];
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if([self OpenDb])
    {
        const char *dbpath = [_databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &AttrcontactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,phone,groupflag from TYPDB where address=\"%@\"",findStr];
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(AttrcontactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSString *ID= [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSString *name = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *groupflag = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    [idArr addObject:ID];
                    [nameArr addObject:name];
                    [groupArr addObject:groupflag];
                }
                [muArr addObject:idArr];
                [muArr addObject:nameArr];
                [muArr addObject:groupArr];
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(AttrcontactDB);
        }
    }
    return muArr;
}

- (MenuButtonView *)menuButtonView
{
    if (!_menuButtonView) {
        _menuButtonView = [[MenuButtonView alloc] init];
        _menuButtonView.titleArray = @[@"最新", @"热销", @"价格↑",@"价格↓"];
    }
    return _menuButtonView;

}

#pragma mark - 导航
- (void)setNavigationItem
{
    //导航条
    self.navigationView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 64)];
    self.navigationView.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:self.navigationView];
    self.navigationView.userInteractionEnabled=YES;
    //左边返回按钮
//    UIImageView *vil = [[UIImageView alloc] initWithFrame:CGRectMake(10+(40-15)/2, 20+(44-25)/2, 15, 25)];
//    vil.image = [UIImage imageNamed:@"返回"];
//    vil.userInteractionEnabled = YES;
//    [self.navigationView addSubview:vil];
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:backbtn];
    
    
    self.headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(45, 20+(44-HeadHeight)/2, kScreenWidth-45, HeadHeight)];
    self.headScrollView.showsHorizontalScrollIndicator = NO;
//    self.headScrollView.backgroundColor = [UIColor greenColor];
    [self.navigationView addSubview:self.headScrollView];
    self.headScrollView.hidden = YES;
    
    self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, 20, 200, 40)];
    self.headLabel.text = self.shopTitle;
    self.headLabel.textAlignment = NSTextAlignmentCenter;
    self.headLabel.hidden = NO;
    [self.navigationView addSubview:self.headLabel];
    
    
    UIButton *setbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    setbtn.frame=CGRectMake(kScreenWidth-50, 20, 50, 44);
    [setbtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    setbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [setbtn setImage:[UIImage imageNamed:@"搜索排序按钮_正常"] forState:UIControlStateNormal];
    [setbtn setImage:[UIImage imageNamed:@"搜索排序按钮_正常"] forState:UIControlStateHighlighted];
//    [self.navigationView addSubview:setbtn];
    
//    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    searchbtn.frame=CGRectMake(kApplicationWidth - 50, 30, 50, 44);
//    searchbtn.tintColor=[UIColor blackColor];
//    [searchbtn setImage:[UIImage imageNamed:@"设置"]  forState:UIControlStateNormal];
//    searchbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [searchbtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationView addSubview:searchbtn];
    
}
-(void)rightBtnClick
{
    CGPoint point = CGPointMake(kApplicationWidth-25, 64);
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:@[@"上新时间排序",@"价格从低到高",@"价格从高到低"] images:nil withSceenWith:kScreenWidth popWith:0 cellTextFont:0];
    pop.tag=8888;
    pop.delegate = self;
    [pop show];
}
#pragma mark --PopoverView 代理

- (void)httpSelectIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            if (self.chooseArr.count == 0) {
                self.page = 1;
                self.notType=@"true";
                self.appendingStr=@"pager.sort=audit_time&pager.order=desc";
                [self httpGetDataAnimation:YES];
                
            } else {
                self.page = 1;
                self.appendingStr=@"pager.sort=audit_time&pager.order=desc";
                [self httpGetTyepDataRequest:self.chooseArr andAnimation:YES];
            }
            break;
        case 1:
            if (self.chooseArr.count == 0) {
                self.page = 1;
                self.notType=@"true";
                self.appendingStr=@"pager.sort=virtual_sales&pager.order=desc";
                [self httpGetDataAnimation:YES];
                
            } else {
                self.page = 1;
                self.appendingStr=@"pager.sort=virtual_sales&pager.order=desc";
                [self httpGetTyepDataRequest:self.chooseArr andAnimation:YES];
                
            }
            break;
        case 2:
            if (self.chooseArr.count == 0) {
                self.page = 1;
                self.notType=@"true";
                self.appendingStr=@"pager.sort=shop_se_price&pager.order=asc";
                [self httpGetDataAnimation:YES];
                
            } else {
                self.page = 1;
                self.appendingStr=@"pager.sort=shop_se_price&pager.order=asc";
                [self httpGetTyepDataRequest:self.chooseArr andAnimation:YES];
                
            }
            break;
        case 3:
            if (self.chooseArr.count == 0) {
                self.page = 1;
                self.notType=@"true";
                self.appendingStr=@"pager.sort=shop_se_price&pager.order=desc";
                [self httpGetDataAnimation:YES];
                
            } else {
                self.page = 1;
                self.appendingStr=@"pager.sort=shop_se_price&pager.order=desc";
                [self httpGetTyepDataRequest:self.chooseArr andAnimation:YES];
                
            }
            break;
        default:
            break;
    }
}

- (void)seletRowAtIndex:(PopoverView *)popoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)leftBarButtonClick
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *count = [user objectForKey:TASK_LIULAN_SHOPCOUNT];
    if(count.intValue >= self.randomNum)
    {
        self.showGetMoneyWindow = YES;
        [user removeObjectForKey:TASK_LIULAN_SHOPCOUNT];
    }

    if(self.isliulan == YES )//浏览分钟数
    {
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"is_read"] == YES)
        {
            TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
            popView.title = @"亲~确定要离开吗？";
            popView.message = @"你正在进行浏览商品任务，浏览时长还未完成，你可以选择去浏览其它商品，浏览时长达到任务要求即可完成任务喔~";
            popView.leftText = @"不了,谢谢";
            popView.rightText = @"其他商品";
            
            [popView showCancelBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            } withConfirmBlock:^{
                [Mtarbar selectedToIndexViewController:0];
            } withNoOperationBlock:^{
                
            }];
        }else{
//            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"is_read"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else{
        if (!self.showGetMoneyWindow) {
            
            if (self.isbrowse == YES)
            {
                TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
                popView.title = @"亲~确定要离开吗？";
                popView.message = @"再逛一下下就可以获得任务奖励噢~";
                popView.leftText = @"不了,谢谢";
                popView.rightText = @"再逛逛";
                
                [popView showCancelBlock:^{
                    [self.navigationController popViewControllerAnimated:YES];
                } withConfirmBlock:^{
                    
                } withNoOperationBlock:^{
                    
                }];
            }
            
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }

}

#pragma mark - 懒加载
- (NSMutableArray *)waterFlowDataArray
{
    if (_waterFlowDataArray == nil) {
        _waterFlowDataArray = [[NSMutableArray alloc] init];
    }
    
    return _waterFlowDataArray;
}

- (NSMutableArray *)type3Arr
{
    if (_type3Arr == nil) {
        _type3Arr = [[NSMutableArray alloc] init];
    }
    return _type3Arr;
}

- (NSMutableArray *)chooseArr
{
    if (_chooseArr == nil) {
        _chooseArr = [[NSMutableArray alloc] init];
    }
    return _chooseArr;
}

- (NSMutableArray *)noChooseArr
{
    if (_noChooseArr == nil) {
        _noChooseArr = [[NSMutableArray alloc] init];
    }
    return _noChooseArr;
}

- (void)tabBarStatusToRight
{
    //    Mtarbar.tabBar.center = CGPointMake(kScreenWidth/2.0+OPENCENTERX, kScreenHeight-49);
    Mtarbar.tabBar.frame=CGRectMake(OPENCENTERX, kScreenHeight-49, kScreenWidth, 49);
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
