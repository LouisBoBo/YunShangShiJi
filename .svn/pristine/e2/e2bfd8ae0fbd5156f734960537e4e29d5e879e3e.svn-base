//
//  InvitationViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "InvitationViewController.h"
#import "GlobalTool.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "NavgationbarView.h"
#import "PostTableViewCell.h"
#import "MyMD5.h"
#import "AFNetworking.h"
#import "ForumModel.h"
#import "DShareManager.h"
#import "PopoverView.h"
#import "UIImageView+WebCache.h"
#import "PersonHomepageViewController.h"
#import "CommentCell.h"
#import "ShareShopModel.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ReportViewController.h"


#import "TFLoginView.h"

#define KFacialSizeWidth    20

#define KFacialSizeHeight   20

#define KCharacterWidth     8


#define VIEW_LINE_HEIGHT    24

#define VIEW_LEFT           16

#define VIEW_RIGHT          16

#define VIEW_TOP            8


#define VIEW_WIDTH_MAX      166


typedef NS_ENUM(NSUInteger, POPMode) {
    POPModeComment,
    POPModeLZ,
};

@interface InvitationViewController ()<PopoverViewDelegate>
{
    POPMode _popMode;
    
    UIView *_headView;
    UIScrollView *_Myscrollview;
    UIView *_pinglunView;
    
    ForumModel *_forummodel;
    
    UITableView *_commentTableview;
    NSMutableArray *_commentArray;
    
    
    BOOL isFirstShowKeyboard;
    
    BOOL isButtonClicked;
    
    BOOL isKeyboardShowing;
    
    BOOL isSystemBoardShow;
    
    CGFloat _keyboardMove;
    
    CGFloat keyboardHeight;
    
    NSMutableArray *messageList;
    
    NSMutableDictionary *sizeList;
    
    FaceBoard *faceBoard;
    
    UIView *toolBar;
    
    UITextView *_textView;
    
    //    UIButton *_keyboardButton;
    
    UIButton *_sendButton;
    
    BOOL _iscollect;
    
    //记录创建的次数
    NSInteger _creatnumber;
    
    NSString *_shareShopurl;
    
    //当前页
    NSInteger _currentPage;
    
    //总页数
    NSInteger _pageCount;
    
    //记录是否是发表评论
    NSString *sendermessage;
    
}
@end

@implementation InvitationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _iscollect=NO;
    _commentArray=[NSMutableArray array];
    _currentPage = 1;
    
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //    headview.image=[UIImage imageNamed:@"u265"];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"帖子详情";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    //分享
    UIButton *selectbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectbtn.frame=CGRectMake(kApplicationWidth-90, 30, 25, 25);
    selectbtn.titleLabel.font=[UIFont systemFontOfSize:12];
    selectbtn.tintColor=[UIColor blackColor];
    //    [selectbtn setBackgroundImage:[UIImage imageNamed:@"u1721"] forState:UIControlStateNormal];
    [selectbtn setImage:[UIImage imageNamed:@"分享-"]  forState:UIControlStateNormal];
    selectbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //    [headview addSubview:selectbtn];
    [selectbtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //收藏---只看楼主
    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchbtn.frame=CGRectMake(kApplicationWidth - 40, 30, 25, 25);
    //    searchbtn.titleLabel.font=[UIFont systemFontOfSize:12];
    searchbtn.tintColor=[UIColor blackColor];
    //    [searchbtn setBackgroundImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [searchbtn setImage:[UIImage imageNamed:@"设置"]  forState:UIControlStateNormal];
    searchbtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [searchbtn addTarget:self action:@selector(moreclick:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:searchbtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-1, kApplicationWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [headview addSubview:line];
    
    [self creatView];
    
    
    
    [self requestHttp];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

#pragma mark 网络请求
-(void)requestHttp
{
    self.model.news_id = @"160";
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    if(token!=nil){
        url=[NSString stringWithFormat:@"%@circleNews/queryNews?version=%@&token=%@&news_id=%@",[NSObject baseURLStr],VERSION,token,self.model.news_id];
    }else
        url=[NSString stringWithFormat:@"%@circleNews/queryNewsUnLogin?version=%@&news_id=%@",[NSObject baseURLStr],VERSION,self.model.news_id];

    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                NSDictionary *dic=responseObject[@"news"];
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.circle_id=dic[@"circle_id"];
                    model.content=dic[@"content"];
                    model.fine=dic[@"fine"];
                    model.pager=dic[@"pager"];
                    model.pic_list=dic[@"pic_list"];
                    model.news_id=dic[@"news_id"];
                    model.send_time=dic[@"send_time"];
                    model.status=dic[@"status"];
                    model.title=dic[@"title"];
                    model.top=dic[@"top"];
                    model.user_id=dic[@"user_id"];
                    model.skim_count=dic[@"skim_count"];
                    model.upic=dic[@"upic"];
                    model.nickname=dic[@"nickname"];
                    model.r_count = dic[@"rn_count"];
                    
                    
                    model.circle_content=responseObject[@"circle"][@"content"];
                    model.circle_title=responseObject[@"circle"][@"title"];
                    
                    _forummodel=model;
                    //userid%@",_forummodel.user_id);
                }
                
                
                _commentTableview.tableHeaderView = [self creatDetailView];
                _creatnumber = 1;
                [self commentHttp];
                
            }
            else if(statu.intValue == 10030){//没登录状态
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud removeObjectForKey:USER_TOKEN];
                LoginViewController *login=[[LoginViewController alloc]init];
                
                login.tag=1000;
                login.loginStatue = @"10030";
                login.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    
}

#pragma mark 评论列表
-(void)commentHttp
{
    
    self.model.news_id = @"160";
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    if (token !=nil) {
        url=[NSString stringWithFormat:@"%@circleReNews/queryList?version=%@&token=%@&news_id=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.model.news_id,(int)_currentPage];
    } else {
        url=[NSString stringWithFormat:@"%@circleReNews/queryLUnlogin?version=%@&token=%@&news_id=%@&pager.curPage=%d",[NSObject baseURLStr],VERSION,token,self.model.news_id,(int)_currentPage];
    }
 
    
    //    url=[NSString stringWithFormat:@"%@circleReNews/queryList?version=V1.0&&token=%@&news_id=%@",[NSObject baseURLStr],token,@"2"];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        [_commentTableview headerEndRefreshing];
        [_commentTableview footerEndRefreshing];
        
        if (_currentPage==1) {
            [_commentArray removeAllObjects];
        }
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                
                
                
                for( NSDictionary *dic in responseObject[@"rennews"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    
                    model.commentcontent=dic[@"content"];
                    
                    model.news_id=dic[@"news_id"];
                    model.nickname=dic[@"nickname"];
                    model.re_id=dic[@"re_id"];
                    model.re_time=dic[@"ren_time"];
                    model.user_id=dic[@"user_id"];
                    model.pic=dic[@"pic"];
                    
                    [_commentArray addObject:model];
                }
                
                _creatnumber = 2;
                
//                [_commentTableview removeFromSuperview];
                
//                [self creatView];

                
                [_commentTableview reloadData];
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_commentTableview headerEndRefreshing];
        [_commentTableview footerEndRefreshing];
        
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    
    
}

#pragma mark 发表评论
-(void)requstSendHttp
{
    self.model.news_id = @"160";
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    MyLog(@"self.circle_id=%@ self.model.news_id=%@",self.circle_id,self.model.news_id);
    
    url=[NSString stringWithFormat:@"%@circleReNews/add?version=%@&token=%@&circle_id=%@&news_id=%@&content=%@",[NSObject baseURLStr],VERSION,token,self.circle_id,self.model.news_id,_textView.text];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        [MBProgressHUD hideHUDForView:self.view];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message;
            
            if(statu.intValue==1)//请求成功
            {
                
                
                message=@"发表评论成功";
                
                sendermessage =@"发表评论";
                
//                if(_commentArray)
//                {
//                    if(_commentArray.count % 10 ==0)
//                    {
//                        
//                    }else{
//                        _currentPage -=1;
//                    }
//                    
//                }
                
//                [_commentArray removeAllObjects];
                _currentPage=1;
                [self commentHttp];
                
                //刷新列表评论数
                NSNotification *commentnote = [[NSNotification alloc]initWithName:@"commentSuccess" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:commentnote];
                
                //刷新当前评论数
                UILabel *pinglunlable = (UILabel*)[self.view viewWithTag:8787];
                pinglunlable.text = [NSString stringWithFormat:@"%d",_forummodel.r_count.intValue +1];
                _forummodel.r_count = pinglunlable.text;
                
            }else{
                message=@"发表评论失败";
                
                sendermessage =@"";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    
    
}

#pragma mark 收藏帖子
-(void)collectHttp
{
    self.model.news_id = @"160";
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@circleNews/collectNews?version=%@&token=%@&news_id=%@&circle_id=%@",[NSObject baseURLStr],VERSION,token,self.model.news_id,self.circle_id];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message=responseObject[@"message"];
            
            if(statu.intValue==1)//请求成功
            {
                message=@"收藏帖子成功";
                
            }
            else{
                //            message=@"收藏帖子失败";
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    
    
}

#pragma mark 只看楼主
-(void)OnlySeeHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
//    url=[NSString stringWithFormat:@"%@circleReNews/queryList?version=%@&token=%@&news_id=%@&User_id=%@",[NSObject baseURLStr],VERSION,token,self.model.news_id,_forummodel.user_id];
    if (token !=nil) {
        url=[NSString stringWithFormat:@"%@circleReNews/queryList?version=%@&token=%@&news_id=%@&User_id=%@",[NSObject baseURLStr],VERSION,token,self.model.news_id,_forummodel.user_id];
    } else {
        url=[NSString stringWithFormat:@"%@circleReNews/queryLUnlogin?version=%@&news_id=%@&User_id=%@",[NSObject baseURLStr],VERSION,self.model.news_id,_forummodel.user_id];
    }
    
    NSString *URL=[MyMD5 authkey:url];
    [[Animation shareAnimation] createAnimationAt:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            [_commentArray removeAllObjects];
            if(statu.intValue==1)//请求成功
            {
                
                for( NSDictionary *dic in responseObject[@"rennews"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    
                    model.commentcontent=dic[@"content"];
                    
                    model.news_id=dic[@"news_id"];
                    model.nickname=dic[@"nickname"];
                    model.re_id=dic[@"re_id"];
                    model.re_time=dic[@"ren_time"];
                    model.user_id=dic[@"user_id"];
                    model.pic=dic[@"pic"];
                    
                    [_commentArray addObject:model];
                }

//                [self creatView];
                
                [_commentTableview reloadData];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    
}
/*
-(void)creatHeadview
{
    
    CGFloat contentlableHeigh=[self getRowHeight:_forummodel.title];
    //%@ %@  %@",_forummodel.title,_forummodel.circle_content,_forummodel.circle_title);
    //头
    _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth-20, ZOOM(80*3.4))];
    [_Myscrollview addSubview:_headView];
    
    UILabel *circle_contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(29), 10, kApplicationWidth-ZOOM(29)-ZOOM(62), 21)];
    
    circle_contentLabel.text=_forummodel.circle_content;
    
    circle_contentLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    [_headView addSubview:circle_contentLabel];
    
    CGFloat width = [self getRowWidth:[NSString stringWithFormat:@"%@",_forummodel.circle_title]];
    
    UILabel *contentlable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(29), CGRectGetMaxY(circle_contentLabel.frame)+10, width+40, ZOOM(100) )];
    
    contentlable.text=[NSString stringWithFormat:@"%@",_forummodel.circle_title];
    
    contentlable.font = [UIFont systemFontOfSize:ZOOM(51)];
    contentlable.textColor = kTextColor;
    contentlable.textAlignment =NSTextAlignmentCenter;
    contentlable.layer.borderWidth=1;
    contentlable.layer.borderColor = kTextColor.CGColor;
    contentlable.layer.cornerRadius = contentlable.frame.size.height/2;
    [_headView addSubview:contentlable];
    
    
    //浏览量
    UIImageView *liulanimg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"查看"]];
    liulanimg.contentMode = UIViewContentModeScaleAspectFit;
    liulanimg.frame=CGRectMake(kApplicationWidth-150, CGRectGetMaxY(contentlable.frame)-15, 20, 20);
    
    UILabel *liulanlable=[[UILabel alloc]initWithFrame:CGRectMake(liulanimg.frame.origin.x+liulanimg.frame.size.width+10, liulanimg.frame.origin.y, 50, 20)];
    liulanlable.text=[NSString stringWithFormat:@"%@",_forummodel.skim_count];
    liulanlable.textColor=kTextColor;
    liulanlable.font=[UIFont systemFontOfSize:ZOOM(40)];
    
    //评论量
    UIImageView *pinglunimg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"评论-1"]];
    pinglunimg.contentMode = UIViewContentModeScaleAspectFit;
    pinglunimg.frame=CGRectMake(liulanlable.frame.origin.x+liulanlable.frame.size.width+5, liulanimg.frame.origin.y+3, 15, 15);
    
    UILabel *pinglunlable=[[UILabel alloc]initWithFrame:CGRectMake(pinglunimg.frame.origin.x+20, liulanimg.frame.origin.y, 60, 20)];
    pinglunlable.text=[NSString stringWithFormat:@"%@",_forummodel.r_count];
    pinglunlable.textColor=kTextColor;
    pinglunlable.font=[UIFont systemFontOfSize:ZOOM(40)];
    
    [_headView addSubview:liulanimg];
    [_headView addSubview:liulanlable];
    [_headView addSubview:pinglunimg];
    [_headView addSubview:pinglunlable];
    
    
    
}
*/
/*
#pragma mark 创建界面
-(void)creatView
{
    _Myscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, kApplicationHeight-64+kUnderStatusBarStartY)];
    _Myscrollview.delegate=self;
    _Myscrollview.userInteractionEnabled=YES;
    _Myscrollview.backgroundColor=[UIColor whiteColor];
    _Myscrollview.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_Myscrollview];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_Myscrollview addGestureRecognizer:tapGestureRecognizer];
    //内容
    [self creatHeadview];
    
    
    UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(0,_headView.frame.origin.y+ _headView.frame.size.height, kApplicationWidth, 0.5)];
    lableline.backgroundColor=lineGreyColor;
    [_Myscrollview addSubview:lableline];
    
    //头像
    UIImageView *headimage=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(32), lableline.frame.origin.y+ZOOM(32), ZOOM(130), ZOOM(130))];
    headimage.clipsToBounds=YES;
    headimage.layer.cornerRadius=ZOOM(130)/2;
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],_forummodel.upic]];
    if ([_forummodel.upic hasPrefix:@"http://"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_forummodel.upic]];
    }
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [headimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            headimage.image = image;
        }
    }];
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.frame = CGRectMake(kScreenWidth-150-ZOOM(32), CGRectGetMaxY(headimage.frame)-21, 150, 21);
    timeLabel.text=[MyMD5 getTimeToShowWithTimestamp:_forummodel.send_time];
    timeLabel.font=[UIFont systemFontOfSize:ZOOM(34)];
    timeLabel.textAlignment=NSTextAlignmentRight;
    timeLabel.textColor=[UIColor lightGrayColor];
    UILabel *rowLabel = [[UILabel alloc]init];
    rowLabel.frame = CGRectMake(timeLabel.frame.origin.x, CGRectGetMinY(timeLabel.frame)-27, 150,21);
    rowLabel.text = @"楼主";
    rowLabel.font=[UIFont systemFontOfSize:ZOOM(34)];
    rowLabel.textAlignment=NSTextAlignmentRight;
    rowLabel.textColor=[UIColor lightGrayColor];
    
    [_Myscrollview addSubview:timeLabel];
    [_Myscrollview addSubview:rowLabel];
    [_Myscrollview addSubview:headimage];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headimageclick:)];
    [headimage addGestureRecognizer:tap];
    headimage.userInteractionEnabled=YES;
    
    
    UILabel *namelable=[[UILabel alloc]initWithFrame:CGRectMake(headimage.frame.origin.x+headimage.frame.size.width+ZOOM(24), headimage.frame.origin.y +(headimage.frame.size.height - 20)/2, 150, 20)];
    namelable.text=_forummodel.nickname;
    namelable.font=[UIFont systemFontOfSize:ZOOM(48)];
    namelable.textColor=tarbarrossred;
    [_Myscrollview addSubview:namelable];
    
    
    //描述内容
    UILabel *discriptionLable=[[UILabel alloc]initWithFrame:CGRectMake(10, headimage.frame.origin.y+headimage.frame.size.height+5, kApplicationWidth-20, 30)];
    discriptionLable.text=[NSString stringWithFormat:@"%@",_forummodel.content];
    discriptionLable.numberOfLines=0;
    discriptionLable.font = [UIFont systemFontOfSize:ZOOM(48)];
    discriptionLable.textColor = kTitleColor;
    CGFloat discriptonHeigh=[self getRowHeight:discriptionLable.text];
    discriptionLable.frame=CGRectMake(10, headimage.frame.origin.y+headimage.frame.size.height+5, kApplicationWidth-20, discriptonHeigh);
    [_Myscrollview addSubview:discriptionLable];
    
    
    //大图
    NSArray *imageArray=[_forummodel.pic_list componentsSeparatedByString:@","];
    
    NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:imageArray];
    for(int i =0;i<imagesArray.count;i++)
    {
        NSString *str = imagesArray[i];
        
        if([str isEqualToString:@""])
        {
            [imagesArray removeObjectAtIndex:i];
        }
    }
    
    imageArray = [NSArray arrayWithArray:imagesArray];
    
    
    NSMutableArray *imageHeightArr = [[NSMutableArray alloc] init];;
    NSMutableArray *images = [NSMutableArray array];
    
    CGFloat headviewheigh;
    
    for(int i=0 ; i<imageArray.count;i++)
    {
        
        NSString *detailimage =imageArray[i];
        
        NSArray *arr =[detailimage componentsSeparatedByString:@":"];
        
        CGFloat scale;
        
        if(arr.count == 2)
        {
            scale = [arr[1] floatValue];
        }
        
        
        UIImageView *bigimg=[[UIImageView alloc]initWithFrame:CGRectMake(10, discriptionLable.frame.origin.y+discriptionLable.frame.size.height+310*i+10, kApplicationWidth-20, kApplicationWidth/scale)];
        
        UIImageView *defaultimage=[[UIImageView alloc]initWithFrame:CGRectMake((bigimg.frame.size.width-IMGSIZEW(@"iconfont-icon 拷贝副本"))/2, (300-IMGSIZEH(@"iconfont-icon 拷贝副本"))/2, IMGSIZEW(@"iconfont-icon 拷贝副本"), IMGSIZEH(@"iconfont-icon 拷贝副本"))];
        defaultimage.tag=7777+i;
        defaultimage.image=[UIImage imageNamed:@"iconfont-icon 拷贝副本"];
        [bigimg addSubview:defaultimage];
        
        [_Myscrollview addSubview:bigimg];
        
        headviewheigh +=bigimg.frame.size.height;
    }
    
    
    _Myscrollview.contentSize=CGSizeMake(0, discriptionLable.frame.origin.y+discriptionLable.frame.size.height+headviewheigh);
    
    
    __block CGFloat imageHeigh = 0;
    if(imageArray.count)
    {
        
        for(int i=0;i<imageArray.count;i++)
        {
            
            NSString *detailimage =imageArray[i];
            
            NSArray *arr =[detailimage componentsSeparatedByString:@":"];
            
            NSString *imageurl;
            CGFloat scale;
            if(arr.count==2)
            {
                imageurl =arr[0];
                scale = [arr[1] floatValue];
            }
            
            
            CGFloat height;
            
            if(scale)
            {
                height = kApplicationWidth/scale;
            }
            
            
            UIImageView *bigimg=[[UIImageView alloc]initWithFrame:CGRectMake(10, discriptionLable.frame.origin.y+discriptionLable.frame.size.height+imageHeigh+ i*10, kApplicationWidth-20,height)];
            
            if (height) {
                
                [imageHeightArr addObject:@(height)];
                imageHeigh += height;
            }
            
            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],imageurl]];
            
            if ([imageurl hasPrefix:@"http://"]) {
                imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageurl]];
            }
            
            __block float d = 0;
            __block BOOL isDownlaod = NO;
            
            
            [bigimg sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                d = (float)receivedSize/expectedSize;
                isDownlaod = YES;
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                
                
                if (image != nil && isDownlaod == YES) {
                    bigimg.alpha = 0;
                    [UIView animateWithDuration:0.5 animations:^{
                        bigimg.alpha = 1;
                    } completion:^(BOOL finished) {
                    }];
                } else if (image != nil && isDownlaod == NO) {
                    
                    
                    
                    bigimg.image = image;
                }
            }];
            
            
            
            if(_creatnumber !=1)
            {
                
                UIImageView *imageView =(UIImageView*)[_Myscrollview viewWithTag:7777+i];
                [imageView removeFromSuperview];
                
                [_Myscrollview addSubview:bigimg];
            }
            
            
        }
        
        
    }
    
    
#pragma mark - 主线程
    //                    if (i == imageArray.count-2)
    {
        
        UIButton *commentBtn=[[UIButton alloc]initWithFrame:CGRectMake(kApplicationWidth - 80,  discriptionLable.frame.origin.y+discriptionLable.frame.size.height+imageHeigh+10 *(imageArray.count), 70, 20)];
        [commentBtn setImage:[UIImage imageNamed:@"回复"] forState:UIControlStateNormal];
        [commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal    ];
        [commentBtn setTitle:@" 回复" forState:UIControlStateNormal];
        commentBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
        commentBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_Myscrollview addSubview:commentBtn];
        
        
        UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0,commentBtn.frame.origin.y + commentBtn.frame.size.height+5, kApplicationWidth, 0.5)];
        line.backgroundColor=lineGreyColor;
        [_Myscrollview addSubview:line];
        
        CGFloat tableviewHeigh=_commentArray.count*(ZOOM(300)+21);
        
        _commentTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, line.frame.origin.y+10, kApplicationWidth, tableviewHeigh) style:UITableViewStylePlain];
        _commentTableview.delegate=self;
        _commentTableview.dataSource=self;
        //        _commentTableview.rowHeight=80;
        _commentTableview.scrollEnabled=NO;
        _commentTableview.backgroundColor = tarbarrossred;
        _commentTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _commentTableview.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
        
        [_commentTableview registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        
        [_Myscrollview addSubview:_commentTableview];
        
        
        //评论
        _pinglunView=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+20, kApplicationWidth, 80)];
        _pinglunView.frame=CGRectMake(0, kApplicationHeight-40+kUnderStatusBarStartY, kApplicationWidth, 80);
        _pinglunView.backgroundColor=kBackgroundColor;
        toolBar=_pinglunView;
        
        UITextView *pingluntextview=[[UITextView alloc]initWithFrame:CGRectMake(10, 5, kApplicationWidth-80, 30)];
        [_pinglunView addSubview:pingluntextview];
        pingluntextview.delegate=self;
        _textView=pingluntextview;
        
        UIButton *imagebut=[UIButton buttonWithType:UIButtonTypeCustom];
        imagebut.frame=CGRectMake(10, 5, 30, 30);
        imagebut.layer.cornerRadius=15;
        [imagebut setBackgroundImage:[UIImage imageNamed:@"board_emoji.png"] forState:UIControlStateNormal];
        [imagebut addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *sendbut=[UIButton buttonWithType:UIButtonTypeCustom];
        sendbut.frame=CGRectMake(kApplicationWidth-70, 5, 60, 30);
        sendbut.layer.cornerRadius=15;
        [sendbut setTitle:@"回复" forState:UIControlStateNormal];
        [sendbut setTitleColor:tarbarrossred forState:UIControlStateNormal];
        [sendbut addTarget:self action:@selector(sendclick:) forControlEvents:UIControlEventTouchUpInside];
        _sendButton=sendbut;
        
        
        [_pinglunView addSubview:sendbut];
        
        [self.view addSubview:_pinglunView];
        
        
        if ( !faceBoard) {
            
            faceBoard = [[FaceBoard alloc] init];
            faceBoard.delegate = self;
            faceBoard.inputTextView = _textView;
        }
        
        [_textView.layer setCornerRadius:6];
        [_textView.layer setMasksToBounds:YES];
        
        isFirstShowKeyboard = YES;
        
        
    }
    _Myscrollview.contentSize=CGSizeMake(0, discriptionLable.frame.origin.y+discriptionLable.frame.size.height+imageHeigh+_commentArray.count*(ZOOM(300)+21)+70);
    
    
    [_Myscrollview addFooterWithCallback:^{
        
        if(_currentPage < _pageCount || _currentPage == _pageCount)
        {
            
            [self commentHttp];
            
        }else{
            
            [_Myscrollview headerEndRefreshing];
            [_Myscrollview footerEndRefreshing];
        }
        
    }];
    
    [_Myscrollview addHeaderWithCallback:^{
        
        _currentPage =1;
        
        [_commentArray removeAllObjects];
        
        [self commentHttp];
        
    }];
    
    
    if([sendermessage isEqualToString:@"发表评论"])
    {
        //        [_Myscrollview setContentOffset:CGPointMake(0,_Myscrollview.contentSize.height-(kApplicationHeight)) animated:YES];
        
        sendermessage=@"";
    }
    
}
*/

-(UIView *)creatDetailView
{
    UIView *Detailview = [[UIView alloc]init];
    
    CGFloat contentlableHeigh=[self getRowHeight:_forummodel.title];
    //%@ %@  %@",_forummodel.title,_forummodel.circle_content,_forummodel.circle_title);

    _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth-20, ZOOM(300))];
    [Detailview addSubview:_headView];
    
    UILabel *circle_contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(29), ZOOM(58), kApplicationWidth-ZOOM(29)*2, 21)];
    circle_contentLabel.text=_forummodel.title;
    
    circle_contentLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    [_headView addSubview:circle_contentLabel];
    
    CGFloat width = [self getRowWidth:[NSString stringWithFormat:@"%@",_forummodel.circle_title]];
    
    UILabel *contentlable=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(29), CGRectGetMaxY(circle_contentLabel.frame)+ZOOM(49), width+40, ZOOM(100) )];
    contentlable.text=[NSString stringWithFormat:@"%@",_forummodel.circle_title];
    contentlable.font = [UIFont systemFontOfSize:ZOOM(51)];
    contentlable.textColor = kTextColor;
    contentlable.textAlignment =NSTextAlignmentCenter;
    contentlable.layer.borderWidth=1;
    contentlable.layer.borderColor = kTextColor.CGColor;
    contentlable.layer.cornerRadius = contentlable.frame.size.height/2;
    [_headView addSubview:contentlable];
    
    
    //浏览量
    UIImageView *liulanimg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"查看"]];
    liulanimg.contentMode = UIViewContentModeScaleAspectFit;
    liulanimg.frame=CGRectMake(kApplicationWidth-150, CGRectGetMaxY(contentlable.frame)-15, 20, 20);
    
    UILabel *liulanlable=[[UILabel alloc]initWithFrame:CGRectMake(liulanimg.frame.origin.x+liulanimg.frame.size.width+10, liulanimg.frame.origin.y, 50, 20)];
    liulanlable.text=[NSString stringWithFormat:@"%@",_forummodel.skim_count];
    liulanlable.textColor=kTextColor;
    liulanlable.font=[UIFont systemFontOfSize:ZOOM(40)];
    
    //评论量
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]};
    CGSize textSize = [_forummodel.r_count boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    //%f",textSize.width);
    UILabel *pinglunlable=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM(32)-textSize.width, liulanimg.frame.origin.y, textSize.width, 20)];
    pinglunlable.text=[NSString stringWithFormat:@"%@",_forummodel.r_count];
    pinglunlable.textColor=kTextColor;
    pinglunlable.tag = 8787;
    pinglunlable.textAlignment=NSTextAlignmentRight;
    pinglunlable.font=[UIFont systemFontOfSize:ZOOM(40)];
    
    UIImageView *pinglunimg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"评论-1"]];
    pinglunimg.contentMode = UIViewContentModeScaleAspectFit;
    pinglunimg.frame=CGRectMake(pinglunlable.frame.origin.x-25, liulanimg.frame.origin.y+3, 15, 15);
    
    [_headView addSubview:liulanimg];
    [_headView addSubview:liulanlable];
    [_headView addSubview:pinglunimg];
    [_headView addSubview:pinglunlable];

    
    UILabel *lableline=[[UILabel alloc]initWithFrame:CGRectMake(0,_headView.frame.origin.y+ _headView.frame.size.height, kApplicationWidth, 0.5)];
    lableline.backgroundColor=lineGreyColor;
    [Detailview addSubview:lableline];
    
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, lableline.frame.origin.y, kScreenWidth, 0)];
    [Detailview addSubview:view2];
    //头像
    UIImageView *headimage=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM(32),ZOOM(53), ZOOM(130), ZOOM(130))];
    headimage.clipsToBounds=YES;
    headimage.layer.cornerRadius=ZOOM(130)/2;
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],_forummodel.upic]];
    if ([_forummodel.upic hasPrefix:@"http://"]) {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_forummodel.upic]];
    }
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [headimage sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像.jpg"] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            headimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                headimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            headimage.image = image;
        }
    }];
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.frame = CGRectMake(kScreenWidth-150-ZOOM(32), CGRectGetMidY(headimage.frame), 150, 21);
    timeLabel.text=[MyMD5 getTimeToShowWithTimestamp:_forummodel.send_time];
    timeLabel.font=[UIFont systemFontOfSize:ZOOM(34)];
    timeLabel.textAlignment=NSTextAlignmentRight;
    timeLabel.textColor=[UIColor lightGrayColor];
    UILabel *rowLabel = [[UILabel alloc]init];
    rowLabel.frame = CGRectMake(timeLabel.frame.origin.x, CGRectGetMidY(headimage.frame)-21, 150,21);
    rowLabel.text = @"楼主";
    rowLabel.font=[UIFont systemFontOfSize:ZOOM(34)];
    rowLabel.textAlignment=NSTextAlignmentRight;
    rowLabel.textColor=[UIColor lightGrayColor];
    
    [view2 addSubview:timeLabel];
    [view2 addSubview:rowLabel];
    [view2 addSubview:headimage];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headimageclick:)];
    [headimage addGestureRecognizer:tap];
    headimage.userInteractionEnabled=YES;
    
    
    UILabel *namelable=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headimage.frame)+ZOOM(24), headimage.frame.origin.y +(headimage.frame.size.height - 20)/2, 150, 20)];
    namelable.text=_forummodel.nickname;
    namelable.font=[UIFont systemFontOfSize:ZOOM(48)];
    namelable.textColor=tarbarrossred;
    [view2 addSubview:namelable];
    

    
    //描述内容
    UILabel *discriptionLable=[[UILabel alloc]initWithFrame:CGRectMake(headimage.frame.origin.x, CGRectGetMaxY(headimage.frame)+ZOOM(32), kApplicationWidth-20, 30)];
    discriptionLable.text=[NSString stringWithFormat:@"%@",_forummodel.content];
    discriptionLable.numberOfLines=0;
    discriptionLable.font = [UIFont systemFontOfSize:ZOOM(48)];
    discriptionLable.textColor = kTitleColor;
    CGFloat discriptonHeigh=[self getRowHeight:discriptionLable.text];
    discriptionLable.frame=CGRectMake(headimage.frame.origin.x, CGRectGetMaxY(headimage.frame)+ZOOM(32), kApplicationWidth-20, discriptonHeigh);
    [view2 addSubview:discriptionLable];
    
    
    //大图
    NSArray *imageArray=[_forummodel.pic_list componentsSeparatedByString:@","];
    
    NSMutableArray *imagesArray = [NSMutableArray arrayWithArray:imageArray];
    for(int i =0;i<imagesArray.count;i++)
    {
        NSString *str = imagesArray[i];
        
        if([str isEqualToString:@""])
        {
            [imagesArray removeObjectAtIndex:i];
        }
    }
    
    imageArray = [NSArray arrayWithArray:imagesArray];
    
    
    NSMutableArray *imageHeightArr = [[NSMutableArray alloc] init];;
    NSMutableArray *images = [NSMutableArray array];
    
    CGFloat headviewheigh;
    
    for(int i=0 ; i<imageArray.count;i++)
    {
        
        NSString *detailimage =imageArray[i];
        
        NSArray *arr =[detailimage componentsSeparatedByString:@":"];
        
        CGFloat scale;
        
        if(arr.count == 2)
        {
            scale = [arr[1] floatValue];
        }
        

        UIImageView *bigimg=[[UIImageView alloc]initWithFrame:CGRectMake(10, discriptionLable.frame.origin.y+discriptionLable.frame.size.height+310*i+10, kApplicationWidth-20, kApplicationWidth/scale)];
        UIImageView *defaultimage=[[UIImageView alloc]initWithFrame:CGRectMake((bigimg.frame.size.width-IMGSIZEW(@"iconfont-icon 拷贝副本"))/2, (300-IMGSIZEH(@"iconfont-icon 拷贝副本"))/2, IMGSIZEW(@"iconfont-icon 拷贝副本"), IMGSIZEH(@"iconfont-icon 拷贝副本"))];
        defaultimage.tag=7777+i;
        defaultimage.image=[UIImage imageNamed:@"iconfont-icon 拷贝副本"];
        [bigimg addSubview:defaultimage];
        
        [view2 addSubview:bigimg];
        
        headviewheigh +=bigimg.frame.size.height;
    }
    
    
    
    __block CGFloat imageHeigh = 0;
    if(imageArray.count)
    {
        
        for(int i=0;i<imageArray.count;i++)
        {
            
            NSString *detailimage =imageArray[i];
            
            NSArray *arr =[detailimage componentsSeparatedByString:@":"];
            
            NSString *imageurl;
            CGFloat scale;
            if(arr.count==2)
            {
                imageurl =arr[0];
                scale = [arr[1] floatValue];
            }
            
            
            CGFloat height;
            
            if(scale)
            {
                height = (kApplicationWidth-20)/scale;
            }
            
            
            UIImageView *bigimg=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(discriptionLable.frame)+ZOOM(32)+imageHeigh+ i*10, kApplicationWidth-20,height)];

            if (height) {
                
                [imageHeightArr addObject:@(height)];
                imageHeigh += height;
                
                UIImageView *defaultimage = (UIImageView*)[view2 viewWithTag:7777+i];
                [defaultimage removeFromSuperview];
            }

            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!560",[NSObject baseURLStr_Upy],imageurl]];
            
            if ([imageurl hasPrefix:@"http://"]) {
                imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imageurl]];
            }
            
            __block float d = 0;
            __block BOOL isDownlaod = NO;
            
            UIImageView *big = (UIImageView*)[bigimg viewWithTag:7777+i];
            [bigimg sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                d = (float)receivedSize/expectedSize;
                isDownlaod = YES;
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                
                if (image != nil && isDownlaod == YES) {
                    bigimg.alpha = 0;
                    big.hidden = NO;
                    [UIView animateWithDuration:0.5 animations:^{
                        bigimg.alpha = 1;
                    } completion:^(BOOL finished) {
                    }];
                } else if (image != nil && isDownlaod == NO) {
                    
                    big.hidden = YES;
                    bigimg.image = image;
                }
            }];
            
            
            
            //                        [bigimg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!318",[NSObject baseURLStr_Upy],imageurl]]];
            
//            if(_creatnumber !=1)
//            {
            
                
                [view2 addSubview:bigimg];
//            }
            
            
        }
        
        
    }
    //imageheigh  %f   discriptionheigh %f  imgarr.count  %lu",imageHeigh,discriptonHeigh,(unsigned long)imageArray.count);
    view2.frame = CGRectMake(0,CGRectGetMaxY(_headView.frame), kScreenWidth, 20+ZOOM(250)+discriptonHeigh+imageHeigh+10*(imageArray.count));
    //view2   %f     %f",view2.frame.size.height, 20+ZOOM(250)+discriptonHeigh+imageHeigh+(10*(imageArray.count)));
    
//    UIButton *commentBtn=[[UIButton alloc]initWithFrame:CGRectMake(kApplicationWidth - 80,CGRectGetMaxY(view2.frame), 70, 20)];
//    [commentBtn setImage:[UIImage imageNamed:@"回复"] forState:UIControlStateNormal];
//    [commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal    ];
//    [commentBtn setTitle:@" 回复" forState:UIControlStateNormal];
//    commentBtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM(40)];
//    commentBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [Detailview addSubview:commentBtn];
//    
//    
    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(view2.frame), kApplicationWidth, 0.5)];
    line.backgroundColor=lineGreyColor;
    [Detailview addSubview:line];
    
    
    
    
    Detailview.frame = CGRectMake(0, 0, kScreenWidth, view2.frame.size.height+_headView.frame.size.height);
    //detailview  %f  view2  %f  _headview   %f",Detailview.frame.size.height,view2.frame.size.height,_headView.frame.size.height);
//    Detailview.backgroundColor = DRandomColor;
    return Detailview;
}
#pragma mark 创建界面
-(void)creatView
{

    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    //内容
    
 
    
    
#pragma mark - 主线程
    //                    if (i == imageArray.count-2)
    {
        

        
        _commentTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kScreenHeight-(40+Height_NavBar)) style:UITableViewStylePlain];
        _commentTableview.delegate=self;
        _commentTableview.dataSource=self;
        _commentTableview.scrollEnabled=YES;
        _commentTableview.backgroundColor = [UIColor whiteColor];
//        _commentTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _commentTableview.tableFooterView=[[UIView alloc]init];
        _commentTableview.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
//        _commentTableview.tableHeaderView = [self creatDetailView];
        [_commentTableview registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        
        [self.view addSubview:_commentTableview];
        
        
        //评论
        _pinglunView=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight+20, kApplicationWidth, 80)];
        _pinglunView.frame=CGRectMake(0, kApplicationHeight-40+kUnderStatusBarStartY, kApplicationWidth, 80);
        _pinglunView.backgroundColor=kBackgroundColor;
        toolBar=_pinglunView;
        
        UITextView *pingluntextview=[[UITextView alloc]initWithFrame:CGRectMake(10, 5, kApplicationWidth-80, 30)];
        [_pinglunView addSubview:pingluntextview];
        pingluntextview.delegate=self;
        _textView=pingluntextview;
        
        UIButton *imagebut=[UIButton buttonWithType:UIButtonTypeCustom];
        imagebut.frame=CGRectMake(10, 5, 30, 30);
        imagebut.layer.cornerRadius=15;
        [imagebut setBackgroundImage:[UIImage imageNamed:@"board_emoji.png"] forState:UIControlStateNormal];
        [imagebut addTarget:self action:@selector(imageclick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *sendbut=[UIButton buttonWithType:UIButtonTypeCustom];
        sendbut.frame=CGRectMake(kApplicationWidth-70, 5, 60, 30);
        sendbut.layer.cornerRadius=15;
        [sendbut setTitle:@"回复" forState:UIControlStateNormal];
        [sendbut setTitleColor:tarbarrossred forState:UIControlStateNormal];
        [sendbut addTarget:self action:@selector(sendclick:) forControlEvents:UIControlEventTouchUpInside];
        _sendButton=sendbut;
        
        
        [_pinglunView addSubview:sendbut];
        
        [self.view addSubview:_pinglunView];
        
        
        if ( !faceBoard) {
            
            faceBoard = [[FaceBoard alloc] init];
            faceBoard.delegate = self;
            faceBoard.inputTextView = _textView;
        }
        
        [_textView.layer setCornerRadius:6];
        [_textView.layer setMasksToBounds:YES];
        
        isFirstShowKeyboard = YES;
        
        
    }
    
    
    [_commentTableview addFooterWithCallback:^{
        
//        if(_currentPage < _pageCount || _currentPage == _pageCount)
//        {
            _currentPage++;
            [self commentHttp];
            
//        }else{
//            
//            [_commentTableview headerEndRefreshing];
//            [_commentTableview footerEndRefreshing];
//        }
        
    }];
    
    [_commentTableview addHeaderWithCallback:^{
        
        _currentPage =1;
        
        if(_popMode == POPModeLZ)
        {
            [_commentTableview headerEndRefreshing];
        }else{
            [self commentHttp];

        }
        
    }];
    
    
    if([sendermessage isEqualToString:@"发表评论"])
    {
        //        [_Myscrollview setContentOffset:CGPointMake(0,_Myscrollview.contentSize.height-(kApplicationHeight)) animated:YES];
        
        sendermessage=@"";
    }
    
}

#pragma mark 头像点击
-(void)headimageclick:(UITapGestureRecognizer*)tap
{
    PersonHomepageViewController *person=[[PersonHomepageViewController alloc]init];
    person.userid=_forummodel.user_id;
    person.forumModel=_forummodel;
    [self.navigationController pushViewController:person animated:YES];
}

-(void)imgClick:(UIButton *)sender
{
    CommentCell * cell;
    if (kIOSVersions >= 7.0 && kIOSVersions < 8) {
        cell = [[(CommentCell *)[sender superview]superview]superview] ;
    }else{
        cell = (CommentCell *)[[sender superview] superview];
    }
    
    NSIndexPath * path = [_commentTableview indexPathForCell:cell];
    ForumModel *model = _commentArray[path.row];
    
    PersonHomepageViewController *person=[[PersonHomepageViewController alloc]init];
    person.userid=model.user_id;
    person.forumModel=model;
    [self.navigationController pushViewController:person animated:YES];
}
-(void)viewDidLayoutSubviews
{
    if ([_commentTableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [_commentTableview setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([_commentTableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [_commentTableview setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (_popMode == POPModeLZ) {
//        return 0;
//    }
    
    MyLog(@"_commentArray.count = %d",_commentArray.count);
    
    return _commentArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForumModel *model = _commentArray[indexPath.row];
    return ZOOM(300)+[self getRowHeight:model.commentcontent];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    ForumModel *model = _commentArray[indexPath.row];

    
    //    NSString *time=[MyMD5 compareCurrentTime:model.re_time];
    
    //re_time = %@", model.re_time);
    
    cell.timeLabel.text=[NSString stringWithFormat:@"%@",[MyMD5 getTimeToShowWithTimestamp:model.re_time]];
    cell.timeLabel.font=[UIFont systemFontOfSize:ZOOM(34)];
    
    //nickname = %@", model.nickname);
    
    if (![model.nickname isEqual:[NSNull null]]) {
        cell.nameLabel.text=model.nickname;
    } else
        cell.nameLabel.text= @"";
    
    cell.headImg.clipsToBounds = YES;
    cell.headImg.layer.cornerRadius = cell.headImg.frame.size.width/2;


//    cell.ImgBtn.backgroundColor = DRandomColor;

    [cell.ImgBtn addTarget:self action:@selector(imgClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],model.pic]];
    if (![model.pic isEqual:[NSNull null]]) {
        if ([model.pic hasPrefix:@"http://"]) {
            imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]];
        }
    }
    
    MyLog(@"imgUrl = %@",imgUrl);
    
    [cell.headImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"默认头像"]];
    
    if (indexPath.row == 0) {
        cell.rowLabel.text = @"沙发";
    }else if (indexPath.row == 1){
        cell.rowLabel.text = @"板凳";
    }else{
        cell.rowLabel.text = [NSString stringWithFormat:@"%d楼",indexPath.row+1];
    }
    cell.rowLabel.font = [UIFont systemFontOfSize:ZOOM(34)];
    
//    cell.line.frame = CGRectMake(0, ZOOM(300)+20, cell.frame.size.width, 0.5);
    cell.line.hidden=YES;
    
    cell.commentLabel.text = model.commentcontent;
    cell.commentLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    cell.commentLabel.numberOfLines=0;
    cell.commentLabel.frame = CGRectMake(cell.headImg.frame.origin.x, CGRectGetMaxY(cell.headImg.frame)+ZOOM(51), cell.commentLabel.frame.size.width, [self getRowHeight:model.commentcontent]);
    
    return cell;
}

-(CGFloat)getRowHeight:(NSString *)text
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kApplicationWidth-20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:ZOOM(48)] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    return height;
}

-(CGFloat)getRowWidth:(NSString *)text
{
    //文字高度
    CGFloat width;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(280, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    else{
        
    }
    return width;
}


#pragma mark 头像
-(void)imageclick:(UIButton*)sender
{
    isButtonClicked = YES;
    
    if ( isKeyboardShowing ) {
        
        [_textView resignFirstResponder];
    }
    else {
        
        if ( isFirstShowKeyboard ) {
            
            isFirstShowKeyboard = NO;
            
            isSystemBoardShow = NO;
        }
        
        if ( !isSystemBoardShow ) {
            
            _textView.inputView = faceBoard;
        }
        
        [_textView becomeFirstResponder];
    }
    
}

#pragma mark 发送
-(void)sendclick:(UIButton*)sender
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    if (token!=nil) {
        BOOL needReload = NO;
        if ( ![_textView.text isEqualToString:@""] && _textView.text.length != 0 && _textView.text != nil) {
            
            
            needReload = YES;
            
            NSMutableArray *messageRange = [[NSMutableArray alloc] init];
            [self getMessageRange:_textView.text :messageRange];
            [messageList addObject:messageRange];
            
            
            //        messageRange = [[NSMutableArray alloc] init];
            //        [self getMessageRange:_textView.text :messageRange];
            //        [messageList addObject:messageRange];
            
            [self requstSendHttp];
            
        }else{
            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
            [mentionview showLable:@"回复内容不能为空" Controller:self];
        }
        
        _textView.text = @"";
        //    [self textViewDidChange:_textView];
        
        [_textView resignFirstResponder];
        
        isFirstShowKeyboard = YES;
        
        isButtonClicked = NO;
        
        _textView.inputView = nil;
        
        //    [_keyboardButton setImage:[UIImage imageNamed:@"board_emoji"]forState:UIControlStateNormal];
        
        if ( needReload ) {
            
            
        }

    } else {
        [self pushLoginAndRegisterView];
    }
    
}

#pragma mark 跳转到登录界面
- (void)toLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)pushLoginAndRegisterView
{
    TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
    [tf show];
    
    tf.upBlock = ^() { //注册
        //上键");
        [self toLogin:2000];
    };
    
    tf.downBlock = ^() {// 登录
        //下键");
        [self toLogin:1000];
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    //    [_Myscrollview setContentOffset:CGPointMake(0,-(_keyboardMove)+faceBoard.frame.size.height) animated:YES];
    
}

/** ################################ UIKeyboardNotification ################################ **/

/*
 - (void)keyboardShow:(NSNotification *)notf
 {
 NSDictionary *userInfo = notf.userInfo;
 
 CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
 
 CGRect textFrame = self.nowTextField.frame;
 
 CGFloat y = CGRectGetMaxY(textFrame) - CGRectGetMinY(keyboardFrame);
 //%f %f",CGRectGetMaxY(textFrame),CGRectGetMinY(keyboardFrame));
 
 //    if (CGRectGetMaxY(textFrame) >= CGRectGetMinY(keyboardFrame)) {
 if (y + 64.0f> 0) {
 
 CGFloat y = CGRectGetMinY(keyboardFrame) - CGRectGetMaxY(textFrame);
 CGRect frame = _bigview.frame;
 frame.origin.y = y;
 
 _bigview.frame = frame;
 }
 }
 
 - (void)keyboardHide:(NSNotification *)notf
 {
 
 CGRect frame = _bigview.frame;
 frame.origin.y = 64;
 _bigview.frame = frame;
 }
 */
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [_sendButton becomeFirstResponder];
    
//    [self.view endEditing:YES];
    
}
- (void)keyboardWillShow:(NSNotification *)notification {
    
    isKeyboardShowing = YES;
    
    
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         _pinglunView.frame=CGRectMake(0, kApplicationHeight-keyboardFrame.size.height-20, kApplicationWidth, 80);
                         
                     }];
    
    if ( isFirstShowKeyboard ) {
        
        isFirstShowKeyboard = NO;
        
        isSystemBoardShow = !isButtonClicked;
    }
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         _pinglunView.frame=CGRectMake(0, kApplicationHeight-40+kUnderStatusBarStartY, kApplicationWidth, 80);
                         
                     }];
}


/** ################################ ViewController ################################ **/

- (void)faceBoardClick:(id)sender {
    
    isButtonClicked = YES;
    
    if ( isKeyboardShowing ) {
        
        [_textView resignFirstResponder];
    }
    else {
        
        if ( isFirstShowKeyboard ) {
            
            isFirstShowKeyboard = NO;
            
            isSystemBoardShow = NO;
        }
        
        if ( !isSystemBoardShow ) {
            
            _textView.inputView = faceBoard;
        }
        
        [_textView becomeFirstResponder];
    }
}

- (void)faceBoardHide:(id)sender {
    
    BOOL needReload = NO;
    if ( ![_textView.text isEqualToString:@""] ) {
        
        needReload = YES;
        
        NSMutableArray *messageRange = [[NSMutableArray alloc] init];
        [self getMessageRange:_textView.text :messageRange];
        [messageList addObject:messageRange];
        
        
        messageRange = [[NSMutableArray alloc] init];
        [self getMessageRange:_textView.text :messageRange];
        [messageList addObject:messageRange];
        
    }
    
    _textView.text = nil;
    [self textViewDidChange:_textView];
    
    [_textView resignFirstResponder];
    
    isFirstShowKeyboard = YES;
    
    isButtonClicked = NO;
    
    _textView.inputView = nil;
    
    //    [_keyboardButton setImage:[UIImage imageNamed:@"board_emoji"]forState:UIControlStateNormal];
    
    
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

/**
 *  获取文本尺寸
 */
- (void)getContentSize:(NSIndexPath *)indexPath {
    
    @synchronized ( self ) {
        
        
        CGFloat upX;
        
        CGFloat upY;
        
        CGFloat lastPlusSize;
        
        CGFloat viewWidth;
        
        CGFloat viewHeight;
        
        BOOL isLineReturn;
        
        
        NSArray *messageRange = [messageList objectAtIndex:indexPath.row];
        
        NSDictionary *faceMap = [[NSUserDefaults standardUserDefaults] objectForKey:@"FaceMap"];
        
        UIFont *font = [UIFont systemFontOfSize:16.0f];
        
        isLineReturn = NO;
        
        upX = VIEW_LEFT;
        upY = VIEW_TOP;
        
        for (int index = 0; index < [messageRange count]; index++) {
            
            NSString *str = [messageRange objectAtIndex:index];
            if ( [str hasPrefix:FACE_NAME_HEAD] ) {
                
                //NSString *imageName = [str substringWithRange:NSMakeRange(1, str.length - 2)];
                
                NSArray *imageNames = [faceMap allKeysForObject:str];
                NSString *imageName = nil;
                NSString *imagePath = nil;
                
                if ( imageNames.count > 0 ) {
                    
                    imageName = [imageNames objectAtIndex:0];
                    imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
                }
                
                if ( imagePath ) {
                    
                    if ( upX > ( VIEW_WIDTH_MAX - KFacialSizeWidth ) ) {
                        
                        isLineReturn = YES;
                        
                        upX = VIEW_LEFT;
                        upY += VIEW_LINE_HEIGHT;
                    }
                    
                    upX += KFacialSizeWidth;
                    
                    lastPlusSize = KFacialSizeWidth;
                }
                else {
                    
                    for ( int index = 0; index < str.length; index++) {
                        
                        NSString *character = [str substringWithRange:NSMakeRange( index, 1 )];
                        
                        CGSize size = [character sizeWithFont:font
                                            constrainedToSize:CGSizeMake(VIEW_WIDTH_MAX, VIEW_LINE_HEIGHT * 1.5)];
                        
                        if ( upX > ( VIEW_WIDTH_MAX - KCharacterWidth ) ) {
                            
                            isLineReturn = YES;
                            
                            upX = VIEW_LEFT;
                            upY += VIEW_LINE_HEIGHT;
                        }
                        
                        upX += size.width;
                        
                        lastPlusSize = size.width;
                    }
                }
            }
            else {
                
                for ( int index = 0; index < str.length; index++) {
                    
                    NSString *character = [str substringWithRange:NSMakeRange( index, 1 )];
                    
                    CGSize size = [character sizeWithFont:font
                                        constrainedToSize:CGSizeMake(VIEW_WIDTH_MAX, VIEW_LINE_HEIGHT * 1.5)];
                    
                    if ( upX > ( VIEW_WIDTH_MAX - KCharacterWidth ) ) {
                        
                        isLineReturn = YES;
                        
                        upX = VIEW_LEFT;
                        upY += VIEW_LINE_HEIGHT;
                    }
                    
                    upX += size.width;
                    
                    lastPlusSize = size.width;
                }
            }
        }
        
        if ( isLineReturn ) {
            
            viewWidth = VIEW_WIDTH_MAX + VIEW_LEFT * 2;
        }
        else {
            
            viewWidth = upX + VIEW_LEFT;
        }
        
        viewHeight = upY + VIEW_LINE_HEIGHT + VIEW_TOP;
        
        NSValue *sizeValue = [NSValue valueWithCGSize:CGSizeMake( viewWidth, viewHeight )];
        [sizeList setObject:sizeValue forKey:indexPath];
    }
}

/** ################################ UITextViewDelegate ################################ **/


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    if (token !=nil) {
        
        return YES;
        
    } else {
        
        [self pushLoginAndRegisterView];
        
        return NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    //点击了非删除键
    if( [text length] == 0 ) {
        
        if ( range.length > 1 ) {
            
            return YES;
        }
        else {
            
            [faceBoard backFace];
            
            return NO;
        }
    }
    else {
        
        return YES;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    CGSize size = textView.contentSize;
    size.height -= 2;
    if ( size.height >= 68 ) {
        
        size.height = 68;
    }
    else if ( size.height <= 32 ) {
        
        size.height = 32;
    }
    
    if ( size.height != _textView.frame.size.height ) {
        
        CGFloat span = size.height - _textView.frame.size.height;
        
        CGRect frame = toolBar.frame;
        frame.origin.y -= span;
        frame.size.height += span;
        //        toolBar.frame = frame;
        
        CGFloat centerY = frame.size.height / 2-20;
        
        frame = _textView.frame;
        frame.size = size;
        //        _textView.frame = frame;
        
        CGPoint center = _textView.center;
        center.y = centerY;
        //        _textView.center = center;
        
        //        center = _keyboardButton.center;
        //        center.y = centerY;
        //        _keyboardButton.center = center;
        
        center = _sendButton.center;
        center.y = centerY;
        //        _sendButton.center = center;
    }
    
    
    //    _sendButton.frame=CGRectMake(kApplicationWidth-40, 5, 30, 30);
    //    _keyboardButton.frame=CGRectMake(10, 5, 30, 30);
    //    _textView.frame=CGRectMake(50, 5, kApplicationWidth-100, 30);
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)shareClick:(UIButton*)sender
{
    //获取商品链接
    //    [self shopRequest];
    
    [[DShareManager share] shareList:nil Title:nil];
    
}

#if 0
#pragma mark 获取商品链接请求
- (void)shopRequest
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *shopcode=[user objectForKey:SHOP_CODE];
    NSString *realm = [user objectForKey:USER_REALM];
    
    NSString *url=[NSString stringWithFormat:@"%@shop/getShopLink?version=%@&shop_code=%@&realm=%@",[NSObject baseURLStr],VERSION,shopcode,realm];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        //responseObject is %@",responseObject);
        
        NSString *str=responseObject[@"status"];
        
        if(str.intValue==1)
        {
            
            ShareShopModel *shareModel=[ShareShopModel alloc];
            shareModel.shopUrl=responseObject[@"link"];
            
            _shareShopurl=responseObject[@"link"];
            
            
            NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
            
            NSArray *imageArray = [_ShopModel.four_pic componentsSeparatedByString:@","];
            
            NSString *imgstr;
            if(imageArray.count==3)
            {
                imgstr = imageArray[2];
                
                UIImage *img=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],imgstr]]]];
                
                MyLog(@"w= %f h=%f",img.size.width,img.size.height);
                
            }else if (imageArray.count > 0)
            {
                imgstr = imageArray[0];
            }
            
            [userdefaul setObject:[NSString stringWithFormat:@"%@",imgstr] forKey:SHOP_PIC];
            
            [userdefaul setObject:[NSString stringWithFormat:@"%@",_ShopModel.content] forKey:SHOP_TITLE];
            
            [userdefaul setObject:[NSString stringWithFormat:@"%@",_shareShopurl] forKey:SHOP_LINK];
            
            
            if( !_shareShopurl)
            {
                return;
            }
            
            AppDelegate *app=[[UIApplication sharedApplication] delegate];
            [app shardk];
            
            
            //第一次先分享图片
            
            UIImage *shopImage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],imgstr]]]];
            
            [[DShareManager share] shareList:shopImage Title:_shareShopurl];
            
            
            
            
        }else{
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络异常，请稍后重试" Controller:self];
            
        }
        
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        
    }];
    
    
}
#endif


#pragma mark 回复
-(void)commentBtnClick:(UIButton *)sender
{
    MyLog(@"heigh is =%f",faceBoard.frame.size.height);
    
    //    _keyboardMove =_Myscrollview.contentSize.height-(kApplicationHeight-faceBoard.frame.size.height-80);
    
    //    [_Myscrollview setContentOffset:CGPointMake(0,_keyboardMove) animated:YES];
    
    //    _pinglunView.frame = CGRectMake(0, kApplicationHeight-40+kUnderStatusBarStartY, kApplicationWidth, 80);
    [_textView becomeFirstResponder];
}

-(void)moreclick:(UIButton*)sender
{
    //更多");
    
    NSArray *arr;
    
    if (_popMode == POPModeComment) {
        arr=@[@"只看楼主",@"收藏",@"举报"];
    }else
        arr=@[@"全部",@"收藏",@"举报"];
    
    CGPoint point = CGPointMake(kApplicationWidth-25, 64);
    
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:arr images:nil withSceenWith:kScreenWidth popWith:100 cellTextFont:0];
    //    pop.frame =CGRectMake(kApplicationWidth-100, 64, 80, 80);
    pop.clipsToBounds=YES;
    //    pop.layer.cornerRadius=8;
    pop.tag=8888;
    pop.delegate = self;
    
    [pop show];
    
    
#if 0
    [UIView animateWithDuration:0 animations:^{
        UIImageView *popview;
        if(_iscollect==NO)
        {
            popview=[[UIImageView alloc]initWithFrame:CGRectMake(kApplicationWidth-100, 64, 100, 60)];
            popview.tag=9999;
    
            popview.backgroundColor=kTextGreyColor;
            
            NSArray *arr=@[@"只看楼主",@"收藏"];
            for(int i=0;i<2;i++)
            {
                UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame=CGRectMake(0, 30*i, popview.frame.size.width, 30);
                button.tag=1000+i;
                [button setTitle:arr[i] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(popclick:) forControlEvents:UIControlEventTouchUpInside];
                button.tintColor=tarbarrossred;
                [popview addSubview:button];
                popview.userInteractionEnabled=YES;
            }
            
            [self.view addSubview:popview];
            _iscollect=YES;
        }else{
            UIImageView *imageview=(UIImageView*)[self.view viewWithTag:9999];
            [imageview removeFromSuperview];
            _iscollect=NO;
        }
        
    } completion:^(BOOL finished) {
        
        
    }];
    
#endif
}

#pragma mark --PopoverView 代理
- (void)seletRowAtIndex:(PopoverView *)popoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *arr=@[@"只看楼主",@"收藏"];
    
    if(popoverView.tag==8888)
    {
        if(indexPath.row==0)
        {
            //只看楼主");
            
            if (_popMode == POPModeComment) {
                [self OnlySeeHttp];
            }else
                [self commentHttp];
            
            _popMode = !_popMode;
            
            
            
        }else if(indexPath.row==1){
            //收藏");
            
            NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
            NSString *token =[userdefaul objectForKey:USER_TOKEN];
            
            if(token ==nil)
            {
                [self pushLoginAndRegisterView];
                
                return;
            }
            
            
            [self collectHttp];
        }else{
            //举报");
            
            NSUserDefaults *userdefaul =[NSUserDefaults standardUserDefaults];
            NSString *token =[userdefaul objectForKey:USER_TOKEN];
            
            if(token ==nil)
            {
                [self pushLoginAndRegisterView];
                
                return;
            }

            
            ReportViewController * report =[[ReportViewController alloc]init];
            
            report.userid = _forummodel.user_id;
            report.cicleid = self.model.news_id;
            [self.navigationController pushViewController:report animated:NO];
        }
        
        
    }
    
    
}

/*
-(void)popclick:(UIButton*)sender
{
    if(sender.tag==1000)
    {
        //只看楼主");
        
        for(id vv in _Myscrollview.subviews)
        {
            [vv removeFromSuperview];
        }
        
        [_commentArray removeAllObjects];
        
        [_Myscrollview removeFromSuperview];
        
        [self OnlySeeHttp];
    }else{
        //收藏");
        
        [self collectHttp];
    }
    
    [UIView animateWithDuration:1 animations:^{
        
        UIImageView *imageview=(UIImageView*)[self.view viewWithTag:9999];
        [imageview removeFromSuperview];
        _iscollect=NO;
        
    }];
}
*/

@end
