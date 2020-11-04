//
//  ScreenViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 15/6/19.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "ScreenViewController.h"
#import "GlobalTool.h"
#import "WaterFLayout.h"
#import "CollectionViewCell.h"
#import "ShopDetailViewController.h"
#import "ShopDetailModel.h"
#import "UIImageView+WebCache.h"
@interface ScreenViewController ()
{
    UICollectionView *_Mycollection;
    NSArray *_dataArray;
}
@end

@implementation ScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=self.collectionDataArray;
    
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"u265"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    //设置我的喜欢
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 120, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text=@"筛选结果";
    titlelable.textColor=[UIColor whiteColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    backbtn.frame=CGRectMake(10, 20, 40, 40);
    backbtn.centerY = View_CenterY(headview);
    [backbtn setBackgroundImage:[UIImage imageNamed:@"u267"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:backbtn];
    
    [self creatCollectionView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    Myview.hidden=NO;
}

-(void)creatCollectionView
{
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    
    
    _Mycollection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar) collectionViewLayout:flowLayout];
    _Mycollection.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _Mycollection.delegate=self;
    _Mycollection.dataSource=self;
    
    [self.view addSubview:_Mycollection];
    [_Mycollection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"Cell";
    CollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[CollectionViewCell alloc]init];
        
    }
    
    ShopDetailModel *model=_dataArray[indexPath.item];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //GCD加载图片
            [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.def_pic]]];
            
            CGFloat imgwidh;
            CGFloat imgheigh;
            
            NSString *str=model.def_pic;
            str=[str substringToIndex:[str length]-4];
            NSArray *arr=[str componentsSeparatedByString:@"_"];
            if(arr.count>=2)
            {
                imgheigh=[arr[1] floatValue];
                imgwidh=[arr[2] floatValue];
            }
            
            CGFloat f=imgwidh/imgheigh;
            
            if (isnan(f)) {
                cell.titleImage.frame=CGRectMake(0, 0, cell.titleImage.frame.size.width, cell.titleImage.frame.size.width/f);
            }

            
//            cell.titleImage.layer.cornerRadius=5;
//            cell.titleImage.layer.masksToBounds = YES;
//            cell.titleImage.layer.borderColor = [UIColor brownColor].CGColor;
//            cell.titleImage.layer.borderWidth = 1;
            
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
    
    ShopDetailModel *model=_dataArray[indexPath.item];
    NSString *str=model.def_pic;
    str=[str substringToIndex:[str length]-4];
    NSArray *arr=[str componentsSeparatedByString:@"_"];
    if(arr.count>=2)
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
    
    
    ShopDetailModel *model=_dataArray[indexPath.row];
    ShopDetailViewController *detail=[[ShopDetailViewController alloc]init];
    detail.shop_code=model.shop_code;
    [self.navigationController pushViewController:detail animated:YES];
    
}

-(void)back:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
