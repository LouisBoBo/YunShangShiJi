//
//  JifenShopViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/4/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "JifenShopViewController.h"
#import "ShopDetailViewController.h"
#import "GlobalTool.h"
#import "WaterFLayout.h"
#import "CollectionViewCell.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "NavgationbarView.h"
@interface JifenShopViewController ()

@end

@implementation JifenShopViewController
{
    //几个状态
    NSArray *_titleArr;
    UIButton *_statebtn;
    UILabel *_statelab;

    //列表
    UICollectionView *_Mycollection;
    //数据源
    NSMutableArray *_DataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor whiteColor];
    
    _DataArray=[NSMutableArray array];
    
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
    titlelable.text=@"积分商城";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    //网络请求数据
    [self requestHttp];
    
    [self creatHeadView];
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

#pragma mark 积分商城商品网络请求
-(void)requestHttp
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    
    NSString* url=[NSString stringWithFormat:@"%@inteShop/queryCondition?version=%@",[NSObject baseURLStr],VERSION];
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            
            if(statu.intValue==1)//请求成功
            {
                NSArray *arr=responseObject[@"listShop"];
                for(NSDictionary *dic in arr)
                {
                    ShopDetailModel *model=[[ShopDetailModel alloc]init];
                    
                    model.def_pic=dic[@"def_pic"];
                    model.ID=dic[@"id"];
                    model.love_num=dic[@"love_num"];
                    model.shop_code=dic[@"shop_code"];
                    model.shop_name=dic[@"shop_name"];
                    model.shop_se_price=dic[@"shop_se_price"];
                    
                    [_DataArray addObject:model];
                }
                
                [_Mycollection reloadData];
                
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
                
            }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
               
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];

}

#pragma mark 头部按钮
-(void)creatHeadView
{
    UIView *headview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kApplicationWidth, 40)];
    [self.view addSubview:headview];
    headview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    _titleArr=@[@"积分兑换",@"幸运抽奖"];
    CGFloat btnwidh=kApplicationWidth/_titleArr.count;
    for(int i=0;i<_titleArr.count;i++)
    {
        //按钮
        _statebtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _statebtn.frame=CGRectMake(btnwidh*i, 0, btnwidh, 30);
        [_statebtn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [_statebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _statebtn.titleLabel.font=kNavigationItemFontSize;
        _statebtn.tag=1000+i;
        [_statebtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        [headview addSubview:_statebtn];
        
        //状态条
        _statelab=[[UILabel alloc]initWithFrame:CGRectMake(btnwidh*i, 35, btnwidh, 5)];
        _statelab.backgroundColor=[UIColor clearColor];
        _statelab.tag=2000+i;
        [headview addSubview:_statelab];
        
        //设置进来时选中的按键
        if(i==0)
        {
            [_statebtn setTitleColor:tarbarYellowcolor forState:UIControlStateNormal];;
            _statelab.backgroundColor=tarbarYellowcolor;
            _statebtn.selected=YES;
            self.slectbtn=_statebtn;
        }
    }
}

#pragma mark 按钮监听事件
-(void)click:(UIButton*)sender
{
    
    for(int i=0;i<_titleArr.count;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:1000+i];
        UILabel *lable=(UILabel*)[self.view viewWithTag:2000+i];
        if(i+1000==sender.tag)
        {
            [btn setTitleColor:tarbarYellowcolor forState:UIControlStateNormal];
            btn.backgroundColor=[UIColor clearColor];
            lable.backgroundColor=tarbarYellowcolor;
            

            
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lable.backgroundColor=[UIColor clearColor];
        }
    }
    
    self.slectbtn.selected=NO;
    sender.selected=YES;
    self.slectbtn=sender;
    
}


#pragma mark 主界面
-(void)creatView
{
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
    
    
    _Mycollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 40+Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar-50+kUnderStatusBarStartY) collectionViewLayout:flowLayout];
    _Mycollection.delegate=self;
    _Mycollection.dataSource=self;
    _Mycollection.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_Mycollection];
    [_Mycollection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _DataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"Cell";
    CollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[CollectionViewCell alloc]init];
        
    }
    
    ShopDetailModel *model=_DataArray[indexPath.item];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            //GCD加载图片
//            [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.def_pic]]];
            
            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.def_pic]];
            __block float d = 0;
            __block BOOL isDownlaod = NO;
            [cell.titleImage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                d = (float)receivedSize/expectedSize;
                isDownlaod = YES;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image != nil && isDownlaod == YES) {
                    cell.titleImage.alpha = 0;
                    [UIView animateWithDuration:0.5 animations:^{
                        cell.titleImage.alpha = 1;
                    } completion:^(BOOL finished) {
                    }];
                } else if (image != nil && isDownlaod == NO) {
                    cell.titleImage.image = image;
                }
            }];
            
            
            CGFloat imgwidh;
            CGFloat imgheigh;
            
            NSString *str=model.def_pic;
            str=[str substringToIndex:[str length]-4];
            NSArray *arr=[str componentsSeparatedByString:@"_"];
            if(arr.count)
            {
                imgheigh=[arr[1] floatValue];
                imgwidh=[arr[2] floatValue];
            }
            
            CGFloat f=imgwidh/imgheigh;
            
            cell.titleImage.frame=CGRectMake(0, 0, cell.titleImage.frame.size.width, cell.titleImage.frame.size.width/f);
            
            cell.titleImage.layer.cornerRadius=5;
            cell.titleImage.layer.masksToBounds = YES;
            cell.titleImage.layer.borderColor = [UIColor brownColor].CGColor;
            cell.titleImage.layer.borderWidth = 1;
            
            //商品描述文字
            cell.title.text=model.shop_name;
            cell.title.numberOfLines=0;
            cell.title.font=[UIFont systemFontOfSize:15];
            
            CGFloat titleHeigh=0;
            titleHeigh=[self getRowHeight:cell.title.text];
            cell.title.frame=CGRectMake(0, cell.titleImage.frame.origin.y+cell.titleImage.frame.size.height+5, 90, titleHeigh);
            
            //分割线
            cell.lableline.frame=CGRectMake(cell.lableline.frame.origin.x, cell.title.frame.origin.y+cell.title.frame.size.height+2, cell.lableline.frame.size.width, cell.lableline.frame.size.height);
            
            //价格
            cell.shopprice.text=@"兑换";
            cell.shopprice.frame=CGRectMake(0, cell.title.frame.origin.y+cell.title.frame.size.height, cell.shopprice.frame.size.width, 25);
            cell.shopprice.tag=5000+indexPath.item;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(change:)];
            [cell.shopprice addGestureRecognizer:tap];
            cell.shopprice.userInteractionEnabled=YES;
            
            //星
            cell.lovenum.frame=CGRectMake(cell.lovenum.frame.origin.x, cell.title.frame.origin.y+cell.title.frame.size.height+3, cell.lovenum.frame.size.width, cell.lovenum.frame.size.height);
            //喜欢数
            cell.lovenumber.text=[NSString stringWithFormat:@"%@",model.love_num];
            cell.lovenumber.frame=CGRectMake(cell.lovenumber.frame.origin.x, cell.title.frame.origin.y+cell.title.frame.size.height, cell.lovenumber.frame.size.width, 25);
            
        });
        
    });
    
    return cell;
}
#pragma mark 兑换
-(void)change:(UITapGestureRecognizer *)sender
{
    //sender tag is %d",sender.view.tag);
    ShopDetailViewController *detiail=[[ShopDetailViewController alloc]init];
    detiail.typestring=@"兑换";
    
    [self.navigationController pushViewController:detiail animated:YES];
    
}
-(CGFloat)getRowHeight:(NSString *)text
{
    //文字高度
    CGFloat height;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(230, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName] context:nil];
        
        height=rect.size.height;
        
    }
    else{
        
    }
    return height;
}


#pragma mark item 大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat imgwidh;
    CGFloat imgheigh;
    
    ShopDetailModel *model=_DataArray[indexPath.item];
    NSString *str=model.def_pic;
    str=[str substringToIndex:[str length]-4];
    NSArray *arr=[str componentsSeparatedByString:@"_"];
    if(arr.count)
    {
        imgheigh=[arr[1] floatValue];
        imgwidh=[arr[2] floatValue];
    }
    
    CGFloat f=imgwidh/imgheigh;
    
    CGSize _size;
    
    _size=CGSizeMake(145, 145/f+55);
    
    return _size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_Mycollection)
    {
        //OK");
        ShopDetailViewController *detail=[[ShopDetailViewController alloc]init];
        detail.typestring=@"兑换";
        [self.navigationController pushViewController:detail animated:YES];
        
    }else{
        //no");
    }
    
}
-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
@end
