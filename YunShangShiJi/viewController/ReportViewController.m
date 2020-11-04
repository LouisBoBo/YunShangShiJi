//
//  ReportViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/12/11.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "ReportViewController.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "NavgationbarView.h"
#import "MyMD5.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
@interface ReportViewController ()

@end

@implementation ReportViewController
{
    UITableView *_myTableview;
    
    NSArray *_dataArray;
    
    NSString *_version_no;
    
    //举报内容
    NSString *_reportContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    _dataArray =@[@"色情",@"广告",@"反动",@"暴力",@"其它"];
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"举报";
    titlelable.textColor= kMainTitleColor;
    titlelable.font = kNavTitleFontSize;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];

    
    [self creatTableview];
    
}

#pragma mark - 网络举报
- (void)httpCommit
{
    //要获取版本号
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@getVersion?version=%@&type=2",[NSObject baseURLStr],VERSION];
    NSString *URL=[MyMD5 authkey:url];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        NSString *token = [userdefaul objectForKey:USER_TOKEN];
        
        NSString *Userid = [NSString stringWithFormat:@"U:%@",_userid];
        NSString *Cilcleid = [NSString stringWithFormat:@"C:%@",_cicleid];
        
        NSString *sstt = [NSString stringWithFormat:@"%@,%@",Userid,Cilcleid];
        
        _reportContent = [NSString stringWithFormat:@"%@,%@",_reportContent,sstt];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                _version_no = [NSString stringWithFormat:@"%@",responseObject[@"version_no"]];
                //进行提交
                NSString *urlStr;
                if([_version_no isEqualToString:@"<null>"]) //版本号为空
                {
                    //进行提交
                    urlStr = [NSString stringWithFormat:@"%@user/addUserFeedBackInfo?version=%@&content=%@&version_no=%@&token=%@",[NSObject baseURLStr],VERSION,_reportContent,nil,token];
                    
                } else{ // 存在版本号
                    
                    urlStr = [NSString stringWithFormat:@"%@user/addUserFeedBackInfo?version=%@&content=%@&version_no=%@&token=%@",[NSObject baseURLStr],VERSION,_reportContent,_version_no,token];
                }
                
                NSString *URL = [MyMD5 authkey:urlStr];
                
                [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

                    if ([responseObject[@"status"] intValue] == 1) {
                        [MBProgressHUD showSuccess:@"举报成功,谢谢反馈"];
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        [MBProgressHUD showError:responseObject[@"message"]];
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    //                    [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
                    
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
                }];
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)creatTableview
{
    UILabel *titlelable = [[UILabel alloc]initWithFrame:CGRectMake(20, 64, 200, 30)];
    titlelable.text = @"举报类型";
    titlelable.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titlelable];
    
    _myTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, kApplicationWidth, 250)];
    _myTableview.delegate=self;
    _myTableview.dataSource=self;

    [self.view addSubview:_myTableview];

    [self creatokbtn];
}

-(void)creatokbtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    CGFloat buutonYY = CGRectGetMaxY(_myTableview.frame);
    button.frame = CGRectMake(50, buutonYY, kApplicationWidth-100, 40);
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    
    [button addTarget:self action:@selector(okclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)okclick
{
    [self httpCommit];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (UITableViewCell *cell in [tableView visibleCells]) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];


    
        oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    
    _reportContent = _dataArray[indexPath.row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.row==4) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
