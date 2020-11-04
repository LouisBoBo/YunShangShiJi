//
//  CommentsViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/4/18.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CommentsViewController.h"
#import "HHHorizontalPagingView.h"
#import "HHContentCollectionView.h"
#import "CommentCollectionViewController.h"
#import "MBProgressHUD+NJ.h"
#import "LastCommentsModel.h"
#import "TopicPublicModel.h"
#import "GlobalTool.h"
#import "FaceBoard.h"
@interface CommentsViewController ()<FaceBoardDelegate,UITextViewDelegate>

@end

@implementation CommentsViewController
{
    FaceBoard *faceBoard;             //键盘
    NSInteger _currentItem;           //当前行
    NSIndexPath *_currentPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadView];
    [self creatMainView];
    [self creatKeyboardView];
    
    _currentItem = 999999;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
//导航条
- (void)creatHeadView
{
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

- (void)creatMainView
{
    self.collectionView1 = [HHContentCollectionView contentCollectionView];
    [self.collectionView1 reloadData:self.theme_id DetailModel:self.detailmodel PageIndex:0];
    self.collectionView = self.collectionView1;
    
    self.collectionView2 = [HHContentCollectionView contentCollectionView];
    [self.collectionView1 reloadData:self.theme_id DetailModel:self.detailmodel PageIndex:1];
    
    NSArray *titles = @[@"全部评论",@"只看楼主"];
    NSMutableArray *buttonArray = [NSMutableArray array];
    for(int i = 0; i < 2; i++) {
        UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"icon_gundongline"] forState:UIControlStateSelected];
        [segmentButton setTitle:titles[i] forState:UIControlStateNormal];
        [segmentButton setTitleColor:RGBCOLOR_I(62, 62, 62) forState:UIControlStateNormal];
        [segmentButton setTitleColor:tarbarrossred forState:UIControlStateSelected];
        segmentButton.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        
        [buttonArray addObject:segmentButton];
    }
    HHHorizontalPagingView *pagingView = [HHHorizontalPagingView pagingViewWithHeaderView:nil headerHeight:0.f segmentButtons:buttonArray segmentHeight:40 contentViews:@[self.collectionView1, self.collectionView2]];
    pagingView.segmentView.backgroundColor = [UIColor whiteColor];
    pagingView.segmentButtonSize = CGSizeMake(100., 35.);//自定义segmentButton的大小
    pagingView.pagingViewSwitchBlock= ^(NSInteger index){
    
        index==0?(self.collectionView = self.collectionView1):(self.collectionView=self.collectionView2);
        self.collectionView.pageIndex = index;
        
        ESWeakSelf;
        self.collectionView.celldidSelectBlock = ^(NSIndexPath *indexpath ,NSString *commentid)
        {
            _currentItem = indexpath.item;
            [__weakSelf.textview becomeFirstResponder];
        };

    };

    //设置需放大头图的top约束
    /*
     pagingView.magnifyTopConstraint = headerView.headerTopConstraint;
     [headerView.headerImageView setImage:[UIImage imageNamed:@"headerImage"]];
     [headerView.headerImageView setContentMode:UIViewContentModeScaleAspectFill];
     */
    
    [self.view addSubview:pagingView];

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
                
                if(self.collectionView1.remenComments.count)
                {
                    if(_currentItem <self.collectionView1.remenComments.count+1)
                    {
                        commentmodel = self.collectionView1.remenComments[_currentItem-1];
                        receive_user_id = commentmodel.user_id;
                    }else{
                        
                        commentmodel = self.collectionView1.newestComments[_currentItem-2-self.collectionView1.remenComments.count];
                        receive_user_id = commentmodel.user_id;
                    }
                }else{
                    commentmodel = self.collectionView1.newestComments[_currentItem];
                    receive_user_id = commentmodel.user_id;
                }
                
//                if(is_reply ==YES)
//                {
//                    receive_user_id = replistmodel.send_user_id;
//                }else{
//                    receive_user_id = @"";
//                }
                
                [TopicPublicModel ReplyData:self.textview.text Comment_id:commentmodel.comment_id Receive_user_id:receive_user_id Success:^(id data) {
                    TopicPublicModel *model = data;
                    if(model.status == 1)
                    {
                        [self.collectionView1.remenComments removeAllObjects];
                        [self.collectionView1.newestComments removeAllObjects];
                        self.collectionView1.currPage = 1;
                        
                        [self.collectionView1 reloadData:self.theme_id DetailModel:self.detailmodel PageIndex:0];
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
                        [self.collectionView1.remenComments removeAllObjects];
                        [self.collectionView1.newestComments removeAllObjects];
                        self.collectionView1.currPage = 1;
                        
                        [self.collectionView1 reloadData:self.theme_id DetailModel:self.detailmodel PageIndex:0];
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
        UICollectionViewCell *selectCell = [self.collectionView1 cellForItemAtIndexPath:_currentPath];
        CGFloat history_Y_offset = [selectCell convertRect:selectCell.bounds toView:self.view].origin.y+selectCell.frame.size.height;
        
        CGFloat delta = 0.0;
        delta = history_Y_offset - (self.view.bounds.size.height - faceBoard.frame.size.height-90);
        
        CGPoint offset = self.collectionView1.contentOffset;
        offset.y += delta;
        if (offset.y < 0) {
            offset.y = 0;
        }
        [self.collectionView1 setContentOffset:offset animated:NO];
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
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
