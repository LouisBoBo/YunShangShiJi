//
//  NewTopicDetailsViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/5/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "NewTopicDetailsViewController.h"
#import "XRWaterfallLayout.h"
#import "HotTopicCollectionViewCell.h"
#import "TopicDetailViewController.h"
#import "TFShoppingViewController.h"
#import "IntimateCircleModel.h"
#import "TopicPublicModel.h"
#import "NavgationbarView.h"
#import "GlobalTool.h"
#import "HeaderReusableView.h"
#import "StickyHeaderFlowLayout.h"
@interface NewTopicDetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,XRWaterfallLayoutDelegate>

@end

@implementation NewTopicDetailsViewController
{
    BOOL is_fresh;                    //是否是刷新
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadView];
    [self creatCollectionView];
    
//    [self httpTheme];
    [self recommendHttp];
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
    titlelable.centerY = View_CenterY(self.tabheadview);
    titlelable.center=CGPointMake(kApplicationWidth/2, self.tabheadview.frame.size.height/2+10);
    titlelable.text=@"热门穿搭";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
}
#pragma mark *****************网络数据******************
- (void)httpTheme {
    
    [CircleModel getCircleThemeModelWithCurPage:1 success:^(id data) {
        
        CircleModel *model = data;
        [self loadModel:model isTags:YES];
        
    }];
}

- (void)recommendHttp
{
    __weak typeof(self) weakSelf = self;
    [CircleModel getCommendThemeModelWithCurPage:weakSelf.recommentPage PageSize:10 Themeid:weakSelf.theme_id success:^(id data) {
        
        if(is_fresh)
        {
            [weakSelf.collectionView ffRefreshHeaderEndRefreshing];
            [weakSelf.collectionView footerEndRefreshing];
        }
        CircleModel *model = data;
        [weakSelf loadModel:model isTags:NO];
    }];
    
}
//- (void)loadModel:(CircleModel *)model isTags:(BOOL)isTags{
//    if (model.status == 1) {
//        self.recommentAllPage = self.recommentPage==1?model.pager.rowCount:model.pager.pageCount;
//        self.recommentPage ++;
//        for(int i =0 ; i <model.myData.count; i++)
//        {
//            IntimateCircleModel *cmodel = model.myData[i];
//            
//            [self.recommendData addObject:cmodel];
//        }
//        
//        [self getCollectionViewHeigh];
//        is_fresh?[self.collectionView reloadData]:0;
//    }
//}


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
    
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) collectionViewLayout:waterfall];
    self.collectionView.backgroundColor = RGBCOLOR_I(239, 239, 239);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotTopicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HotCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HeaderReusableView class])];

    //下拉刷新
    __weak NewTopicDetailsViewController *myController = self;
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
    [self.navigationController pushViewController:topic animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//collectionviewHead
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(kind == UICollectionElementKindSectionHeader)
    {
        HeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([HeaderReusableView class]) forIndexPath:indexPath];

        return header;
    }
    return nil;
}

//Header的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 2000);
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
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
