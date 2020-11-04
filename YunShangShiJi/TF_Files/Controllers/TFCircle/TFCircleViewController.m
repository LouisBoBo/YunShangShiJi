//
//  TFCircleViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/11/18.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "TFCircleViewController.h"
#import "TFCircleSubViewController.h"
#import "CollectnewsViewController.h"
#import "PostViewController.h"

#import "TFLoginView.h"
#import "LoginViewController.h"

@interface TFCircleViewController () <UIScrollViewDelegate, TFCircleSubViewControllerDelegate>
{
    BOOL firstComeIn;
    
    //是否是从其它界面过来的
    BOOL _isback;
}

@property (nonatomic, strong)UIView *headView;
@property (nonatomic, strong)UIScrollView *backgroundScrollView;

@property (nonatomic, assign)NSInteger currIndex;
@property (nonatomic, assign)NSInteger countIndex;
@property (nonatomic, strong)UIView *slideView;
@property (nonatomic, strong)UIView *bottomView;


@property (nonatomic ,strong)TFCircleSubViewController  *CircleSub_AVC;
@property (nonatomic ,strong)TFCircleSubViewController  *CircleSub_BVC;
@property (nonatomic ,strong)TFCircleSubViewController  *CircleSub_CVC;
@property (nonatomic ,strong)UIViewController *currentVC;

@end

@implementation TFCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadCircleData) name:@"CircleAdd" object:nil];
    
    _isback = NO;
//    if (!firstComeIn) {
        [self httpCircleTagData];
//    }
    [self createUI];
 
    [self circleSubHttp];

}
-(void)reloadCircleData
{
    [self circleSubHttp];
}
/**
 *  请求标签数据
 */
-(void)httpCircleTagData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
//    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
//    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    NSString *url;
    url=[NSString stringWithFormat:@"%@circleNews/queryTag?version=%@&tag_data=%@",[NSObject baseURLStr],VERSION,@""];
    NSString *URL=[MyMD5 authkey:url];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //%@",responseObject);
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject[@"circle_tag"]!=nil) {
            NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
            NSString*newFielPath = [documentsPath stringByAppendingPathComponent:@"circleTag.txt"];
            
            NSMutableDictionary *dictionary=[NSMutableDictionary dictionary];
            //        NSDictionary *dic = responseObject[@"circle_tag"];
            for(NSDictionary *dic in responseObject[@"circle_tag"]){
                [dictionary setObject:dic[@"tag_name"] forKey:dic[@"id"]];
                //%@,%@,%@",dic[@"tag_name"],responseObject[@"tag_data"],dic[@"id"]);
            }
            
            BOOL isSucceed = [dictionary writeToFile:newFielPath atomically:YES];
            //%d",isSucceed);
            
            NSString* newFielPath1 = [documentsPath stringByAppendingPathComponent:@"circleTag.txt"];
            NSDictionary *content = [NSDictionary dictionaryWithContentsOfFile:newFielPath1];
            //%@",content);
            NSArray *arr=@[@"1"];
            
            NSMutableArray *array=[NSMutableArray array];
            for (int i=0; i<arr.count; i++) {
                NSString *string =[NSString stringWithFormat:@"%@",[content objectForKey:arr[i]] ];
                NSString *str2=[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //%@,%@",string,str2);
                [array addObject:str2];
            }
            //%@",array);
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}
- (void)createUI
{
    NSArray *titleArr = @[@"我的", @"推荐", @"全部"];
    
    self.countIndex = titleArr.count;
    self.currIndex = 1;
    
    
    [self.view addSubview:self.headView];
    
    [self.headView addSubview:self.slideView];
    
    [self.view addSubview:self.backgroundScrollView];
    
    

    
    CGFloat W = kScreenWidth/titleArr.count;
    CGFloat H = 40;
    
    for (int i = 0; i<titleArr.count; i++) {
        
        CGFloat x = i*W;
        CGFloat y = 0;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, W, H);
        
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
//        btn.backgroundColor = COLOR_RANDOM;
        
        [btn setTitleColor:COLOR_ROSERED forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = 100+i;
        
        if (i == self.currIndex) {
            btn.selected = YES;
            
            [self mobileSlideView:self.currIndex];
            self.backgroundScrollView.contentOffset = CGPointMake(kScreenWidth*self.currIndex, 0);
            
        }
        
        [self.headView addSubview:btn];
        
    }
    
    CGFloat H_scroll = CGRectGetHeight(self.backgroundScrollView.frame);
    
    self.CircleSub_AVC = [[TFCircleSubViewController alloc] init];
    self.CircleSub_AVC.CURR_STATUS = CIRCLE_STATUS_MY;
    self.CircleSub_AVC.delegate = self;
    self.CircleSub_AVC.view.frame = CGRectMake(kScreenWidth*0, 0, kScreenWidth, H_scroll-40);
    
    self.CircleSub_BVC = [[TFCircleSubViewController alloc] init];
    self.CircleSub_BVC.CURR_STATUS = CIRCLE_STATUS_RECOMMEND;
    self.CircleSub_BVC.delegate = self;
    self.CircleSub_BVC.view.frame = CGRectMake(kScreenWidth*1, 0, kScreenWidth, H_scroll);
    
    self.CircleSub_CVC = [[TFCircleSubViewController alloc] init];
    self.CircleSub_CVC.CURR_STATUS = CIRCLE_STATUS_ALL;
    self.CircleSub_CVC.delegate = self;
    self.CircleSub_CVC.view.frame = CGRectMake(kScreenWidth*2, 0, kScreenWidth, H_scroll);
    
    [self addChildViewController:self.CircleSub_AVC];
    [self.backgroundScrollView addSubview:self.CircleSub_AVC.view];
    
    [self addChildViewController:self.CircleSub_BVC];
    [self.backgroundScrollView addSubview:self.CircleSub_BVC.view];
    
    [self addChildViewController:self.CircleSub_CVC];
    [self.backgroundScrollView addSubview:self.CircleSub_CVC.view];
    
    self.currentVC  = self.CircleSub_AVC;
    
    [self.backgroundScrollView addSubview:self.bottomView];
    
    UIButton *collectBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    collectBtn.frame=CGRectMake(kApplicationWidth-ZOOM(110)-20,CGRectGetHeight(_backgroundScrollView.frame)-50-ZOOM(110), ZOOM(110), ZOOM(110));
    [collectBtn setBackgroundImage:[UIImage imageNamed:@"圈圈收藏" ]forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(collectbtn:) forControlEvents:UIControlEventTouchUpInside];
    collectBtn.clipsToBounds = YES;
    collectBtn.layer.cornerRadius=15;
    
    [self.backgroundScrollView addSubview:collectBtn];

}

- (void)smileViewSelect:(CIRCLE_STATUS)status
{
//    //选择哪个 %d", (int)status);
    self.currIndex = 2;
    
    [self mobileSlideView:self.currIndex];
    
    for (int i = 0; i<self.countIndex; i++) {
        UIButton *btn = (UIButton *)[self.headView viewWithTag:100+i];
        if (i != self.currIndex) {
            btn.selected = NO;
        } else {
            btn.selected = YES;
        }
    }
    self.backgroundScrollView.contentOffset = CGPointMake(kScreenWidth*self.currIndex, 0);
    
}

- (void)mobileSlideView:(NSInteger)index
{
    CGFloat M = 20;
    CGFloat W = (kScreenWidth-self.countIndex*2*M)/self.countIndex;
    CGFloat x = M+index*(M+W)+index*M;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.slideView.frame = CGRectMake(x, self.slideView.frame.origin.y, self.slideView.frame.size.width, self.slideView.frame.size.height);
    }];

    
}
#pragma mark 跳转到登录界面
- (void)ToLogin :(NSInteger)tag
{
    LoginViewController *login=[[LoginViewController alloc]init];
    login.tag = tag;
    login.loginStatue=@"toBack";
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)ToLoginView
{
    TFLoginView *tf = [[TFLoginView alloc] initWithHeadImage:nil contentText:nil upButtonTitle:nil downButtonTitle:nil];
    [tf show];
    
    tf.upBlock = ^() { //注册
        //上键");
        
        [self ToLogin:2000];
    };
    
    tf.downBlock = ^() {// 登录
        //下键");
        
        [self ToLogin:1000];
    };
}
#pragma mark 收藏的帖子
-(void)collectbtn:(UIButton*)sender
{
    //ok");
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]==nil) {
        [self ToLoginView];
        return;
    }else{
        CollectnewsViewController *collect=[[CollectnewsViewController alloc]init];
        collect.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:collect animated:YES];
    }
}

- (void)btnMoreCircleClick
{
    //更多圈子");
    
    self.currIndex = 2;
    
    [self mobileSlideView:self.currIndex];
    
    for (int i = 0; i<self.countIndex; i++) {
        UIButton *btn = (UIButton *)[self.headView viewWithTag:100+i];
        if (i != self.currIndex) {
            btn.selected = NO;
        } else {
            btn.selected = YES;
        }
    }
    
    
    self.backgroundScrollView.contentOffset = CGPointMake(kScreenWidth*self.currIndex, 0);
    
}

- (void)btnClick:(UIButton *)sender
{
    for (int i = 0; i<self.countIndex; i++) {
        UIButton *btn = (UIButton *)[self.headView viewWithTag:100+i];
        if (i != sender.tag-100) {
            btn.selected = NO;
        } else {
            btn.selected = YES;
            self.currIndex = btn.tag-100;
        }
    }
    
    [self mobileSlideView:self.currIndex];
    self.backgroundScrollView.contentOffset = CGPointMake(kScreenWidth*self.currIndex, 0);
    
    [self circleSubHttp];
    
    
}

- (void)circleSubHttp
{
    switch (self.currIndex) {
        case 0: {
            self.CircleSub_AVC.currPage = 1;
            [self.CircleSub_AVC httpGetData];
            self.CircleSub_AVC.tableView.scrollsToTop=YES;
            self.CircleSub_BVC.tableView.scrollsToTop=NO;
            self.CircleSub_CVC.tableView.scrollsToTop=NO;
        }
            break;
            
        case 1: {
            self.CircleSub_BVC.currPage = 1;
            [self.CircleSub_BVC httpGetData];
            self.CircleSub_AVC.tableView.scrollsToTop=NO;
            self.CircleSub_BVC.tableView.scrollsToTop=YES;
            self.CircleSub_CVC.tableView.scrollsToTop=NO;
        }
            break;
        case 2: {
            self.CircleSub_CVC.currPage = 1;
            [self.CircleSub_CVC httpGetData];
            self.CircleSub_AVC.tableView.scrollsToTop=NO;
            self.CircleSub_BVC.tableView.scrollsToTop=NO;
            self.CircleSub_CVC.tableView.scrollsToTop=YES;
        }
            break;
            
        default:
            break;
    }
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.backgroundScrollView.frame)-40, kScreenWidth, 40)];
        _bottomView.backgroundColor = RGBCOLOR_I(220,220,220);
        
        
        NSString *st = @"更多圈子";
        CGSize size = [st boundingRectWithSize:CGSizeMake(100, 40) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        
        CGFloat W = 20+size.width+10;
        CGFloat X = (kScreenWidth-W)/2.0;
        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(X+20+10, 0, W, 40)];
        lable.text = @"更多圈子";
        lable.textColor = kTitleColor;
        lable.textAlignment=NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:16];
        [_bottomView addSubview:lable];
        
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(X, (_bottomView.frame.size.height-IMGSIZEW(@"+"))/2, IMGSIZEW(@"+"), IMGSIZEH(@"+"))];
        
        imgView.image = [UIImage imageNamed:@"+"];
        imgView.userInteractionEnabled = YES;
        [_bottomView addSubview:imgView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, kScreenWidth, 40);
        [btn addTarget:self action:@selector(btnMoreCircleClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:btn];

    }
    return _bottomView;
}

- (UIScrollView *)backgroundScrollView
{
    if (_backgroundScrollView == nil) {
        _backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar-Height_TabBar)];
        _backgroundScrollView.backgroundColor = [UIColor whiteColor];
//        _backgroundScrollView.backgroundColor = COLOR_RANDOM;
        _backgroundScrollView.contentSize = CGSizeMake(self.countIndex*kScreenWidth, CGRectGetHeight(_backgroundScrollView.frame));
        _backgroundScrollView.pagingEnabled = YES;
        _backgroundScrollView.scrollsToTop=NO;
        _backgroundScrollView.delegate = self;
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _backgroundScrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger oldIndex = self.currIndex;
    NSInteger newIndex = scrollView.contentOffset.x/kScreenWidth;
    
    if (newIndex != oldIndex) {
        
        self.currIndex = newIndex;
        [self mobileSlideView:self.currIndex];
        
        
        for (int i = 0; i<self.countIndex; i++) {
            UIButton *btn = (UIButton *)[self.headView viewWithTag:100+i];
            if (i != self.currIndex) {
                btn.selected = NO;
            } else {
                btn.selected = YES;
            }
        }
        [self circleSubHttp];
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger oldIndex = self.currIndex;
    NSInteger newIndex = scrollView.contentOffset.x/kScreenWidth;
    
    if (newIndex != oldIndex) {
        
        self.currIndex = newIndex;
        [self mobileSlideView:self.currIndex];
        
        
        for (int i = 0; i<self.countIndex; i++) {
            UIButton *btn = (UIButton *)[self.headView viewWithTag:100+i];
            if (i != self.currIndex) {
                btn.selected = NO;
            } else {
                btn.selected = YES;
            }
        }
      [self circleSubHttp];

    }
}

- (UIView *)slideView
{
    if (_slideView == nil) {
        
        CGFloat M = 20;
        CGFloat W = (kScreenWidth-self.countIndex*2*M)/self.countIndex;
        CGFloat H = 2.0f;
        
        CGFloat x = M+self.currIndex*(M+W)+self.currIndex*M;
        
        _slideView = [[UIView alloc] initWithFrame:CGRectMake(x, CGRectGetHeight(self.headView.frame)-2, W, H)];
        _slideView.backgroundColor = COLOR_ROSERED;
        
    }
    return _slideView;
}

- (UIView *)headView
{
    if (_headView == nil) {
        _headView                 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
        _headView.backgroundColor = [UIColor whiteColor];
    }

    return _headView;
}

- (void)backnote:(NSNotification*)note
{
    MyLog(@"8888888888");
    _isback = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    Myview.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backnote:) name:@"backnote" object:nil];
    
    if(_isback==NO)
    {
        self.currIndex = 1;
        
    }
    for (int i = 0; i<self.countIndex; i++) {
        UIButton *btn = (UIButton *)[self.headView viewWithTag:100+i];
        if (i != self.currIndex) {
            btn.selected = NO;
        } else {
            btn.selected = YES;
            self.currIndex = btn.tag-100;
        }
    }
    
    [self mobileSlideView:self.currIndex];
    self.backgroundScrollView.contentOffset = CGPointMake(kScreenWidth*self.currIndex, 0);
    
    _isback = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden = NO;
}
-(void)viewDidAppear:(BOOL)animated
{
//    [self circleSubHttp];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
