//
//  RecommendRemindView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/7.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "RecommendRemindView.h"
#import "CCDraggableContainer.h"
#import "DataManager.h"
#import "CustomCardView.h"
#import "GlobalTool.h"
#import "SlideRemindView.h"
#import "LastGroupRemindView.h"
#import "ShareBeautifulRemindView.h"
#import "QualificationsModel.h"
#import "RecommendLikeModel.h"
#import "ShopDislikeModel.h"
#import "RecommendModel.h"
#import "ShopLikeModel.h"
#import "ShopShareModel.h"
#import "TaskSignModel.h"
#import "MyMD5.h"
#import "ShopDetailViewController.h"
@implementation RecommendRemindView
{
    CGFloat shareimageYY ;
    
    CGFloat invitcodeYY;                           //弹框初始y坐标
    CGFloat RemindViewHeigh;                       //弹框的高度
    CGFloat RemindViewWidth;                       //弹框的宽度
    
    BOOL isLast;                                   //是否点击上一件
    BOOL isSelect;                                 //是否浏览过商品
    
    ShareBeautifulRemindView *Recommendview;       //发布分享视图
    LastGroupRemindView *lastRecommendview;        //下一组弹框
    int loadViewIndex;                             //当前视图的下标;
    int publViewIndex;
    
    
}

- (instancetype)initWithFrame:(CGRect)frame DataModel:(RecommendModel*)model
{
    if(self = [super initWithFrame:frame])
    {
        [self loadData:model];
        [DataManager sharedManager].beginYiFuRecommend = [NSDate timeIntervalSince1970WithDate];
        [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达左划右划" success:nil failure:nil];
    }
    
    return self;
}

#pragma mark ************************UI界面*************************
- (void)creatMainView
{
    RemindViewWidth = kScreenWidth;
    RemindViewHeigh = kScreenHeight-kTabBarHeight;
    
    CGFloat oringY = IS_IPHONE_X ? ZOOM6(80) : ZOOM6(50);
    //底视图
    self.RemindBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, RemindViewWidth, RemindViewHeigh)];
    self.RemindBackView.userInteractionEnabled = YES;
    self.RemindBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.RemindBackView];
    
    //不再自动弹出按钮
    self.remindbtn = [[UIButton alloc]init];
    self.remindbtn.frame = CGRectMake(ZOOM6(20), oringY, ZOOM6(300), ZOOM6(50));
    self.remindbtn.imageEdgeInsets = UIEdgeInsetsMake(0,-ZOOM(40),0.0f,ZOOM(40));
    self.remindbtn.titleEdgeInsets = UIEdgeInsetsMake(0, -ZOOM(30), 0.0f, ZOOM(30));
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDate *record = [user objectForKey:RECOMMENDSELECT];
    if([[MyMD5 compareDate:record] isEqualToString:@"今天"])
    {
        self.remindbtn.selected = YES;
    }else{
        self.remindbtn.selected = NO;
    }
    [self.remindbtn setImage:[UIImage imageNamed:@"recommend_icon_nor"] forState:UIControlStateNormal];
    [self.remindbtn setImage:[UIImage imageNamed:@"recommend_icon_cel"] forState:UIControlStateSelected];
    self.remindbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.remindbtn setTitle:@"不再自动弹出" forState:UIControlStateNormal];
    self.remindbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
    [self.remindbtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
    self.remindbtn.clipsToBounds=YES;
    [self.remindbtn addTarget:self action:@selector(remindclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.RemindBackView addSubview:self.remindbtn];
    
    //标题
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(300), oringY, CGRectGetWidth(self.RemindBackView.frame)-2*ZOOM6(300), ZOOM6(50))];
    title.font = [UIFont systemFontOfSize:ZOOM6(36)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"精选推荐";
    [self.RemindBackView addSubview:title];
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"recommend_icon_close")*1.5;
    self.canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.canclebtn.frame=CGRectMake(CGRectGetWidth(self.RemindBackView.frame)-btnwidth-ZOOM(40), oringY-ZOOM6(10), btnwidth, btnwidth);
    [self.canclebtn setImage:[UIImage imageNamed:@"recommend_icon_close"] forState:UIControlStateNormal];
    self.canclebtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.canclebtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.RemindBackView addSubview:self.canclebtn];
    
    //滑动视图
    [self loadUI];
    
    //底部按钮
    [self creatButton];
    
    self.RemindBackView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    self.RemindBackView.alpha = 0.5;
    [UIView animateWithDuration:0.5 animations:^{
        
        self.RemindBackView.transform = CGAffineTransformMakeScale(1, 1);
        self.RemindBackView.alpha = 1;
        
    } completion:^(BOOL finish) {
        
        //记录蒙层弹出时间（每天只弹一次）
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSDate *record = [user objectForKey:RECOMMENDDATE];
        
        if(![[MyMD5 compareDate:record] isEqualToString:@"今天"] || record==nil )
        {
            SlideRemindView *slideRemind = [[SlideRemindView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) Type:@"推荐"];

            [self addSubview:slideRemind];
            
            __weak SlideRemindView *sRemind = slideRemind;
            sRemind.disapperBlock = ^{
                
                NSDate *date = [NSDate date];
                [user setObject:date forKey:RECOMMENDDATE];

            };
        }
    }];
    
}
- (void)creatButton
{
    CGFloat likebtnwith = ZOOM6(150);
    CGFloat lastbtnheigh= ZOOM6(100);
    CGFloat lastbtnwith = ZOOM6(190);
    CGFloat leftspace   = ZOOM6(40);
    CGFloat btnY        = CGRectGetHeight(self.RemindBackView.frame)-ZOOM6(140);
    CGFloat modelspace  = (kScreenWidth-2*likebtnwith-2*lastbtnwith-2*leftspace)/3;
    
    for(int i = 0; i<4;i++)
    {
        UIButton *button = [[UIButton alloc]init];
        button.tag = 60000+i;
        
        if(i==0)
        {
//            button.frame = CGRectMake(leftspace, btnY+ZOOM6(10), lastbtnwith, lastbtnheigh);
//            [button setTitle:@"分享" forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:@"recommend_icon_share_dis"] forState:UIControlStateNormal];
//            button.userInteractionEnabled = NO;
//            button.layer.cornerRadius = 3;
//            self.sharebutton = button;
        }else if (i==1)
        {
            button.frame = CGRectMake((leftspace+lastbtnwith)+modelspace, btnY-ZOOM6(20), likebtnwith, likebtnwith);
            [button setImage:[UIImage imageNamed:@"recommend_icon_Dislike"] forState:UIControlStateNormal];
            self.dislikebtn = button;
        }else if (i==2)
        {
            button.frame = CGRectMake(CGRectGetMaxX(self.dislikebtn.frame)+modelspace, btnY-ZOOM6(20), likebtnwith, likebtnwith);
            [button setImage:[UIImage imageNamed:@"recommend_icon_like"] forState:UIControlStateNormal];
            self.likebutton = button;
        }else if (i==3){
            button.frame = CGRectMake(CGRectGetMaxX(self.likebutton.frame)+modelspace, btnY+ZOOM6(10), lastbtnwith, lastbtnheigh);
            [button setImage:[UIImage imageNamed:@"recommend_icon_reback_dis"] forState:UIControlStateNormal];
            button.userInteractionEnabled = NO;
            button.layer.cornerRadius = 3;
            self.lastbutton = button;
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.RemindBackView addSubview:button];
    }
}
#pragma mark 刷新分享按钮
- (void)reloadShareBtn
{
    if(self.likeArray.count)
    {
        [self.sharebutton setImage:[UIImage imageNamed:@"recommend_icon_share"] forState:UIControlStateNormal];
        
        self.sharebutton.userInteractionEnabled = YES;
    }else{
        [self.sharebutton setImage:[UIImage imageNamed:@"recommend_icon_share_dis"] forState:UIControlStateNormal];
        
        self.sharebutton.userInteractionEnabled = YES;
    }
}
#pragma mark 刷新上一件按钮
- (void)reloadLasterBtn
{
    //若当前不是第一件上一件按钮点亮
    int count = publViewIndex;
    if(count != 0 && count<_dataArray.count)
    {
        [self.lastbutton setImage:[UIImage imageNamed:@"recommend_icon_reback"] forState:UIControlStateNormal];
        
        self.lastbutton.userInteractionEnabled = YES;
    }else{
        [self.lastbutton setImage:[UIImage imageNamed:@"recommend_icon_reback_dis"] forState:UIControlStateNormal];
        self.lastbutton.userInteractionEnabled = NO;
    }
}
#pragma mark 刷新主界面
- (void)reloadCardView:(NSString*)islike cardView:(CCDraggableCardView *)panGesturecardView
{
//    int count = loadViewIndex==0?0:loadViewIndex-1;
//    RecommendLikeModel *model1 = _dataSources[count];
//    model1.is_like = islike;
    
    CustomCardView *cardView = (CustomCardView*)panGesturecardView;
    int count = publViewIndex<0?0:publViewIndex;
    RecommendLikeModel *model1 = _dataArray[count];
    model1.is_like = islike;

    //新加的最爱存储到本地
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *likearr = [user objectForKey:@"user_like"];

    if([islike isEqualToString:@"喜欢"])
    {
        NSMutableArray *newlikearr = [NSMutableArray arrayWithArray:likearr];
        if(![newlikearr containsObject:model1.shop_code])
        {
            [newlikearr addObject:model1.shop_code];
        }
        [user setObject:newlikearr forKey:@"user_like"];

        cardView.markImageview.image = [UIImage imageNamed:@"recommend_icon_like_01"];
        
    }else{
    
        NSMutableArray *newlikearr = [NSMutableArray arrayWithArray:likearr];
        [newlikearr removeObject:model1.shop_code];
        [user setObject:newlikearr forKey:@"user_like"];
        
        cardView.markImageview.image = [UIImage imageNamed:@"recommend_icon_dislike_01"];
        
        //如果有相同元素删除
        if(![self.likeArray containsObject:model1.shop_code])
        {
            [self.likeArray removeObject:model1.shop_code];
        }
    }
    
    //如果有相同元素不加
    if(![self.dislikeArray containsObject:model1.shop_code])
    {
        [self.dislikeArray addObject:model1.shop_code];
        [[NSUserDefaults standardUserDefaults]setObject:self.dislikeArray forKey:RECOMMENDBROWSEDATA];
    }
    
    [self signHttp];
}
#pragma mark 不再自动提示按钮
- (void)remindclick:(UIButton*)sender
{
    NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
    sender.selected = !sender.selected;
    if(sender.selected)
    {
        NSDate *date = [NSDate date];
        [userdefaul setObject:date forKey:RECOMMENDSELECT];
    }else{
        
        [userdefaul removeObjectForKey:RECOMMENDSELECT];
    }
}
#pragma mark 关闭弹框
- (void)cancleClick
{
    if(self.likeArray.count)
    {
        [QualificationsModel getQualificationsSuccess:^(id data) {
            QualificationsModel *model = data;
            if(model.status == 1 && model.send_allow == 1 && self.likeArray.count)
            {
                [self ShareRecommendPopMindView:NO];
            }else{
                //将不喜欢的商品返回后台
                [self disLikeHttp];
                [self remindViewHiden];
            }
        }];
    }else{
        //将不喜欢的商品返回后台
        [self disLikeHttp];
        [self remindViewHiden];
    }
}
#pragma mark 弹框消失
- (void)remindViewHiden
{
//    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
    [UIView animateWithDuration:0.5 animations:^{
        
        self.RemindBackView.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        self.RemindBackView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.RemindBackView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
    }];
    
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出左划右划" success:nil failure:nil];
    [self httpUseAppTimeInterval];
}
#pragma makr 分享 不喜欢 喜欢 上一件
- (void)buttonClick:(UIButton*)sender
{
    if(sender.tag == 60000)//分享
    {
        [self ShareRecommendPopMindView:YES];
        
    }else if (sender.tag == 60001)//不喜欢
    {
        self.dislikebtn.userInteractionEnabled = NO;
        [self.container removeFormDirection:CCDraggableDirectionLeft];
        [self performSelector:@selector(dislike) withObject:nil afterDelay:0.5];
    }else if (sender.tag == 60002)//喜欢
    {
        self.likebutton.userInteractionEnabled = NO;
        [self.container removeFormDirection:CCDraggableDirectionRight];
        [self performSelector:@selector(like) withObject:nil afterDelay:0.5];
    }else if (sender.tag == 60003)//上一件
    {
        if(self.container)
        {
            isLast = YES;
            [_dataSources removeAllObjects];
            [_dataSources addObjectsFromArray:_dataArray];
            
            int count = (publViewIndex>=1)?publViewIndex:loadViewIndex;
            [_dataSources removeObjectsInRange:NSMakeRange(0, count-1)];
            
            [self.container reloadData];
           
            loadViewIndex --;
            publViewIndex --;
        }
    }
    [self reloadLasterBtn];
}

- (void)dislike
{
     self.dislikebtn.userInteractionEnabled = YES;
}
- (void)like
{
    self.likebutton.userInteractionEnabled = YES;
}

#pragma mark 浏览完毕
- (void)setRecommendPopMindView:(recommendType)type last:(void(^)())success
{
    if(!lastRecommendview)
    {
        lastRecommendview = [[LastGroupRemindView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) Type:type];
        lastRecommendview.tag = 888666;
        ESWeakSelf;
        lastRecommendview.myfaviourtBlock = ^{
            if(type == recommend_lastgroup)//下一组
            {
                if(success)
                {
                    success();
                }
                
            }else{//我的喜欢
                Mtarbar.selectedIndex=3;
                Mtarbar.navigationController.hidesBottomBarWhenPushed = NO;
                
                [__weakSelf remindViewHiden];
            }
            lastRecommendview =nil;
        };
        lastRecommendview.cancleBlock = ^{
            if(type == recommend_lastgroup)//下一组
            {
                [__weakSelf cancleClick];
            }else{
                //将不喜欢的商品返回后台
                [__weakSelf disLikeHttp];
                [__weakSelf remindViewHiden];
            }
            lastRecommendview =nil;
        };
        lastRecommendview.dismissBlock = ^{
            
            if(type == recommend_lastgroup)//我的喜欢
            {
                Mtarbar.selectedIndex=3;
                Mtarbar.navigationController.hidesBottomBarWhenPushed = NO;
            }else{//取消
                //将不喜欢的商品返回后台
                [__weakSelf disLikeHttp];
            }
            
            [__weakSelf remindViewHiden];
            lastRecommendview =nil;
        };
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:lastRecommendview];
    }
}

#pragma mark 分享精选推荐商品
- (void)ShareRecommendPopMindView:(BOOL)hide
{
    if(!Recommendview)
    {
        [RecommendModel getShareData:^(id data) {
        RecommendModel *model = data;
        if(model.status == 1 && model.list.count)
        {
            NSMutableArray *photos = [NSMutableArray array];
            if(model.list.count > 9)
            {
                int count = (int)model.list.count;
                for(int i = count-1;i>=count-9;i--)
                {
                    [photos addObject:model.list[i]];
                }
            }else{
                [photos addObjectsFromArray:model.list];
            }
            
            Recommendview = [[ShareBeautifulRemindView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) Photos:photos exitBtnHide:hide];
            ESWeakSelf;
            Recommendview.addImageBlock = ^(NSArray*photos){
                if(__weakSelf.addImageBlock)
                {
                    __weakSelf.addImageBlock(photos);
                }
            };
            Recommendview.exitBlock = ^{
                //将不喜欢的商品返回后台
                [__weakSelf disLikeHttp];
                
                [__weakSelf remindViewHiden];
                Recommendview =nil;
            };
            Recommendview.cancleBlock = ^{
                
                //将不喜欢的商品返回后台
                [__weakSelf disLikeHttp];
                [__weakSelf remindViewHiden];
                Recommendview =nil;
            };
            [self addSubview:Recommendview];
            
        }else{
            //将不喜欢的商品返回后台
            [self disLikeHttp];
            
            [self remindViewHiden];
        }
        
    }];
    }
}
- (void)refreshView:(NSArray *)images
{
    [Recommendview refreshView:images];
}

#pragma mark ************************网络数据***********************
- (void)signHttp
{
    NSString *index_id = [Signmanager SignManarer].recommend_indexid;
    NSString *day = [Signmanager SignManarer].recommend_day;
    BOOL isFinish = [DataManager sharedManager].isFinishRecommendTask;
    
    if(index_id && day && isFinish)
    {
        [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
            TaskSignModel *model = data;
            if(model.status == 1)
            {
                [Signmanager SignManarer].recommend_indexid = nil;
                [Signmanager SignManarer].recommend_day = nil;
                [DataManager sharedManager].isFinishRecommendTask = NO;
                
                if(self.RemindFinishBlock)
                {
                    self.RemindFinishBlock();
                }
//                [MBProgressHUD show:@"精选推荐任务完成！" icon:nil view:self];
            }
        }];
    }
}
- (void)loadData:(RecommendModel*)model {
    _dataSources = [NSMutableArray array];
    _dataArray   = [NSMutableArray array];
    
    if(model.status == 1 && model.likes.count)
    {
        self.totalPage = model.pageCount;
        self.currentPage = 1;
        
        [_dataSources addObjectsFromArray:model.likes];
        [_dataArray addObjectsFromArray:model.likes];
        
        [self creatMainView];
    }else{
        if(self.likeDataBlock)
        {
            self.likeDataBlock(@"没有精选推荐商品喔~");
        }
        [self removeFromSuperview];
    }
    
}

//删除浏览的商品
- (void)disLikeHttp
{
    if(self.dislikeArray.count)
    {
        //将不喜欢的商品返回后台
        NSString *shopcodes = [self.dislikeArray componentsJoinedByString:@","];
        [ShopDislikeModel getShopDisLike:shopcodes Success:^(id data) {
            
            ShopDislikeModel *model = data;
            if(model.status == 1)
            {
                MyLog(@"删除成功");
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:RECOMMENDBROWSEDATA];
            }
        }];
    }
}
//喜欢
- (void)LikeHttp
{
//    int count = loadViewIndex==0?0:loadViewIndex-1;
    int count = publViewIndex>0?(publViewIndex-1):(int)(self.dataArray.count-1);
    if(count >= _dataArray.count)
    {
        return;
    }
    RecommendLikeModel *model1 = _dataArray[count];
    
    [ShopLikeModel getShopLike:model1.shop_code Success:^(id data) {
        ShopLikeModel *model = data;
        if(model.status == 1)
        {
            //如果有相同元素不加
            if(![self.likeArray containsObject:model1.shop_code])
            {
                [self.likeArray addObject:model1.shop_code];
            }
        }
    }];
}
//取消喜欢
- (void)cancleLikeHttp
{
//    int count = loadViewIndex==0?0:loadViewIndex-1;
    int count = publViewIndex>0?(publViewIndex-1):(int)(self.dataArray.count-1);
    if(count >= _dataArray.count)
    {
        return;
    }
    RecommendLikeModel *model1 = _dataArray[count];
    
    [ShopLikeModel getShopDisLike:model1.shop_code Success:^(id data) {
        ShopLikeModel *model = data;
        if(model.status == 1)
        {
            
        }
    }];
}

/**
 App 左滑右滑停留时长
 */
- (void)httpUseAppTimeInterval
{
    NSTimeInterval currTimeInterval = [NSDate timeIntervalSince1970WithDate];
    NSTimeInterval diffTimeInterval = ABS(currTimeInterval- [[DataManager sharedManager] beginYiFuRecommend])/1000;
    NSDictionary *parameter = @{@"type": @"1002",
                                @"timer": [NSNumber numberWithDouble:(int)diffTimeInterval],
                                @"version":VERSION};
    
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:kApi_apptimeRecord parameter:parameter caches:NO cachesTimeInterval:0*TFSecond token:YES success:^(id data, Response *response) {
        
        MyLog(@"data: %@", data);
        
    } failure:^(NSError *error) {
        MyLog(@"error: %@", error);
        
    }];
}

#pragma mark ************************左滑右滑视图***********************
- (void)loadUI {
    
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.canclebtn.frame),CGRectGetWidth(self.RemindBackView.frame), CGRectGetHeight(self.RemindBackView.frame)-2*(CGRectGetMaxY(self.canclebtn.frame))+ZOOM6(50)) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    [self.RemindBackView addSubview:self.container];
    [self.container reloadData];
}
#pragma mark - CCDraggableContainer DataSource
- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    CustomCardView *cardView = [[CustomCardView alloc] initWithFrame:draggableContainer.bounds];
    [cardView installData:[_dataSources objectAtIndex:index]];
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate
- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == CCDraggableDirectionLeft) {

        self.dislikebtn.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
        
        self.likebutton.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

//点击手势
- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
    RecommendLikeModel *model = _dataSources[didSelectIndex];
    if(self.didselectShopBlock)
    {
        self.didselectShopBlock(model.shop_code);
    }
}

//滑动手势
- (void)panGesturedraggaChangebleContainer:(CCDraggableContainer *)panGesturedraggableContainer
                                  cardView:(CCDraggableCardView *)panGesturecardView
                            didSelectIndex:(NSInteger)panGesturedidSelectIndex;
{
    loadViewIndex = (int)panGesturedidSelectIndex+1==_dataArray.count?(int)_dataArray.count:(int)panGesturedidSelectIndex+1;
    
    if(panGesturedraggableContainer.direction == CCDraggableDirectionLeft)
    {
        [self reloadCardView:@"不喜欢" cardView:panGesturecardView];
    }else if(panGesturedraggableContainer.direction == CCDraggableDirectionRight)
    {
        [self reloadCardView:@"喜欢" cardView:panGesturecardView];
    }
}
//滑动手势结束
- (void)panGesturedraggableContainer:(CCDraggableContainer *)panGesturedraggableContainer
                            cardView:(CCDraggableCardView *)panGesturecardView
                      didSelectIndex:(NSInteger)panGesturedidSelectIndex
{
    if(panGesturedidSelectIndex == 0)
    {
        if(publViewIndex <= 0 )
        {
            publViewIndex = 1;
        }
        else{
            publViewIndex += 1;
        }
    }else{
        publViewIndex += 1;
    }

    loadViewIndex = (int)panGesturedidSelectIndex+1==_dataArray.count?(int)_dataArray.count:(int)panGesturedidSelectIndex+1;
    
    isLast = NO;
    if(panGesturedidSelectIndex+1 <= _dataArray.count-1)
    {
        [self.allCrads removeAllObjects];
        [self.allCrads addObjectsFromArray:panGesturedraggableContainer.allCards];
    }
    
    if(panGesturedraggableContainer.direction == CCDraggableDirectionLeft)
    {
        [self cancleLikeHttp];
    }else if(panGesturedraggableContainer.direction == CCDraggableDirectionRight)
    {
        [self LikeHttp];
    }

    [self reloadLasterBtn];
}

//一组商品浏览完毕
- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    
    loadViewIndex = 0;
    self.lastbutton.userInteractionEnabled = NO;
    
    if(isLast==NO )
    {
        if(self.currentPage+1>self.totalPage)
        {
            [QualificationsModel getQualificationsSuccess:^(id data) {
                QualificationsModel *model = data;
                if(model.status == 1 && model.send_allow == 1 && self.likeArray.count)
                {
                    [self ShareRecommendPopMindView:YES];
                }else{
                    [self setRecommendPopMindView:reccomend_finish last:^{
                    
                    }];
                }
            }];
    
            //记录浏览完时间
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSDate *date = [NSDate date];
            [user setObject:date forKey:FINISHRECOMMENDPOPDATE];
            if(self.FinishbrowseBlock)
            {
                self.FinishbrowseBlock();
            }
        }else{
            
            publViewIndex = -1;
            
            ESWeak_(self)
            //下一组
            [self setRecommendPopMindView:recommend_lastgroup last:^{
                
                NSInteger page = self.currentPage+1>self.totalPage?1:self.currentPage+1;
                [RecommendModel getLikeData:page Success:^(id data) {
                    RecommendModel *model = data;
                    if(model.status == 1 && model.likes.count)
                    {
                        [weak_self.dataSources removeAllObjects];
                        [weak_self.dataArray removeAllObjects];
                        
                        [weak_self.dataSources addObjectsFromArray:model.likes];
                        [weak_self.dataArray addObjectsFromArray:model.likes];
                        
                        weak_self.totalPage = model.pageCount;
                        weak_self.currentPage++;
                        
                        [draggableContainer reloadData];
                        
                        [weak_self reloadLasterBtn];
                    }else{
                        
                        [weak_self setRecommendPopMindView:reccomend_finish last:^{
                        }];

                        [MBProgressHUD show:model.message icon:nil view:weak_self];
                    }
                }];

            }];
            
        }

       
        [self disLikeHttp];
    }
}

- (NSMutableArray*)likeArray
{
    if(_likeArray == nil)
    {
        _likeArray = [NSMutableArray array];
    }
    return _likeArray;
}
- (NSMutableArray*)dislikeArray
{
    if(_dislikeArray == nil)
    {
        _dislikeArray = [NSMutableArray array];
    }
    
    return _dislikeArray;
}
- (NSMutableArray*)allCrads
{
    if(_allCrads == nil)
    {
        _allCrads = [NSMutableArray array];
    }
    return _allCrads;
}
@end
