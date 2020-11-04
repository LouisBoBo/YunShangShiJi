//
//  SearchViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/13.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "SearchViewController.h"
#import "ShopthreeViewController.h"
#import "ShopDetailViewController.h"
#import "CollectionViewCell.h"
#import "NavgationbarView.h"
#import "AFNetworking.h"
#import "GlobalTool.h"
#import "KeyboardTool.h"
#import "WaterFLayout.h"
#import "MJRefresh.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "MyMD5.h"
#import "Tools.h"
#import <sqlite3.h>
@interface SearchViewController ()
{
    //商品分类列表
    UITableView *_Mytableview;
    NSMutableArray *_dataArray;
    
    //商品搜索列表
    UICollectionView *_MycollectionView;
    NSMutableArray *_collectionDataArray;
    
    //记录是否搜索
    BOOL _issearch;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _collectionDataArray=[NSMutableArray array];
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, 64)];
    headview.image=[UIImage imageNamed:@"u265"];

    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    //搜索框
    UISearchBar *search=[[UISearchBar alloc]initWithFrame:CGRectMake(10, 25, kApplicationWidth-60, 30)];
    search.delegate=self;
    search.placeholder=@"Search";
    search.text=@"上";
    search.autoresizingMask=UIViewAutoresizingNone;
    [headview addSubview:search];
    
    //设置搜索框背景色
    [search setBackgroundImage:headview.image];
    self.search=search;
    
    KeyboardTool *tool = [KeyboardTool keyboardTool];
    tool.delegate = self;
    tool.frame=CGRectMake(0, tool.frame.origin.y, kScreenWidth, 40);
    search.inputAccessoryView = tool;
   
    
    //注册搜索框监听通知
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardshowFrame:) name:UIKeyboardWillShowNotification object:nil];
    
    //取消搜索
    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchbtn.frame=CGRectMake(search.frame.origin.x+search.frame.size.width+10, 25, 30, 30);
    [searchbtn setTitle:@"取消" forState:UIControlStateNormal];
    searchbtn.titleLabel.font=[UIFont systemFontOfSize:12];
    searchbtn.tintColor=[UIColor whiteColor];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"u524"] forState:UIControlStateNormal];
    [searchbtn addTarget:self action:@selector(Cancelclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchbtn];
    
    [self creatData];
    
    [self creatTableview];

}

//键盘
- (void)keyboardTool:(KeyboardTool *)keyboardTool itemClick:(KeyboardToolItemType)itemType
{
    if (itemType == KeyboardToolItemTypePrevious) { // 上一个
        //----上一个----");
    } else if (itemType == KeyboardToolItemTypeNext) { // 下一个
        //----下一个----");
    } else { // 完成
        //----完成----");
        self.search.showsCancelButton = NO;
        [self.view endEditing:YES];
        
        
        if ([self.search.text length]<1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"搜索不能为空,请输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        if ([[Tools share] stringContainsEmoji:self.search.text]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"表情字符暂时不支持搜索" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        [self creatView];
        
        [self requestSearchHttp];

        
    }
}


-(void)creatData
{
    _dataArray=[NSMutableArray arrayWithArray:self.type1array];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.search.showsCancelButton = NO;
    [self.view endEditing:YES];
    
    
    if ([self.search.text length]<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"搜索不能为空,请输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if ([[Tools share] stringContainsEmoji:self.search.text]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"表情字符暂时不支持搜索" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    [self creatView];
    
    [self requestSearchHttp];

}

#pragma mark 下拉刷新
-(void)addheadFresh:(NSString*)str
{
    __weak UICollectionView *weakCollect= _MycollectionView;
    [_MycollectionView addHeaderWithCallback:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 结束刷新
            [weakCollect headerEndRefreshing];
            [weakCollect footerEndRefreshing];
            
            [weakCollect reloadData];
        });
    }];
    
    [_MycollectionView headerBeginRefreshing];
}

#pragma mark 上拉刷新
-(void)addfootFresh:(NSString*)str
{
     __weak UICollectionView *weakCollect= _MycollectionView;
    [_MycollectionView addFooterWithCallback:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakCollect reloadData];
            // 结束刷新
            [weakCollect headerEndRefreshing];
            [weakCollect footerEndRefreshing];

        });
        
    }];
    
    
}

-(void)creatView
{
    WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
    UICollectionView *collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, Height_NavBar, self.view.frame.size.width, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY) collectionViewLayout:flowLayout];

    collectionview.delegate=self;
    collectionview.dataSource=self;
    collectionview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [collectionview registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    _MycollectionView=collectionview;
    
    [self.view addSubview:collectionview];
    
    [self addheadFresh:nil];
    [self addfootFresh:nil];



}
#pragma mark 发送搜索网络请求
-(void)requestSearchHttp
{
    [_collectionDataArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSString *searchstr=self.search.text;
    
    NSString *url;
    url=[NSString stringWithFormat:@"%@shop/queryCondition?version=%@&shop_name=%@&curPage=1",[NSObject baseURLStr],VERSION,searchstr];
    NSString *URL=[MyMD5 authkey:url];
    
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *messsage=responseObject[@"message"];
            
            if(statu.intValue==1)
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
                    
                    [_collectionDataArray addObject:model];
                }
                
                if(_collectionDataArray.count==0)
                {
                    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake((kApplicationWidth-100)/2, 20, 100, 30)];
                    lable.text=@"暂无数据";
                    lable.textAlignment=NSTextAlignmentCenter;
                    lable.textColor=kTextGreyColor;
                    [_MycollectionView addSubview:lable];
                    
                }
                [_MycollectionView reloadData];
                _issearch=YES;
                
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
                NavgationbarView *alertview=[[NavgationbarView alloc] init];
                [alertview showLable:messsage Controller:self];
                
            }

        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        if ([error code] == kCFURLErrorTimedOut) {
            [[SVProgressHUD  sharedManager]showMessage:timeOutMsg];
        }else{
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        }
        
    }];
    

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"Cell";
    CollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[CollectionViewCell alloc]init];
        
    }
    
    ShopDetailModel *model;
    if(_collectionDataArray.count)
    {
        model=_collectionDataArray[indexPath.item];
    }else{
        return 0;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //GCD加载图片
            [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PHOTOhttp,model.def_pic]]];
            
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
            
            //文字
            cell.title.text=model.shop_name;
            cell.title.numberOfLines=0;
            cell.title.font=[UIFont systemFontOfSize:15];
            
            CGFloat titleHeigh=0;
            titleHeigh=[self getRowHeight:cell.title.text];
            cell.title.frame=CGRectMake(0, cell.titleImage.frame.origin.y+cell.titleImage.frame.size.height+5, 145, titleHeigh);
            
            //分割线
            cell.lableline.frame=CGRectMake(cell.lableline.frame.origin.x, cell.title.frame.origin.y+cell.title.frame.size.height+2, cell.lableline.frame.size.width, cell.lableline.frame.size.height);
            
            //价格
            cell.shopprice.text=[NSString stringWithFormat:@"￥%.2f",[model.shop_se_price floatValue]];
            cell.shopprice.frame=CGRectMake(0, cell.title.frame.origin.y+cell.title.frame.size.height, cell.shopprice.frame.size.width, 25);
            //星
            cell.lovenum.frame=CGRectMake(cell.lovenum.frame.origin.x, cell.title.frame.origin.y+cell.title.frame.size.height+3, cell.lovenum.frame.size.width, cell.lovenum.frame.size.height);
            //喜欢数
            cell.lovenumber.text=[NSString stringWithFormat:@"%@",model.love_num];
            cell.lovenumber.frame=CGRectMake(cell.lovenumber.frame.origin.x, cell.title.frame.origin.y+cell.title.frame.size.height, cell.lovenumber.frame.size.width, 25);
            
        });
        
    });
    
    return cell;
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
    
    ShopDetailModel *model=_collectionDataArray[indexPath.item];
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
    if(_MycollectionView)
    {
        //OK");
        ShopDetailViewController *detail=[[ShopDetailViewController alloc]init];
        CollectionViewCell *cell = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        detail.bigimage=cell.titleImage.image;

        [self.navigationController pushViewController:detail animated:YES];
        
    } else {
        //no");
    }
    
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark 监听搜索框
-(void)keyboardshowFrame:(NSNotification*)notification
{
    self.search.showsCancelButton=NO;
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

#pragma mark 创建列表
-(void)creatTableview
{
    _Mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar+kUnderStatusBarStartY) style:UITableViewStylePlain];
    _Mytableview.dataSource=self;
    _Mytableview.delegate=self;
    
    
    [self.view addSubview:_Mytableview];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictionary=self.findArray[indexPath.row];
    NSString *ID=[dictionary objectForKey:_dataArray[indexPath.row]];
    
    ShopthreeViewController *shopthree=[[ShopthreeViewController alloc]init];
    shopthree.shoptitle=_dataArray[indexPath.row];
    shopthree.parentid=ID;
    [self.navigationController pushViewController:shopthree animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark 返回上一视图
-(void)Cancelclick:(UIButton*)sender
{
    if(_issearch==YES)
    {
        [_MycollectionView removeFromSuperview];
        _issearch=NO;
    }else
    {
     [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
