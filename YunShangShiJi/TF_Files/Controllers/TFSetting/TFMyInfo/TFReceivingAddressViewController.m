//
//  TFReceivingAddressViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/20.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFReceivingAddressViewController.h"
#import "TFNewBuildViewController.h"
#import "AddressModel.h"
#import "AddressCell.h"
#import "TFAddressDetailViewController.h"

@interface TFReceivingAddressViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UIView *bgView;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UIButton *addAddressBtn;

@property (nonatomic, strong)UIButton *addNewAddressBtn;


@end

@implementation TFReceivingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"我的收货地址"];

    if([self.adresstype isEqualToString:@"选择收货地址"])
    {
        UIButton *setting=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        setting.frame=CGRectMake(kApplicationWidth-65, 20, 60, 44);
        setting.centerY = Height_NavBar/2+10;
        [setting setTitle:@"管理" forState:UIControlStateNormal];
        setting.titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
        setting.tintColor=[UIColor blackColor];
        [setting addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:setting];
    }
    
    [MBProgressHUD showMessage:@"正在获取收货地址..." afterDeleay:0 WithView:self.view];
    
    /*
     NavgationbarView *mentionview=[[NavgationbarView alloc]init];
     [mentionview showLable:message Controller:self];
     */
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
    [self httpReceivingAddress];
    
}
-(void)rightBtnClick
{
    TFReceivingAddressViewController *adress = [[TFReceivingAddressViewController alloc] init];
    [self.navigationController pushViewController:adress animated:YES];
}
#pragma mark - 获取收获地址
- (void)httpReceivingAddress
{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@address/queryall?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL = [MyMD5 authkey:urlStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    //
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseObject = [NSDictionary changeType:responseObject];
        [self clearBackgroundView:self.view withTag:99999];
        //
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [self.dataArr removeAllObjects];
                if ([responseObject[@"listdt"] count] == 0) {

                    for (UIView *view in self.bgView.subviews) {
                        [view removeFromSuperview];
                    }
                    
                    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+ZOOM(80), kScreenWidth, kScreenHeight-kNavigationheightForIOS7-ZOOM(80))],
                    [self.view addSubview:self.bgView];
                    
                    CGFloat lriv_Margin = ZOOM(304);
                    CGFloat udiv_Margin = ZOOM(250);
                    CGFloat iv_W_H = kScreenWidth-lriv_Margin*2;
                    
                    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-iv_W_H)/2, udiv_Margin, iv_W_H, iv_W_H)];
                    iv.image = [UIImage imageNamed:@"地址标示"];
                    
//                    self.bgView.backgroundColor = COLOR_RANDOM;
                    
                    [self.bgView addSubview:iv];
                    
                    CGFloat udlb_Margin = ZOOM(150);
                    CGFloat label_H = ZOOM(80);
                    
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,  iv.bottom+udlb_Margin, kScreenWidth, label_H)];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.textColor = RGBCOLOR_I(152,152,152);
                    label.text = @"暂无收货地址";
                    label.font = [UIFont systemFontOfSize:ZOOM(60)];
                    
                    [self.bgView addSubview:label];
                    
                    CGFloat lrbtn_Margin = ZOOM(173);
                    CGFloat btn_H = ZOOM(120);
//                    CGFloat udbtn_Margin = ZOOM(227);
                    
                    self.addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    self.addAddressBtn.frame = CGRectMake(lrbtn_Margin, CGRectGetHeight(self.bgView.frame)-btn_H*2, self.bgView.frame.size.width-2*lrbtn_Margin, btn_H);
                    
                    UILabel *addrLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.addAddressBtn.frame), CGRectGetHeight(self.addAddressBtn.frame))];
                    
                    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:@"+ 添加收货地址"];
                    
                    [atStr addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED} range:NSMakeRange(0, atStr.length)];
                    [atStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(80)]} range:NSMakeRange(0, 1)];
                    [atStr addAttributes:@{NSFontAttributeName:kFont6px(34)} range:NSMakeRange(2, atStr.length-2)];
                    
                    addrLabel.attributedText = atStr;
                    addrLabel.textAlignment = NSTextAlignmentCenter;
                    addrLabel.textColor = COLOR_ROSERED;
                    
                    addrLabel.layer.borderWidth = 1;
                    addrLabel.layer.borderColor = [COLOR_ROSERED CGColor];
//                    addrLabel.font = kFont6px(32);
                    [self.addAddressBtn addSubview:addrLabel];
                    
//                    [self.addAddressBtn setBackgroundImage:[UIImage imageNamed:@"添加地址框"] forState:UIControlStateNormal];
//                    [self.addAddressBtn setBackgroundImage:[UIImage imageNamed:@"添加地址框"] forState:UIControlStateHighlighted];
//                    [self.addAddressBtn setTitle:@" 添加收货地址" forState:UIControlStateNormal];
                    
//                    self.addAddressBtn.titleLabel.text = @"添加收货地址";
                    
//                    self.addAddressBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
//                    [self.addAddressBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
                    [self.addAddressBtn addTarget:self action:@selector(addAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    [self.bgView addSubview:self.addAddressBtn];
                    
                } else { //有地址
                    [self createlistUI];
                    NSArray *listdt = responseObject[@"listdt"];
                    for (NSDictionary *dic in listdt) {
                        AddressModel *model = [[AddressModel alloc] init];
                        [model setValuesForKeysWithDictionary:dic];
                        model.ID = dic[@"id"];
                        model.addressArray = [self getAddressStateID:model.province withCityID:model.city witAreaID:model.area withStreetID:model.street];
                        
                        [self.dataArr addObject:model];
                    }
                }
                [self.tableView reloadData];
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络请求失败,请检查网络设置"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
        [self createBackgroundView:self.view andTag:99999 andFrame:frame withImgge:[UIImage imageNamed:@"哭脸"] andText:@"亲,没网了"];
    }];
}
- (void)createlistUI
{
    [self.bgView removeFromSuperview];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar)];
//    self.bgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.bgView];
    
    CGFloat H_btn = ZOOM(120);
    CGFloat Margin_ud_btn = ZOOM(62);
    CGFloat Margin_lr_btn = ZOOM(173);
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bgView.frame.size.height-H_btn-Margin_ud_btn)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.bgView addSubview:self.tableView];

    if(![self.adresstype isEqualToString:@"选择收货地址"])
    {
    self.addNewAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addNewAddressBtn.frame = CGRectMake(Margin_lr_btn, self.bgView.frame.size.height-Margin_ud_btn-H_btn, self.bgView.frame.size.width-2*Margin_lr_btn, H_btn);
    [self.addNewAddressBtn setBackgroundImage:[UIImage imageNamed:@"添加地址框"] forState:UIControlStateNormal];
    [self.addNewAddressBtn setBackgroundImage:[UIImage imageNamed:@"添加地址框"] forState:UIControlStateHighlighted];
    [self.addNewAddressBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    self.addNewAddressBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
    [self.addNewAddressBtn setTitleColor:COLOR_ROSERED forState:UIControlStateNormal];
    [self.addNewAddressBtn addTarget:self action:@selector(addAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.addNewAddressBtn];
    }
}

#pragma mark - tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressCell *cell = (AddressCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return [self getCellHeight:cell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADDRESSCELLID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.addressLabel.preferredMaxLayoutWidth = cell.addressLabel.bounds.size.width;
    [cell receiveDataModel:self.dataArr[indexPath.row]];
    
    if (indexPath.row==0) {
        [[NSUserDefaults standardUserDefaults]setObject:[cell.addressLabel.text substringFromIndex:4] forKey:USER_ADDRESS];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressModel *model = self.dataArr[indexPath.row];
    //model.addressArray %@",model.addressArray);

    if([self.adresstype isEqualToString:@"选择收货地址"])
    {
        //注册通知
        
        NSNotification *notification=[NSNotification notificationWithName:@"changeaddress" object:model];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else{
        
       
        TFAddressDetailViewController *tdvc = [[TFAddressDetailViewController alloc] init];
        tdvc.model = model;
        [self.navigationController pushViewController:tdvc animated:YES];
    }
    
}
//获取Cell高度
- (CGFloat)getCellHeight:(UITableViewCell*)cell
{
    [cell layoutIfNeeded];
    [cell updateConstraintsIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

#pragma mark - 编辑
// 设置删除按钮标题
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

// 是否可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![self.adresstype isEqualToString:@"选择收货地址"])
        return YES;
    return NO;
}
// 编辑模式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模式
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        
        AddressModel *model = self.dataArr[indexPath.row];
        
        [self httpDeleteAddress:model];
        // 从数据源中删除
        [self.dataArr removeObjectAtIndex:indexPath.row];
        // 删除行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}



// 是否支持移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}


#pragma mark - 获取地址
- (NSArray *)getAddressStateID:(NSNumber *)stateNum withCityID:(NSNumber *)cityNum witAreaID:(NSNumber *)areaNum withStreetID:(NSNumber *)streetNum
{
    NSString *state;
    NSString *city;
    NSString *area;
    NSString *street;

    NSArray *stateArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areatbl" ofType:@"plist"]];
    if ([stateNum intValue]!=0) {
        for (NSDictionary *dic in stateArr) {
            if ([dic[@"id"] intValue] == [stateNum intValue]) {
                state = dic[@"state"];
                if ([cityNum intValue]!=0) {
                    NSArray *citiesArr = dic[@"cities"];
                    for (NSDictionary *dic in citiesArr) {
                        if ([dic[@"id"] intValue] == [cityNum intValue]) {
                            city = dic[@"city"];
                            if ([areaNum intValue]!=0) {
                                NSArray *areasArr = dic[@"areas"];
                                for (NSDictionary *dic in areasArr) {
                                    if ([dic[@"id"] intValue] == [areaNum intValue]) {
                                        area = dic[@"area"];
                                        if ([streetNum intValue]!=0) {
                                            NSArray *streetsArr = dic[@"streets"];
                                            for (NSDictionary *dic in streetsArr) {
                                                if ([streetNum intValue] == [dic[@"id"] intValue]) {
                                                    street = dic[@"street"];
                                                    break;
                                                }
                                            }
                                        }
                                        break;
                                    }
                                }
                            }
                            break;
                        }
                    }
                }
                break;
            }
        }
    }
    if (area!=nil&&street!=nil) {
        return [NSArray arrayWithObjects:state,city,area,street, nil];
    } else if (area!=nil&&street == nil) {
        return [NSArray arrayWithObjects:state,city,area, nil];
    } else if (area ==nil&&street == nil) {
        return [NSArray arrayWithObjects:state,city, nil];
    } else
        return nil;
}


- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)addAddressBtnClick:(UIButton *)sender
{
    TFNewBuildViewController *tnvc = [[TFNewBuildViewController alloc] init];
    [self.navigationController pushViewController:tnvc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self httpReceivingAddress];
}


#pragma mark - 网络
- (void)httpDeleteAddress:(AddressModel *)model
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr;
    
        urlStr = [NSString stringWithFormat:@"%@address/delete?version=%@&token=%@&id=%@",[NSObject baseURLStr],VERSION,token,model.ID];
    
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                [MBProgressHUD showSuccess:@"删除成功"];
                
//                for (UIViewController *view in self.navigationController.viewControllers) {
//                    if ([view isKindOfClass:[TFReceivingAddressViewController class]]) {
//                        [(TFReceivingAddressViewController *)view httpReceivingAddress];
//                    }
//                }
//                                TFReceivingAddressViewController *tfRv = (TFReceivingAddressViewController *)self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
                                    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[TFReceivingAddressViewController class]]) {
                                                                        TFReceivingAddressViewController *tfRv = (TFReceivingAddressViewController *)self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];

                                                        [tfRv httpReceivingAddress];
                                    }

                //                [tfRv httpReceivingAddress];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteAddress" object:model];
                
//                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络请求失败,请检查网络设置"];
    }];
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
