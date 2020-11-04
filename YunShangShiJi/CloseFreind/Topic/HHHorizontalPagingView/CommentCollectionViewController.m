//
//  CommentCollectionViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CommentCollectionViewController.h"
#import "TFShoppingViewController.h"
#import "TopicPublicModel.h"
#import "LastCommentsModel.h"
#import "LreplistModel.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD.h"
#import "TopicviewModel.h"
#import "FaceBoard.h"

#import "RemenComtCollectionViewCell.h"
#import "CommentCollectionViewCell.h"
#import "GlobalTool.h"
@interface CommentCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CelldidselectDelegate,FaceBoardDelegate,UITextViewDelegate>

@end
static NSString *collectionViewCellIdentifier = @"collectionViewCell";

@implementation CommentCollectionViewController
{
    LreplistModel *replistmodel;      //评论内回复的对象
    NSInteger _currentItem;           //当前行
    NSIndexPath *_currentPath;
    FaceBoard *faceBoard;             //键盘
    BOOL is_reply;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.currPage = 1;
    self.pageIndex = 0;
    _currentItem = 999999;
    [self creatHeadView];
    
    [self.view addSubview:self.topselectView];
    [self.view addSubview:self.collectionview];
    [self creatKeyboardView];
    [self loadData];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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
    titlelable.text=@"评论";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
}

- (TopselectView*)topselectView
{
    if(_topselectView == nil)
    {
        NSString *commentstr =[NSString stringWithFormat:@"全部评论 %d",(int)self.detailmodel.post_details.comment_count];
        NSArray *titleArray = @[commentstr,@"只看楼主"];
        _topselectView = [[TopselectView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, ZOOM6(80)) WithNames:titleArray pubIndex:self.pageIndex Data:self.detailmodel.post_details];
        
        ESWeakSelf;
        _topselectView.selectBlock = ^(NSInteger tag){
            __weakSelf.pageIndex = tag;
            __weakSelf.currPage = 1;
            [__weakSelf.view endEditing:YES];
            //滑动到最底部
            [__weakSelf.collectionview setContentOffset:CGPointMake(0, 0)];
            [__weakSelf loadData];
        };
        
        _topselectView.fabulousBlock = ^(NSInteger num){
            
            [__weakSelf loginSuccess:^{
                
                [__weakSelf fabulousHttp:num];
            }];
        };
        
    }
    return _topselectView;
}
//- (void)creatData
//{
//    if(self.pageIndex == 0)
//    {
//        [self newestComentData:self.theme_id];
//    }else{
//        [self LandlordHttp:self.theme_id Model:self.detailmodel];
//    }
//}

- (void)loadData;
{
    //详情
    [TopicviewModel getDataTheme_id:(NSString*)self.theme_id Success:^(id data) {
        [self.collectionview headerEndRefreshing];
        [self.collectionview footerEndRefreshing];
        [self.collectionview ffRefreshHeaderEndRefreshing];

        TopicviewModel *model = data;
        if(model.status == 1)
        {
            if(self.currPage == 1)
            {
                [self.remenComments removeAllObjects];
            }
            TopicdetailsModel* detailmodel = model.data;
            
            detailmodel.hot_comments.count?[self chareModel:detailmodel.hot_comments Type:1]:nil;
        
        }else{
            [MBProgressHUD show:model.message icon:nil view:self.view];
        }
        
        if(self.pageIndex == 0)
        {
            [self newestComentData:self.theme_id];
        }else{
            [self LandlordHttp:self.theme_id Model:self.detailmodel];
        }
        
    }];
    
}

//最新评论
- (void)newestComentData:(NSString*)theme_id
{
    [TopicPublicModel LastComments:(NSString*)theme_id Page:self.currPage Pagesize:10 Success:^(id data) {
        [self.collectionview headerEndRefreshing];
        [self.collectionview footerEndRefreshing];
        [self.collectionview ffRefreshHeaderEndRefreshing];
        
        TopicPublicModel *model = data;
        if(model.status == 1 && model.list.count)
        {
            if(self.currPage == 1)
            {
                [self.newestComments removeAllObjects];
            }
            self.currPage ++;
            [self chareModel:model.list Type:2];
            [self.collectionview reloadData];
        }else{
            [self.collectionview reloadData];
        }
    }];
    
}
//只看楼主
- (void)LandlordHttp:(NSString*)theme_id Model:(TopicdetailsModel*)datamodel
{
    [self.remenComments removeAllObjects];
    [self.newestComments removeAllObjects];
    
    [TopicPublicModel LandlordComments:theme_id Theme_user_id:datamodel.post_details.user_id Page:self.currPage Pagesize:10 Success:^(id data) {
        [self.collectionview headerEndRefreshing];
        [self.collectionview footerEndRefreshing];
        [self.collectionview ffRefreshHeaderEndRefreshing];
        
        TopicPublicModel *model = data;
        if(model.status == 1)
        {
            if(self.currPage == 1)
            {
                [self.remenComments removeAllObjects];
                [self.newestComments removeAllObjects];
            }

            self.currPage ++;
            model.hotlist.count?[self chareModel:model.hotlist Type:1]:nil;
            model.list.count?[self chareModel:model.list Type:2]:nil;
            [self.collectionview reloadData];
        }else{
            [self.collectionview reloadData];
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
        int count = commentModel.replies_list.count >4?4:(int)commentModel.replies_list.count;
        for(int j =0;j<count;j++)
        {
            LreplistModel *replymodel = commentModel.replies_list[j];
            CGFloat H = ZOOM6(50);
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
            NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
            if(commentModel.status.intValue==0 || (commentModel.status.intValue == 1 && commentModel.user_id.intValue == userid.intValue))
            {
                [self.newestComments addObject:commentModel];
            }

        }

    }
    
}

// 点赞
- (void)fabulousHttp:(NSUInteger)fabulousNum
{
    __weak TopselectView *fabulousview = self.topselectView;
    if(fabulousview.fabulousBtn.selected)//取消点赞
    {
        [TopicPublicModel DisThumbstData:1 This_id:self.detailmodel.post_details.theme_id Theme_id:self.detailmodel.post_details.theme_id Success:^(id data) {
            TopicPublicModel *model = data;
            if(model.status == 1)
            {
                self.topselectView.fabulousBtn.selected = !self.topselectView.fabulousBtn.selected;
                
                if(fabulousNum >0)
                {
                    [fabulousview.fabulousBtn setTitle:[NSString stringWithFormat:@"%d",(int)fabulousNum-1] forState:UIControlStateNormal];
                    
                    [fabulousview.fabulousBtn setTitleColor:RGBCOLOR_I(168, 168, 168) forState:UIControlStateNormal];
                }
            }
        }];
    }else{//点赞
        
        [TopicPublicModel ThumbstData:1 This_id:self.detailmodel.post_details.theme_id Theme_id:self.detailmodel.post_details.theme_id Success:^(id data) {
            TopicPublicModel *model = data;
            if(model.status == 1)
            {
                self.topselectView.fabulousBtn.selected = !self.topselectView.fabulousBtn.selected;
                
                [self.topselectView.fabulousBtn setTitle:[NSString stringWithFormat:@"%d",(int)fabulousNum+1] forState:UIControlStateNormal];
                
                [self.topselectView.fabulousBtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
            }
            
        }];
    }
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
    return 0;
}

- (UICollectionView*)collectionview
{
    if(_collectionview == nil)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionview.frame = CGRectMake(0, Height_NavBar+ZOOM6(80), kScreenWidth, kScreenHeight-Height_NavBar-50-ZOOM6(80));
        _collectionview.backgroundColor = [UIColor clearColor];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        
        [_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
    
        [_collectionview registerNib:[UINib nibWithNibName:@"RemenComtCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RemenCell"];
        
        [_collectionview registerNib:[UINib nibWithNibName:@"CommentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CommentCell"];
        
        __weak CommentCollectionViewController *mycontroller = self;
        //下拉刷新
        [_collectionview addHeaderWithCallback:^{
            
            mycontroller.currPage = 1;
            [mycontroller newestComentData:mycontroller.theme_id];
        }];
        
        //上拉加载
        [_collectionview addFooterWithCallback:^{
            
            [mycontroller newestComentData:mycontroller.theme_id];
        }];

    }
    return _collectionview;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
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
    return count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.remenComments.count)
    {
        if(indexPath.item == 0 || indexPath.item == self.remenComments.count+1)
        {
            RemenComtCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RemenCell" forIndexPath:indexPath];
            indexPath.item ==0?[cell refreshTitle:@"热门评论"]:[cell refreshTitle:@"最新评论"];
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.remenComments.count)
    {
        if(indexPath.item == 0 || indexPath.item == self.remenComments.count+1)
        {
            return CGSizeMake(kScreenWidth, ZOOM6(50));
        }else{
            
            LastCommentsModel *model ;
            if(indexPath.item < self.remenComments.count+1)
            {
                model = self.remenComments[indexPath.item-1];
            }else{
                model = self.newestComments[indexPath.item-(self.remenComments.count +1)- 1];
            }
            
            return CGSizeMake(kScreenWidth, 55 +model.replyCellHeigh+model.replyHeadHeigh+ZOOM6(20));
        }
    }else{
        LastCommentsModel* model = self.newestComments[indexPath.item];
        return CGSizeMake(kScreenWidth, 55 +model.replyCellHeigh+model.replyHeadHeigh+ZOOM6(20));
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(self.remenComments.count)
    {
        if(indexPath.item == 0 || indexPath.item == self.remenComments.count+1)
        {
            
        }else{
            _currentPath = indexPath;
            _currentItem = indexPath.item;
            self.placeHolder.text = @"说一下你的看法吧~";
            [self.textview becomeFirstResponder];
        }
    }else{
        _currentPath = indexPath;
        _currentItem = self.newestComments.count?indexPath.item:999999;
        self.placeHolder.text = @"说一下你的看法吧~";
        [self.textview becomeFirstResponder];
    }
    
}

#pragma mark CelldidselectDelegate
- (void)didselect:(LreplistModel*)model Indexpath:(NSIndexPath *)indexPath
{
    NSString *userid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];
    NSString *theme_user_id = [NSString stringWithFormat:@"%@",self.detailmodel.post_details.user_id];
    if([theme_user_id isEqualToString:userid])//是楼主
    {
        is_reply = YES;
        replistmodel = model;
        _currentPath = indexPath;
        _currentItem = indexPath.item;
        
        if(self.detailmodel.post_details.user_id.intValue == model.base_user_id.intValue)
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
    
    if (!faceBoard) {
        faceBoard = [[FaceBoard alloc] init];
        faceBoard.delegate = self;
        faceBoard.inputTextView = self.textview;
    }

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
    [self loginSuccess:^{
        if (![self.textview.text isEqualToString:@""] && self.textview.text.length != 0 && self.textview.text != nil)
        {
            
            if(_currentItem !=999999 )//回复
            {
                LastCommentsModel *commentmodel ;
                NSString * receive_user_id;
                
                if(self.remenComments.count)
                {
                    if(_currentItem <self.remenComments.count+1)
                    {
                        commentmodel = self.remenComments[_currentItem-1];
//                        receive_user_id = commentmodel.user_id;
                    }else{
                        
                        commentmodel = self.newestComments[_currentItem-2-self.remenComments.count];
//                        receive_user_id = commentmodel.user_id;
                    }
                }else{
                    commentmodel = self.newestComments[_currentItem];
//                    receive_user_id = commentmodel.user_id;
                }
                
                if(is_reply ==YES)
                {
                    receive_user_id = replistmodel.send_user_id;
                }else{
                    receive_user_id = @"";
                }
                
                [TopicPublicModel ReplyData:self.textview.text Comment_id:commentmodel.comment_id Receive_user_id:receive_user_id Success:^(id data) {
                    TopicPublicModel *model = data;
                    if(model.status == 1)
                    {
                        self.currPage = 1;
                        [self loadData];
                        [MBProgressHUD show:@"回复成功" icon:nil view:self.view];
                    }else{
                        [MBProgressHUD show:@"回复失败" icon:nil view:self.view];
                    }
                }];
                
            }else{//评论
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *area = [user objectForKey:USER_ARRER];
                NSString *user_id = self.detailmodel.post_details.user_id;
                
                [TopicPublicModel CommentData:self.textview.text Location:area Theme_id:(NSString*)self.theme_id Base_user_id:user_id Success:^(id data) {
                    TopicPublicModel *model = data;
                    if(model.status == 1)
                    {
                        self.currPage = 1;
                        [self loadData];
                        [MBProgressHUD show:@"评论成功" icon:nil view:self.view];
                    }else{
                        [MBProgressHUD show:@"评论失败" icon:nil view:self.view];
                    }
                    
                }];
                
            }
            _currentItem = 999999;
            
        }else{
            
            [MBProgressHUD show:@"回复内容不能为空" icon:nil view:self.view];
        }
        
        self.textview.text = @"";
        [self.textview resignFirstResponder];
        self.textview.inputView = nil;
        self.replyButton.backgroundColor = RGBCOLOR_I(197, 197, 197);
        
    }];
}

- (void)keyboardWillShow:(NSNotification*)note
{
    NSDictionary *userInfo = [note userInfo];
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //view的偏移
    if(_currentPath)
    {
        UICollectionViewCell *selectCell = [self.collectionview cellForItemAtIndexPath:_currentPath];
        CGFloat history_Y_offset = [selectCell convertRect:selectCell.bounds toView:self.view].origin.y+selectCell.frame.size.height;
        
        CGFloat delta = 0.0;
        delta = history_Y_offset - (self.view.bounds.size.height - faceBoard.frame.size.height-90);
        
        CGPoint offset = self.collectionview.contentOffset;
        offset.y += delta;
        if (offset.y < 0) {
            offset.y = 0;
        }
        [self.collectionview setContentOffset:offset animated:NO];
    }
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.Keyboardview.frame=CGRectMake(0, kApplicationHeight-keyboardFrame.size.height-30, kApplicationWidth, 90);
                         self.distapview.frame=CGRectMake(0, 0, kScreenWidth, ZOOM6(600));
                     }];
    
}

- (void)keyboardWillHide:(NSNotification*)note
{
    NSDictionary *userInfo = [note userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.Keyboardview.frame=CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 90);
                         self.distapview.frame=CGRectMake(0, -ZOOM6(600), kScreenWidth, ZOOM6(600));
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

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
