//
//  RecommendRemindView.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/7.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "RecommendRemindView.h"
#import "CCDraggableContainer.h"
#import "CustomCardView.h"
#import "GlobalTool.h"
#import "SlideRemindView.h"
#import "LastGroupRemindView.h"
#import "ShareBeautifulRemindView.h"
#import "RecommendLikeModel.h"
#import "ShopDislikeModel.h"
#import "RecommendModel.h"
#import "ShopLikeModel.h"
#import "MyMD5.h"

@implementation RecommendRemindView
{
    CGFloat shareimageYY ;
    
    CGFloat invitcodeYY;                           //弹框初始y坐标
    CGFloat RemindViewHeigh;                       //弹框的高度
    CGFloat RemindViewWidth;                       //弹框的宽度
    
    BOOL isLast;                                   //是否点击上一件
    
    ShareBeautifulRemindView *Recommendview;       //发布分享视图
    int loadViewIndex;                             //当前视图的下标;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
        
        [self loadData:1];
//        [self creatMainView];
    }
    
    return self;
}

#pragma mark ************************UI界面*************************
- (void)creatMainView
{
    RemindViewWidth = kScreenWidth;
    RemindViewHeigh = kScreenHeight-49;
    
    //底视图
    self.RemindBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, RemindViewWidth, RemindViewHeigh)];
    self.RemindBackView.userInteractionEnabled = YES;
    self.RemindBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.RemindBackView];
    
    //不再自动弹出按钮
    self.remindbtn = [[UIButton alloc]init];
    self.remindbtn.frame = CGRectMake(ZOOM6(20), ZOOM6(50), ZOOM6(300), ZOOM6(50));
    self.remindbtn.imageEdgeInsets = UIEdgeInsetsMake(0,-ZOOM(40),0.0f,ZOOM(40));
    self.remindbtn.titleEdgeInsets = UIEdgeInsetsMake(0, -ZOOM(30), 0.0f, ZOOM(30));
    [self.remindbtn setImage:[UIImage imageNamed:@"recommend_icon_nor"] forState:UIControlStateNormal];
    [self.remindbtn setImage:[UIImage imageNamed:@"recommend_icon_cel"] forState:UIControlStateSelected];
    self.remindbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.remindbtn setTitle:@"不再自动弹出" forState:UIControlStateNormal];
    self.remindbtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(28)];
    [self.remindbtn setTitleColor:kMainTitleColor forState:UIControlStateNormal];
    self.remindbtn.clipsToBounds=YES;
    self.remindbtn.selected=NO;
    [self.remindbtn addTarget:self action:@selector(remindclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.RemindBackView addSubview:self.remindbtn];
    
    //标题
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(300), ZOOM6(50), CGRectGetWidth(self.RemindBackView.frame)-2*ZOOM6(300), ZOOM6(50))];
    title.font = [UIFont systemFontOfSize:ZOOM6(36)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"精选推荐";
    [self.RemindBackView addSubview:title];
    
    //关闭按钮
    CGFloat btnwidth = IMGSIZEW(@"recommend_icon_close")*1.5;
    self.canclebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.canclebtn.frame=CGRectMake(CGRectGetWidth(self.RemindBackView.frame)-btnwidth-ZOOM(40), ZOOM6(40), btnwidth, btnwidth);
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
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:slideRemind];
            
            __weak SlideRemindView *sRemind = slideRemind;
            sRemind.disapperBlock = ^{
                
                NSDate *date = [NSDate date];
                [user setObject:date forKey:RECOMMENDDATE];
                [sRemind remindViewHiden];
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
        }else{
            button.frame = CGRectMake(CGRectGetMaxX(self.likebutton.frame)+modelspace, btnY+ZOOM6(10), lastbtnwith, lastbtnheigh);
            [button setTitle:@"上一件" forState:UIControlStateNormal];
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
    //是否有喜欢的商品若有分享按钮点亮
    BOOL likecount = NO;
    for (int i =0; i<_dataSources.count; i++) {
        
        RecommendLikeModel *model = _dataSources[i];
        if([model.is_like isEqualToString:@"喜欢"])
        {
            likecount = YES;
            break;
        }
    }
    if(likecount==YES)
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
    int count = loadViewIndex;
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
- (void)reloadCardView:(NSString*)islike
{
    int count = loadViewIndex;
    CustomCardView *cardView = self.container.allCards[count];
    
    RecommendLikeModel *model1 = _dataSources[count];
    model1.is_like = islike;
    
    RecommendLikeModel *model2 = _dataArray[count];
    model2.is_like = islike;

    if([islike isEqualToString:@"喜欢"])
    {
        cardView.markImageview.image = [UIImage imageNamed:@"recommend_icon_like_01"];
        [self.container removeFormDirection:CCDraggableDirectionRight];
        
        model1.shop_code?[self.dislikeArray removeObject:model1.shop_code]:nil;
        
        [self LikeHttp];
    }else{
    
        cardView.markImageview.image = [UIImage imageNamed:@"recommend_icon_dislike_01"];
        [self.container removeFormDirection:CCDraggableDirectionLeft];
        
        model1.shop_code?[self.dislikeArray addObject:model1.shop_code]:nil;
    }
    
}
#pragma mark 不再自动提示按钮
- (void)remindclick:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if(sender.selected)
    {
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        [userdefaul setBool:YES forKey:RECOMMENDSELECT];
    }
}
#pragma mark 关闭弹框
- (void)cancleClick
{
    for(int i =0;i<_dataSources.count;i++)
    {
        RecommendLikeModel *model = _dataSources[i];
        if([model.is_like isEqualToString:@"喜欢"])
        {
            [self ShareRecommendPopMindView:NO];
            return;
        }
    }
    //将不喜欢的商品返回后台
    [self disLikeHttp];
    
    [self remindViewHiden];
}
#pragma mark 弹框消失
- (void)remindViewHiden
{
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
    [UIView animateWithDuration:0.5 animations:^{
        
        self.RemindBackView.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
        self.RemindBackView.transform = CGAffineTransformMakeScale(0.25, 0.25);
        self.RemindBackView.alpha = 0;
        
    } completion:^(BOOL finish) {
        
        [self removeFromSuperview];
    }];
    
}
#pragma makr 分享 不喜欢 喜欢 上一件
- (void)buttonClick:(UIButton*)sender
{
    if(sender.tag == 60000)//分享
    {
        [self ShareRecommendPopMindView:YES];
        
    }else if (sender.tag == 60001)//不喜欢
    {
        [self reloadCardView:@"不喜欢"];
    }else if (sender.tag == 60002)//喜欢
    {
        [self reloadCardView:@"喜欢"];//测试用后面删除
        
    }else if (sender.tag == 60003)//上一件
    {
        if(self.container)
        {
            isLast = YES;
            [_dataSources removeAllObjects];
            [_dataSources addObjectsFromArray:_dataArray];
            
            int count = loadViewIndex;
            [_dataSources removeObjectsInRange:NSMakeRange(0, count-1)];
            [self.container reloadData];
            loadViewIndex --;
        }
    }
    
    [self reloadLasterBtn];
}
#pragma mark 下一组精选推荐商品
- (void)setRecommendPopMindView
{
    LastGroupRemindView *lastRecommendview = [[LastGroupRemindView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    lastRecommendview.myfaviourtBlock = ^{
        [self remindViewHiden];
        Mtarbar.selectedIndex=0;
    };
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:lastRecommendview];
}

#pragma mark 分享精选推荐商品
- (void)ShareRecommendPopMindView:(BOOL)hide
{
    for(int i =0;i<_dataSources.count;i++)
    {
        RecommendLikeModel *model = _dataSources[i];
        if([model.is_like isEqualToString:@"喜欢"])
        {
            [self.likeArray addObject:model];
        }
    }
    Recommendview = [[ShareBeautifulRemindView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) Photos:self.likeArray exitBtnHide:hide];
    ESWeakSelf;
    Recommendview.addImageBlock = ^{
        if(__weakSelf.addImageBlock)
        {
            __weakSelf.addImageBlock();
        }
    };
    Recommendview.exitBlock = ^{
        [__weakSelf remindViewHiden];
    };
    [self addSubview:Recommendview];
    
}
- (void)refreshView:(NSArray *)images
{
    [Recommendview refreshView:images];
}

#pragma mark ************************网络数据***********************
- (void)loadData:(NSInteger)currentpage {
    _dataSources = [NSMutableArray array];
    _dataArray   = [NSMutableArray array];
    
    [RecommendModel getLikeData:currentpage Success:^(id data) {
        RecommendModel *model = data;
        if(model.status == 1)
        {
            self.totalPage = model.pageCount=2;
            self.currentPage = currentpage;
            
            [_dataSources addObjectsFromArray:model.likes];
            [_dataArray addObjectsFromArray:model.likes];
            
            [self creatMainView];
        }
    }];
}
//不喜欢
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
                
            }
        }];
    }
}
//喜欢
- (void)LikeHttp
{
    int count = loadViewIndex;
    RecommendLikeModel *model = _dataSources[count];
    
    [ShopLikeModel getShopLike:model.shop_code Success:^(id data) {
        ShopLikeModel *model = data;
        if(model.status == 1)
        {

        }
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
}

//滑动手势结束
- (void)panGesturedraggableContainer:(CCDraggableContainer *)panGesturedraggableContainer
                            cardView:(CCDraggableCardView *)panGesturecardView
                      didSelectIndex:(NSInteger)panGesturedidSelectIndex
{
    loadViewIndex = (int)panGesturedidSelectIndex+1==_dataArray.count?0:(int)panGesturedidSelectIndex+1;
    isLast = NO;
    if(panGesturedidSelectIndex+1 <= _dataArray.count-1)
    {
        [self.allCrads removeAllObjects];
        [self.allCrads addObjectsFromArray:panGesturedraggableContainer.allCards];
    }
    
    RecommendLikeModel *model1 = _dataSources[panGesturedidSelectIndex];
    RecommendLikeModel *model2 = _dataArray[panGesturedidSelectIndex];
    if(panGesturedraggableContainer.direction == CCDraggableDirectionLeft)
    {
        model1.is_like = @"不喜欢";
        
//        [self.sharebutton setImage:[UIImage imageNamed:@"recommend_icon_share_dis"] forState:UIControlStateNormal];
//        
//        self.sharebutton.userInteractionEnabled = NO;
    }else if(panGesturedraggableContainer.direction == CCDraggableDirectionRight)
    {
        model2.is_like = @"喜欢";
        [self LikeHttp];
        
//        [self.sharebutton setImage:[UIImage imageNamed:@"recommend_icon_share"] forState:UIControlStateNormal];
//        self.sharebutton.userInteractionEnabled = YES;
    }
    
    [self reloadLasterBtn];
}

//一组商品浏览完毕
- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    
    loadViewIndex = 0;
    self.lastbutton.userInteractionEnabled = NO;
    
    if(isLast==NO)
    {
        if(self.currentPage+1>self.totalPage)
        {
            [self ShareRecommendPopMindView:YES];
        }

        NSInteger page = self.currentPage+1>self.totalPage?1:self.currentPage+1;
        [RecommendModel getLikeData:page Success:^(id data) {
            RecommendModel *model = data;
            if(model.status == 1)
            {
                [_dataSources removeAllObjects];
                [_dataArray removeAllObjects];

                [_dataSources addObjectsFromArray:model.likes];
                [_dataArray addObjectsFromArray:model.likes];
    
                self.currentPage++;
                
                [draggableContainer reloadData];
            }
        }];

    }
    [self disLikeHttp];
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
