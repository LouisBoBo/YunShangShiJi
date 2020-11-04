//
//  CollectNewsController.m
//  YunShangShiJi
//
//  Created by yssj on 15/8/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "CollectNewsController.h"
#import "GlobalTool.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "MyMD5.h"
#import "NavgationbarView.h"
#import "AFNetworking.h"
#import "CollectTableViewCell.h"
#import "ForumModel.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "InvitationViewController.h"


@interface CollectNewsController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableViewCellEditingStyle selectEditingStyle;
    
    UIView *_footview;
    //编辑按钮
    UIButton *_setting;

}
//一级标签选中按钮
@property (nonatomic,strong)UIButton *slectbtn1;
@property (nonatomic,strong)UIButton *statebtn1;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) UIButton *multiDeleteBarButton;

@end

@implementation CollectNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    
    //    headview.image=[UIImage imageNamed:@"u265"];
    headview.backgroundColor=kBackgroundColor;
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
    titlelable.text=@"收藏列表";
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    _setting=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _setting.frame=CGRectMake(kApplicationWidth-50, 20, 40, 40);
    _setting.centerY = View_CenterY(headview);
    [_setting setTitle:@"编辑" forState:UIControlStateNormal];
    [_setting setTitle:@"取消" forState:UIControlStateSelected];
    _setting.tintColor=kbackgrayColor;
    [_setting addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:_setting];
    
    
    [self creatHeadView];
    
    [self creatTableView];
    
    [self creatFootView];

}
- (void)viewWillAppear:(BOOL)animated
{
    Myview.hidden=YES;
    
    [self requestSubmitHttp];
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden=NO;
}

#pragma mark - Table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CollectCell"];
    if(!cell)
    {
        cell=[[CollectTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CollectCell"];
    }
    cell.selectbtn.hidden=YES;
    cell.selectbtn.selected=NO;
    ForumModel *model=_dataArray[indexPath.row];
    
    
//    [cell.titleimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.upic]]];
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.upic]];
    __block float d = 0;
    __block BOOL isDownlaod = NO;
    [cell.titleimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        d = (float)receivedSize/expectedSize;
        isDownlaod = YES;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil && isDownlaod == YES) {
            cell.titleimage.alpha = 0;
            [UIView animateWithDuration:0.5 animations:^{
                cell.titleimage.alpha = 1;
            } completion:^(BOOL finished) {
            }];
        } else if (image != nil && isDownlaod == NO) {
            cell.titleimage.image = image;
        }
    }];
    
    cell.titleimage.clipsToBounds=YES;
    cell.titleimage.layer.cornerRadius=15;
    
    cell.title.text=model.nickname;
    
    if(model.pic !=nil || model.pic.length > 0)
    {
//        [cell.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.npic]]];
        
        cell.headimage.hidden = NO;
        
        cell.content.frame = CGRectMake(50 , cell.content.frame.origin.y, cell.content.frame.size.width, cell.content.frame.size.height);

        
        
        NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.npic]];
        __block float d = 0;
        __block BOOL isDownlaod = NO;
        [cell.headimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            d = (float)receivedSize/expectedSize;
            isDownlaod = YES;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image != nil && isDownlaod == YES) {
                cell.headimage.alpha = 0;
                [UIView animateWithDuration:0.5 animations:^{
                    cell.headimage.alpha = 1;
                } completion:^(BOOL finished) {
                }];
            } else if (image != nil && isDownlaod == NO) {
                cell.headimage.image = image;
            }
        }];
        
    }else{
        NSArray *piclist=[model.pic_list componentsSeparatedByString:@","];
        if(piclist.count)
        {
//            [cell.headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],piclist[0]]]];
            
            cell.headimage.hidden = YES;
            
            cell.content.frame = CGRectMake(cell.headimage.frame.origin.x, cell.content.frame.origin.y, cell.headimage.frame.size.width + cell.content.frame.size.width, cell.content.frame.size.height);

            
            NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],piclist[0]]];
            __block float d = 0;
            __block BOOL isDownlaod = NO;
            [cell.headimage sd_setImageWithURL:imgUrl placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                d = (float)receivedSize/expectedSize;
                isDownlaod = YES;
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image != nil && isDownlaod == YES) {
                    cell.headimage.alpha = 0;
                    [UIView animateWithDuration:0.5 animations:^{
                        cell.headimage.alpha = 1;
                    } completion:^(BOOL finished) {
                    }];
                } else if (image != nil && isDownlaod == NO) {
                    cell.headimage.image = image;
                }
            }];
        }
    }
    cell.content.text=model.title;
    
    return cell;
}
// 选中行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //您点击了第%d分区第%d行",indexPath.section, indexPath.row);
    [self updateDeleteButtonTitle];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update the delete button's title based on how many items are selected.
    [self updateDeleteButtonTitle];
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
    
    return YES;
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
        
        // 从数据源中删除
        [self.dataArray removeObjectAtIndex:indexPath.row];
        // 删除行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}



//// 移动行操作
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//    id object = [self.dataArray objectAtIndex:fromIndexPath.row];
//    
//    [self.dataArray removeObjectAtIndex:fromIndexPath.row];
//    
//    [self.dataArray insertObject:object atIndex:toIndexPath.row];
//}



// 是否支持移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

#pragma mark - button
-(void)updateDeleteButtonTitle
{
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    
    BOOL allItemsAreSelected = selectedRows.count == self.dataArray.count;
    
    BOOL noItemsAreSelected = selectedRows.count == 0;
    
    if (allItemsAreSelected || noItemsAreSelected)
    {
//        self.multiDeleteBarButton.title = @"删除全部";
        [self.multiDeleteBarButton setTitle:@"删除全部" forState:UIControlStateNormal];
    }
    else
    {
//        self.multiDeleteBarButton.title = [NSString stringWithFormat:@"删除 (%d)", selectedRows.count];
        [self.multiDeleteBarButton setTitle:[NSString stringWithFormat:@"删除 (%d)", (int)selectedRows.count]forState:UIControlStateNormal];
    }
    
}
// 更新导航栏按钮
-(void) updateBarButtons
{

    if (self.tableView.allowsSelectionDuringEditing == YES) {
        
        [self updateDeleteButtonTitle];
        
        self.navigationItem.leftBarButtonItems = nil;
        
//        self.navigationItem.leftBarButtonItem = self.multiDeleteBarButton;
        
//        self.navigationItem.rightBarButtonItem = self.cancelBarButtonItem;

        
        return;
    }
    if (self.tableView.editing==YES) {
        
//        self.navigationItem.rightBarButtonItem = self.doneBarButtonItem;
    }
    else {
//        NSArray *leftBarButtons = [NSArray arrayWithObjects:self.addButton,self.deleteBarButtonItem, nil];
//        self.navigationItem.leftBarButtonItems = leftBarButtons;
//        
//        self.navigationItem.rightBarButtonItem = self.editBarButtonItem;

    }
}
#pragma mark - 点击事件
-(void)allselect:(UIButton *)sender
{
//            // 删除全部
//            [self.dataArray removeAllObjects];
//    
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}
// 编辑按钮
- (void)editButtonClicked:(UIButton *)sender {
    
    if (sender.selected == NO) {
        sender.selected = YES;
//        _footview.hidden= NO;
        [self.view addSubview:_footview];
        self.tableView.allowsMultipleSelectionDuringEditing = YES;
        
        
        
        [self.tableView setEditing:YES animated:YES];
        
    }else
    {
        sender.selected = NO;
//        _footview.hidden = YES;
        [_footview removeFromSuperview];
        self.tableView.allowsMultipleSelectionDuringEditing = NO;
        
//         self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
        
        [self.tableView setEditing:NO animated:YES];

    }
    
    
    [self updateBarButtons];
    
    
}
//删除按钮
- (void)multiDeleteClicked:(id)sender {
    // 选中的行
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    
    // 是否删除特定的行
    BOOL deleteSpecificRows = selectedRows.count > 0;
    // 删除特定的行
    if (deleteSpecificRows)
    {
        // 将所选的行的索引值放在一个集合中进行批量删除
        NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
        
        NSMutableString *str=[NSMutableString string];
        NSMutableString *str2=[NSMutableString string];
        
        //NSMutableArray *indexarray=[NSMutableArray array];

        for (NSIndexPath *selectionIndex in selectedRows)
        {
            [indicesOfItemsToDelete addIndex:selectionIndex.row];

            ForumModel *model = _dataArray[selectionIndex.row];
            
            [str appendString:[NSString stringWithFormat:@"%@",model.news_id]];
            [str appendString:@","];
            
            [str2 appendString:[NSString stringWithFormat:@"%@",model.circle_id]];
            [str2 appendString:@","];
            
        }
        // 从数据源中删除所选行对应的值
        [self.dataArray removeObjectsAtIndexes:indicesOfItemsToDelete];
        
        //删除所选的行
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSString *ccc=[str substringToIndex:[str length]-1];
//        NSString *ccc2=[str2 substringToIndex:[str2 length]-1];
        //ccc---ccc2-------%@   %@",ccc,ccc2);
        for(int i=0;i<2;i++)
        {
            UIButton *btn=(UIButton*)[self.view viewWithTag:8888+i];
            
            if (btn.selected == YES) {
                if(btn.tag==8888)
                {
                    [self deleateHttp:ccc];
                }else{
                    [self deleateCollectHttp:ccc];
                }
                
            }
            
        }

    }
//    else
//    {
//        // 删除全部
//        [self.dataArray removeAllObjects];
//        
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
    
    [self.tableView setEditing:NO animated:YES];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    [self updateBarButtons];
}

// 取消按钮
- (void)cancelButtonClicked:(id)sender {
    
    [self.tableView setEditing:NO animated:YES];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    [self updateBarButtons];
    
//    self.deleteBarButtonItem.title = @"删除";
}

-(void)creatHeadView
{
    NSArray *titlearr=@[@"发帖记录",@"收藏记录"];
    CGFloat btnwidh=kApplicationWidth/2;
    for(int i=0;i<titlearr.count;i++)
    {
        //按钮
        self.statebtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        self.statebtn1.frame=CGRectMake(btnwidh*i, 64, btnwidh, 40);
        [self.statebtn1 setTitle:titlearr[i] forState:UIControlStateNormal];
        [self.statebtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.statebtn1.titleLabel.font=kNavigationItemFontSize;
        self.statebtn1.backgroundColor=kBackgroundColor;
        self.statebtn1.tag=8888+i;
        [self.statebtn1 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:self.statebtn1];
        
        
        //设置进来时选中的按键
        if(i==0)
        {
            [self.statebtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];;
            self.statebtn1.backgroundColor=tarbarrossred;
            self.statebtn1.selected=YES;
            self.slectbtn1=_statebtn1;
        }
    }
    
}
#pragma mark 一级按钮监听事件
-(void)btnclick:(UIButton*)sender
{
    
    UIImageView *footview=(UIImageView*)[self.view viewWithTag:9999];
    [footview removeFromSuperview];
    
    
    for(int i=0;i<2;i++)
    {
        UIButton *btn=(UIButton*)[self.view viewWithTag:8888+i];
        
        if(i+8888==sender.tag)
        {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor=tarbarrossred;
            
            if(btn.tag==8888)
            {
                [self requestSubmitHttp];
            }else{
                [self requestHttp];
            }
            
            
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.backgroundColor=kBackgroundColor;
            
            
        }
        
    }
    
    self.slectbtn1.selected=NO;
    sender.selected=YES;
    self.slectbtn1=sender;
    
    
}
-(void)creatFootView
{
    _footview=[[UIView alloc]initWithFrame:CGRectMake(0, kApplicationHeight-50+kUnderStatusBarStartY, kApplicationWidth, 50)];
    _footview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _footview.tag=9999;
//    _footview.hidden = YES;
    
    [self.view addSubview:_footview];
    
    UIButton *selectbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    selectbutton.frame=CGRectMake(15, 15, 20, 20);
    selectbutton.tag=2222;
    [selectbutton setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option@2x"] forState:UIControlStateNormal];
    [selectbutton addTarget:self action:@selector(allselect:) forControlEvents:UIControlEventTouchUpInside];
    [_footview addSubview:selectbutton];
    
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(40, 15, 40, 20)];
    lable.text=@"全选";
    lable.font=kTitleFontSize;
    [_footview addSubview:lable];
    
    _multiDeleteBarButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _multiDeleteBarButton.frame=CGRectMake(kApplicationWidth-60, 10, 50, 30);
    [_multiDeleteBarButton setTitle:@"删除" forState:UIControlStateNormal];
    _multiDeleteBarButton.tintColor=[UIColor whiteColor];
    [_multiDeleteBarButton setBackgroundColor:kbackgrayColor];
    
    [_multiDeleteBarButton addTarget:self action:@selector(multiDeleteClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_footview addSubview:_multiDeleteBarButton];
    
//    [self.view addSubview:_footview];

}
-(void)creatTableView
{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40+Height_NavBar, kApplicationWidth, kApplicationHeight-Height_NavBar-kUnderStatusBarStartY) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.rowHeight=80;
        
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"CollectTableViewCell" bundle:nil] forCellReuseIdentifier:@"CollectCell" ];
    
}

#pragma mark 网络请求发帐号记录
-(void)requestSubmitHttp
{
    [self.dataArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@circle/queryUserNewsList?version=%@&token=%@&bool=true",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        
//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message;
            
            if(statu.intValue==1)//请求成功
            {
                
                for(NSDictionary *dic in responseObject[@"news"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.circle_id=dic[@"circle_id"];
                    model.fine=dic[@"fine"];
                    model.hot=dic[@"hot"];
                    model.news_id=dic[@"news_id"];
                    model.nickname=dic[@"nickname"];
                    model.pic=dic[@"pic"];
                    model.pic_list=dic[@"pic_list"];
                    model.send_time=dic[@"send_time"];
                    model.title=dic[@"title"];
                    
                    model.user_id=dic[@"user_id"];
                    
                    
                    [self.dataArray addObject:model];
                }
                
                
                [_tableView reloadData];
                
            }else{
                
            }
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
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
#pragma mark 删除发帖记录
-(void)deleateHttp:(NSString*)news_id
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSArray *arr=[news_id componentsSeparatedByString:@","];
    NSString *url;
    if(arr.count>1)
    {
        url=[NSString stringWithFormat:@"%@circleNews/delNews?version=%@&token=%@&news_ids=%@",[NSObject baseURLStr],VERSION,token,news_id];
    }else{
        url=[NSString stringWithFormat:@"%@circleNews/delNews?version=%@&token=%@&&news_id=%@",[NSObject baseURLStr],VERSION,token,news_id];
    }
    
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
//        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
//            NSString *message = @"";
            
            if(statu.intValue==1)//请求成功
            {
                //            NSMutableArray *indexarray=[NSMutableArray array];
                //            for(int i=0;i<_selectArray.count;i++)
                //            {
                //
                //                if([_selectArray[i] isEqualToString:@"1"])
                //                {
                //                    [indexarray addObject:[NSString stringWithFormat:@"%d",i]];
                //                }
                //
                //            }
                
                //            [_CollectionArray removeObjectsInArray:indexarray];
                //            [_selectArray removeObjectsInArray:indexarray];
                [self.dataArray removeAllObjects];
                
                [self requestSubmitHttp];
                
//                message=@"删除成功";
            }else{
//                message=@"删除失败";
            }
            
            //        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            //        [mentionview showLable:message Controller:self];
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

#pragma mark 网络请求收藏记录
-(void)requestHttp
{
    [_dataArray removeAllObjects];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSString *url;
    
    url=[NSString stringWithFormat:@"%@circle/queryCollectList?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    
    NSString *URL=[MyMD5 authkey:url];
    //    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
        

//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
            NSString *message;
            
            if(statu.intValue==1)//请求成功
            {
                
                for(NSDictionary *dic in responseObject[@"collects"])
                {
                    ForumModel *model=[[ForumModel alloc]init];
                    model.news_id=dic[@"news_id"];
                    model.nickname=dic[@"nickname"];
                    model.title=dic[@"title"];
                    model.upic=dic[@"upic"];
                    model.user_id=dic[@"user_id"];
                    model.npic=dic[@"npic"];
                    
                    [_dataArray addObject:model];
                }
                
                //            [self creatData];
                
                [_tableView reloadData];
                
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
            
            NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            [mentionview showLable:message Controller:self];
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

#pragma mark 删除收藏的帖子
-(void)deleateCollectHttp:(NSString*)collectNewsid
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    
    NSUserDefaults *userdefaul=[NSUserDefaults standardUserDefaults];
    NSString *token=[userdefaul objectForKey:USER_TOKEN];
    
    NSArray *arr=[collectNewsid componentsSeparatedByString:@","];
    NSString *url;
    if(arr.count>1)
    {
        url=[NSString stringWithFormat:@"%@circleNews/deleteCollectNews?version=%@&token=%@&news_ids=%@",[NSObject baseURLStr],VERSION,token,collectNewsid];
    }else{
        url=[NSString stringWithFormat:@"%@circleNews/deleteCollectNews?version=%@&token=%@&news_id=%@",[NSObject baseURLStr],VERSION,token,collectNewsid];
    }
    
    
    NSString *URL=[MyMD5 authkey:url];
    [MBProgressHUD showMessage:@"正在玩命加载" afterDeleay:0 WithView:self.view];
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view];
        

//        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            NSString *statu=responseObject[@"status"];
//            NSString *message;
            
            if(statu.intValue==1)//请求成功
            {
                //            NSMutableArray *indexarray=[NSMutableArray array];
                //            for(int i=0;i<_selectArray.count;i++)
                //            {
                //
                //                if([_selectArray[i] isEqualToString:@"1"])
                //                {
                //                    [indexarray addObject:[NSString stringWithFormat:@"%d",i]];
                //                }
                //
                //            }
                //
                //            [_CollectionArray removeObjectsInArray:indexarray];
                //            [_selectArray removeObjectsInArray:indexarray];
                
                [_dataArray removeAllObjects];
                [self requestHttp];
                
//                message=@"删除成功";
            }else{
//                message=@"删除失败";
            }
            
            //        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
            //        [mentionview showLable:message Controller:self];

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
-(void)back
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
