//
//  ViewController.m
//  searchView
//
//  Created by yssj on 2016/12/27.
//  Copyright © 2016年 CooFree. All rights reserved.
//

#import "SearchTypeViewController.h"
#import "PYSearchViewController.h"
#import "VitalityTaskPopview.h"
#import "WaterFLayout.h"

#import "GlobalTool.h"
#import "SqliteManager.h"
#import "BaseModel.h"
#import "OneYuanModel.h"
#import "RedXuanfuHongBao.h"
#import "TFSearchViewController.h"
#import "MoreBrandsMakerVC.h"
#import "BrandMakerDetailVC.h"
#import "TFPopBackgroundView.h"
#import "TFCollocationViewController.h"
#import "MyOrderViewController.h"
#import "TFMyWalletViewController.h"
#import "ShouYeShopStoreViewController.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, SearchTabBarStutes)
{
    SearchTabBarStutesNormal = 100,
    SearchTabBarStutesBottom
};

@implementation HotModel
@end
@implementation SearchTypeModel
+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[HotModel mappingWithKey:@"hotTagList"],@"hotTagList",nil];
    return mapping;
}
+ (void)httpGetSearchTypeModelSuccess:(void(^)(id data))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"shop/getHotTag?version=%@&token=%@",VERSION,token];
    [self getDataResponsePath:urlStr success:success];
}

@end

@interface SearchReusableView : UICollectionReusableView

@property(nonatomic,strong)UILabel *nameLabel;
- (void)receiveWithNames:(NSString *)name;

@end

@implementation SearchReusableView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBackgroundColor;
//        self.backgroundColor=[UIColor whiteColor];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, ZOOM6(20), frame.size.width, ZOOM6(20))];
        line.backgroundColor=[UIColor whiteColor];
        [self addSubview:line];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.backgroundColor=[UIColor whiteColor];
        _nameLabel.frame = CGRectMake(0, ZOOM6(40), SCREEN_WIDTH, ZOOM6(40));
        _nameLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        _nameLabel.textColor=lineGreyColor;
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)receiveWithNames:(NSString *)name{
    [self.nameLabel setAttributedText:[NSString getOneColorInLabel:[NSString stringWithFormat:@"———  %@  ———",name] ColorString:name Color:kMainTitleColor fontSize:ZOOM6(30)]];
//    self.nameLabel.text=[NSString stringWithFormat:@"———  %@  ———",name];
}
@end

@interface SectionOneCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *backImg;
@property (nonatomic, strong) UILabel *nameLabel;
@end
@implementation SectionOneCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        _backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _backImg.backgroundColor=DRandomColor;
        _backImg.clipsToBounds = YES;
        _backImg.layer.cornerRadius = ZOOM6(8);
        _backImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_backImg];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _nameLabel.textColor=[UIColor whiteColor];
        _nameLabel.clipsToBounds = YES;
        _nameLabel.layer.cornerRadius = ZOOM6(8);
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}

@end

@interface SearchCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *hotImg;
@property (nonatomic, strong) UILabel *nameLabel;
- (void)receiveName:(TypeTagItem *)item;
@end
@implementation SearchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor=DRandomColor;
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-ZOOM6(50))];
        _imageV.contentMode=UIViewContentModeScaleAspectFit;
//        _imageV.backgroundColor=[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

//        imageV.layer.masksToBounds = YES;
//        imageV.layer.cornerRadius = ZOOM6(70)*0.5;
        [self.contentView addSubview:_imageV];
        
        _hotImg = [[UIImageView alloc]initWithFrame:CGRectMake(_imageV.width-ZOOM6(50), 0, ZOOM6(50), ZOOM6(50))];
//        _hotImg.center=CGPointMake(CGRectGetMaxX(_imageV.frame), 0);
//        _hotImg.backgroundColor=tarbarrossred;
        [self.contentView addSubview:_hotImg];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-ZOOM6(40), frame.size.width, ZOOM6(40))];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _nameLabel.textColor=kSubTitleColor;
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}
- (void)receiveName:(TypeTagItem *)item {
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], item.pic]]];
    self.nameLabel.text = item.class_name;
    self.hotImg.hidden= item.is_hot.integerValue==1||item.is_new.integerValue==1?NO:YES;
    if (item.is_new.integerValue==1) {
        _hotImg.image=[UIImage imageNamed:@"classify_new"];
    }else if (item.is_hot.integerValue==1)
        _hotImg.image=[UIImage imageNamed:@"classify_hot"];

}

@end

#pragma mark - SearchTypeViewController
@interface SearchTypeViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,PYSearchViewControllerDelegate>
{
    CGFloat tabarHeight;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (strong,nonatomic)UIButton *cancelBtn;
@property (strong, nonatomic) PYSearchViewController *searchController;
@property (nonatomic,assign)SearchType searchType;
@property (nonatomic, weak) PYSearchSuggestionViewController *searchSuggestionVC;

@property (nonatomic, strong) NSMutableArray *searchDataArray;
@property (nonatomic, strong) NSMutableArray *searchCateArray;
@property (nonatomic, strong) NSMutableArray *sectionOneData;
@property (nonatomic, strong)RedXuanfuHongBao *hongbaoview;

@end

static NSString * const reuseIdentifier = @"Cell";
static NSString *headerID = @"headerID";



@implementation SearchTypeViewController
- (instancetype)init {
    if (self = [super init]) {
        self.searchType=SearchTypeNormal;
    }
    return self;
}
+ (SearchTypeViewController *)allocWithSearchType:(SearchType)searchType {
    SearchTypeViewController *searchVC = [[SearchTypeViewController alloc] init];
    searchVC.searchType = searchType;
    return searchVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self createTableData];
    [self setNavgationView];
    
    if (self.searchType==SearchTypeNormal) {
        //何波修改2017-10-23
        tabarHeight= self.is_pushCome?0:Height_TabBar;
        [self.view addSubview:self.cancelBtn];
        [self.view addSubview:self.searchBar];
    }else{
        tabarHeight=0;
    }

    [self.view addSubview:self.collectionView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达购物" success:nil failure:nil];
    
    [self getFightSuccess];
    
    [self xuanfuHongBaoView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出购物" success:nil failure:nil];
}

#pragma  mark - 数据
- (void)getHotData {
    [SearchTypeModel httpGetSearchTypeModelSuccess:^(id data) {
        SearchTypeModel *model=data;
        if (model.status==1) {
            [self hotTagData:model.hotTagList];
        }
    }];
}
- (void)hotTagData:(NSArray *)arr {
    /*
    NSArray *hotArr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SearchTypeModel *model1 = obj1;
        SearchTypeModel *model2 = obj2;
        if (model1.count > model2.count) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if (model1.count < model2.count) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    */
   
    NSMutableArray *hotTitleArr=[NSMutableArray array];
    SqliteManager *manager = [SqliteManager sharedManager];
    for (HotModel *model in arr) {
        ShopTagItem *item = [manager getShopTagItemForId:model.tag_id];
        if(item.tag_name)
            [hotTitleArr addObject: item.tag_name];
    }
    self.searchController.hotSearches=[hotTitleArr copy];
    self.searchBar.placeholder=hotTitleArr.count ? hotTitleArr[0] :@"元气少女连衣裙";
}
- (void)createTableData
{
    SqliteManager *manager = [SqliteManager sharedManager];
    /*
    NSArray *typeArray = [manager getShopTypeItemForSuperId:@"0"];
//    NSMutableArray *tmpArr = [NSMutableArray array];
    NSMutableArray *muTypeArr = [NSMutableArray arrayWithArray:typeArray];
    NSArray *sortArr = nil;
//    for (ShopTypeItem *item in muTypeArr) {
//        if ([item.name isEqualToString:@"特卖"] || [item.name isEqualToString:@"热卖"] || [item.name isEqualToString:@"上新"] ) {
//            [tmpArr addObject:item];
//        }
//    }
//    [muTypeArr removeObjectsInArray:tmpArr];
    sortArr = [manager sortShopTypeArrayWithSequenceFromSourceArray:muTypeArr];
    self.searchCateArray = [NSMutableArray arrayWithArray:sortArr];
    
    if (self.searchCateArray.count!=0) {
        for (ShopTypeItem *item in self.searchCateArray) {
            NSString *superID = item.ID;
            NSArray *array = [manager getShopTypeItemForSuperId:superID];
            [self.searchDataArray addObject:array];
        }
    }
    */
    self.searchCateArray = [NSMutableArray arrayWithArray:@[@"",@"流行趋势",@"上衣",@"裤子",@"裙子",@"套装"]];
//    self.sectionOneData = [NSMutableArray arrayWithArray:@[@"ZARA",@"H&M",@"GAP",@"Honneys",@"i.t",@"ochrily",@"UNIQ",@"MORE"]];
   self.sectionOneData = [[manager getAllForBrandsItem]copy];
    NSArray *typeArr=@[@"0",@"2",@"4",@"3",@"7"];
    
    [self.searchDataArray addObject:@[@""]];
    
    for (int i=0; i<typeArr.count; i++) {
        NSArray *arr =[manager getTypeTagItemForSuperIdWithHomePage:[NSString stringWithFormat:@"%@",typeArr[i]]];
        [self.searchDataArray addObject:arr];
    }
    [self getHotData];
    
}
#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"搜索下—输入后确定" success:nil failure:nil];
    [DataManager sharedManager].outAppStatistics = [NSString stringWithFormat:@"%@",@"搜索结果列表页"];
    
    [self.searchController saveSearchCacheAndRefreshView:searchBar];
    /*
    //添加搜索的文本到历史
    SearchItem *item = [[SearchItem alloc] init];
    item.searchText = searchBar.text;
    BOOL bl = NO;
    FMDBSearchManager *manager = [FMDBSearchManager sharedManager];
    NSArray *itemArray = [manager getAllSearchItem];
    for (SearchItem *itemTemp in itemArray) {
        if ([itemTemp.searchText isEqualToString:searchBar.text]) {
            bl = YES;
        }
    } if (bl == NO) {
        [manager addSearchItem:item];
    }
    */
    
    //开始搜索 = %@",searchBar.text);
    


    [self.searchBar resignFirstResponder];
    
    [self searchToShopListView:searchBar.text];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        [self.searchSuggestionVC.tableView reloadData];
        [self.view bringSubviewToFront:self.searchSuggestionVC.tableView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜索完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            [self.searchController.hotSearches enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj containsString:searchText]) {
                    [searchSuggestionsM addObject:obj];
                }
            }];
            self.searchSuggestionVC.searchSuggestions=searchSuggestionsM;
        });
    }
    
        self.searchSuggestionVC.view.hidden=!searchText.length;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self addChildViewController:self.searchController];
    
    NSString * path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"];
    [self.searchController setSearchHistories:[NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:path]]];
    [self getHotData];

    
    if (_searchType==SearchTypeNormal) {
        [self tabBarFrameChangeStatus:SearchTabBarStutesBottom animation:YES];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat searchY = 0;
        self.searchBar.frame=CGRectMake(0, _searchType==SearchTypeScreen?(20+searchY):(Height_NavBar+searchY), SCREEN_WIDTH-50, 40);
        self.cancelBtn.frame=CGRectMake(SCREEN_WIDTH-50,_searchType==SearchTypeScreen?(20+searchY) : (Height_NavBar+searchY), 40, 40);
    }];
    CGFloat height = _searchType==SearchTypeScreen
                   ? self.view.frame.size.height-Height_NavBar
                   : self.view.frame.size.height-Height_NavBar-40;
    self.searchController.baseSearchTableView.frame=CGRectMake(0,_searchType==SearchTypeScreen?Height_NavBar:Height_NavBar+40, SCREEN_WIDTH, height);

    [self.view addSubview:self.searchController.baseSearchTableView];
    [self.searchController didMoveToParentViewController:self];

}
- (void)searchToShopListView:(NSString *)text {
    
    TFScreenViewController *svc = [[TFScreenViewController alloc] init];
    svc.dataStatistics = @"搜索下—输入后确定";
    svc.index = 0;
    
    svc.muStr = text;
    
    svc.titleText = text;
    //    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
}


- (void)leftBtnClick {
    //何波修改2017-10-23
    if(self.is_pushCome)
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
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelBtnClick {
    self.searchSuggestionVC.view.hidden=YES;
    if (_searchType==SearchTypeNormal) {
        [self tabBarFrameChangeStatus:SearchTabBarStutesNormal animation:YES];
    }
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat xPoint=_searchType==SearchTypeScreen? 34:0;
        CGFloat searchY = 0;
        self.searchBar.frame = CGRectMake(xPoint,_searchType==SearchTypeScreen?(20 + searchY) : (Height_NavBar + searchY), SCREEN_WIDTH-xPoint, 40);
//        self.cancelBtn.frame=CGRectMake(SCREEN_WIDTH, 64, 40, 40);
        [self.searchBar endEditing:YES];
        self.searchBar.text=nil;
        
        [self.searchController willMoveToParentViewController:nil];
        [self.searchController.baseSearchTableView removeFromSuperview];
        [self.searchController removeFromParentViewController];
        
        [self.searchSuggestionVC willMoveToParentViewController:nil];
        [self.searchSuggestionVC.view removeFromSuperview];
        [self.searchSuggestionVC removeFromParentViewController];

    }completion:^(BOOL finished) {
      

    }];
}

#pragma mark - PYSearchViewController
- (void)didClickCancel:(PYSearchViewController *)searchViewController {
    [self cancelBtnClick];
}

//- (void)searchViewController:(PYSearchViewController *)searchViewController didSelectHotSearchAtIndex:(NSInteger)index searchText:(NSString *)searchText {
//    ShopTypeItem *item = self.searchController.hotSearches[index];
//    
//    NSString *ID = item.ID;
//    NSString *title = item.name;
//
//    TFScreenViewController *svc = [[TFScreenViewController alloc] init];
//    svc.dataStatistics = @"搜索下—输入后确定";
//    svc.index = 0;
//    svc.type2=ID;
//    svc.titleText = title;
//    svc.muStr=title;
//    svc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:svc animated:YES];
//}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.searchDataArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (section==0) {
        return self.sectionOneData.count>=11?12:self.sectionOneData.count;
//        return MIN(8, self.sectionOneData.count);
//        self.sectionOneData.count;
    }
    return [self.searchDataArray[section]count];
//    return arc4random()%8+4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        SectionOneCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SectionOneCell" forIndexPath:indexPath];
        cell.nameLabel.hidden=indexPath.row!=11;
        cell.backImg.hidden=indexPath.row==11;
        if (indexPath.row==11) {
            cell.nameLabel.text = @"MORE >";
            cell.nameLabel.textColor=RGBA(62, 62, 62, 11);
            cell.nameLabel.font=kFont6px(28);
            cell.backgroundColor=RGBA(248, 248, 248, 1);
            
            cell.clipsToBounds = YES;
            cell.layer.cornerRadius =ZOOM6(8);
        }else {
            TypeTagItem *item=self.sectionOneData[indexPath.row];
            //        cell.nameLabel.text= indexPath.row==7
            //                                ? @"MORE"
            //                                : item.class_name;
            
            
            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],item.icon]];
            //        __block float d = 0;
            //        __block BOOL isDownlaod = NO;
            [cell.backImg sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                //            d = (float)receivedSize/expectedSize;
                //            isDownlaod = YES;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //            if (image != nil && isDownlaod == YES) {
                //                cell.backImg.alpha = 0;
                //                [UIView animateWithDuration:0.5 animations:^{
                //                    cell.backImg.alpha = 1;
                //                } completion:^(BOOL finished) {
                //                }];
                //            } else if (image != nil && isDownlaod == NO) {
                //                cell.backImg.image = image;
                //            }
            }];
        }
        return cell;
    }
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    TypeTagItem *item = [self.searchDataArray[indexPath.section] objectAtIndex:indexPath.row];
    [cell receiveName:item];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        if (indexPath.row==11) {
            MoreBrandsMakerVC *vc=[MoreBrandsMakerVC new];
            vc.dataArr=self.sectionOneData;
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            BrandMakerDetailVC *view=[BrandMakerDetailVC new];
            TypeTagItem *item = self.sectionOneData[indexPath.row];
            view.shopItem=item;
            view.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:view animated:YES];
        }
    }else{
    
    TypeTagItem *item = [self.searchDataArray[indexPath.section] objectAtIndex:indexPath.row];
    
    NSString *ID = item.ID;
    NSString *title = item.class_name;
    
//    NSNumber *type1=[self.currTitlePageTypeParms objectForKey:@"id"];
//    NSString *type_name=[self.currTitlePageTypeParms objectForKey:@"name"];
    
//    TFSearchViewController *svc = [[TFSearchViewController alloc] init];
//    svc.parentID = ID;
//    svc.dataStatistics = @"搜索结果商品点击";
//    svc.shopTitle = title;
    TFScreenViewController *svc = [[TFScreenViewController alloc] init];
    svc.dataStatistics = @"搜索下—输入后确定";
    svc.index = 0;
    svc.class_id=ID;
    svc.titleText = title;
    svc.muStr=title;
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
    }
}
#pragma mark UICollectionView---section
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind != WaterFallSectionHeader)
        return nil;
    if(indexPath.section == 0)
    {
//        _headerView =(CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//        _headerView.backgroundColor=[UIColor groupTableViewBackgroundColor];
//        return _headerView;
        return nil;
    }else{
        SearchReusableView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        if (self.searchCateArray.count>indexPath.section) {
//            ShopTypeItem *item = self.searchCateArray[indexPath.section];
//            [header receiveWithNames:[NSString stringWithFormat:@"%@",item.name]];
            [header receiveWithNames:[NSString stringWithFormat:@"%@",self.searchCateArray[indexPath.section]]];
        }
        return header;
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{
    if(section == 0)
    {
        return  0;
    }
    return  ZOOM6(80);
}
#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark =item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imgH = ZOOM6(200);
    CGFloat imgW = ZOOM6(140);
    
    if (indexPath.section==0) {
        imgH=ZOOM6(160);//ZOOM6(74);
        imgW=ZOOM6(160);
        CGFloat W = (self.view.frame.size.width-ZOOM6(20)*4)/2.0;
        CGFloat H = imgH*W/imgW;
        return CGSizeMake(W, H);
    }
  
    
    CGFloat W = (self.view.frame.size.width-18)/2.0;
    CGFloat H = imgH*W/imgW;
    
    CGSize size = CGSizeMake(W, H);
    return size;
}
#pragma mark - 懒加载
#pragma mark =数组
- (NSMutableArray *)searchCateArray {
    if (!_searchCateArray) {
        _searchCateArray = [NSMutableArray array];
    }
    return _searchCateArray;
}

- (NSMutableArray *)searchDataArray {
    if (!_searchDataArray) {
        _searchDataArray = [NSMutableArray array];
    }
    return _searchDataArray;
}
- (NSMutableArray *)sectionOneData {
    if (!_sectionOneData) {
        _sectionOneData = [NSMutableArray array];
    }
    return _sectionOneData;
}
#pragma mark =VC
- (PYSearchSuggestionViewController *)searchSuggestionVC
{
    if (!_searchSuggestionVC) {
        PYSearchSuggestionViewController *searchSuggestionVC = [[PYSearchSuggestionViewController alloc] initWithStyle:UITableViewStylePlain];
        __weak typeof(self) _weakSelf = self;
        searchSuggestionVC.didSelectCellBlock = ^(UITableViewCell *didSelectCell) {
            // 设置搜索信息
            _weakSelf.searchBar.text = didSelectCell.textLabel.text;
            
            [self searchToShopListView:_weakSelf.searchBar.text];
           
        };
        searchSuggestionVC.view.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), self.view.width, self.view.height-CGRectGetMaxY(self.searchBar.frame));
        
        [self.view addSubview:searchSuggestionVC.view];
        [self addChildViewController:searchSuggestionVC];
        _searchSuggestionVC = searchSuggestionVC;
    }
    return _searchSuggestionVC;
}
- (PYSearchViewController *)searchController {
    if (!_searchController) {
        
        // 1.创建热门搜索
//        NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
        // 2. 创建控制器
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:@"搜索" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            // 开始搜索执行以下代码
            // 如：跳转到指定控制器
//            [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
            [self searchToShopListView:searchText];
        }];
        searchViewController.keyboardDismiss=^{
            [self.searchBar endEditing:YES];
        };
        // 3. 设置风格
        
        searchViewController.hotSearchStyle = 0; // 热门搜索风格根据选择
        searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag; // 搜索历史风格为default
        searchViewController.searchResultShowMode=PYSearchResultShowModePush;
        // 4. 设置代理
        searchViewController.delegate=self;
        searchViewController.searchBar=self.searchBar;
        _searchController=searchViewController;
        
    }
    return _searchController;
}

- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
        flowLayout.sectionInset = UIEdgeInsetsMake(ZOOM6(30), ZOOM6(20), ZOOM6(30), ZOOM6(20));
        flowLayout.minimumColumnSpacing=ZOOM6(20);
        flowLayout.minimumInteritemSpacing=ZOOM6(30);
        flowLayout.columnCount=4;
        
        CGFloat navaHeigh = IS_IPHONE_X?88:64;
        CGFloat height = _searchType==SearchTypeScreen
                       ? kScreenHeight-navaHeigh-tabarHeight
                       : kScreenHeight-navaHeigh-tabarHeight-40;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,_searchType==SearchTypeScreen?navaHeigh:navaHeigh+40, self.view.frame.size.width, height)collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        // Register cell classes
        [_collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[SectionOneCell class] forCellWithReuseIdentifier:@"SectionOneCell"];
        [_collectionView registerClass:[SearchReusableView class] forSupplementaryViewOfKind:WaterFallSectionHeader  withReuseIdentifier:headerID];
//        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:WaterFallSectionHeader withReuseIdentifier:@"HeaderView"];
    }
    return _collectionView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        CGFloat xPoint=_searchType==SearchTypeScreen? 34:0;
        _searchBar.frame = CGRectMake(xPoint,_searchType==SearchTypeScreen?20:Height_NavBar, SCREEN_WIDTH-xPoint, 40);
//        _searchBar.backgroundColor = [UIColor redColor];
        
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.barTintColor=[UIColor whiteColor];
        [_searchBar.layer setBorderWidth:0.5f];
        [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
    return _searchBar;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame=CGRectMake(SCREEN_WIDTH-50, _searchType==SearchTypeScreen?20 :Height_NavBar, 40, 40);
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        _cancelBtn.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    return  _cancelBtn;
}
- (void)setNavgationView {
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    if (self.searchType==SearchTypeNormal) {
        UILabel *titlelable=[[UILabel alloc]init];
        titlelable.frame=CGRectMake(0, 0, 300, 40);
        titlelable.center=CGPointMake(SCREEN_WIDTH/2, headview.frame.size.height/2+10);
        titlelable.text = @"全部分类";
        titlelable.font = kNavTitleFontSize;
        titlelable.textColor=kMainTitleColor;
        titlelable.textAlignment=NSTextAlignmentCenter;
        [headview addSubview:titlelable];
        
        //何波修改2017-10-23
        if(self.is_pushCome)
        {
            UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
            backbtn.frame=CGRectMake(0, 18, 44, 44);
            backbtn.centerY = View_CenterY(headview);
            [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
            [backbtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [headview addSubview:backbtn];
            [self.view addSubview:self.cancelBtn];
            [self.view addSubview:self.searchBar];
        }
    }else{
        UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        backbtn.frame=CGRectMake(0, 18, 44, 44);
        backbtn.centerY = View_CenterY(headview);
        [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
        [backbtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headview addSubview:backbtn];
        [self.view addSubview:self.cancelBtn];
        [self.view addSubview:self.searchBar];
    }

    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-0.5, kScreenWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [headview addSubview:line];
    
}
#pragma mark =tabBarFrameChangeStatus
- (void)tabBarFrameChangeStatus:(SearchTabBarStutes)status animation:(BOOL)isAnimation {

    if (isAnimation) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            if (status == SearchTabBarStutesNormal) {
                [self tabBarStatusWithNormal];
            } else {
                [self tabBarStatusToBottom];
            }
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
        if (status == SearchTabBarStutesNormal) {
            [self tabBarStatusWithNormal];
        } else {
            [self tabBarStatusToBottom];
        }
        
    }
    
}
- (void)tabBarStatusWithNormal {
//    Mtarbar.tabBar.frame = CGRectMake(0, kScreenHeight-Height_TabBar, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
    Mtarbar.tabBar.hidden = NO;
    CGFloat navaHeigh = IS_IPHONE_X?88:64;
    CGFloat height = _searchType==SearchTypeScreen
    ? kScreenHeight-navaHeigh-tabarHeight
    : kScreenHeight-navaHeigh-40-tabarHeight;
    self.collectionView.frame=CGRectMake(0, _searchType==SearchTypeScreen?navaHeigh:navaHeigh+40, self.view.frame.size.width, height);
}
- (void)tabBarStatusToBottom {
//    CGRect rect = Mtarbar.tabBar.frame;
//    rect.origin.x = 0;
//    rect.origin.y = kScreenHeight;
//    Mtarbar.tabBar.frame = rect;
    
    Mtarbar.tabBar.hidden = YES;
    CGFloat navaHeigh = IS_IPHONE_X?88:64;
    CGFloat height = _searchType==SearchTypeScreen
    ? kScreenHeight-navaHeigh
    : kScreenHeight-navaHeigh-40;
    self.collectionView.frame=CGRectMake(0, _searchType==SearchTypeScreen?navaHeigh:navaHeigh+40, self.view.frame.size.width, height);
}

#pragma mark 是否有拼团成功的订单
- (void)getFightSuccess
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefaul objectForKey:USER_TOKEN];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *url=[NSString stringWithFormat:@"%@/order/getOrderStatus?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            
            NSInteger roll = [responseObject[@"roll"] integerValue];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            BOOL isFightSuccessShow = [user boolForKey:@"isFightSuccessShow"];
            if(roll == 1 && !isFightSuccessShow)
            {
                NSString *username = [NSString stringWithFormat:@"%@",responseObject[@"user_name"]];
                [user setBool:YES forKey:@"isFightSuccessShow"];
                [user setValue:username forKey:@"fightSuccessUser"];
                
                [self setVitalityPopMindView:Fight_luckSuccess];
                
            }else{
                //拼团失败退款提示框
                kWeakSelf(self);
                [OneYuanModel GetOneYuanCountSuccess:^(id data) {
                    OneYuanModel *oneModel = data;
                    if(oneModel.status == 1 && oneModel.isFail == 1)
                    {
                        [DataManager sharedManager].OneYuan_count = oneModel.order_price;

                        [weakself setVitalityPopMindView:Detail_OneYuanDeductible];
                    }
                }];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark 0元购弹框
- (void)setVitalityPopMindView:(VitalityType)type
{
    NSInteger valityGrade = type ==Detail_OneYuanDeductible?3:0;
    VitalityTaskPopview *vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:type valityGrade:valityGrade YidouCount:0];
    vitaliview.oneYuanDiKou = [DataManager sharedManager].OneYuan_count;
    __weak VitalityTaskPopview *view = vitaliview;
    view.tapHideMindBlock = ^{
        
        [view remindViewHiden];
    };
    view.closeMindBlock = ^{
        
    };
    view.leftHideMindBlock = ^(NSString*title){
        if (type == Fight_luckSuccess || type == Detail_OneYuanDeductible)
        {
            
            MyOrderViewController *myorder = [[MyOrderViewController alloc]init];
            myorder.hidesBottomBarWhenPushed = YES;
            myorder.tag= (type == Detail_OneYuanDeductible)?999:1001;
            myorder.status1= (type == Detail_OneYuanDeductible)?@"0":@"2";
            
            Mtarbar.selectedIndex=4;
            UINavigationController *nv = (UINavigationController *)Mtarbar.viewControllers[4];
            nv.navigationBarHidden = YES;
            [nv pushViewController:myorder animated:YES];
        }
    };
    
    view.rightHideMindBlock = ^(NSString *title) {
        if (type == Detail_OneYuanDeductible)//余额返回说明
        {
            TFMyWalletViewController *wallet = [[TFMyWalletViewController alloc]init];
            wallet.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wallet animated:YES];
        }
    };
    [self.view addSubview:vitaliview];
}

/**
 悬浮红包
 */
- (void)xuanfuHongBaoView
{
    if(self.hongbaoview == nil)
    {
        self.hongbaoview = [[RedXuanfuHongBao alloc]initWithFrame:CGRectMake(kScreen_Width-78, kScreen_Height-(kTabBarHeight+ZOOM6(320)), 70,70) isShouYeThree:NO];
        [self.view addSubview:self.hongbaoview];
    }else{
        [self.hongbaoview refreshXuanfuImage];
    }
    
    kWeakSelf(self);
    self.hongbaoview.lingHongBaoBlock = ^(BOOL isNewUser) {
        
//        if(isNewUser)//没有交易记录用户
//        {
//            ShouYeShopStoreViewController *vc = [[ShouYeShopStoreViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.isHeadView = YES;
//            vc.isFootView = NO;
//            vc.isVseron = YES;
//            [weakself.navigationController pushViewController:vc animated:YES];
//        }else{
//            MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [weakself.navigationController pushViewController:vc animated:YES];
//        }
        
        MakeMoneyViewController *vc = [[MakeMoneyViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
}
@end
