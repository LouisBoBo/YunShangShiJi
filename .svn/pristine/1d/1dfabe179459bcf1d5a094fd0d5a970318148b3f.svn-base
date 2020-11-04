//
//  HotOutfitViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "HotOutfitViewController.h"
#import "XRWaterfallLayout.h"
#import "HotTopicCollectionViewCell.h"
#import "TopicDetailViewController.h"
#import "TFShoppingViewController.h"
#import "IntimateCircleModel.h"
#import "TopicPublicModel.h"
#import "NavgationbarView.h"
#import "GlobalTool.h"
#import "TFPopBackgroundView.h"

@interface HotOutfitViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate>
@property (nonatomic, strong) UIView *headerTimerView;
@property (nonatomic, strong) UIButton *explainBtn;
@property (nonatomic, strong) UILabel *messageLab;
@end

@implementation HotOutfitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadView];
    self.isTiXian?[self addHeaderTimerView]:nil;
    [self creatCollectionView];
    
    [self httpTheme];
}
- (void)creatHeadView
{
    //导航条
    self.tabheadview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:self.tabheadview];
    self.tabheadview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(self.tabheadview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, self.tabheadview.frame.size.height/2+10);
    titlelable.text= self.isTiXian?@"社区详情":@"热门穿搭";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
}
- (void)addHeaderTimerView
{
    [self.view addSubview:self.headerTimerView];
    
    ESWeakSelf;
    [_headerTimerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(__weakSelf.tabheadview.mas_bottom);
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
        //        messageLab.text = @"亲，任务奖励就藏在这些商品详情页里噢，快去领取吧~";
        if(self.isTiXian)
        {
            messageLab.text = [NSString stringWithFormat:@"每浏览%zd件衣服即得%zd元提现额度哦，快去领取吧",[Signmanager SignManarer].everyLinlanCount,[Signmanager SignManarer].everyLiulanRaward];
        }else
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
    NSString *rewardstr = [NSString stringWithFormat:@"每浏览%zd件美衣，即可得到%zd元提现额度，任务奖励就藏在商品里，快去领取吧~",[Signmanager SignManarer].everyLinlanCount,[Signmanager SignManarer].everyLiulanRaward];
    NSString *title = rewardstr;
    TFPopBackgroundView *popBackgV = [[TFPopBackgroundView alloc] initWithTitle:nil message:title showCancelBtn:NO leftBtnText:nil rightBtnText:@"知道啦~"];
    popBackgV.textAlignment = NSTextAlignmentCenter;
    [popBackgV setCancelBlock:^{
        
    } withConfirmBlock:^{
        
    } withNoOperationBlock:^{
        
    }];
    
    [popBackgV show];
    
}

#pragma mark *****************网络数据******************
- (void)httpTheme {
    
    [CircleModel getCircleThemeModelWithCurPage:1 success:^(id data) {
        
        CircleModel *model = data;
        [self loadModel:model isTags:YES];
        
    }];
}

- (void)loadModel:(CircleModel *)model isTags:(BOOL)isTags{
    if (model.status == 1) {
        
        for(int i =0 ; i <model.myData.count; i++)
        {
            IntimateCircleModel *cmodel = model.myData[i];
            
            if(cmodel.pics.length>6 || cmodel.shop_list.count)
            {
                [self.dataSource addObject:cmodel];
            }
        }
    
        [self.collectionView reloadData];
    } else {
        [NavgationbarView showMessageAndHide:model.message backgroundVisiable:NO];
    }
}

#pragma mark *************collectionView***************
- (void)creatCollectionView
{
    //创建瀑布流布局
    XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
    
    //或者一次性设置
    [waterfall setColumnSpacing:ZOOM6(15) rowSpacing:ZOOM6(15) sectionInset:UIEdgeInsetsMake(0, ZOOM6(15), 0, ZOOM6(15))];
    
    //设置代理，实现代理方法
    waterfall.delegate = self;
    /*
     //或者设置block
     [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
     //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
     XRImage *image = self.images[indexPath.item];
     return image.imageH / image.imageW * itemWidth;
     }];
     */
    //创建collectionView
    CGFloat headheigh = self.isTiXian?ZOOM6(60):0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar+headheigh, kScreenWidth, kScreenHeight-Height_NavBar-headheigh) collectionViewLayout:waterfall];
    self.collectionView.backgroundColor = RGBCOLOR_I(239, 239, 239);
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotTopicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HotCell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];

    //下拉刷新
    __weak HotOutfitViewController *myController = self;
    [self.collectionView addHeaderWithCallback:^{
        [myController.collectionView headerEndRefreshing];
    }];
    
//    //上拉加载
//    [self.collectionView addFooterWithCallback:^{
//        [myController.collectionView footerEndRefreshing];
//    }];

}

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    
    IntimateCircleModel *model = self.dataSource[indexPath.item];
    
    CGFloat imageSize = 0;
    
    if(model.theme_type.intValue == 1)
    {
        imageSize = 0.67;
    }else{
        NSString *str = model.pics;
        NSArray *imageArr = [str componentsSeparatedByString:@","];
        NSString *imagestr = @"";
        
        if(imageArr.count)
        {
            imagestr = imageArr[0];
            NSArray *arr = [imagestr componentsSeparatedByString:@":"];
            if(arr.count == 2)
            {
                imageSize = ([arr[1] floatValue]<0.56)?0.56:[arr[1] floatValue];
            }
        }
    }
    
    if(imageSize >0)
    {
        return itemWidth/imageSize +50+ZOOM6(90);
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.bigImage.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height-50-ZOOM6(90));
    IntimateCircleModel *model = self.dataSource[indexPath.item];
    [cell refreshCircleData:model];

    NSString *them_id = [NSString stringWithFormat:@"%@",model.theme_id];
    kWeakSelf(cell);
    cell.likeBlock = ^(NSInteger num){
        
        if(weakcell.like.selected)//取消点赞
        {
            [TopicPublicModel DisThumbstData:1 This_id:them_id Theme_id:them_id Success:^(id data) {
                TopicPublicModel *model = data;
                if(model.status == 1)
                {
                    weakcell.like.selected = !weakcell.like.selected;
                    
                    if(num >0)
                    {
                        [weakcell.like setTitle:[NSString stringWithFormat:@"%d",(int)num-1] forState:UIControlStateNormal];
                        
                        [weakcell.like setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
                    }
                }
            }];
        }else{//点赞
            
            [TopicPublicModel ThumbstData:1 This_id:them_id Theme_id:them_id Success:^(id data) {
                TopicPublicModel *model = data;
                if(model.status == 1)
                {
                    weakcell.like.selected = !weakcell.like.selected;
                    
                    [weakcell.like setTitle:[NSString stringWithFormat:@"%d",(int)num+1] forState:UIControlStateNormal];
                    
                    [weakcell.like setTitleColor:tarbarrossred forState:UIControlStateNormal];
                }
                
            }];
        }
    };

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntimateCircleModel *model = self.dataSource[indexPath.item];
    TopicDetailViewController *topic = [[TopicDetailViewController alloc]init];
    topic.theme_id = [NSString stringWithFormat:@"%@",model.theme_id];
    topic.comefrom = self.isFinish?nil:@"穿搭任务";
    topic.hidesBottomBarWhenPushed = YES;
    topic.isTiXian = self.isTiXian;
    topic.day = self.day;
    topic.index = self.index;
    topic.browseCountBlock = ^() {
        
        self.showGetMoneyWindow = YES;
    };

    [self.navigationController pushViewController:topic animated:YES];
}
- (NSMutableArray*)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)back
{
    if(self.isFinish)
    {
        self.showGetMoneyWindow = YES;
    }
    if(self.isLiulan == YES)//浏览件数
    {
        if (!self.showGetMoneyWindow)
        {
            TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
            popView.title = @"亲~确定要离开吗？";
            popView.message = @"再逛一下下就可以获得任务奖励噢~";
            popView.leftText = @"不了，谢谢";
            popView.rightText = @"再逛逛";
            popView.textAlignment = NSTextAlignmentCenter;
            [popView setCancelBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            } withConfirmBlock:^{
                
            } withNoOperationBlock:^{
                
            }];
            [popView show];
        }else
            [self.navigationController popViewControllerAnimated:YES];
    }else
        [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
