//
//  TFHelpCenterViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/17.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFHelpCenterViewController.h"
#import "HelpCenterModel.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "ContactKefuViewController.h"
#import "TFHotQuestionViewController.h"

@interface TFHelpCenterViewController () <UITableViewDataSource,UITableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *titleArr;


@end

@implementation TFHelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [super setNavigationItemLeft:@"帮助中心"];
    
    [self createUI];
}

- (void)createUI
{
    NSArray *titArr = [NSArray arrayWithObjects:@"人工服务-周一至周日：09:00-22:00",
                       @"联系在线客服",
                       @"拨打官方客服电话",
                       @"4008884224",
                       nil];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((35), 0, kScreenWidth-2*(35), (30))];
    label.text = titArr[0];
    label.font = [UIFont systemFontOfSize:(15)];
    label.textAlignment = NSTextAlignmentCenter;
    //[self.view addSubview:label];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0,  label.bottom+(5), kScreenWidth, 1)];
    lineView1.backgroundColor = RGBCOLOR_I(220,220,220);
    //[self.view addSubview:lineView1];
    
    UIImageView *iv1 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-(50))/2,  lineView1.bottom+(10), (50), (50))];
//    iv1.backgroundColor = [UIColor yellowColor];
    iv1.image = [UIImage imageNamed:@"在线客服"];
    iv1.contentMode = UIViewContentModeScaleToFill;
    iv1.userInteractionEnabled = YES;
//    [self.view addSubview:iv1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-(150))/2,  iv1.bottom+(5), (150), (30))];
    label2.text = titArr[1];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont boldSystemFontOfSize:(17)];
//    [self.view addSubview:label2];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0,  label2.bottom+(5), kScreenWidth, 1)];
    lineView2.backgroundColor = RGBCOLOR_I(220,220,220);
//    [self.view addSubview:lineView2];
    
    UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-(50))/2,  lineView2.bottom+(10), (50), (50))];
    iv2.contentMode = UIViewContentModeScaleToFill;
    iv2.image = [UIImage imageNamed:@"客服电话"];
    iv2.userInteractionEnabled = YES;
//    [self.view addSubview:iv2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-(150))/2,  iv2.bottom+(5), (150), (30))];
    label3.text = titArr[2];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont boldSystemFontOfSize:(17)];
//    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-(150))/2,  label3.bottom, (150), (20))];
    label4.text = titArr[3];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont systemFontOfSize:(17)];
//    [self.view addSubview:label4];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0,  label4.bottom+(10), kScreenWidth, 1)];
    lineView3.backgroundColor = RGBCOLOR_I(220,220,220);
//    [self.view addSubview:lineView3];
    
//    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake((20),  lineView3]+(10), (200), (20))];
//    label5.text = titArr[4];
//    label5.font = [UIFont systemFontOfSize:(17)];
//    [self.view addSubview:label5];
    
//    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0,  label5]+(10), kScreenWidth, 1)];
//    lineView4.backgroundColor = RGBCOLOR_I(220,220,220);
//    [self.view addSubview:lineView4];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(iv1.frame.origin.x-(20), iv1.frame.origin.y-(10), iv1.frame.size.width+(40), iv1.frame.size.height+(20));
//    btn.backgroundColor = [UIColor yellowColor];
    btn.tag = 100;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(iv2.frame.origin.x-(20), iv2.frame.origin.y-(10), iv2.frame.size.width+(40), iv2.frame.size.height+(20));
//    btn2.backgroundColor = [UIColor yellowColor];
    btn2.tag = 101;
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn2];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(lineView3.frame))];
    [self.view addSubview:bgView];
    
    [bgView addSubview:label];
    [bgView addSubview:label2];
    [bgView addSubview:label3];
    [bgView addSubview:label4];
    
    
    [bgView addSubview:iv1];
    [bgView addSubview:iv2];
    
    [bgView addSubview:lineView1];
    [bgView addSubview:lineView2];
    [bgView addSubview:lineView3];
    
    
    [bgView addSubview:btn];
    [bgView addSubview:btn2];
    
    //self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  lineView4]+(5), kScreenWidth, kScreenHeight-(5)-( lineView4]+(5)))];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) style:UITableViewStylePlain];
    //self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.delegate = self;
//    self.tableView.backgroundColor = [UIColor yellowColor];
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor yellowColor];
    
    self.tableView.tableHeaderView = bgView;
    [self.view addSubview:self.tableView];
    
    [self httpGetHelp];


}

- (NSArray *)sortTheTitleFromArray:(NSArray *)arr
{
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:arr];
//    for (int i= 0 ; i<arr.count; i++) {
//        NSNumber *num = [NSNumber numberWithInt:i];
//        [muArr addObject:num];
//    }
//    
//    for (int i = 0; i<arr.count; i++) {
//        HelpCenterModel *model = arr[i];
//        int j = [model.sort intValue]-1;
//        [muArr replaceObjectAtIndex:j withObject:model];
//    }
    
    if(muArr.count)
    {
        for (int i = 0; i<muArr.count-1; i++) {
            for (int j = 0; j<muArr.count-1-i; j++) {
                
                if(muArr[j] && muArr[j+1])
                {
                    HelpCenterModel *model = muArr[j];
                    HelpCenterModel *model2 = muArr[j+1];
                    
                    if ([model.sort intValue]>[model2.sort intValue]) {
                        [muArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                    
                }
            }
        }
        
    }
    
    
    return muArr;
}

#pragma mark - tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, (40))];
    view.backgroundColor = kBackgroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(60), 0, kScreenWidth-ZOOM(60)*2, (40))];
    NSDictionary *dic = _titleArr[section];
    label.text = dic[@"title"];
    label.font = [UIFont systemFontOfSize:ZOOM(50)];
    [view addSubview:label];
    return view;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    //%ld",(long)section);
    NSMutableArray *arr = self.dataArr[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HelpCenterModel *model = self.dataArr[indexPath.section][indexPath.row];
    //CGSize size = [model.question sizeWithFont:[UIFont systemFontOfSize:ZOOM(44)] constrainedToSize:CGSizeMake(kScreenWidth-40, 1000)];
    
    CGSize size = [model.question boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(60), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(44)]} context:nil].size;
    
    return size.height+(25);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    HelpCenterModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.text = model.question;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:ZOOM(44)];
    return cell;
}

#pragma mark - cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFHotQuestionViewController *thvc = [[TFHotQuestionViewController alloc] init];
    thvc.titleStr = [_titleArr[indexPath.section] objectForKey:@"title"];
    thvc.model = self.dataArr[indexPath.section][indexPath.row];
    
    if([_typestring isEqualToString:@"聊天"])
    {
        thvc.typestring = _typestring;
        [self presentViewController:thvc animated:YES completion:nil];
    }else{
        [self.navigationController pushViewController:thvc animated:YES];
    }
    
}


#pragma mark - 网络获取帮助的问题
- (void)httpGetHelp
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"%@help/goHelp?token=%@&version=%@",[NSObject baseURLStr],token,VERSION];
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                
                [NSObject saveResponseData:responseObject toPath:urlStr];
                
                [self tableViewGetHelpData:responseObject];
                
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        id responseObject = [NSObject loadResponseWithPath:urlStr];
        
        [self tableViewGetHelpData:responseObject];
        NavgationbarView *nv = [[NavgationbarView alloc] init];
        [nv showLable:@"网络连接失败，请检查网络设置~" Controller:self];
        
    }];
}

- (void)tableViewGetHelpData:(NSDictionary *)responseObject
{
    NSDictionary *helpTypeDic = responseObject[@"helpType"];
    //            //helpTypeDic = %@", helpTypeDic);
    if (helpTypeDic.count!=0) {
        NSArray *allKeyArr = [helpTypeDic allKeys];
        NSArray *allValueArr = [helpTypeDic allValues];
        //                //%@ == %@", allKeyArr, allValueArr);
        for (int i = 0; i<allKeyArr.count; i++) {
            NSMutableDictionary *muDic = [NSMutableDictionary dictionary];
            [muDic setValue:allKeyArr[i] forKey:@"type"];
            [muDic setValue:allValueArr[i] forKey:@"title"];
            [self.titleArr addObject:muDic];
        }
        
    }
    
    if (self.titleArr.count!=0) {
        for (int i = 0; i<self.titleArr.count-1; i++) {
            for (int j = 0; j<self.titleArr.count-i-1; j++) {
                NSDictionary *dic1 = self.titleArr[j];
                NSDictionary *dic2 = self.titleArr[j+1];
                
                if ([dic1[@"type"] intValue] > [dic2[@"type"] intValue]) {
                    [self.titleArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
                
            }
        }
    }
    
    //            //self.title = %@", self.titleArr)
    NSArray *helpsArr = responseObject[@"helps"];
    
    for (NSDictionary *dic in self.titleArr) {
        NSMutableArray *muArr = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dicc in helpsArr) {
            HelpCenterModel *hModel = [[HelpCenterModel alloc] init];
            [hModel setValuesForKeysWithDictionary:dicc];
            hModel.ID = dicc[@"id"];
            
            if ([hModel.type intValue] == [dic[@"type"] intValue]) {
                [muArr addObject:hModel];
            }
        }
        NSArray *sortArr = [self sortTheTitleFromArray:muArr];
        
        [self.dataArr addObject:sortArr];
    }
    
    [self.tableView reloadData];
}

- (void)btnClick:(UIButton *)sender
{
    if (sender.tag == 100) { //联系客服
        
//        [self Message:@"123456"];
        
        
        ContactKefuViewController *contact = [[ContactKefuViewController alloc]init];
        contact.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:contact animated:YES];
    } else if (sender.tag == 101) { //拨打电话
        /*
         *[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4008884224"]]];
         */
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"呼叫客服" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:[NSString stringWithFormat:@"%@", @"4008884224"] otherButtonTitles:nil, nil];
        [sheet showInView:self.view];
        
//        [sheet showWithInView:self.view withBlock:^(NSInteger buttonIndex) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4008884224"]]];
//            MyLog(@"buttonIndex: %ld", (long)buttonIndex);
//        }];
    }
}

- (void)leftBarButtonClick
{
    if([_typestring isEqualToString:@"聊天"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark 聊天
-(void)Message:(NSString*)suppid
{
    if([_typestring isEqualToString:@"聊天"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
//    suppid = @"915";
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    suppid = [user objectForKey:PTEID];

    
    // begin 赵官林 2016.5.26
    [self messageWithSuppid:suppid title:nil model:nil detailType:nil imageurl:nil];
    // end
}


#pragma mark - 懒加载
- (NSMutableArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = [[NSMutableArray alloc] init];
    }
    return _titleArr;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4008884224"]]];
    }
}

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
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
