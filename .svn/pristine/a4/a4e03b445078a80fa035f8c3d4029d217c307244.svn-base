//
//  ChoseShareViewController.m
//  demo
//
//  Created by yssj on 15/9/2.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ChoseShareViewController.h"
#import "ChoseShareViewCell.h"
#import "ShopDetailModel.h"
#import "UIImageView+WebCache.h"
#import "GlobalTool.h"
#import "IntelligenceViewController.h"
#import "ShopDetailModel.h"

@interface ChoseShareViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;

@end

@implementation ChoseShareViewController

-(void)viewWillAppear:(BOOL)animated
{
    Myview.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray=[NSMutableArray array];
    [self.dataArray removeAllObjects];
    for(int i=0 ;i<_orderArray.count;i++)
    {
        ShopDetailModel *model=_orderArray[i];
        
        NSArray *arr=model.shopsArray;
        for(int j =0;j<arr.count ;j++)
        {
            ShopDetailModel *ordetmodel =arr[j];
            
            [_dataArray addObject:ordetmodel];
        }
    }
    
    
    [self setNavgationView];
    
    [self setMainView];

    
    
}
-(void)setMainView
{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, self.view.frame.size.height-74)];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.rowHeight = 110;
    [_myTableView registerNib:[UINib nibWithNibName:@"ChoseShareViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    _myTableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:_myTableView];
}
-(void)setNavgationView
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    //
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    headview.backgroundColor=[UIColor whiteColor];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 200, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"请选择分享的商品";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    [self.view addSubview:headview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_shopArray.count)
    {
        return _shopArray.count;
        
    }
    else if (_dataArray.count)
    {
        return _dataArray.count;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChoseShareViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];

    if(!cell)
    {
        cell=[[ChoseShareViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    ShopDetailModel *model;
    ShopDetailModel *ordermodel;
    if(_shopArray.count)
    {
    
        model = _shopArray[indexPath.row];
    
        cell.shop_name.text = [NSString stringWithFormat:@"%@",model.shop_name];
        cell.shop_name.font=[UIFont systemFontOfSize:ZOOM(40)];
        cell.shop_money.font=[UIFont systemFontOfSize:ZOOM(40)];
        cell.shop_money.text = [NSString stringWithFormat:@"¥%@",model.shop_se_price];
        cell.colorSize.text=[NSString stringWithFormat:@"颜色:%@ 尺寸:%@",model.shop_color,model.shop_size];
        cell.shop_num.text=[NSString stringWithFormat:@"%@",model.shop_num];
        cell.shop_num.font=fortySize;
        cell.colorSize.font=fortySize;
        cell.colorSize.textColor=kTextGreyColor;
        cell.shop_num.textColor=kTextGreyColor;
//        [cell.shop_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.def_pic]]];
        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.def_pic]];
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [cell.shop_pic sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                cell.shop_pic.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    cell.shop_pic.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                cell.shop_pic.image = image;
            }
        }];
        
        return cell;

    }else if(_dataArray.count){
        
        ordermodel = _dataArray[indexPath.row];
        
        //%@",_dataArray[indexPath.row]);
        
        //name is %@",ordermodel.shop_name);
        
        cell.shop_name.text = [NSString stringWithFormat:@"%@",ordermodel.shop_name];
        cell.shop_money.text = [NSString stringWithFormat:@"¥%@",ordermodel.shop_price];
        cell.colorSize.text=[NSString stringWithFormat:@"颜色:%@ 尺寸:%@",ordermodel.shop_color,ordermodel.shop_size];
        cell.shop_num.text=[NSString stringWithFormat:@"%@",ordermodel.shop_num];
        cell.shop_num.font=fortySize;
        cell.colorSize.font=fortySize;
        cell.colorSize.textColor=kTextGreyColor;
        cell.shop_num.textColor=kTextGreyColor;
//        [cell.shop_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],ordermodel.shop_pic]]];
        
        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],ordermodel.shop_pic]];
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [cell.shop_pic sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                cell.shop_pic.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    cell.shop_pic.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                cell.shop_pic.image = image;
            }
        }];
        
        return cell;

    }
    
    
    return 0;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntelligenceViewController *intell=[[IntelligenceViewController alloc]init];
    
    if(self.shopArray.count)
    {
        
        ShopDetailModel *model=self.shopArray[indexPath.row];
    
    
        intell.shopPrice=model.shop_se_price;

        NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
        [userdefaul setObject:[NSString stringWithFormat:@"%@",model.shop_code] forKey:SHOP_CODE];
        [userdefaul setObject:[NSString stringWithFormat:@"%@",model.def_pic] forKey:SHOP_PIC];
        
    }else{
        
        ShopDetailModel *model=_dataArray[indexPath.row];
        
        
        intell.shopPrice=[NSString stringWithFormat:@"%@",model.shop_price];
        
        NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
        [userdefaul setObject:[NSString stringWithFormat:@"%@",model.shop_code] forKey:SHOP_CODE];
        [userdefaul setObject:[NSString stringWithFormat:@"%@",model.shop_pic] forKey:SHOP_PIC];

    }
        
    [self.navigationController pushViewController:intell animated:YES];
    
}
-(void)back:(UIButton *)btn
{
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
