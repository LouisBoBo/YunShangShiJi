//
//  MessageCenterVC.m
//  YunShangShiJi
//
//  Created by yssj on 2017/2/22.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "MessageCenterVC.h"
#import "AXSampleSwipableHeaderView.h"
#import "AXTabBarItemButton.h"

#import "MessageChildTableViewController.h"
#import "CustomTitleView.h"
#import "YFTestChatViewController.h"
//#import "ChatListViewController.h"

@interface MessageCenterVC ()

@property (nonatomic,strong)NSArray *titleArr;
@end

@implementation MessageCenterVC

- (NSArray *)titleArr {
    if (_titleArr==nil) {
//        _titleArr=@[@"聊天",@"话题",@"系统"];
        _titleArr =  self.type==MessageCenterFromPersonCenter?@[@"聊天",@"话题",@"系统"]:@[@"话题",@"系统"];
    }
    return _titleArr;
}
- (instancetype)initWithType:(MessageCenterType)type {
    if (self = [super init]) {
        self.automaticallyAdjustsScrollViewInsets=NO;
        self.type=type;
        AXSampleSwipableHeaderView *headerView = [[AXSampleSwipableHeaderView alloc] init];
        self.headerView = headerView;
        
        self.tabBar.tabBarButtonFont=[UIFont systemFontOfSize:ZOOM6(32)];
        [self addChildViewControllers];
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
    
        self.automaticallyAdjustsScrollViewInsets=NO;
        
        AXSampleSwipableHeaderView *headerView = [[AXSampleSwipableHeaderView alloc] init];
        self.headerView = headerView;
        
        self.tabBar.tabBarButtonFont=[UIFont systemFontOfSize:ZOOM6(32)];
        [self addChildViewControllers];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.headerView.minimumOfHeight = Height_NavBar;
    self.headerView.maximumOfHeight = Height_NavBar;
    self.bottomInset=0;
    self.headerView.bounces=NO;
    
    [self setNavgationView];

}

- (void)addChildViewControllers {
    
    __block UIViewController *chatlist = nil;
    [self loginVerifySuccess:^{
        if (IsRongCloub) {
            // 融云
           // 目前没弄
//            chatlist = [[YFTestChatViewController alloc] init];
        } else {
            // 环信
//            ChatListViewController * vc=[[ChatListViewController alloc]init];
//            vc.hideNavgationView=YES;;
//            chatlist=vc;
        }
    }];
    
    
    NSMutableArray *arr=[NSMutableArray array];
    for (int i=0; i<self.titleArr.count; i++) {
//        if (i==0&&_type==MessageCenterFromPersonCenter) {
//            chatlist.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.titleArr[i] image:nil tag:0];
//            [arr addObject:chatlist.view];
//        }else {
//            MessageChildTableViewController *vc=[MessageChildTableViewController new];
//            vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.titleArr[i] image:nil tag:0];
//            [arr addObject:vc];
//            if (i==0&&_type==MessageCenterFromTabbar) {//   从密友圈过来请求一次数据
//                [vc loadData:1];
//            }
//        }
        
        MessageChildTableViewController *vc=[MessageChildTableViewController new];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.titleArr[i] image:nil tag:0];
        [arr addObject:vc];
        if (i==0&&_type==MessageCenterFromTabbar) {//   从密友圈过来请求一次数据
            [vc loadData:1];
        }
    }
    self.viewControllers=[arr copy];

    //红点是否显示
    [self.tabBar.tabBarItemButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AXTabBarItemButton *button = obj;
        button.redBadge.hidden = idx==0 ||idx==2 || (idx==1&&![[NSUserDefaults standardUserDefaults]integerForKey:@"TOPICMESSAGE"]);
    }];
}

#pragma mark -BtnClick
- (void)changeSelectedIndex:(NSInteger)selectedIndex {
    [super changeSelectedIndex:selectedIndex];
    MyLog(@"%zd",selectedIndex);
    
    AXTabBarItemButton *button =self.tabBar.tabBarItemButtons[selectedIndex] ;
    button.redBadge.hidden=YES;

    
    if (_type==MessageCenterFromTabbar) {
        [(MessageChildTableViewController *)self.selectedViewController loadData:selectedIndex+1];
    }else if (selectedIndex) {
        [(MessageChildTableViewController *)self.selectedViewController loadData:selectedIndex];
    }
}

- (void)setNavgationView {
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kScreenWidth/2, headview.frame.size.height/2+10);
    titlelable.text = @"消息中心";
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, headview.frame.size.height-0.5, kScreenWidth, 0.5)];
    line.backgroundColor = kNavLineColor;
    [headview addSubview:line];
    
    /******  响应点击事件 ******/
    AXSampleSwipableHeaderView *headerView = (id)self.headerView;
    headerView.interactiveSubviews=@[backbtn];
}
- (void)goBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
