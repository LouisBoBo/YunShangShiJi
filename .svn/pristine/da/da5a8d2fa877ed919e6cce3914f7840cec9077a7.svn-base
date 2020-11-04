//
//  TFSubIntimateCircleVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFSubIntimateCircleVC.h"
#import "IntimateCircleCell.h"
#import "IntimateCircleModel.h"
#import "CircleTagsCell.h"
#import "NavgationbarView.h"
#import "TopicDetailViewController.h"
#import "ShopDetailViewController.h"
#import "TopicPublicModel.h"
#import "TFSearchViewController.h"
#import "BrandMakerDetailVC.h"
#import "LoginViewController.h"
#import "VitalityTaskPopview.h"
#import "MoreCommendViewController.h"
@interface TFSubIntimateCircleVC () <UITableViewDelegate, UITableViewDataSource> {
    struct {
        unsigned int intimateCirclePullDownRefreshWithIndex: 1;
        unsigned int intimateCircleWithScrollViewWillBeginDragging : 1;
        unsigned int intimateCircleWithScrollViewDidEndDragging : 1;
        unsigned int intimateCircleWithScrollViewWillBeginDecelerating : 1;
        unsigned int intimateCircleWithscrollViewDidEndDecelerating : 1;
    }_delegateFlags;
}
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger currPage;
@property (nonatomic, strong) NSMutableArray *tagsSource;
@property (nonatomic, strong) NSMutableArray *tagItemsSource;
@property (nonatomic, assign) BOOL isHome;
@end

@implementation TFSubIntimateCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setUI];
    
    [self setData];
}

- (void)setUI {
    if ([self.name isEqualToString:@"蜜友"] || [self.name isEqualToString:@"话题广场"]) {
        self.isHome = YES;
        [self.dataSource addObject:self.tagsSource];
    } else {
        if (self.item) {
            [self setNavigationItemLeft:self.item.name];
        }else if ([self.name isEqualToString:@"穿搭"]||[self.name isEqualToString:@"收藏"]){
            [self setNavigationItemLeft:[NSString stringWithFormat:@"我的%@",self.name]];
        }else {
            [self setNavigationItemLeft:self.name];
        }
        
    }
}


- (void)setData {
    self.currPage = 1;
    
    int index = 0;
    UIScrollView *superScrollView = (UIScrollView *)self.tableView.superview;
    if ([superScrollView isKindOfClass:[UIScrollView class]]) {
        index = superScrollView.contentOffset.x / kScreenWidth;
    }
    self.index = index;
    
    [self getData];
}

- (void)getData {
    if ([self.name isEqualToString:@"蜜友"]) {
        [self httpCircle];
    } else if ([self.name isEqualToString:@"话题广场"]){
        [self httpTheme];
    } else if (self.item) {//标签
        [self httpTagsData];
    } else if ([self.name isEqualToString:@"话题"]){
        [self httpMyTheme];
    } else if ([self.name isEqualToString:@"穿搭"]){
        [self httpDress];
    } else if ([self.name isEqualToString:@"推荐"]){
        [self httpCommend];
    } else if ([self.name isEqualToString:@"收藏"]){
        [self httpMyCollect];
    }
}

#pragma mark - Http Tools
- (void)httpCircle {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if(token == nil) {
        [self.tableView ffRefreshHeaderEndRefreshing];
        [self.tableView footerEndRefreshing];

        CGRect frame = CGRectMake(0, ZOOM6(100), self.view.frame.size.width, kScreenHeight-64-49-ZOOM6(180)-kScreen_Width/2);
        [self showBackgroundType:ShowBackgroundTypeToLogin message:nil superView:self.tableView setSubFrame:frame];
    }else{
        [self cleanShowBackground];
        kSelfWeak;
        [CircleModel getCircleModelWithCurPage:self.currPage success:^(id data) {
            [weakSelf.tableView ffRefreshHeaderEndRefreshing];
            [weakSelf.tableView footerEndRefreshing];
            
            CircleModel *model = data;
            [self loadModel:model isTags:YES];
        }];
    }
}

- (void)httpTheme {
    kSelfWeak;
    [CircleModel getCircleThemeModelWithCurPage:self.currPage success:^(id data) {
        [weakSelf.tableView ffRefreshHeaderEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
        
        CircleModel *model = data;
        [self loadModel:model isTags:YES];
        
    }];
    
}

- (void)httpMyCollect {
    kSelfWeak;
    [CircleModel getPersonCollectModelWithCurPage:self.currPage success:^(id data) {
        [weakSelf.tableView ffRefreshHeaderEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
        
        CircleModel *model = data;
        [self loadModel:model isTags:NO];
        
    }];
    
}

- (void)httpMyTheme {
    kSelfWeak;
    [CircleModel getPersonThemeModelWithCurPage:self.currPage success:^(id data) {
        [weakSelf.tableView ffRefreshHeaderEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
        
        CircleModel *model = data;
        [self loadModel:model isTags:NO];
    }];
}

- (void)httpDress {
    kSelfWeak;
    [CircleModel getPersonDressModelWithCurPage:self.currPage success:^(id data) {
        [weakSelf.tableView ffRefreshHeaderEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
        
        CircleModel *model = data;
        [weakSelf loadModel:model isTags:NO];
        
    }];
}

- (void)httpTagsData {
//    [CircleModel getCircleTagThemeModelWithCurPage:self.currPage tag:self.item.ID success:^(id data) {
//        [self.tableView ffRefreshHeaderEndRefreshing];
//        [self.tableView footerEndRefreshing];
//        
//        CircleModel *model = data;
//        [self loadModel:model isTags:NO];
//
//    }];
    kSelfWeak;
    [CircleModel getTagCircleThemeModelWithCurPage:self.currPage tag:self.item.ID success:^(id data) {
        
        [weakSelf.tableView ffRefreshHeaderEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
        
        CircleModel *model = data;
        [self loadModel:model isTags:NO];
    }];
}

- (void)httpCommend
{
    kSelfWeak;
    [CircleModel getCommendThemeModelWithCurPage:self.currPage PageSize:30 Themeid:self.themeid success:^(id data) {
        [weakSelf.tableView ffRefreshHeaderEndRefreshing];
        [weakSelf.tableView footerEndRefreshing];
        
        CircleModel *model = data;
        [self loadModel:model isTags:NO];
        
    }];
}

- (void)loadModel:(CircleModel *)model isTags:(BOOL)isTags{
    if (model.status == 1) {
        NSMutableArray *dataArray = [NSMutableArray arrayWithArray:model.myData];
        if (self.currPage == 1) {
            [self.dataSource removeAllObjects];
            if (isTags) {
                [self.dataSource addObject:self.tagsSource];
            }
        }else{//何波加的2017-3-21
            
            for(int i =0 ; i <model.myData.count; i++)
            {
                IntimateCircleModel *cmodel = model.myData[i];
                for(int j=0;j<self.dataSource.count;j++)
                {
                    IntimateCircleModel *nmodel = self.dataSource[j];
                    if([nmodel isKindOfClass:[IntimateCircleModel class]])
                    {
                        if([nmodel.theme_id intValue] == [cmodel.theme_id intValue])
                        {
                            [dataArray removeObject:cmodel];
                        }
                    }
                }
            }
        }
        [self.dataSource addObjectsFromArray:dataArray];
        [self.tableView reloadData];
    } else {
//        if (model.status==10030) {
//            LoginViewController *login=[[LoginViewController alloc]init];
//            login.tag = 1000;
//            login.loginStatue=@"toBack";
//            login.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:login animated:YES];
//        }
//        else
//        NavgationbarView *naV = [[NavgationbarView alloc] init];
//        [naV showLable:model.message Controller:self];
        [NavgationbarView showMessageAndHide:model.message backgroundVisiable:NO];
    }
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.isHome) {
            static NSString *idf = @"CellId0";
            CircleTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:idf];
            if (cell == nil) {
                cell = [[CircleTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
            }
            
            [cell setData:self.dataSource[indexPath.row]];
            cell.didSelectedBlock = ^(NSInteger selectedItem) {
                if (selectedItem == 0) {
                    return ;
                } else {
                    ShopTypeItem *item = self.tagItemsSource[selectedItem];
                    TFSubIntimateCircleVC *vc = [[TFSubIntimateCircleVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.item = item;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
            return cell;
        } else {
            return [self getCircleCellWithTableView:tableView indexPath:indexPath];
        }
    } else {
        return [self getCircleCellWithTableView:tableView indexPath:indexPath];
    }
    return 0;
}

- (IntimateCircleCell *)getCircleCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    static NSString *idf = @"CellId";
    IntimateCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:idf];
    if (cell == nil) {
        cell = [[IntimateCircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
    }
    IntimateCircleModel *model = self.dataSource[indexPath.row];
    [cell setModel:model indexPath:indexPath];
    
    kSelfWeak;
    cell.refreshSingleCellBlock = ^(){
        [weakSelf.tableView reloadData];
    };
    
    cell.heedBtn.hidden=[self.name isEqualToString:@"话题"];
    
    NSString *userId = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
    if([userId integerValue] == [model.user_id integerValue])
    {
        cell.heedBtn.hidden = YES;
    }else{
        cell.heedBtn.hidden = NO;
    }

    cell.headerTitleTapBlock = ^(IntimateCircleModel *curModel, NSIndexPath *currIndexPath) {
        MyLog(@"点击头像");
    };
    
    //点赞
    cell.likeBtnClickedBlock = ^(IntimateCircleModel *curModel, NSIndexPath *currIndexPath) {
        kWeakSelf(curModel);
        [weakSelf loginSuccess:^{
            if (weakcurModel.applaud_status != 0) {
                [TopicPublicModel DisThumbstData:1 This_id:[weakcurModel.theme_id stringValue] Theme_id:[weakcurModel.theme_id stringValue] Success:^(id data) {
                    TopicPublicModel *model = data;
                    if (model.status == 1) {
                        weakcurModel.applaud_status = 0;
                        weakcurModel.applaud_num = @([weakcurModel.applaud_num integerValue] - 1);
                        [NavgationbarView showMessageAndHide:@"取消成功" backgroundVisiable:NO];
                        [weakSelf reloadTableViewIndexPath:currIndexPath model:weakcurModel];
                    } else {
                        [NavgationbarView showMessageAndHide:model.message backgroundVisiable:NO];
                    }
                }];
            } else {
                [TopicPublicModel ThumbstData:1 This_id:[weakcurModel.theme_id stringValue] Theme_id:[weakcurModel.theme_id stringValue] Success:^(id data) {
                    TopicPublicModel *model = data;
                    if (model.status == 1) {
                        weakcurModel.applaud_status = 1;
                        weakcurModel.applaud_num = @([weakcurModel.applaud_num integerValue] + 1);
                        [NavgationbarView showMessageAndHide:@"点赞成功" backgroundVisiable:NO];
                        [weakSelf reloadTableViewIndexPath:currIndexPath model:weakcurModel];
                    } else {
                        [NavgationbarView showMessageAndHide:model.message backgroundVisiable:NO];
                    }
                }];
            }
        }];
    };
    
    //评论
    cell.commentClickedBlock = ^(IntimateCircleModel *curModel, NSIndexPath *currIndexPath) {
        [weakSelf pushThemeVCWithModel:curModel Comment:YES];
    };
    
    //删除或收藏
    cell.del_collectionBlock = ^(IntimateCircleModel *curModel, NSIndexPath*currIndexPath) {
    
        [weakSelf loginSuccess:^{
            NSString *userId = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
            if ([userId isEqualToString:[curModel.user_id stringValue]]) {
                
                VitalityTaskPopview* vitaliview = [[VitalityTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) VitalityType:Topic_delateTopic valityGrade:0 YidouCount:0];
                __weak VitalityTaskPopview *view = vitaliview;
                view.rightHideMindBlock = ^(NSString*title){
                    
                    [TopicPublicModel DtleateTheme:[curModel.theme_id stringValue] Success:^(id data) {
                        TopicPublicModel *model = data;
                        if(model.status == 1)
                        {
                            [weakSelf getData];
                            [NavgationbarView showMessageAndHide:@"删除成功" backgroundVisiable:NO];
                        }else{
                            [NavgationbarView showMessageAndHide:@"删除失败" backgroundVisiable:NO];
                        }
                    }];
                    
                };
                UIWindow *kwindow = [UIApplication sharedApplication].keyWindow;
                [kwindow addSubview:vitaliview];

            }else{
                if(curModel.collection_status == 1)
                {
                    [TopicPublicModel DelCollectionTheme:[curModel.theme_id stringValue] Success:^(id data) {
                        TopicPublicModel *model = data;
                        if(model.status == 1){
                            curModel.collect_num = @([curModel.collect_num integerValue] - 1);
                            curModel.collection_status = 0;
                           
                            [weakSelf reloadTableViewIndexPath:currIndexPath model:curModel];
                        }
                    }];
                }else{
                    
                    [TopicPublicModel AddCollectionTheme:[curModel.theme_id stringValue] Success:^(id data) {
                        TopicPublicModel *model = data;
                        if(model.status == 1)
                        {
                            curModel.collect_num = @([curModel.collect_num integerValue] + 1);
                            curModel.collection_status = 1;
                            [NavgationbarView showMessageAndHide:@"收藏成功" backgroundVisiable:NO];
                            [weakSelf reloadTableViewIndexPath:currIndexPath model:curModel];
                        }else{
                            [NavgationbarView showMessageAndHide:@"收藏失败" backgroundVisiable:NO];
                        }
                    }];
                    
                }
                
            }
        }];
       
    };
    //关注
    cell.heedBtnClickedBlock = ^(IntimateCircleModel *curModel, NSIndexPath *currIndexPath) {
        [weakSelf loginSuccess:^{
            NSInteger type = 0;
            if (curModel.attention_status == 0 ) {
                type = 1;
            } else {
                NSString *userId = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]];
                if ([userId isEqualToString:[curModel.user_id stringValue]]) {
                    [NavgationbarView showMessageAndHide:@"不能取消关注自己" backgroundVisiable:NO];
                    return ;
                }
                type = 2;
            }
            [TopicPublicModel FollowData:type Friend_user_id:[curModel.user_id stringValue] Success:^(id data) {
                TopicPublicModel *model = data;
                if (model.status == 1) {
                    if (type == 1) {
                        curModel.attention_status = 1;
                    } else {
                        curModel.attention_status = 0;
                    }
                    [weakSelf reloadTableViewIndexPath:currIndexPath model:curModel];
                } else {
                    [NavgationbarView showMessageAndHide:model.message backgroundVisiable:NO];
                }
            }];
        }];
    };

    // 商品推荐
    cell.followClickBlock = ^(TFShopModel *shopModel, NSIndexPath *shopMIndexPath) {
        [weakSelf pushShopVCWithModel:shopModel];
    };
    
    // 商品推荐标签
    cell.followTagClickBlock = ^(ShopTypeItem *item, NSIndexPath *indexPath) {
        TFSubIntimateCircleVC *vc = [[TFSubIntimateCircleVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.item = item;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    // 话题标签
    cell.tagThemeClickBlock = ^(ShopTypeItem *item, NSIndexPath *indexPath) {
        TFSubIntimateCircleVC *vc = [[TFSubIntimateCircleVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.item = item;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    // 穿搭风格
    cell.tagDressWithStyleClickBlock = ^(ShopTagItem *item, NSIndexPath *indexPath) {
        /*
        TFSearchViewController *vc = [[TFSearchViewController alloc] init];
        vc.parentID = item.ID;
        vc.shopTitle = item.tag_name;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
   */
        TFScreenViewController *screen = [[TFScreenViewController alloc]init];
        screen.muStr = item.ID;
        screen.index = 1;
        screen.titleText = item.tag_name;
        screen.hidesBottomBarWhenPushed=YES;
        [weakSelf.navigationController pushViewController:screen animated:YES];
        
    };
    // 穿搭品牌
    cell.tagDressWithSuppClickBlock = ^(TypeTagItem *item, NSIndexPath *indexPath,IntimateCircleModel *curModel) {
        if(item.supperLabertype == 2)
        {
            if(item.isrepeat)
            {
                if(curModel.shop_list.count >=20)
                {
                    MoreCommendViewController *commend = [[MoreCommendViewController alloc]init];
                    commend.theme_id = [NSString stringWithFormat:@"%@",curModel.theme_id];
                    commend.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:commend animated:YES];
                }
            }else{
                TFScreenViewController *screen = [[TFScreenViewController alloc]init];
                screen.muStr = [NSString stringWithFormat:@"%@",item.only_id];
                screen.index = 3;
                screen.titleText = item.class_name;
                screen.theme_id = [NSString stringWithFormat:@"%@",curModel.theme_id];
                screen.hidesBottomBarWhenPushed=YES;
                [weakSelf.navigationController pushViewController:screen animated:YES];
            }
        }else{
            BrandMakerDetailVC *vc = [BrandMakerDetailVC new];
            vc.shopItem = item;
            vc.hidesBottomBarWhenPushed=YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    //评论
    cell.commentclickBlock = ^(IntimateCircleModel *curmodel,NSIndexPath *indexpath){

        [weakSelf pushThemeVCWithModel:curmodel Comment:NO];
    };
    
    cell.imageclickBlock = ^(IntimateCircleModel *curmodel,NSIndexPath *indexpath){
        [weakSelf pushThemeVCWithModel:curmodel Comment:NO];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (self.isHome) {
            return;
        }
    }
    IntimateCircleModel *model = self.dataSource[indexPath.row];
    [self pushThemeVCWithModel:model Comment:NO];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        if (self.isHome) {
            return ZOOM6(100);
        } else {
            IntimateCircleModel *model = self.dataSource[indexPath.row];
            return [IntimateCircleCell cellHeightWithObj:model];
        }
    } else {
        IntimateCircleModel *model = self.dataSource[indexPath.row];
        return [IntimateCircleCell cellHeightWithObj:model];
    }
    return 0;
}

#pragma mark - Private Methods
- (void)reloadTableViewIndexPath:(NSIndexPath *)currIndexPath model:(IntimateCircleModel *)currModel {
    [self.dataSource replaceObjectAtIndex:currIndexPath.row withObject:currModel];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[currIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    });
}

- (void)pushShopVCWithModel:(TFShopModel *)model {
    ShopDetailViewController *detail=[[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
    detail.shop_code = model.shop_code;
    detail.stringtype = @"订单详情";
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)pushThemeVCWithModel:(IntimateCircleModel *)model Comment:(BOOL)comment
{
    if(comment)
    {
        kSelfWeak;
        [self loginSuccess:^{
            TopicDetailViewController *topic = [[TopicDetailViewController alloc]init];
            topic.hidesBottomBarWhenPushed = YES;
            comment==YES?topic.comefrom = @"列表评论":nil;
            topic.theme_id = [NSString stringWithFormat:@"%@",model.theme_id];
            [weakSelf.navigationController pushViewController:topic animated:YES];
        }];
    }else{
        TopicDetailViewController *topic = [[TopicDetailViewController alloc]init];
        topic.hidesBottomBarWhenPushed = YES;
        topic.theme_id = [NSString stringWithFormat:@"%@",model.theme_id];
        [self.navigationController pushViewController:topic animated:YES];
    }
}

#pragma mark - Getter Setter
- (void)setCustomDelegate:(id<TFSubIntimateCircleDelegate>)customDelegate {
    _customDelegate = customDelegate;
    _delegateFlags.intimateCirclePullDownRefreshWithIndex = [customDelegate respondsToSelector:@selector(intimateCirclePullDownRefreshWithIndex:)];
    _delegateFlags.intimateCircleWithScrollViewDidEndDragging = [customDelegate respondsToSelector:@selector(intimateCircleWithScrollViewDidEndDragging:willDecelerate:index:)];
    _delegateFlags.intimateCircleWithScrollViewWillBeginDragging = [customDelegate respondsToSelector:@selector(intimateCircleWithScrollViewWillBeginDragging:index:)];
    _delegateFlags.intimateCircleWithscrollViewDidEndDecelerating = [customDelegate respondsToSelector:@selector(intimateCircleWithscrollViewDidEndDecelerating:index:)];
    _delegateFlags.intimateCircleWithScrollViewWillBeginDecelerating = [customDelegate respondsToSelector:@selector(intimateCircleWithScrollViewWillBeginDecelerating:index:)];
}
- (UITableView *)tableView {
    if (_tableView != nil) {
        return _tableView;
    }
    
    CGFloat Height = kScreenHeight - Height_NavBar;
    CGFloat y = Height_NavBar;
    if ([self.name isEqualToString:@"话题广场"] || [self.name isEqualToString:@"蜜友"]) {
        Height = kScreenHeight;
        y = 0;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y, kScreen_Width, Height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.topLoadHeight = [NSNumber numberWithDouble:self.headerView_H];
    [self.view addSubview:_tableView];
    
    //***   解决iOS11刷新tableview会出现漂移的现象
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    
    kWeakSelf(self);
    [_tableView addTopHeaderWithCallback:^{
        weakself.currPage = 1;
        [weakself getData];
        
        kStrongSelf(self);
        if (self -> _delegateFlags.intimateCirclePullDownRefreshWithIndex) {
            [weakself.customDelegate intimateCirclePullDownRefreshWithIndex:(int)weakself.index];
        }
    }];
    
    [_tableView addFooterWithCallback:^{
        weakself.currPage ++;
        [weakself getData];
    }];
    _tableView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    return _tableView;
}

- (void)pullRefresh {
    
}

- (NSMutableArray *)tagsSource {
    if (_tagsSource == nil) {
        _tagsSource = [NSMutableArray array];
        
        SqliteManager *manager = [SqliteManager sharedManager];
        NSArray *array = [manager getAllForCircleTagItem];
        NSArray *sortArray = [manager sortCircleTagArrayWithSequenceFromSourceArray:array];
        [_tagsSource addObject:@"全部"];
        ShopTypeItem *cusTomItem = [[ShopTypeItem alloc] init];
        cusTomItem.name = @"全部";
        [self.tagItemsSource addObject:cusTomItem];
        for (ShopTypeItem *item in sortArray) {
            if ([item.type integerValue] == 1 && [item.is_show integerValue] == 1) {
                [_tagsSource addObject:item.name];
                [self.tagItemsSource addObject:item];
            }
        }
//        NSArray *array2 = @[@"全部", @"穿搭", @"闲置", @"明星", @"情感",
//                           @"笑话段子", @"旅行", @"穿搭", @"闲置", @"明星", @"情感",
//                           @"笑话段子", @"旅行"];
//        [_tagsSource addObjectsFromArray:array];
    }
    return _tagsSource;
}

- (NSMutableArray *)tagItemsSource {
    if (_tagItemsSource == nil) {
        _tagItemsSource = [NSMutableArray array];
    }
    return _tagItemsSource;
}

- (NSMutableArray *)dataSource {
    if (_dataSource != nil) {
        return _dataSource;
    }
    NSMutableArray *dataSource = [NSMutableArray array];
    return _dataSource = dataSource;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, kScreen_Width * 2, 0, 0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, kScreen_Width * 2, 0, 0)];
    }
}

- (void)dealloc
{
    if (self.netStatusBlock) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:netStatusNotificationCenter object:nil];
    }
    
    if (self.tableView.topShowView) {
        [self.tableView removeObserver:self.tableView forKeyPath:observerRefreshHeaderViewKeyPath context:nil];
        self.tableView = nil;
    }
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
