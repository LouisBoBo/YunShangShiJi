//
//  RefundAndReturnViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/19.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "RefundAndReturnViewController.h"
#import "GlobalTool.h"
#import "RerundViewController.h"
#import "CircleTableViewCell.h"
@interface RefundAndReturnViewController ()
{
    UITableView *_mytableview;
    
    NSMutableArray *_DataArray;
    
    NSArray *imgArray;

    NSArray *subTitleArray;
}
@end

@implementation RefundAndReturnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
    _DataArray=[NSMutableArray array];
    
    imgArray = @[@"退款退货",@"仅退款",@"换货"];
    subTitleArray = @[@"已收到货,需要退还收到的货物",@"未收到货,需要和卖家协商退款",@"收到货不满意,联系卖家协商换货"];
    
    if (_ordermodel.issue_status.integerValue==21)
    {
        imgArray = @[@"退款退货",@"换货"];
    }else if (_ordermodel.issue_status.integerValue==22)
    {
        imgArray = @[@"换货"];
    }
    else if (self.shop_from.integerValue==4&&_ordermodel.status.integerValue==3) {
        imgArray = @[@"退款退货",@"换货"];
    }
    else if (self.shop_from.integerValue==2||(_ordermodel.is_kick.intValue==1&&(_ordermodel.status.intValue==6||_ordermodel.status.intValue==5||_ordermodel.status.intValue==4))) {
        imgArray = @[@"换货"];
        subTitleArray = @[@"收到货不满意,联系卖家协商换货"];
    }
    else if(_ordermodel.orderShopStatus.intValue==0&&(_ordermodel.status.intValue==3||_ordermodel.status.intValue==4||_ordermodel.status.intValue==5||_ordermodel.status.intValue==6))//待收货
    {
        imgArray = @[@"退款退货",@"换货"];
    }
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"选择服务";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self creatView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

-(void)creatView
{
    _mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY)];
    _mytableview.delegate=self;
    _mytableview.dataSource=self;
    _mytableview.rowHeight=90;
    _mytableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mytableview];
    
    [_mytableview registerNib:[UINib nibWithNibName:@"CircleTableViewCell" bundle:nil] forCellReuseIdentifier:@"CilcleCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imgArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    RerundViewController *rerund=[[RerundViewController alloc]init];
    rerund.shop_from=self.shop_from;
    rerund.orderPrice=self.orderPrice;
    rerund.ordermodel=self.ordermodel;
    rerund.order_code=self.ordermodel.order_code;
    rerund.shop_id=self.shop_id;
    
    if (self.shop_from.integerValue==4&&_ordermodel.issue_status.integerValue==3) {
        if(indexPath.row==0)
        {
            rerund.titletext=@"申请退货";
        }else {
            rerund.titletext=@"申请换货";
        }
    }
  else if (self.shop_from.integerValue==2||(_ordermodel.is_kick.intValue==1&&(_ordermodel.status.intValue==6||_ordermodel.status.intValue==5||_ordermodel.status.intValue==4))) {
        rerund.titletext=@"申请换货";
   }else if(_ordermodel.orderShopStatus.intValue==0&&(_ordermodel.status.intValue==3||_ordermodel.status.intValue==4||_ordermodel.status.intValue==5||_ordermodel.status.intValue==6))//待收货
   {
       if(indexPath.row==0)
       {
           rerund.titletext=@"申请退货";
       }else {
           rerund.titletext=@"申请换货";
       }
   }else if(indexPath.row==0)
    {
        rerund.titletext=@"申请退货";
    }else if(indexPath.row==1){
        rerund.titletext=@"申请退款";
    }else{
        rerund.titletext=@"申请换货";
    }
    [self.navigationController pushViewController:rerund animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CilcleCell"];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,89, kApplicationWidth, 1)];
        line.backgroundColor=lineGreyColor;
        [cell addSubview:line];
    }
    cell.imageView.image=[UIImage imageNamed:imgArray[indexPath.row]];
    cell.textLabel.text=imgArray[indexPath.row];
    cell.detailTextLabel.text=subTitleArray[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:ZOOM(44)];
    cell.detailTextLabel.textColor=kTextColor;
    /*
    CircleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CilcleCell"];
    if(!cell)
    {
        cell=[[CircleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CilcleCell"];
    }
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.origin.y+cell.frame.size.height-1, kApplicationWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [cell addSubview:line];
    cell.content.frame=CGRectMake(cell.content.frame.origin.x, cell.content.frame.origin.y, kScreenWidth-cell.headimage.frame.size.width-30, cell.content.frame.size.height);
    if(indexPath.row==0)
    {
        
        cell.title.text=@"退货退款";
        cell.content.text=@"已收到货,需要退还收到的货物";
        cell.headimage.image=[UIImage imageNamed:@"退款退货"];
        
    }else if(indexPath.row==1){
        
        cell.title.text=@"仅退款";
        cell.content.text=@"未收到货,需要和卖家协商退款";
        cell.headimage.image=[UIImage imageNamed:@"仅退款"];


    }else{
        cell.title.text=@"换货";
        cell.content.text=@"收到货不满意,联系卖家协商换款";
        cell.headimage.image=[UIImage imageNamed:@"换货"];

    }
    cell.content.textColor=kTextGreyColor;
    cell.day_count.hidden=YES;
    */
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
