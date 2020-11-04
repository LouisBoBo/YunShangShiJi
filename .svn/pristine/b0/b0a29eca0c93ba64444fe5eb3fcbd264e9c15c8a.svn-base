//
//  HelppingCenterViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/20.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "HelppingCenterViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "QuestionModel.h"
@interface HelppingCenterViewController ()

@end

@implementation HelppingCenterViewController
{
    //数据源
    NSMutableArray *_dataArray;
    
    //列表
    UITableView *_MytableView;
    
    //帮助中心网络返回的热门问题
    NSMutableArray *_questionArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray=[NSMutableArray array];

    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
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
    titlelable.text=@"帮助中心";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    //联系在线客服
    UITapGestureRecognizer *servicetap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(service:)];
    [self.serviceView addGestureRecognizer:servicetap];
    self.serviceView.userInteractionEnabled=YES;
    //打电话
    UITapGestureRecognizer *phonetap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phone:)];
    [self.phoneView addGestureRecognizer:phonetap];
    self.phoneView.userInteractionEnabled=YES;
    
    
    [self creatHttp];
    [self creatView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

#pragma mark 在线联系客服
-(void)service:(UITapGestureRecognizer*)tap
{
    //在线联系");
}
#pragma mark 打电话
-(void)phone:(UITapGestureRecognizer*)tap
{
    NSString* phoneNumber = @"400-888-4224";
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

#pragma mark 网络请求
-(void)creatHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@help/goHelp?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)//检测成功
            {
                NSArray *questionArr=responseObject[@"helps"];
                
                _questionArr = [NSMutableArray arrayWithCapacity:50];
                for(NSDictionary *dic in questionArr)
                {
                    QuestionModel *model=[[QuestionModel alloc]init];
                    model.question =dic[@"question"];
                    model.questionID=dic[@"id"];
                    
                    //NSUserDefaults如果要存储自定义数据先转化成NSData类型
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
                    
                    [_questionArr addObject:data];
                    
                }
                //NSUserDefaults存储数组时一定是不可变的
                NSArray *arr=[NSArray arrayWithArray:_questionArr];
                NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
                [userdefaul setObject:arr forKey:USER_QUESTION];
            }
            
            [_MytableView reloadData];

        }
        
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
    }];
    
    
}


#pragma mark 界面
-(void)creatView
{
    _MytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 310, kApplicationWidth-20, 200) style:UITableViewStylePlain];
    _MytableView.dataSource=self;
    _MytableView.delegate=self;
    _MytableView.rowHeight=40;
    [self.view addSubview:_MytableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSData *data = _dataArray[indexPath.row];
    QuestionModel *questionMldel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //id is %@ question is %@",questionMldel.questionID,questionMldel.question);
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    
    NSString *url=[NSString stringWithFormat:@"%@help/questionOne?id=%@&version=%@&token=%@",[NSObject baseURLStr],questionMldel.questionID,VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];        
        if (responseObject!=nil) {
            NSString *str=responseObject[@"status"];
            
            if(str.intValue==1)//检测成功
            {
                //question is %@",responseObject[@"question"][@"question"]);
            }

        }
        
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
    }];
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    // 网络获得数据源
    if(_questionArr.count)
    {
        _dataArray=_questionArr;
        
    }else{
       
     //本地获得数据源
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        NSMutableArray *arr=[user objectForKey:USER_QUESTION];

        if(arr.count)
        {
            _dataArray=arr;
        }

    }
    
    NSData *data ;
    if(_dataArray.count)
    {
       data = _dataArray[indexPath.row];
    }
    QuestionModel *questionMldel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",questionMldel.question];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
