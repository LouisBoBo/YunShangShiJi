//
//  InterveneDetailViewController.m
//  YunShangShiJi
//
//  Created by yssj on 16/3/30.
//  Copyright © 2016年 ios-1. All rights reserved.
//
/*------------------------------------------------------------------
 
                            平台介入订单详情
 
 -------------------------------------------------------------------
 */

#import "InterveneDetailViewController.h"
#import "YSSJInterveneViewController.h"
//#import "ChatListViewController.h"
#import "AftersaleViewController.h"

#define left ZOOM(62)
#define titleLabelString @"申请"
#define orderPriceLabString @"订单金额（包邮）¥"
#define orderCodeLabString @"订单号:"
#define addtimeLabString @"时间:"

#define remindLabel1String @"商家拒绝签收"
#define remindLabel2String @"拒绝说明:亲一律不接受到付件的哦，如果亲有疑问可以拨打客服电话或者申请平台介入～"
//#define remindLabel3String @"此订单平台已介入处理纠纷，请耐心等候"
@interface InterveneDetailViewController ()
{
    NSString *titleString;
    NSString *remindLabel3String ;
}

@end

@implementation InterveneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (_orderModel.ys_intervene.integerValue) {//平台接入 0没有介入,1申请介入,2已经介入.3卖家赢,4买家赢.5不管了
//        case 0:
//            remindLabel3String = @"此订单平台已介入处理纠纷，请耐心等候";
//            break;
//        case 1:
//            remindLabel3String = @"此订单平台已介入处理纠纷，请耐心等候";
//            break;
//        case 2:
//            remindLabel3String = @"此订单平台已介入处理纠纷，请耐心等候";
//            break;
            
        case 3:
            remindLabel3String = @"交易成功";
            break;
        case 4:
        {
            switch ([_orderModel.orderShopStatus integerValue]) {
                case 1:
                    remindLabel3String = @"换货成功";
                    break;
                case 2:
                    remindLabel3String = @"退货成功";
                    break;
                case 3:
                    remindLabel3String = @"退款成功";
                    break;
            }
        }
            break;
            
        case 5:
            remindLabel3String = @"售后关闭";
            break;
        case 6:
            remindLabel3String = @"售后关闭";
            break;
        default:
            remindLabel3String = @"此订单平台已介入处理纠纷，请耐心等候";
            break;
    }
    
    switch (_orderModel.orderShopStatus.integerValue) {
        case 1:
            titleString=@"换货";
            break;
        case 2:
            titleString=@"退货";
            break;
        case 3:
            titleString=@"退款";
            break;
        default:
            break;
    }

//    [self setNavigationItemLeftAndRight:[NSString stringWithFormat:@"%@详情",titleString]];
    [self setNavigationItemLeft:[NSString stringWithFormat:@"%@详情",titleString]];
    [self setMainView];
    
}
-(void)setMainView
{
    UIView *blackView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 120+ZOOM(100))];
    blackView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:blackView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(left, ZOOM(50), 200, 30)];
    titleLabel.textColor=[UIColor whiteColor];
    [blackView addSubview:titleLabel];
    UILabel *orderPriceLab=[[UILabel alloc]initWithFrame:CGRectMake(left, CGRectGetMaxY(titleLabel.frame), 300, 30)];
    orderPriceLab.textColor=[UIColor whiteColor];
    [blackView addSubview:orderPriceLab];
    UILabel *orderCodeLab=[[UILabel alloc]initWithFrame:CGRectMake(left, CGRectGetMaxY(orderPriceLab.frame), 300, 30)];
    orderCodeLab.textColor=[UIColor whiteColor];
    [blackView addSubview:orderCodeLab];
    UILabel *addtimeLab=[[UILabel alloc]initWithFrame:CGRectMake(left, CGRectGetMaxY(orderCodeLab.frame), 200, 30)];
    addtimeLab.textColor=[UIColor whiteColor];
    [blackView addSubview:addtimeLab];

    titleLabel.text=[NSString stringWithFormat:@"%@%@",titleLabelString,titleString];
    orderPriceLab.text=[NSString stringWithFormat:@"%@%.2f",orderPriceLabString,[_orderModel.money doubleValue]];
    orderCodeLab.text=[NSString stringWithFormat:@"%@%@",orderCodeLabString,_orderModel.order_code];

    NSString *addtime;
    NSString *time = [NSString stringWithFormat:@"%@",_orderModel.add_time];
    if (time !=nil && ![time isEqualToString:@"<null>"]) {
        addtime=[MyMD5 getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%@",_orderModel.add_time]];
    }else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        addtime=[formatter stringFromDate:[NSDate date]];
    }
    addtimeLab.text=[NSString stringWithFormat:@"%@%@",addtimeLabString,addtime];

    
    UILabel *remindLabel1=[[UILabel alloc]initWithFrame:CGRectMake(left, CGRectGetMaxY(blackView.frame)+ZOOM(50), kScreenWidth-left*2, 30)];
    remindLabel1.text=[NSString stringWithFormat:@"%@",remindLabel1String];
    [self.view addSubview:remindLabel1];
    
    UILabel *remindLabel2=[[UILabel alloc]initWithFrame:CGRectMake(left, CGRectGetMaxY(remindLabel1.frame)+ZOOM(10), kScreenWidth-left*2, 70)];
    remindLabel2.numberOfLines=0;
    remindLabel2.textColor=kTextColor;
    if (_orderModel.supp_refuse_msg&&![_orderModel.supp_refuse_msg isEqual:[NSNull null]]) {
        remindLabel2.text=[NSString stringWithFormat:@"拒绝理由:%@",_orderModel.supp_refuse_msg];
    }else
        remindLabel2.text=[NSString stringWithFormat:@"%@",remindLabel2String];
    
    [self.view addSubview:remindLabel2];
    
    switch (_orderModel.ys_intervene.integerValue) {
        case 0:
        {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(left, CGRectGetMaxY(remindLabel2.frame)+ZOOM(100), kScreenWidth-left*2, 40);
            [btn setTitle:@"申请平台介入" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor blackColor]];
            [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            break;
        }
        default:
        {
            UILabel *remindLabel3=[[UILabel alloc]initWithFrame:CGRectMake(left, CGRectGetMaxY(remindLabel2.frame)+ZOOM(100), kScreenWidth-left*2, 60)];
            remindLabel3.textColor=tarbarrossred;
            remindLabel3.numberOfLines=0;
            remindLabel3.text=remindLabel3String;
            [self.view addSubview:remindLabel3];
        }
            break;
    }
   
 
    
}
-(void)btnClick
{
    YSSJInterveneViewController *view=[[YSSJInterveneViewController alloc]init];
    view.orderModel=_orderModel;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)rightBarButtonClick{ 
    // begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    // end
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
