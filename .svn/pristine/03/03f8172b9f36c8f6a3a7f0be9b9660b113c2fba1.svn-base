//
//  popViewController.m
//  YunShangShiJi
//
//  Created by yssj on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "popViewController.h"
#import "GlobalTool.h"
#import "popCell.h"
#import "ShopDetailModel.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "MBProgressHUD+NJ.h"
#import "NavgationbarView.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"


#define buttonWidth 30
#define buttonHeight 70

@interface popViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_popView;
    UITableView *_myTableView;
    UIButton *_btn;
    
    //商品刷新到第几页
    NSInteger _currentpage1;
    
    //商品总页数
    NSString *_pageCount1;
}


@property(nonatomic,strong)NSArray *imgArray;
@property(nonatomic,strong)NSMutableArray *popArray;

@end

@implementation popViewController

- (void)viewDidLoad {
        [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    _popArray = [NSMutableArray array];
    _currentpage1 = 1;

    _imgArray = @[@"背景图.jpg",@"背景图.jpg",@"背景图.jpg",@"背景图.jpg",@"背景图.jpg"];

    [self setfootPopView];
    
    [self setfootBtn];


}
/**
 *  足迹按钮
 */
-(void)setfootBtn
{
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn.frame = CGRectMake(_popView.frame.size.width-buttonWidth,_popView.frame.size.height/2-buttonHeight/2-5, buttonWidth, buttonHeight);
//    [_btn setBackgroundImage:[UIImage imageNamed:@"足迹框"] forState:UIControlStateNormal];
    [_btn setTitle:@"足 迹" forState:UIControlStateNormal];
    [_btn setTintColor:[UIColor clearColor]];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _btn.selected = YES;
    _btn.tag = 5555;
    [_btn addTarget:self action:@selector(footPrintClick:) forControlEvents:UIControlEventTouchUpInside];
    _btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_popView addSubview:_btn];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:5555];

    //如果往左滑
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        

        if (btn.selected == NO)
        {
            [self disappear];
            btn.selected = YES;
            
        }
        
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        
        if (btn.selected == YES)
        {
            [self showInView];
            btn.selected = NO;
            
        }
        
    }

}
/**
 *  足迹界面
 **/
-(void)setfootPopView
{
    _popView = [[UIView alloc]initWithFrame:CGRectMake(-120,kApplicationHeight/2-180, 150, 360) ];
    _popView.backgroundColor = [UIColor clearColor];
    _popView.userInteractionEnabled = YES;
    [self.view addSubview:_popView];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, _popView.frame.size.width, _popView.frame.size.height)];
    imgView.image = [UIImage imageNamed:@"足迹框"];
    imgView.contentMode = UIViewContentModeScaleToFill;
    [_popView addSubview:imgView];
    
   UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_popView addGestureRecognizer:recognizer];
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [_popView addGestureRecognizer:recognizer];
    
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, 120, 360) style:UITableViewStylePlain];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.bounces = NO;
    
    _myTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _myTableView.backgroundColor = [UIColor blackColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [_myTableView registerNib:[UINib nibWithNibName:@"popCell" bundle:nil]forCellReuseIdentifier:@"cell"];
    [_popView addSubview:_myTableView];
}

#pragma mark 网络请求
-(void)requestHTTP
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];

    
    NSString *url;
        url=[NSString stringWithFormat:@"%@mySteps/queryStepsList?version=%@&token=%@&isApp=true&pager.curPage=%d",[NSObject baseURLStr_H5],VERSION,token,_currentpage1];

    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        //
        
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            
            _pageCount1=responseObject[@"pager"][@"pageCount"];
            
            if(statu.intValue==1)
            {
                
                NSArray *brr=responseObject[@"mysList"];
                if(brr.count)
                {
                    for(NSDictionary *dic in brr)
                    {
                        if(dic !=NULL)
                        {
                            ShopDetailModel *model=[[ShopDetailModel alloc]init];
                            model.def_pic=dic[@"def_pic"];
                            model.isCart=dic[@"isCart"];
                            model.isLike=dic[@"isLike"];
                            model.is_del=dic[@"is_del"];
                            model.kickback=dic[@"kickback"];
                            model.shop_price=dic[@"shop_price"];
                            model.shop_code=dic[@"shop_code"];
                            model.shop_name=dic[@"shop_name"];
                            
                            [_popArray addObject:model];
                            
                        }
                    }
                }
                
                
                
                [_myTableView reloadData];
                
                
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

            else{
                
                [MBProgressHUD show:messsage icon:nil view:nil];
                
            }
            

        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        [MBProgressHUD hideHUDForView:self.view];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    
    
}
#pragma mark UITableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cell";
    popCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ShopDetailModel *model=_popArray[indexPath.row];

    [cell.popImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.def_pic]]placeholderImage:[UIImage imageNamed:@"背景图"]];


    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _popArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //indexpath.row: %d",indexPath.row);
    
}
-(void)footPrintClick:(UIButton *)sender
{
       
    if (sender.selected == YES) {
        [self showInView];
        UIButton *btn = (UIButton *)[self.view viewWithTag:5555];
        btn.selected = NO;

    }else
    {
        [self disappear];
        UIButton *btn = (UIButton *)[self.view viewWithTag:5555];
        btn.selected = YES;

    }


}
-(void)showInView
{
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _popView.frame =CGRectMake(0,kApplicationHeight/2-180, 150, 360);
        
    } completion:^(BOOL finished) {
        
    }];

}

#pragma mark 视图消失
-(void)disappear{

    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    
    
        _popView.frame = CGRectMake(-_myTableView.frame.size.width, kApplicationHeight/2-180, 150, 360);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestHTTP];
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}



@end
