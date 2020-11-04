//
//  LogisticsViewController.m
//  YunShangShiJi
//
//  Created by hyj on 15/8/25.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "LogisticsViewController.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "UIImageView+WebCache.h"
#import "MyMD5.h"
#import "ShopDetailViewController.h"
//#import "ChatViewController.h"
#import "RobotManager.h"
#import "GlobalTool.h"
#import "AFNetworking.h"
#import "tableHeadView.h"
//#import "ChatListViewController.h"
 
#import "logistTableViewCell.h"
#import "OrderTableViewCell.h"
#import "AttenceTimelineCell.h"
//#import "ComboShopDetailViewController.h"

@interface LogisticsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LogisticsViewController
{
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    ShopDetailModel *_logisticmodel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];

    //右边设置按钮
//    UIImageView *vir = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-50+(40-25)/2, 20+(44-5)/2, 25, 5)];
//    vir.image = [UIImage imageNamed:@"设置"];
//    vir.userInteractionEnabled = YES;
//    [headview addSubview:vir];
//    UIButton *setbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [setbtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    setbtn.frame=CGRectMake(kScreenWidth-80, 20, 80, 44);
//    [setbtn addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [headview addSubview:setbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"查看物流";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    
    //%@---%@",self.Ordermodel.logi_code,self.Ordermodel.logi_name);
    
     //表头
/*
    tableHeadView *view = [[NSBundle mainBundle] loadNibNamed:@"talbleHeadView" owner:nil options:nil][0];
    CGRect frame = CGRectMake(0, 0, kApplicationWidth, view.frame.size.height+ZOOM(32)*5);
    frame.size.width = kScreenWidth;
    view.frame = frame;
//    view.backgroundColor=[UIColor grayColor];
    CGFloat space = ZOOM(60);
    
    view.logi_name.frame=CGRectMake(space, view.logi_name.frame.origin.y, view.logi_name.frame.size.width, view.logi_name.frame.size.height);
    view.logi_code.frame=CGRectMake(space, view.logi_code.frame.origin.y, view.logi_code.frame.size.width, view.logi_code.frame.size.height);
    view.logi_name.text = self.Ordermodel.logi_name;
    view.logi_name.font = [UIFont systemFontOfSize:ZOOM(48)];
    view.logi_code.text = [NSString stringWithFormat:@"运单编号:%@",self.Ordermodel.logi_code];
    view.logi_code.font = [UIFont systemFontOfSize:ZOOM(44)];
    
    view.detailLabel.frame = CGRectMake(space, view.detailLabel.frame.origin.y+ZOOM(32),view.detailLabel.frame.size.width,view.detailLabel.frame.size.height);
    view.topLine.frame=CGRectMake(0,CGRectGetMaxY(view.detailLabel.frame)+ZOOM(32) , kApplicationWidth, 1);
    
    view.bgView.frame=CGRectMake(0, view.topLine.frame.origin.y+ZOOM(50), kApplicationWidth, view.bgView.frame.size.height+ZOOM(32)*2);
    view.headImage.frame = CGRectMake(space, view.headImage.frame.origin.y, view.headImage.frame.size.width, view.headImage.frame.size.height);
    view.title.frame=CGRectMake(CGRectGetMaxX(view.headImage.frame)+ZOOM(32), view.headImage.frame.origin.y, view.title.frame.size.width-ZOOM(32), view.title.frame.size.height);
    view.color_size.frame=CGRectMake(view.title.frame.origin.x, CGRectGetMaxY(view.title.frame)+ZOOM(32), view.color_size.frame.size.width, view.color_size.frame.size.height);
    view.statue.frame=CGRectMake(kApplicationWidth-ZOOM(62)-view.statue.frame.size.width, view.title.frame.origin.y, view.statue.frame.size.width, view.statue.frame.size.height);
    view.number.frame=CGRectMake(kApplicationWidth-ZOOM(62)-view.number.frame.size.width, view.color_size.frame.origin.y, view.number.frame.size.width, view.number.frame.size.height);
    view.price.frame=CGRectMake(view.title.frame.origin.x, CGRectGetMaxY(view.color_size.frame)+ZOOM(32), view.price.frame.size.width, view.price.frame.size.height);
    

    view.detailLabel.font =[UIFont systemFontOfSize:ZOOM(48)];
    view.logistLabel.font =[UIFont systemFontOfSize:ZOOM(48)];
    view.statue.font = [UIFont systemFontOfSize:ZOOM(44)];
    view.color_size.font=[UIFont systemFontOfSize:ZOOM(44)];
    
    view.logistLabel.frame = CGRectMake(space,CGRectGetMaxY(view.bgView.frame)+ZOOM(32),view.logistLabel.frame.size.width,view.logistLabel.frame.size.height);
    view.bottomLine.frame=CGRectMake(0,CGRectGetMaxY(view.logistLabel.frame)+ZOOM(32) , kApplicationWidth, 1);

    
    ShopDetailModel *shopModel = self.Ordermodel.shopsArray[0];
    
//    [view.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shopModel.shop_pic]]];
    //%@",shopModel.shop_pic);
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shopModel.shop_pic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [view.headImage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            view.headImage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                view.headImage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            view.headImage.image = image;
        }
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [view.bgView addGestureRecognizer:tap];
    view.bgView.userInteractionEnabled = YES;
    //快递图片
    //view.logistImage
    view.title.text=[self exchangeTextWihtString:shopModel.shop_name];
    view.title.font = [UIFont systemFontOfSize:ZOOM(46)];
    
    view.color_size.text=[NSString stringWithFormat:@"颜色:%@ 尺码:%@",shopModel.shop_color,shopModel.shop_size];
    
    view.price.text=[NSString stringWithFormat:@"￥%@",shopModel.shop_price];
    view.number.text=[NSString stringWithFormat:@"x%@",shopModel.shop_num];
    
    //    self.statue.font=[UIFont systemFontOfSize:14];
    view.statue.textColor=tarbarrossred;
    view.number.textColor=kTextColor;
    
    //订单状态
    NSString *statue;
    statue=shopModel.status;
    if(statue !=nil)
    {
        switch (statue.intValue) {
            case 1:
                view.statue.text=@"待付款";
                break;
            case 2:
                view.statue.text=@"购买成功";
                break;
            case 3:
                view.statue.text=@"已发货";
                break;
            case 4:
                view.statue.text=@"交易成功";
                break;
            case 5:
                view.statue.text=@"退款中";
                break;
            case 6:
                view.statue.text=@"已经完结";
                
                break;
            case 7:
                view.statue.text=@"已延长收货";
                break;
            case 8:
                view.statue.text=@"退款成功";
                break;
            case 9:
                view.statue.text=@"已取消";
                
                break;
            default:
                break;
        }
        
    }

    */
    
    _dataSource = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //    [_tableView registerNib:[UINib nibWithNibName:@"logistTableViewCell" bundle:nil] forCellReuseIdentifier:@"logistcell"];
    [_tableView registerClass:[AttenceTimelineCell class] forCellReuseIdentifier:@"logistcell"];
    
    [self GetlogHttp:self.Ordermodel.logi_code :self.Ordermodel.logi_name];
    
    [self.view addSubview:_tableView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 80)];
    view.backgroundColor=kBackgroundColor;
    UILabel *logi_name=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60), ZOOM(30),kApplicationWidth-ZOOM(60)*2, 25)];
    UILabel *logi_code=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60), view.frame.size.height-ZOOM(30)-25,kApplicationWidth-ZOOM(60)*2,25)];

    NSString *path=[[NSBundle mainBundle]pathForResource:@"logistics" ofType:@"plist"];
    NSDictionary *dict=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSString *string;
    if (dict[_Ordermodel.logi_name]) {
        string=dict[_Ordermodel.logi_name];
    }else
        string=_Ordermodel.logi_name;
//    NSString *string;
    
    /*
    if ([_Ordermodel.logi_name isEqualToString:@"yuantong"]) {
        string = @"圆通";
    }else if ([_Ordermodel.logi_name isEqualToString:@"shentong"]){
        string = @"申通";
    }else if ([_Ordermodel.logi_name isEqualToString:@"ems"]){
        string = @"EMS";
    }else if ([_Ordermodel.logi_name isEqualToString:@"shunfeng"]){
        string = @"顺丰";
    }else if ([_Ordermodel.logi_name isEqualToString:@"zhongtong"]){
        string = @"中通";
    }else if ([_Ordermodel.logi_name isEqualToString:@"yunda"]){
        string = @"韵达";
    }else if ([_Ordermodel.logi_name isEqualToString:@"tiantian"]){
        string = @"天天";
    }else if ([_Ordermodel.logi_name isEqualToString:@"huitongkuaidi"]){
        string = @"汇通";
    }else if ([_Ordermodel.logi_name isEqualToString:@"quanfengkuaidi"]){
        string = @"全峰";
    }else if ([_Ordermodel.logi_name isEqualToString:@"debangwuliu"]){
        string = @"德邦";
    }else if ([_Ordermodel.logi_name isEqualToString:@"zhaijisong"]){
        string = @"宅急送";
    }else if ([_Ordermodel.logi_name isEqualToString:@"youzhengguonei"]){
        string = @"邮政包裹/平邮";
    }else if ([_Ordermodel.logi_name isEqualToString:@"guotongkuaidi"]){
        string = @"国通";
    }else if ([_Ordermodel.logi_name isEqualToString:@"zengyisudi"]){
        string = @"增益";
    }else if ([_Ordermodel.logi_name isEqualToString:@"suer"]){
        string = @"速尔";
    }else if ([_Ordermodel.logi_name isEqualToString:@"ztky"]){
        string = @"中铁物流";
    }else if ([_Ordermodel.logi_name isEqualToString:@"ganzhongnengda"]){
        string = @"能达";
    }else if ([_Ordermodel.logi_name isEqualToString:@"youshuwuliu"]){
        string = @"优速";
    }else if([_Ordermodel.logi_name isEqualToString:@"quanfengkuaidi"]){
        string = @"全峰";
    }
    else
        string = _Ordermodel.logi_name;
    */
    
    logi_name.text = string;
    logi_name.font = [UIFont systemFontOfSize:ZOOM(48)];
    logi_code.text = [NSString stringWithFormat:@"运单编号:%@",self.Ordermodel.logi_code];
    logi_code.font = [UIFont systemFontOfSize:ZOOM(44)];
    
    [view addSubview:logi_name];
    [view addSubview:logi_code];
    
    _tableView.tableHeaderView = view;
    

}

- (NSString *)exchangeTextWihtString:(NSString *)text
{
    if ([text rangeOfString:@"】"].location != NSNotFound){
        NSArray *arr = [text componentsSeparatedByString:@"】"];
        NSString *textStr;
        if (arr.count == 2) {
            textStr = [NSString stringWithFormat:@"%@%@】", arr[1], arr[0]];
        }
        return textStr;
    }
    return text;
}

-(void)viewWillAppear:(BOOL)animated
{
    Myview.hidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden=NO;
}


-(void)GetlogHttp:(NSString*)logi_code :(NSString*)logi_name
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    
//    NSString *url=[NSString stringWithFormat:@"http://www.kuaidi100.com/query?type=%@&postid=%@",logi_name,logi_code];
        NSString *url = [NSString stringWithFormat:@"%@order/expQuery?version=%@&token=%@&nu=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN],logi_code];
    
    NSString *URL=[MyMD5 authkey:url];
    
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
        MyLog(@"responseObject is %@",responseObject);
        
        //responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
//            if(responseObject[@"com"] !=nil)
            if(responseObject[@"data"] !=nil && [responseObject[@"data"]count]!=0)

            {
                ShopDetailModel *model=[[ShopDetailModel alloc]init];
                model.codenumber=responseObject[@"codenumber"];
                model.com=responseObject[@"com"];
                model.companytype=responseObject[@"companytype"];
                model.condition=responseObject[@"condition"];
                model.ischeck=responseObject[@"ischeck"];
                model.nu=responseObject[@"nu"];
                model.state=responseObject[@"state"];
                model.logisstatus=responseObject[@"status"];
                model.updatetime=responseObject[@"updatetime"];
                _logisticmodel= model;
                
//                for(NSDictionary *dic in responseObject[@"data"])
                for(NSDictionary *dic in responseObject[@"data"][0][@"lastResult"][@"data"])

                {
                    ShopDetailModel *Logisticsmodel=[[ShopDetailModel alloc]init];
                    Logisticsmodel.context=dic[@"context"];
                    //%@",Logisticsmodel.context);
                    Logisticsmodel.ftime=dic[@"ftime"];
                    Logisticsmodel.time=dic[@"time"];
                    
                    [_dataSource addObject:Logisticsmodel];
                }
                [_tableView reloadData];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络连接失败");
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 40)];
    view.backgroundColor=[UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM(60), 0, kApplicationWidth-ZOOM(60)*2, 40)];
    titleLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    switch (section) {
        case 0:
            titleLabel.text=@"商品信息";
            break;
        case 1:
            titleLabel.text=@"物流跟踪";
            break;
        default:
            break;
    }
    [view addSubview:titleLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.size.height-1, kApplicationWidth, 1)];
    line.backgroundColor=lineGreyColor;
    [view addSubview:line];
    
    return view;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        if (self.Ordermodel.shop_from.intValue==1||self.Ordermodel.shop_from.intValue==3||self.Ordermodel.shop_from.intValue==4||self.Ordermodel.shop_from.intValue==6) {
            return 1;
        }
        return _Ordermodel.shopsArray.count;
    }
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ShopDetailModel *model=_dataSource[indexPath.row];
     //CGSize size = [model.context sizeWithFont:[UIFont systemFontOfSize:ZOOM(44)] constrainedToSize:CGSizeMake(kScreenWidth-40, 1000)];
    
//     CGSize size = [model.context boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(60), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} context:nil].size;
    
    if (indexPath.section==0) {
        return 140;
    }
     ShopDetailModel *model=_dataSource[indexPath.row];
    NSString *content=[NSString stringWithFormat:@"%@\n%@",model.context,model.time];
    
    return [AttenceTimelineCell cellHeightWithString:content isContentHeight:NO];
    return 55;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (self.Ordermodel.shop_from.intValue==3||self.Ordermodel.shop_from.intValue==4||self.Ordermodel.shop_from.intValue==6) {
            if(self.Ordermodel.shop_from.intValue==4||self.Ordermodel.shop_from.intValue==6)
                [self showHint:@"请在签到界面抽奖记录中进行查看"];
        }
        else if(self.Ordermodel.shop_from.intValue==1)
        {
            
//            ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//            detail.shop_code = self.Ordermodel.bak;
//            detail.stringtype=@"订单详情";
//            detail.hidesBottomBarWhenPushed=YES;
//            [self.navigationController pushViewController:detail animated:YES];
        }else{
            
            OrderDetailModel *model=self.Ordermodel.shopsArray[indexPath.row];
            
            //    ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]init];
            ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]initWithNibName:@"ShopDetailViewController" bundle:nil];
            
            OrderTableViewCell *cell = (OrderTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
            shopdetail.bigimage=cell.headimage.image;
            
            shopdetail.shop_code=model.shop_code;
            shopdetail.stringtype = @"订单详情";
            
            //%@",model.shop_code);
            [self.navigationController pushViewController:shopdetail animated:YES];
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {
        OrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if(!cell)
        {
            cell=[[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        if (_Ordermodel.shop_from.intValue==4||_Ordermodel.shop_from.intValue==6) {
            [cell refreshIndianaData:_Ordermodel];
            cell.zeroLabel.hidden=YES;
            cell.color_size.hidden=YES;
        }
        else if (self.Ordermodel.shop_from.intValue==1) {
            [cell refreshZeroData:self.Ordermodel];
            cell.zeroLabel.hidden=NO;
            cell.color_size.hidden=YES;
        }else if(_Ordermodel.shopsArray.count){
            
            ShopDetailModel *model=_Ordermodel.shopsArray[indexPath.row];
            [cell refreshData2:model];
            cell.zeroLabel.hidden=YES;
            cell.color_size.hidden=NO;
        }
        cell.statue.hidden=YES;

        return cell;
    }else{
    /*
        logistTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"logistcell"];
        if(!cell)
        {
            cell=[[logistTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"logistcell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ShopDetailModel *model=_dataSource[indexPath.row];
        
        if (indexPath.row ==0) {
            cell.textlabel.textColor = tarbarrossred;
            cell.detail.textColor = tarbarrossred;
            cell.img.frame=CGRectMake(ZOOM(60)-5/2, cell.img.frame.origin.y, 25, 25);
            cell.img.image=[UIImage imageNamed:@"椭圆-23"];
        }
        else
        {
            cell.textlabel.textColor = kTextColor;
            cell.detail.textColor = kTextColor;
            cell.img.frame=CGRectMake(ZOOM(60), cell.img.frame.origin.y, 20, 20);
            cell.img.image=[UIImage imageNamed:@"椭圆"];
            
        }
        
        cell.textlabel.text=[NSString stringWithFormat:@"%@",model.context];
        cell.textlabel.font=[UIFont systemFontOfSize:ZOOM(40)];
        cell.detail.font=[UIFont systemFontOfSize:ZOOM(36)];
        cell.detail.text=[NSString stringWithFormat:@"%@",model.time];
        
        return cell;
        */
        
        AttenceTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logistcell"];
//        if(!cell)
//        {
//            cell=[[AttenceTimelineCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"logistcell"];
//        }
        bool isFirst = indexPath.row == 0;
        bool isLast = indexPath.row == _dataSource.count - 1;
        ShopDetailModel *model=_dataSource[indexPath.row];
        NSString *content=[NSString stringWithFormat:@"%@\n%@",model.context,model.time];
        [cell setDataSource:content isFirst:isFirst isLast:isLast];
        //[cell borderColor:[UIColor orangeColor] borderWidth:1 cornerRadius:0];
        return cell;
    }
    
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonClick
{
    [self Message];
}


#pragma mark 聊天
-(void)Message
{
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
    
}

- (void)tap
{
    if(self.Ordermodel.shop_from.intValue==1)
    {
        
//        ComboShopDetailViewController *detail=[[ComboShopDetailViewController alloc] initWithNibName:@"ComboShopDetailViewController" bundle:nil];
//        detail.shop_code = self.Ordermodel.bak;
//        detail.stringtype=@"订单详情";
//        detail.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:detail animated:YES];
    }else{
    
    ShopDetailModel *model=self.Ordermodel.shopsArray[0];
    
    ShopDetailViewController *shopdetail=[[ShopDetailViewController alloc]init];
    shopdetail.shop_code=model.shop_code;
    [self.navigationController pushViewController:shopdetail animated:NO];
    }
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
