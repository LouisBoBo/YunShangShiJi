//
//  TopicDetailViewController.m
//  TestStickHeader
//
//  Created by ios-1 on 2017/2/15.
//  Copyright © 2017年 liqi. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "StickyHeaderFlowLayout.h"
#import "HeaderReusableView.h"
#import "BigImageCollectionViewCell.h"
#import "CommendCollectionViewCell.h"
#import "CommentCollectionViewCell.h"
#import "RemenComtCollectionViewCell.h"
#import "CollectionHeaderView.h"
#import "InvitationViewController.h"
#import "ShopDetailViewController.h"
#import "TFSubIntimateCircleVC.h"
#import "HotTopicCollectionViewCell.h"
#import "CommentCollectionViewController.h"

#import "MBProgressHUD.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "TopicReportView.h"
#import "TopheaderView.h"
#import "TopfooterView.h"
#import "TopselectView.h"
#import "SecondHeadView.h"
#import "PopoverView.h"
#import "TopicShareview.h"
#import "TopicSofaView.h"
#import "GlobalTool.h"
#import "FinishTaskPopview.h"
#import "NavgationbarView.h"

#import "TopicPublicModel.h"
#import "TopicReplyModel.h"
#import "TopicviewModel.h"
#import "TopicTagsModel.h"
#import "ReportModel.h"
#import "ShareModel.h"
#import "TaskSignModel.h"
#import "IntimateCircleModel.h"

#import "TopicdetailsModel.h"
#import "LastCommentsModel.h"
#import "Relatedrecommended.h"
#import "LreplistModel.h"

#import "BrandMakerDetailVC.h"
#import "XRWaterfallLayout.h"
#import "MoreCommendViewController.h"
#import "HotOutfitViewController.h"
#import "TagImageCollectionViewCell.h"
#import "CommentsViewController.h"
#import "HXTagsView.h"
#import "JRWaterFallLayout.h"
#import "CustomCollectionViewLayout.h"
#import "MakeMoneyViewController.h"
#import "WXApi.h"
@interface TopicDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,PopoverViewDelegate,CelldidselectDelegate,CustomCollectionViewLayoutDelegate,WXApiDelegate,MiniShareManagerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TopfooterView *topfooterView;
@property (nonatomic, strong) CustomCollectionViewLayout *jrLayout;
@end

static NSString *kPagingCellIdentifier            = @"kPagingCellIdentifier";
@implementation TopicDetailViewController
{
    TopicdetailsModel *detailmodel;   //详情数据
    TopselectView *selectview;        //sectionview
    NSInteger _pubIndex;              //sectiontag
    NSInteger _currentItem;           //当前行
    NSInteger _cellCount;             //有多少行
    NSInteger _imageCellCount;        //section=0 时有多少行
    NSIndexPath *_currentPath;
    FaceBoard *faceBoard;
    
    LreplistModel *replistmodel;      //评论内回复的对象
    BOOL is_reply;                    //是否是评论内回复
    BOOL is_fresh;                    //是否是刷新
    BOOL is_finshtfresh;              //是否完成加载
    
    CGFloat _footViewHeigh;           //foot的高度
    CGFloat _collectionViehHeigh;     //collectionview高度
    CGFloat _firstImageViewHeigh;     //第一张大图的高度
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    _pubIndex = 0;
    _currPage = 1;
    _recommentPage = 1;
    _currentItem = 999999;
    
    [self creatNavagationbar];
    [self.view addSubview:self.collectionView];
    [self creatKeyboardView];
    
    [self loadData:NO];
    [self recommendHttp];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!faceBoard) {
        faceBoard = [[FaceBoard alloc] init];
        faceBoard.delegate = self;
        faceBoard.inputTextView = self.textview;
    }
    
    if([self.comefrom isEqualToString:@"列表评论"])
    {
        [self.textview becomeFirstResponder];
        self.comefrom = nil;
    }else if ([self.comefrom isEqualToString:@"穿搭任务"]){
        [self creatSlideView];
    }
    
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"到达帖子页" success:nil failure:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [TFStatisticsClickVM StatisticshandleDataWithClickType:@"跳出帖子页" success:nil failure:nil];
}


- (void)creatNavagationbar
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
    titlelable.text=@"详情";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
    UIButton *ReportBtn =[[UIButton alloc]init];
    ReportBtn.frame=CGRectMake(kApplicationWidth-ZOOM6(100), 23, ZOOM6(100), 40);
    ReportBtn.centerY = View_CenterY(self.tabheadview);
    ReportBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [ReportBtn setImage:[UIImage imageNamed:@"liaotianchuangkou_gengduo_icon"] forState:UIControlStateNormal];
    
    [ReportBtn addTarget:self action:@selector(report:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:ReportBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
}

#pragma mark 屏蔽 举报
- (void)report:(UIButton*)sender
{
    ESWeakSelf;
    [self loginSuccess:^{
        
        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        backview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        backview.userInteractionEnabled = YES;
        [__weakSelf.view addSubview:backview];
        
        backview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [UIView animateWithDuration:0.2 animations:^{
            
            backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0.5];
            
        } completion:^(BOOL finish) {
            
            NSArray *arr = @[@"举报该用户",@"取消"];
            CGPoint point = CGPointMake(kApplicationWidth-25, Height_NavBar);
            
            PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:arr images:nil withSceenWith:kScreenWidth popWith:110 cellTextFont:0];
            pop.clipsToBounds=YES;
            pop.tag=8888;
            pop.delegate = __weakSelf;
            [pop show];
            
            pop.dismissblock = ^{
                [UIView animateWithDuration:0.2 animations:^{
                    
                    backview.backgroundColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0] colorWithAlphaComponent:0];
                    
                } completion:^(BOOL finish) {
                    
                    [backview removeFromSuperview];
                }];
                
            };
            
        }];
        
    }];
}

#pragma mark *********************网络数据************************
- (void)loadData:(BOOL)ischange;
{
    [self.remenComments removeAllObjects];
    [self.newestComments removeAllObjects];
    [self.relatedrecommended removeAllObjects];
    
    [NSObject baseURLStr];
    //详情
    kSelfWeak;
    [TopicviewModel getDataTheme_id:(NSString*)weakSelf.theme_id Success:^(id data) {
        
        [weakSelf.collectionView headerEndRefreshing];
        [weakSelf.collectionView ffRefreshHeaderEndRefreshing];
        
        TopicviewModel *model = data;
        if(model.status == 1)
        {
            detailmodel = model.data;
            
            detailmodel.hot_comments.count?[weakSelf chareModel:detailmodel.hot_comments Type:1]:nil;
            detailmodel.related_recommended.count?[weakSelf.relatedrecommended addObjectsFromArray:detailmodel.related_recommended]:nil;
            
        }else{
            [MBProgressHUD show:model.message icon:nil view:weakSelf.view];
        }
        
        if(_pubIndex == 0)
        {
            [weakSelf newestComentData];//最新评论
        }else{
            [weakSelf LandlordHttp];//只看楼主
        }
        
    }];
    
}
//最新评论
- (void)newestComentData
{
    kSelfWeak;
    [TopicPublicModel LastComments:(NSString*)weakSelf.theme_id Page:weakSelf.currPage Pagesize:10 Success:^(id data) {
        TopicPublicModel *model = data;
        if(model.status == 1 && model.list.count)
        {
            weakSelf.currPage ++;
            weakSelf.alltotalPage = [model.pager[@"pageCount"] integerValue];
            [weakSelf chareModel:model.list Type:2];
            [weakSelf.collectionView reloadData];
        }else{
            [weakSelf.collectionView reloadData];
        }
    }];
    
}
//1热门评论 2最新评论
- (void)chareModel:(NSArray*)dataArray Type:(NSInteger)type
{
    for(int i =0 ;i<dataArray.count;i++)
    {
        CGFloat headHeigh =0;
        CGFloat cellHeigh =0;
        LastCommentsModel *commentModel = dataArray[i];
        
        //head
        headHeigh = [self getRowHeight:commentModel.content fontSize:ZOOM6(34)];
        
        //cell
        //        int count = commentModel.replies_list.count >4?4:(int)commentModel.replies_list.count;
        for(int j =0;j<commentModel.replies_list.count;j++)
        {
            LreplistModel *replymodel = commentModel.replies_list[j];
            CGFloat H = [self getRowHeight:replymodel.content fontSize:ZOOM6(34)];
            //            CGFloat H = ZOOM6(50);
            replymodel.cellheigh = H;
            cellHeigh +=H;
        }
        commentModel.replyCellHeigh = cellHeigh;
        commentModel.replyHeadHeigh = headHeigh;
        
//        type==1?[self.remenComments addObject:commentModel]:[self.newestComments addObject:commentModel];
        if(type == 1)
        {
            [self.remenComments addObject:commentModel];
        }else{
            NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
            if(commentModel.status.intValue==0 || (commentModel.status.intValue == 1 && user_id.intValue == commentModel.user_id.intValue))
            {
                [self.newestComments addObject:commentModel];
            }
        }
    }
    
}

// 点赞
- (void)fabulousHttp:(NSUInteger)fabulousNum
{
    __weak TopselectView *fabulousview = selectview;

    [self loginSuccess:^{
        if(fabulousview.fabulousBtn.selected)//取消点赞
        {
            [TopicPublicModel DisThumbstData:1 This_id:detailmodel.post_details.theme_id Theme_id:detailmodel.post_details.theme_id Success:^(id data) {
                TopicPublicModel *model = data;
                if(model.status == 1)
                {
                    selectview.fabulousBtn.selected = !selectview.fabulousBtn.selected;
                    
                    if(fabulousNum >0)
                    {
                        [fabulousview.fabulousBtn setTitle:[NSString stringWithFormat:@"%d",(int)fabulousNum-1] forState:UIControlStateNormal];
                        
                        [fabulousview.fabulousBtn setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
                        
                        detailmodel.post_details.applaud_num = fabulousNum-1;
                        detailmodel.post_details.applaud_status = 0;
                    }
                }
            }];
        }else{//点赞
            
            [TopicPublicModel ThumbstData:1 This_id:detailmodel.post_details.theme_id Theme_id:detailmodel.post_details.theme_id Success:^(id data) {
                TopicPublicModel *model = data;
                if(model.status == 1)
                {
                    selectview.fabulousBtn.selected = !selectview.fabulousBtn.selected;
                    
                    [selectview.fabulousBtn setTitle:[NSString stringWithFormat:@"%d",(int)fabulousNum+1] forState:UIControlStateNormal];
                    
                    [selectview.fabulousBtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
                    
                    detailmodel.post_details.applaud_num = fabulousNum+1;
                    detailmodel.post_details.applaud_status = 1;
                }
                
            }];
        }
    }];
}

//只看楼主
- (void)LandlordHttp
{
    [self.remenComments removeAllObjects];
    [self.newestComments removeAllObjects];
    
    kSelfWeak;
    [TopicPublicModel LandlordComments:weakSelf.theme_id Theme_user_id:detailmodel.post_details.user_id Page:weakSelf.currPage Pagesize:5 Success:^(id data) {
        TopicPublicModel *model = data;
        if(model.status == 1)
        {
            weakSelf.currPage ++;
            weakSelf.landlordPage = [model.pager[@"pageCount"] integerValue];
            model.hotlist.count?[weakSelf chareModel:model.hotlist Type:1]:nil;
            model.list.count?[weakSelf chareModel:model.list Type:2]:nil;
            [weakSelf.collectionView reloadData];
        }else{
            [weakSelf.collectionView reloadData];
        }
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
        }else{
//            [weakSelf loadData:NO];
        }
        
        CircleModel *model = data;
        [weakSelf loadModel:model isTags:NO];
        _jrLayout.isLoadingMore = NO;
    }];
    
}
- (void)loadModel:(CircleModel *)model isTags:(BOOL)isTags{
    if (model.status == 1) {
        self.recommentAllPage = self.recommentPage==1?model.pager.rowCount:model.pager.pageCount;
        self.recommentPage ++;
        for(int i =0 ; i <model.myData.count; i++)
        {
            IntimateCircleModel *cmodel = model.myData[i];
            
            [self.recommendData addObject:cmodel];
        }
        
        [self getCollectionViewHeigh];
        [self.collectionView reloadData];
//        is_fresh?[self.collectionView reloadData]:0;
    }
}


#pragma mark *********************评论键盘************************
- (void)creatKeyboardView
{
    self.distapview = [[UIView alloc]initWithFrame:CGRectMake(0, -ZOOM6(600), kScreenWidth, ZOOM6(600))];
    self.distapview.backgroundColor = [UIColor clearColor];
    self.distapview.userInteractionEnabled = YES;
    [self.view addSubview:self.distapview];
    
    self.Keyboardview = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-50, kApplicationWidth,90)];
    self.Keyboardview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.Keyboardview];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line.backgroundColor = RGBCOLOR_I(229, 229, 229);
    [self.Keyboardview addSubview:line];
    
    self.replyView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.Keyboardview.frame)-100, 30)];
    self.replyView.backgroundColor = RGBCOLOR_I(239, 239, 239);
    self.replyView.layer.cornerRadius = 3;
    [self.Keyboardview addSubview:self.replyView];
    
    self.textview=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.replyView.frame), 30)];
    self.textview.delegate=self;
    self.textview.textColor = RGBCOLOR_I(62, 62, 62);
    self.textview.backgroundColor = [UIColor clearColor];
    [self.replyView addSubview:self.textview];
    [self.textview.layer setCornerRadius:3];
    [self.textview.layer setMasksToBounds:YES];
    
    //提示语
    self.placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.textview.frame) - 2 * 5, CGRectGetHeight(self.textview.frame))];
    self.placeHolder.text = @"说一下你的看法吧~";
    self.placeHolder.textColor = RGBCOLOR_I(197, 197, 197);
    self.placeHolder.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.placeHolder.numberOfLines = 0;
    self.placeHolder.contentMode = UIViewContentModeTop;
    [self.textview addSubview:self.placeHolder];
    
    self.replyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.replyButton.frame = CGRectMake(kScreenWidth-80, 10, 70, 30);
    self.replyButton.backgroundColor = RGBCOLOR_I(197, 197, 197);
    [self.replyButton setTitle:@"发送" forState:UIControlStateNormal];
    self.replyButton.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
    self.replyButton.tintColor = [UIColor whiteColor];
    self.replyButton.layer.cornerRadius = 3;
    [self.replyButton addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.Keyboardview addSubview:self.replyButton];
    
}

//评论
- (void)sendClick:(UIButton*)sender
{
    kSelfWeak;
    [self loginSuccess:^{
        if (![weakSelf.textview.text isEqualToString:@""] && weakSelf.textview.text.length != 0 && weakSelf.textview.text != nil)
        {
            
            if(_currentItem !=999999 )//回复
            {
                LastCommentsModel *commentmodel ;
                NSString * receive_user_id;
                
                if(weakSelf.remenComments.count)
                {
                    if(_currentItem <weakSelf.remenComments.count+1)
                    {
                        commentmodel = weakSelf.remenComments[_currentItem-1];
//                        receive_user_id = commentmodel.user_id;
                    }else{
                        
                        commentmodel = weakSelf.newestComments[_currentItem-2-weakSelf.remenComments.count];
//                        receive_user_id = commentmodel.user_id;
                    }
                }else{
                    commentmodel = weakSelf.newestComments[_currentItem];
//                    receive_user_id = commentmodel.user_id;
                }
                
                if(is_reply ==YES)
                {
                    receive_user_id = replistmodel.send_user_id;
                }else{
                    receive_user_id = @"";
                }
                
                [TopicPublicModel ReplyData:weakSelf.textview.text Comment_id:commentmodel.comment_id Receive_user_id:receive_user_id Success:^(id data) {
                    TopicPublicModel *model = data;
                    if(model.status == 1)
                    {
                        weakSelf.currPage = 1;
                        [weakSelf loadData:NO];
                        [MBProgressHUD show:@"回复成功" icon:nil view:weakSelf.view];
                    }else{
                        [MBProgressHUD show:@"回复失败" icon:nil view:weakSelf.view];
                    }
                }];
                
            }else{//评论
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *area = [user objectForKey:USER_ARRER];
                NSString *user_id = detailmodel.post_details.user_id;
                
                [TopicPublicModel CommentData:self.textview.text Location:area Theme_id:(NSString*)self.theme_id Base_user_id:user_id Success:^(id data) {
                    TopicPublicModel *model = data;
                    if(model.status == 1)
                    {
                        weakSelf.currPage = 1;
                        [weakSelf loadData:NO];
                        [MBProgressHUD show:@"评论成功" icon:nil view:weakSelf.view];
                    }else{
                        [MBProgressHUD show:@"评论失败" icon:nil view:weakSelf.view];
                    }
                    
                }];
                
            }
            _currentItem = 999999;
            
        }else{
            
            [MBProgressHUD show:@"回复内容不能为空" icon:nil view:weakSelf.view];
        }
        
        weakSelf.textview.text = @"";
        [weakSelf.textview resignFirstResponder];
        weakSelf.textview.inputView = nil;
        weakSelf.replyButton.backgroundColor = RGBCOLOR_I(197, 197, 197);
        
    }];
}

- (void)keyboardWillShow:(NSNotification*)note
{
    NSDictionary *userInfo = [note userInfo];
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
//    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardRect = [aValue CGRectValue];
//    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //view的偏移
    if(_currentPath)
    {
        UICollectionViewCell *selectCell = [self.collectionView cellForItemAtIndexPath:_currentPath];
        CGFloat history_Y_offset = [selectCell convertRect:selectCell.bounds toView:self.view].origin.y+selectCell.frame.size.height;
        
        CGFloat delta = 0.0;
        delta = history_Y_offset - (self.view.bounds.size.height - faceBoard.frame.size.height-90);
        
        CGPoint offset = self.collectionView.contentOffset;
        offset.y += delta;
        if (offset.y < 0) {
            offset.y = 0;
        }
        [self.collectionView setContentOffset:offset animated:NO];
    }
    kSelfWeak;
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         weakSelf.Keyboardview.frame=CGRectMake(0, kApplicationHeight-keyboardFrame.size.height-30, kApplicationWidth, 90);
                         weakSelf.distapview.frame=CGRectMake(0, 0, kScreenWidth, ZOOM6(600));
                     }];
    
}

- (void)keyboardWillHide:(NSNotification*)note
{
    NSDictionary *userInfo = [note userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    kSelfWeak;
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         weakSelf.Keyboardview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 90);
                         weakSelf.distapview.frame=CGRectMake(0, -ZOOM6(600), kScreenWidth, ZOOM6(600));
                     }];
    _currentPath = nil;
    if(self.textview.text.length <= 0)
    {
        self.placeHolder.text = @"说一下你的看法吧~";
        self.placeHolder.alpha = 1;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self loginSuccess:^{
        
    }];
}
- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length >0)
    {
        self.placeHolder.alpha = 0;
        self.replyButton.backgroundColor = tarbarrossred;
    }else{
        self.placeHolder.alpha = 1;
        self.replyButton.backgroundColor = RGBCOLOR_I(197, 197, 197);;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
/**
 * 解析输入的文本
 *
 * 根据文本信息分析出哪些是表情，哪些是文字
 */
- (void)getMessageRange:(NSString*)message :(NSMutableArray*)array {
    
    NSRange range = [message rangeOfString:FACE_NAME_HEAD];
    
    //判断当前字符串是否存在表情的转义字符串
    if ( range.length > 0 ) {
        
        if ( range.location > 0 ) {
            
            [array addObject:[message substringToIndex:range.location]];
            
            message = [message substringFromIndex:range.location];
            
            if ( message.length > FACE_NAME_LEN ) {
                
                [array addObject:[message substringToIndex:FACE_NAME_LEN]];
                
                message = [message substringFromIndex:FACE_NAME_LEN];
                [self getMessageRange:message :array];
            }
            else
                // 排除空字符串
                if ( message.length > 0 ) {
                    
                    [array addObject:message];
                }
        }
        else {
            
            if ( message.length > FACE_NAME_LEN ) {
                
                [array addObject:[message substringToIndex:FACE_NAME_LEN]];
                
                message = [message substringFromIndex:FACE_NAME_LEN];
                [self getMessageRange:message :array];
            }
            else
                // 排除空字符串
                if ( message.length > 0 ) {
                    
                    [array addObject:message];
                }
        }
    }
    else {
        
        [array addObject:message];
    }
}


#pragma mark **********************分享弹框***********************
- (void)creatShareView
{
    TopicShareview *share = [[TopicShareview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    ESWeakSelf;
    share.shareBlock = ^(NSInteger tag){
        [__weakSelf goShare:tag];
    };
    
    [self.view addSubview:share];
}

#pragma mark 分享
- (void)goShare:(NSInteger)tag
{
    NSString *imgUrl = nil;
    
    if(detailmodel.post_details.theme_type==1)
    {
        TShoplistModel *shopmodel = detailmodel.post_details.shop_list[0];
        
        NSMutableString *code = [NSMutableString stringWithString:shopmodel.shop_code];
        
        NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
        MyLog(@"supcode =%@",supcode);
        
        NSString *imagestr = [NSString stringWithFormat:@"%@/%@/%@",supcode,shopmodel.shop_code,shopmodel.def_pic];
        
        imgUrl = imagestr;
        
    }else{
        
        NSArray *pic = [detailmodel.post_details.pics componentsSeparatedByString:@","];
        NSArray *picurl = [pic[0] componentsSeparatedByString:@":"];
        if(picurl.count>=2)
        {
            imgUrl = [NSString stringWithFormat:@"/myq/theme/%@/%@",detailmodel.post_details.user_id,picurl[0]];
        }
    }
    
    NSString *realm = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    NSString *title = detailmodel.post_details.content;
    NSString *link  = [NSString stringWithFormat:@"%@/views/topic/detail.html?theme_id=%@&realm=%@",[NSObject baseH5ShareURLStr],detailmodel.post_details.theme_id,realm];
    ShareModel *model = [[ShareModel alloc]init];
    switch (tag) {
//        case 0:
//            MyLog(@"微信朋友圈");
//            model.sharetype = shareType_weixin_pyq;
//            break;
        case 0:
            MyLog(@"微信好友");
            model.sharetype = shareType_weixin_hy;
            break;
        case 1:
            MyLog(@"qq好友");
            model.sharetype = shareType_qq_hy;
            break;
        case 2:
            MyLog(@"空间");
            model.sharetype = shareType_qq_kj;
            break;
        case 3:
            MyLog(@"微博");
            model.sharetype = shareType_weibo;
            break;
            
        default:
            break;
    }
    
    model.shareResultBlock = ^(NSInteger statue){
        switch (statue) {
            case 0:
                [MBProgressHUD show:@"分享成功" icon:nil view:self.view];
                break;
            case 1:
                [MBProgressHUD show:@"分享失败" icon:nil view:self.view];
                break;
            case 2:
                [MBProgressHUD show:@"分享取消" icon:nil view:self.view];
                break;
            default:
                break;
        }
        
    };
    if(title.length >30)
    {
        title = [title substringToIndex:30];
    }
    if(tag == 0)//微信好友
    {
        MiniShareManager *minishare = [MiniShareManager share];
        NSString *image = [NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],imgUrl];
        NSString *path  = [NSString stringWithFormat:@"/pages/shouye/detail/sweetFriendsDetail/friendsDetail?theme_id=%@&user_id=%@",detailmodel.post_details.theme_id,realm];
        
        minishare.delegate = self;
        [minishare shareAppWithType:MINIShareTypeWeixiSession Image:image Title:title Discription:nil WithSharePath:path];
    }else{
        [model goshare:model.sharetype ShareImage:imgUrl ShareTitle:title ShareLink:link];
    }
}

#pragma mark *************小程序分享****************
//小程序分享回调
- (void)MinihareManagerStatus:(MINISHARESTATE)shareStatus withType:(NSString *)type
{
    [MBProgressHUD hideHUDForView:self.view];
    
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


#pragma mark --PopoverView 代理
- (void)seletRowAtIndex:(PopoverView *)popoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(popoverView.tag==8888)
    {
        if(indexPath.row==0){//
            
            TopicReportView *reportview = [[TopicReportView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            kSelfWeak;
            reportview.reportBlock = ^(NSString*str){
                
                [ReportModel ReportData:str Theme_id:detailmodel.post_details.theme_id Success:^(id data) {
                    
                    ReportModel *model = data;
                    if(model.status == 1)
                    {
                        [MBProgressHUD show:@"举报成功" icon:nil view:weakSelf.view];
                    }else{
                        [MBProgressHUD show:@"举报失败" icon:nil view:weakSelf.view];
                    }
                }];
            };
            
            [weakSelf.view addSubview:reportview];
            
        }else{//取消
            
        }
    }
}

//footview
- (TopfooterView*)topfooterView
{
    if(!_topfooterView && detailmodel != nil)
    {
        _topfooterView = [[TopfooterView alloc]initWithFrame:CGRectMake(-3, 0,kScreenWidth, _footViewHeigh) Data:detailmodel.post_details];
        __weak TopfooterView *footviiew = _topfooterView;
        kWeakSelf(self);
        footviiew.shareBlock = ^(NSInteger tag)
        {
            if(tag == 3)
            {
                [weakself creatShareView];
            }else{
                [weakself goShare:tag+(tag==0?0:1)];
            }
        };
        
        footviiew.shopBlock = ^(NSInteger tag ,NSString *shopcode){
            
            if([shopcode isEqualToString:@"更多"])
            {
                MoreCommendViewController *commend = [[MoreCommendViewController alloc]init];
                commend.theme_id = weakself.theme_id;
                [weakself.navigationController pushViewController:commend animated:YES];
            }else{
                
                ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
                shopdetail.shop_code = shopcode;
                shopdetail.stringtype = @"订单详情";
                [weakself.navigationController pushViewController:shopdetail animated:YES];
            }
        };
        footviiew.tagsBlock = ^(NSInteger tag ,NSString *title){//标签
            
            [weakself tagToVC:tag Title:title];
        };
        
        footviiew.customTagBlock = ^(NSString *ID ,NSString *title,BOOL repeat){
            
            if(repeat)
            {
//                if(detailmodel.post_details.shop_list.count >= 20)
//                {
                    [weakself repeatcustomTagToVC:ID Title:title];
//                }
            }
            else{
                [weakself customTagToVC:ID Title:title];
            }
        };
    }
    return _topfooterView;
}

- (void)creatSlideView
{
    if(!self.SlideView)
    {
        CGFloat imageWidth = IMAGEW(@"hover_xunbao");
        CGFloat imageHeigh = IMAGEH(@"hover_xunbao");
        
        self.SlideView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth+imageWidth, (kScreenHeight-imageHeigh)/2, imageWidth, imageHeigh)];
        self.SlideView.image = [UIImage imageNamed:@"hover_xunbao"];
        
        [self.view addSubview:self.SlideView];
        kSelfWeak;
        [UIView animateWithDuration:0.5 animations:^{
            
            weakSelf.SlideView.frame =CGRectMake(kScreenWidth-imageWidth, (kScreenHeight-imageHeigh)/2, imageWidth, imageHeigh);
        }];
    }
}

#pragma mark - UICollectionView
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _jrLayout = [[CustomCollectionViewLayout alloc]init];
        _jrLayout.delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar, self.view.bounds.size.width, self.view.bounds.size.height-Height_NavBar-50) collectionViewLayout:_jrLayout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"RemenComtCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RemenCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"BigImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"CommendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CommendCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"CommentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CommentCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"HotTopicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HotCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"TagImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TAGCELL"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kPagingCellIdentifier];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HeaderReusableView class])];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([HeaderReusableView class])];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([CollectionHeaderView class])];

//        [_collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
        
    }
    
    kSelfWeak;
    //上拉加载
    [_collectionView addFooterWithCallback:^{
        kSelfStrong;
        strongSelf -> is_fresh = YES;
        
        [weakSelf.collectionView ffRefreshHeaderEndRefreshing];
        [weakSelf.collectionView footerEndRefreshing];

//        if(weakSelf.recommentPage > weakSelf.recommentAllPage)
//        {
//            [weakSelf.collectionView ffRefreshHeaderEndRefreshing];
//            [weakSelf.collectionView footerEndRefreshing];
//            
//            NavgationbarView *mention = [[NavgationbarView alloc]init];
//            [mention showLable:@"没有更多数据" Controller:weakSelf];
//        }else{
//            [weakSelf recommendHttp];
//        }
        
    }];
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout
{
    
    StickyHeaderFlowLayout *layout = [[StickyHeaderFlowLayout alloc] init];
    // 全部固定设为YES, 局部固定则设为NO, 并实现代理方法
    layout.stickyHeader = NO;
    
    return layout;
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)
    {
        if(detailmodel.post_details.theme_type == 1)
        {
            _imageCellCount = (int)detailmodel.post_details.shop_list.count+1;
        }else{
            NSArray *pics = [detailmodel.post_details.pics componentsSeparatedByString:@","];
            _imageCellCount = (int)pics.count+1;
        }
        return _imageCellCount;
    }else if (section == 1)
    {
        int count = 0;
        if(self.remenComments.count)
        {
            count += self.remenComments.count+1;
            
            if(self.newestComments.count)
            {
                count += self.newestComments.count+1;
            }
            
        }else{
            if(self.newestComments.count)
            {
                count += self.newestComments.count;
            }
        }
        if(self.alltotalPage >1)
        {
            _cellCount = count+1;
            return count+1;
        }else{
            return count;
        }
        
        return 0;
    }else{

        return self.recommendData.count;
    }
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        if(self.remenComments.count)
        {
            if(_cellCount >0 && indexPath.item == _cellCount-1)
            {
                CommentCollectionViewController *comment = [[CommentCollectionViewController alloc]init];
                comment.theme_id = self.theme_id;
                comment.detailmodel = detailmodel;
                [self.navigationController pushViewController:comment animated:YES];
                
            }else{
                if(indexPath.item == 0 || indexPath.item == self.remenComments.count+1)
                {
                    
                }else{
                    _currentPath = indexPath;
                    _currentItem = indexPath.item;
                    self.placeHolder.text = @"说一下你的看法吧~";
                    [self.textview becomeFirstResponder];
                }
            }
        }else{
            
            if(indexPath.item > self.newestComments.count - 1)
            {
                CommentCollectionViewController *comment = [[CommentCollectionViewController alloc]init];
                comment.theme_id = self.theme_id;
                comment.detailmodel = detailmodel;
                [self.navigationController pushViewController:comment animated:YES];
            }else{
                _currentPath = indexPath;
                _currentItem = self.newestComments.count?indexPath.item:999999;
                self.placeHolder.text = @"说一下你的看法吧~";
                [self.textview becomeFirstResponder];
            }
        }
        
    }else if (indexPath.section == 2)
    {
        IntimateCircleModel *model = self.recommendData[indexPath.item];
        [self toTopic:model];
    }
}
#pragma mark CelldidselectDelegate
- (void)didselect:(LreplistModel*)model Indexpath:(NSIndexPath *)indexPath
{
    NSString *userid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];
    NSString *theme_user_id = [NSString stringWithFormat:@"%@",detailmodel.post_details.user_id];
    if([theme_user_id isEqualToString:userid])//是楼主
    {
        is_reply = YES;
        replistmodel = model;
        _currentPath = indexPath;
        _currentItem = indexPath.item;
        
        if(detailmodel.post_details.user_id.intValue == model.base_user_id.intValue)
        {
            self.placeHolder.text = [NSString stringWithFormat:@"回复%@~",@"楼主"];
        }else{
            self.placeHolder.text = [NSString stringWithFormat:@"回复%@~",model.send_nickname];
        }
        [self.textview becomeFirstResponder];
    }
}

- (void)fabulous:(LreplistModel *)model Indexpath:(NSIndexPath *)indexPath
{
    [self loginSuccess:^{//是事登录
        
    }];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.item == _imageCellCount-1)
        {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPagingCellIdentifier forIndexPath:indexPath];
            for(UIView *v in cell.contentView.subviews) {
                [v removeFromSuperview];
            }
            [cell.contentView addSubview:[self topfooterView]];
            return cell;
        }else{
            if(detailmodel.post_details.theme_type ==4 && indexPath.item == 0)
            {
                TagImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TAGCELL" forIndexPath:indexPath];
                [cell refreshData:detailmodel.post_details];
                ESWeakSelf;
                cell.tagsBlock = ^(NSString *ID ,NSString *title,NSInteger labeltype,NSString*shop_code){//标签
                    
                    if(shop_code != nil && shop_code.length >=8)
                    {
                        [__weakSelf shopTagToVC:shop_code];
                    }else{
                        if(labeltype == 2)
                        {
                            [__weakSelf customTagToVC:ID Title:title];
                        }else{
                            [__weakSelf offcialTagToVC:ID];
                        }
                    }
                };
                
                return cell;
            }else{
                BigImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
                
                [cell refreshData:detailmodel.post_details Index:indexPath.item];
                ESWeakSelf;
                cell.gotoBuyBlock = ^(NSString *shopcode){
                    
                    [__weakSelf toShopDetail:shopcode Theme:__weakSelf.theme_id];
                };
                return cell;
            }
        }
        
    }else if (indexPath.section == 1)
    {
        if(self.remenComments.count)
        {
            if(indexPath.item == 0 || indexPath.item == self.remenComments.count+1)
            {
                RemenComtCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RemenCell" forIndexPath:indexPath];
                indexPath.item ==0?[cell refreshTitle:@"热门评论"]:[cell refreshTitle:@"最新评论"];
                return cell;
            }else{
                if(_cellCount >0 && indexPath.item == _cellCount-1)
                {
                    RemenComtCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RemenCell" forIndexPath:indexPath];
                    [cell refreshTitle:[NSString stringWithFormat:@"查看全部%d条评论",(int)detailmodel.post_details.comment_count]];
                    return cell;
                    
                }else{
                    
                    CommentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentCell" forIndexPath:indexPath];
                    cell.delegate = self;
                    LastCommentsModel *model ;
                    if(indexPath.item < self.remenComments.count+1)
                    {
                        model = self.remenComments[indexPath.item-1];
                    }else{
                        model = self.newestComments[indexPath.item-(self.remenComments.count +1)- 1];
                    }
                    [cell refreshData:model Indexpath:indexPath];
                    
                    return cell;
                }
                
            }
        }else{
            if(indexPath.item > self.newestComments.count-1)
            {
                RemenComtCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RemenCell" forIndexPath:indexPath];
                [cell refreshTitle:[NSString stringWithFormat:@"查看全部%d条评论",(int)detailmodel.post_details.comment_count]];
                return cell;
                
            }else{
                CommentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentCell" forIndexPath:indexPath];
                if(self.newestComments.count)
                {
                    cell.delegate = self;
                    LastCommentsModel *model = self.newestComments[indexPath.row];
                    [cell refreshData:model Indexpath:indexPath];
                }
                return cell;
                
            }
            
        }
        
    }
    else if (indexPath.section == 2)
    {
        
        HotTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.bigImage.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height-50-ZOOM6(90));
        IntimateCircleModel *model = self.recommendData[indexPath.item];
        [cell refreshCircleData:model];
        
        NSString *them_id = [NSString stringWithFormat:@"%@",model.theme_id];
        kWeakSelf(cell);
//        kWeakSelf(self);
        cell.likeBlock = ^(NSInteger num){
//            [weakself loginSuccess:^{
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
//            }];
        };
        
        return cell;

    }
    return nil;
}

//去帖子详情
- (void)toTopic:(IntimateCircleModel*)model
{
    TopicDetailViewController *topic = [[TopicDetailViewController alloc]init];
    topic.theme_id = [NSString stringWithFormat:@"%@",model.theme_id];
    topic.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:topic animated:YES];
}
//商品详情
- (void)toShopDetail:(NSString*)shopcode Theme:(NSString*)theme_id
{
    ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
    shopdetail.shop_code = shopcode;
    shopdetail.theme_id =theme_id;
    shopdetail.stringtype = @"订单详情";
    [self.navigationController pushViewController:shopdetail animated:YES];
}
//关注
- (void)tofollw:(NSInteger)type View:(TopheaderView*)top
{
    [self loginSuccess:^{//是否登录
        
        [TopicPublicModel FollowData:type Friend_user_id:detailmodel.post_details.user_id Success:^(id data) {
            TopicPublicModel *model = data;
            if(model.status == 1)
            {
                top.followbutton.selected = !top.followbutton.selected;
            }
        }];
    }];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionFooter) {
        
        HeaderReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([HeaderReusableView class]) forIndexPath:indexPath];
        
        for (UIView *view in footer.subviews) {
            [view removeFromSuperview];
        }
        
//        if(indexPath.section == 0)
//        {
//            CollectionHeaderView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([CollectionHeaderView class]) forIndexPath:indexPath];
//            [footer addSubview:self.topfooterView];
//            return  footer;
//            
//        }else if (indexPath.section == 1)//抢沙发
//        {
//            HeaderReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([HeaderReusableView class]) forIndexPath:indexPath];
//            
//            for (UIView *view in footer.subviews) {
//                [view removeFromSuperview];
//            }
//            
//            TopicSofaView *sofaview=[[TopicSofaView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(400))];
//            ESWeakSelf;
//            sofaview.sofaBlock = ^{
//                [__weakSelf.textview becomeFirstResponder];
//            };
//            [footer addSubview:sofaview];
//            return  footer;
//        }

        TopicSofaView *sofaview=[[TopicSofaView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(400))];
        ESWeakSelf;
        sofaview.sofaBlock = ^{
            [__weakSelf.textview becomeFirstResponder];
        };
        [footer addSubview:sofaview];
        return  footer;

    }
    else {
        
        HeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([HeaderReusableView class]) forIndexPath:indexPath];
        
        for (UIView *view in header.subviews) {
            [view removeFromSuperview];
        }
        if(indexPath.section == 0)
        {
            TopheaderView *top = [[TopheaderView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(header.frame), CGRectGetHeight(header.frame)) Data:detailmodel.post_details];
            
            __weak TopheaderView *headviiew = top;
            ESWeakSelf;
            top.tagBlock = ^(NSInteger tag ,NSString *title){//标签
                
                [__weakSelf tagToVC:tag Title:title];
            };
            top.followBlock = ^(NSInteger type){//关注
                
                [__weakSelf tofollw:type View:headviiew];
            };
            [header addSubview:top];
            
        }else if (indexPath.section == 1){
            
            NSString *commentstr =[NSString stringWithFormat:@"全部评论 %d",(int)detailmodel.post_details.comment_count];
            NSArray *titleArray = @[commentstr,@"只看楼主"];
            selectview = [[TopselectView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(header.frame), CGRectGetHeight(header.frame)) WithNames:titleArray pubIndex:_pubIndex Data:detailmodel.post_details];
            
            kSelfWeak;
            selectview.selectBlock = ^(NSInteger tag){
                kSelfStrong;
                strongSelf -> _pubIndex = tag;
                weakSelf.currPage = 1;
                [weakSelf.view endEditing:YES];
                tag==0?[weakSelf loadData:YES]:[weakSelf LandlordHttp];
            };
            
            selectview.fabulousBlock = ^(NSInteger num){
                
                [weakSelf loginSuccess:^{
                    
                    [weakSelf fabulousHttp:num];
                }];
            };
            [header addSubview:selectview];
            
        }else{
            
            SecondHeadView *headview = [[SecondHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(100))];
            headview.moreBlock = ^{
                
            };
            [header addSubview:headview];
        }
        
        header.backgroundColor = [UIColor whiteColor];
        
        return header;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0);
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath;
{
    //浏览赢提现
    if (self.isTiXian && indexPath.section == 2 && indexPath.item==0 && !self.browseFlag)
    {
        [self publicTixianEdu];
    }
    else if(indexPath.section == 2 && indexPath.item==0 && !self.browseFlag && [self.comefrom isEqualToString:@"穿搭任务"])
    {
        
        NSString *index_id = [Signmanager SignManarer].topic_indexid;
        NSString *day = [Signmanager SignManarer].topic_day;
        NSInteger num = [Signmanager SignManarer].topic_rewardNumber;
        NSString *rewardvalue = [Signmanager SignManarer].topic_value;
        NSString *typename = [Signmanager SignManarer].topic_type;
        NSInteger mustLiulanCount = [Signmanager SignManarer].topic_liulanNumber;
        
        NSInteger liulanNumber;
        NSString *liulanCount = [[NSUserDefaults standardUserDefaults]objectForKey:TASK_LIULAN_TOPIC];
        liulanNumber = liulanCount.integerValue;
        liulanNumber ++;
        
        if(num == 1)//奖励分一次发
        {
            if(mustLiulanCount > liulanNumber)//浏览多次
            {
                self.browseFlag = YES;
                [[NSUserDefaults standardUserDefaults] setInteger:liulanNumber forKey:TASK_LIULAN_TOPIC];
                [MBProgressHUD show:[NSString stringWithFormat:@"再浏览%zd件可完成任务喔~",(mustLiulanCount - liulanNumber)] icon:nil view:nil];
                
            }else{//浏览1次
                kSelfWeak;
                [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
                    TaskSignModel *model = data;
                    if(model.status == 1)
                    {
                        weakSelf.browseFlag = YES;
                        [weakSelf setTaskPopMindView:Task_liulanChuanDaFinish];
                        
                        CGFloat imageWidth = IMAGEW(@"hover_xunbao");
                        CGFloat imageHeigh = IMAGEH(@"hover_xunbao");
                        [UIView animateWithDuration:0.5 animations:^{
                            
                            weakSelf.SlideView.frame =CGRectMake(kScreenWidth+imageWidth, (kScreenHeight-imageHeigh)/2, imageWidth, imageHeigh);
                        }];
                        
                        [[NSUserDefaults standardUserDefaults]removeObjectForKey:TASK_LIULAN_TOPIC];
                        
                        if(self.browseCountBlock)
                        {
                            self.browseCountBlock();
                        }
                    }
                }];
            }
            
        }else{//多次发
            kSelfWeak;
            [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
                TaskSignModel *model = data;
                if(model.status == 1)
                {
                    weakSelf.browseFlag = YES;
                    if(mustLiulanCount > liulanNumber)
                    {
                        [[NSUserDefaults standardUserDefaults] setInteger:liulanNumber forKey:TASK_LIULAN_TOPIC];
                        NSString *value = [NSString stringWithFormat:@"浏览完成！%.0f元%@奖励已发放至账户",rewardvalue.floatValue,typename];
                        if([typename isEqualToString:@"积分"])
                        {
                            value = [NSString stringWithFormat:@"浏览完成！%.0f%@奖励已发放至账户",rewardvalue.floatValue,typename];
                        }
                        
                        [MBProgressHUD show:value icon:nil view:weakSelf.view];
                    }else{
                        
                        [weakSelf setTaskPopMindView:Task_liulanChuanDaFinish];
                        
                        CGFloat imageWidth = IMAGEW(@"hover_xunbao");
                        CGFloat imageHeigh = IMAGEH(@"hover_xunbao");
                        [UIView animateWithDuration:0.5 animations:^{
                            
                            weakSelf.SlideView.frame =CGRectMake(kScreenWidth+imageWidth, (kScreenHeight-imageHeigh)/2, imageWidth, imageHeigh);
                        }];
                        
                        [[NSUserDefaults standardUserDefaults]removeObjectForKey:TASK_LIULAN_TOPIC];
                        
                        if(self.browseCountBlock)
                        {
                            self.browseCountBlock();
                        }

                    }
                }
            }];
        }
    }
}
- (void)publicTixianEdu
{
    if([Signmanager SignManarer].liulanAlreadyCount <= 0)//此浏览任务已经完成
    {
        return;
    }
    [Signmanager SignManarer].liulanTixianCount ++;
    NSString *index_id = self.index;
    NSString *day = self.day;
    
    NavgationbarView *mentionview = [NavgationbarView alloc];
    if([Signmanager SignManarer].liulanTixianCount == [Signmanager SignManarer].everyLinlanCount)
    {
        kWeakSelf(self);
        [TaskSignModel getTaskHttp:index_id Day:day Success:^(id data) {
            
            TaskSignModel *model = data;
            if(model.status == 1)
            {
                weakself.browseFlag = YES;
                [Signmanager SignManarer].liulanTixianCount = 0;
                [Signmanager SignManarer].liulanAlreadyCount --;
                
                if([Signmanager SignManarer].liulanAlreadyCount <= 0)
                {
                    if(self.browseCountBlock)
                    {
                        self.browseCountBlock();
                    }

                    [self setTaskPopMindView:Task_liulan_tixian];//任务完成
                }else{
                    
                    NSString *money = [NSString stringWithFormat:@"%zd",[Signmanager SignManarer].everyLiulanRaward];
                    int count = (int)[Signmanager SignManarer].everyLinlanCount;
//                    NSString *message = [NSString stringWithFormat:@"%@元现金已存入你的余额，再次浏览%d次\n可再赢得%@元提现额度，继续努力",money,count,money];
                    
                    NSString *message = [NSString stringWithFormat:@"%@元提现现金已经发放，到账时间为3-5个工作日，请耐心等待。再次浏览%d次\n可再得%@元提现现金，继续努力！",money,count,money];
                    
                    [mentionview showLable:message Controller:self];
                }
                
            }else{
                [Signmanager SignManarer].liulanTixianCount --;
            }
        }];
    }else {
        NSInteger nextcount = [Signmanager SignManarer].everyLinlanCount - [Signmanager SignManarer].liulanTixianCount;
        self.browseFlag = YES;
        NSString *message = [NSString stringWithFormat:@"再浏览%zd件可完成任务哦~",nextcount];
        [mentionview showLable:message Controller:self];
    }
}
#pragma mark -<CustomCollectionViewLayoutDelegate>
-(NSInteger)numberOfColumnsForSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 1;
    }else{
        return 2;
    }
}

-(CGFloat)interItemSpacingForSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else if (section == 1)
    {
        return 0;
    }
    else{
        return 5;
    }
}

-(void)allowLoadMoreData{
    
    is_fresh = YES;
    _jrLayout.isLoadingMore = YES;

    if(self.recommentPage > self.recommentAllPage)
    {
        [self.collectionView ffRefreshHeaderEndRefreshing];
        [self.collectionView footerEndRefreshing];
        if(!is_finshtfresh)
        {
            NavgationbarView *mention = [[NavgationbarView alloc]init];
            [mention showLable:@"没有更多数据" Controller:self];
            is_finshtfresh = YES;
        }
    }else{
        
        [self recommendHttp];
    }
}

- (CGFloat)collectionView:(UICollectionView*) collectionView
                   layout:(CustomCollectionViewLayout*) layout
 heightForItemAtIndexPath:(NSIndexPath*) indexPath{
    
    CGFloat heigh = 0;
    if (indexPath.section == 0) {
        
        if(indexPath.item == _imageCellCount-1)
        {
            heigh = _footViewHeigh;
        }else{
            if(detailmodel.post_details.theme_type ==1)
            {
                heigh = kScreenWidth*1.5;
                
            }else{
                
                NSArray *pics =[detailmodel.post_details.pics componentsSeparatedByString:@","];
                NSString *str = pics[indexPath.item];
                NSArray *arr = [str componentsSeparatedByString:@":"];
                if(arr.count==2)
                {
                    NSString *scale = arr[1];
                    heigh =scale!=0?(kScreenWidth/[scale floatValue]):0;
                }else{
                    heigh = 0;
                }
            }
        }
        if(indexPath.item == 0)
        {
            _firstImageViewHeigh = heigh;
        }
        return heigh;
    }else if (indexPath.section == 1)
    {
        CGSize cgsize = CGSizeZero;
        if(self.remenComments.count)
        {
            if(indexPath.item == 0 || indexPath.item == self.remenComments.count+1)
            {
                cgsize = CGSizeMake(kScreenWidth, ZOOM6(50));
            }else{
                
                LastCommentsModel *model ;
                if(indexPath.item < self.remenComments.count+1)
                {
                    model = self.remenComments[indexPath.item-1];
                    cgsize = CGSizeMake(kScreenWidth, 55 +model.replyCellHeigh+model.replyHeadHeigh+ZOOM6(20));
                }else{
                    if((indexPath.item < _cellCount-1) && _cellCount>0)
                    {
                        model = self.newestComments[indexPath.item-(self.remenComments.count +1)- 1];
                        cgsize = CGSizeMake(kScreenWidth, 55 +model.replyCellHeigh+model.replyHeadHeigh+ZOOM6(20));
                    }else{
                        cgsize = CGSizeMake(kScreenWidth, 40-5);
                    }
                }
            }
            return cgsize.height;
        }else if(self.newestComments.count){
            if (indexPath.item > self.newestComments.count-1)
            {
                return 40-5;
            }else{
                
                LastCommentsModel* model = self.newestComments[indexPath.item];
                return  55 +model.replyCellHeigh+model.replyHeadHeigh+ZOOM6(20);
            }
        }
        
    }else if (indexPath.section == 2)
    {
        
        CGFloat itemWidth = (kScreenWidth - 15)/2;
        CGFloat itemHeith = 0;
        IntimateCircleModel *model = self.recommendData[indexPath.item];
        
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
            
            itemHeith= (itemWidth/imageSize +55+ZOOM6(90));
        }
        
        return itemHeith;
        
    }
    return heigh;

}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        CGFloat heigh = 0;
        if(indexPath.item == _imageCellCount-1)
        {
            heigh = [self getFootViewHeigh];
        }else{
            if(detailmodel.post_details.theme_type ==1)
            {
                heigh = kScreenWidth*1.5;
                
            }else{
                
                NSArray *pics =[detailmodel.post_details.pics componentsSeparatedByString:@","];
                NSString *str = pics[indexPath.item];
                NSArray *arr = [str componentsSeparatedByString:@":"];
                if(arr.count==2)
                {
                    NSString *scale = arr[1];
                    heigh =scale!=0?(kScreenWidth/[scale floatValue]):0;
                }else{
                    heigh = 0;
                }
            }
        }
        if(indexPath.item == 0)
        {
            _firstImageViewHeigh = heigh;
        }
        return CGSizeMake(kScreenWidth, heigh);
    }else if (indexPath.section == 1)
    {
        CGSize cgsize = CGSizeZero;
        if(self.remenComments.count)
        {
            if(indexPath.item == 0 || indexPath.item == self.remenComments.count+1)
            {
                cgsize = CGSizeMake(kScreenWidth, ZOOM6(50));
            }else{
                
                LastCommentsModel *model ;
                if(indexPath.item < self.remenComments.count+1)
                {
                    model = self.remenComments[indexPath.item-1];
                    cgsize = CGSizeMake(kScreenWidth, 55 +model.replyCellHeigh+model.replyHeadHeigh+ZOOM6(20));
                }else{
                    if((indexPath.item < _cellCount-1) && _cellCount>0)
                    {
                        model = self.newestComments[indexPath.item-(self.remenComments.count +1)- 1];
                        cgsize = CGSizeMake(kScreenWidth, 55 +model.replyCellHeigh+model.replyHeadHeigh+ZOOM6(20));
                    }else{
                        cgsize = CGSizeMake(kScreenWidth, 40);
                    }
                }
            }
            return cgsize;
        }else if(self.newestComments.count){
            if (indexPath.item > self.newestComments.count-1)
            {
                return CGSizeMake(kScreenWidth, 40);
            }else{
                
                LastCommentsModel* model = self.newestComments[indexPath.item];
                return CGSizeMake(kScreenWidth, 55 +model.replyCellHeigh+model.replyHeadHeigh+ZOOM6(20));
            }
        }
        
    }else if (indexPath.section == 2)
    {
        return CGSizeMake(kScreenWidth, _collectionViehHeigh);
    }
    return CGSizeMake(0, 0);
}

//Header的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        if(detailmodel.post_details !=nil)
        {
            [self getFootViewHeigh];
            return CGSizeMake(kScreenWidth, ZOOM6(140));
        }
    }else if(section == 1)
    {
        return CGSizeMake(kScreenWidth, ZOOM6(80));
    }else if (section == 2)
    {
        if(self.recommendData.count)
        {
            return CGSizeMake(kScreenWidth, ZOOM6(100)-5);
        }
        return CGSizeZero;
    }
    return CGSizeMake(kScreenWidth, 100);
}

//footer的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        if(self.remenComments.count + self.newestComments.count>0)
        {
            return CGSizeZero;
        }
        return CGSizeMake(kScreenWidth, ZOOM6(400));
    }
    else if (section == 0)
    {
        if(detailmodel.post_details !=nil)
        {
            return CGSizeMake(kScreenWidth, 0);
        }
    }
    return CGSizeZero;
}

- (CGFloat)getFootViewHeigh
{
    //标签高度
    
    NSArray *titles = [self gettitleArray:detailmodel.post_details.tagsArray];
    CGFloat tagsHeight = 0;
    if(titles.count)
    {
        tagsHeight = [HXTagsView getHeightWithTags:titles layout:nil tagAttribute:nil width:kScreenWidth];
    }
    CGFloat tagviewH   = tagsHeight + (detailmodel.post_details.tagsArray.count >0?ZOOM6(20):0);
    
    //内容高度
    NSString *title =@"";
    if(detailmodel.post_details.title.length>0)
    {
        title = [NSString stringWithFormat:@"#%@# %@",detailmodel.post_details.title,detailmodel.post_details.content];
    }else{
        title = [NSString stringWithFormat:@"%@",detailmodel.post_details.content];
    }
    while ([title rangeOfString:@"\n\n"].length>0) {
        title = [title stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
    }
    CGFloat titleviewH = detailmodel.post_details.content.length>0?([self getRowHeight:title fontSize:ZOOM6(30)]+ZOOM6(20)):0;
    
//    CGFloat shopviewH =(detailmodel.post_details.shop_list.count>0 && detailmodel.post_details.theme_type !=1)?ZOOM6(250):ZOOM6(20);
    
    CGFloat shopviewH =(detailmodel.post_details.shop_list.count>0 && detailmodel.post_details.theme_type !=1)?(ZOOM6(200)*1.5+ZOOM6(70)+ZOOM6(40)):ZOOM6(20);
    _footViewHeigh = titleviewH + tagviewH +shopviewH +ZOOM6(210);
    
    return _footViewHeigh;
}

- (NSArray *)gettitleArray:(NSArray*)tagsArray
{
    NSMutableArray *tagstitleArray = [NSMutableArray array];
    
    for(int i =0 ;i<tagsArray.count;i++)
    {
        TopicTagsModel *model = tagsArray[i];
        [tagstitleArray addObject:model.title];
    }
    
    return tagstitleArray;
}

- (void)getCollectionViewHeigh
{
    CGFloat itemWidth = (kScreenWidth - 15)/2;
    CGFloat leftheigh = 0;
    CGFloat rightheith = 0;
    
    for(int i =0; i< self.recommendData.count;i++)
    {
        IntimateCircleModel *model = self.recommendData[i];
        
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
            
            leftheigh<=rightheith?(leftheigh += (itemWidth/imageSize +55+ZOOM6(90))):(rightheith += (itemWidth/imageSize +55+ZOOM6(90)));
        }
    }
    
    _collectionViehHeigh = (leftheigh>rightheith?leftheigh:rightheith);
    is_fresh == YES?[self.collectionView reloadData]:nil;
}

#pragma mark 标签界面跳转
- (void)tagToVC:(NSInteger)tag Title:(NSString*)title
{
    TopicTagsModel *model = detailmodel.post_details.tagsArray[tag];
    ShopTypeItem *item = [[ShopTypeItem alloc]init];
    item.ID = model.ID;
    item.name = title;
    if(model.shop_code != nil)
    {
        ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
        shopdetail.shop_code = model.shop_code;
        shopdetail.stringtype = @"订单详情";
        [self.navigationController pushViewController:shopdetail animated:YES];
    }
    else if([model.type isEqualToString:@"风格"])
    {
        TFScreenViewController *screen = [[TFScreenViewController alloc]init];
        screen.muStr = model.ID;
        screen.index = 1;
        screen.titleText = item.name;
        screen.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:screen animated:YES];
    }else if ([model.type isEqualToString:@"品牌"]){
        
        BrandMakerDetailVC *view=[BrandMakerDetailVC new];
        SqliteManager *manager = [SqliteManager sharedManager];
        TypeTagItem *item = [manager getSuppLabelItemForId:model.ID];
        view.shopItem=item;
        [self.navigationController pushViewController:view animated:YES];
    }else if ([model.type isEqualToString:@"话题"])
    {
        TFSubIntimateCircleVC *vc = [[TFSubIntimateCircleVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.item = item;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 重复的自定义标签跳转
- (void)repeatcustomTagToVC:(NSString*)supperID Title:(NSString*)title
{
    MoreCommendViewController *commend = [[MoreCommendViewController alloc]init];
    commend.theme_id = self.theme_id;
    [self.navigationController pushViewController:commend animated:YES];
}
#pragma mark 自定义标签跳转
- (void)customTagToVC:(NSString*)supperID Title:(NSString*)title
{
    TFScreenViewController *screen = [[TFScreenViewController alloc]init];
    screen.muStr = supperID;
    screen.index = 3;
    screen.titleText = title;
    screen.theme_id = [NSString stringWithFormat:@"%@",self.theme_id];
    screen.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:screen animated:YES];
}
#pragma mark 官方品牌标签跳转
- (void)offcialTagToVC:(NSString*)ID
{
    BrandMakerDetailVC *view=[BrandMakerDetailVC new];
    SqliteManager *manager = [SqliteManager sharedManager];
    TypeTagItem *item = [manager getSuppLabelItemForId:ID];
    view.shopItem=item;
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark 关联商品标签跳转
- (void)shopTagToVC:(NSString*)shop_code
{
    ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
    shopdetail.shop_code = shop_code;
    shopdetail.stringtype = @"订单详情";
    [self.navigationController pushViewController:shopdetail animated:YES];
}
#pragma mark 签到任务弹框
- (void)setTaskPopMindView:(TaskPopType)type
{
    NSString *rewardvalue = [Signmanager SignManarer].topic_value;
    NSString *rewardtype = [Signmanager SignManarer].topic_type;
    NSInteger rewardnum = [Signmanager SignManarer].topic_rewardNumber;
    
    FinishTaskPopview * bonusview = [[FinishTaskPopview alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) TaskType:type TaskValue:nil Title:@"浏览完成~" RewardValue:rewardvalue RewardNumber:(int)rewardnum Rewardtype:rewardtype];
    
    __weak FinishTaskPopview *view = bonusview;
    ESWeakSelf;
    view.tapHideMindBlock = ^{
        [view remindViewHiden];
    };
    
    view.leftHideMindBlock = ^(NSString*title){
        
    };
    view.rightHideMindBlock = ^(NSString*title){
        [__weakSelf gonextTask];
    };
    [self.view addSubview:bonusview];
    
}
//继续浏览
- (void)gogogo
{
    Mtarbar.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//一键做下个任务
- (void)gonextTask
{
    [[NextTaskManager taskManager] bakeToMakemoneyVC];
}
#pragma mark 获取文本高度
-(CGFloat)getRowHeight:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat height = 0;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM6(20), 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
    }
    
    if(height < ZOOM6(50))
    {
        return  ZOOM6(50);
    }else{
        return height;
    }
    return height;
}


- (void)dealloc
{
    NSLog(@"释放了");
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray*)remenComments
{
    if(_remenComments == nil)
    {
        _remenComments = [NSMutableArray array];
    }
    
    return _remenComments;
}
- (NSMutableArray*)newestComments
{
    if(_newestComments == nil)
    {
        _newestComments = [NSMutableArray array];
    }
    
    return _newestComments;
}
- (NSMutableArray*)relatedrecommended
{
    if(_relatedrecommended ==nil)
    {
        _relatedrecommended = [NSMutableArray array];
    }
    return _relatedrecommended;
}

- (NSMutableArray*)recommendData
{
    if(_recommendData == nil)
    {
        _recommendData = [NSMutableArray array];
    }
    return _recommendData;
}
@end
