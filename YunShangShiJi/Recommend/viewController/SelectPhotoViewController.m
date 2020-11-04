//
//  SelectPhotoViewController.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/9.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "SelectPhotoViewController.h"
#import "FJWaterfallFlowLayout.h"
#import "ImageCollectionViewCell.h"
#import "ShopShareModel.h"
#import "RecommendModel.h"
#import "MBProgressHUD+XJ.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD.h"
#import "GlobalTool.h"

@interface SelectPhotoViewController ()<UICollectionViewDelegateFlowLayout,FJWaterfallFlowLayoutDelegate>

@property (strong, nonatomic)  UICollectionViewFlowLayout   *flowLayout;
@end

@implementation SelectPhotoViewController
{
    UICollectionViewFlowLayout *_flowLayout;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    [self creatData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
}
#pragma mark *********************UI界面***********************
- (void)creatUI
{
    [self creatNavagationbar];
    
    [self creatCollectionView];
}

- (void)creatNavagationbar
{
    //导航条
    self.tabheadview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:self.tabheadview];
    self.tabheadview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(self.tabheadview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, self.tabheadview.frame.size.height/2+10);
    titlelable.text=@"自己选";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
    self.okbtn=[[UIButton alloc]init];
    self.okbtn.frame=CGRectMake(kApplicationWidth-ZOOM6(120), 23, ZOOM6(100), 40);
    self.okbtn.centerY = View_CenterY(self.tabheadview);
    [self.okbtn setTitle:@"确定" forState:UIControlStateNormal];
    self.okbtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.okbtn setTitleColor:tarbarrossred forState:UIControlStateNormal];
    self.okbtn.selected = NO;
    [self.okbtn addTarget:self action:@selector(okclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:self.okbtn];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar-1, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    
}
- (void)creatCollectionView
{
//    FJWaterfallFlowLayout *fjWaterfallFlowLayout = [[FJWaterfallFlowLayout alloc] init];
//    fjWaterfallFlowLayout.itemSpacing = 0;
//    fjWaterfallFlowLayout.lineSpacing = 0;
//    fjWaterfallFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    fjWaterfallFlowLayout.colCount = 4;
//    fjWaterfallFlowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];    
}

#pragma mark *********************数据***********************
- (void)creatData
{
    [RecommendModel getShareData:^(id data) {
        RecommendModel *model = data;
        if(model.status == 1 && model.list.count)
        {
//            NSMutableArray *photos = [NSMutableArray array];
//            [photos addObjectsFromArray:model.list];
            
            for (int i = 0; i < model.list.count; i++) {
                
                ShopShareModel *sharemodel = model.list[i];
                
                NSMutableString *code = [NSMutableString stringWithString:sharemodel.shop_code];
                NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                NSMutableString *str1 = [NSMutableString stringWithString:sharemodel.show_pic];
                NSArray *arr1 = [str1 componentsSeparatedByString:@","];
                if(arr1.count)
                {
                    NSString *imageurl = [NSString stringWithFormat:@"%@/%@/%@",supcode,sharemodel.shop_code,arr1[0]];
                    
                    sharemodel.show_pic = [NSString stringWithFormat:@"%@",imageurl];
                    sharemodel.is_Select = NO;
                    [self.dataSource addObject:sharemodel];
                }
            }
            
            [self.collectionView reloadData];
        }else{
            [MBProgressHUD show:@"网络请求失败" icon:nil view:self.view];
        }
    }];
}

#pragma mark collectionViewDatasouce
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShopShareModel *model = _dataSource[indexPath.item];
    
    ImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    kWeakSelf(cell);
    cell.clickBlock = ^(){
        
        model.is_Select = !model.is_Select;
        if(model.is_Select)
        {
            NSMutableArray *images = [NSMutableArray array];
            for(int i = 0 ;i<self.dataSource.count;i++)
            {
                ShopShareModel *model = self.dataSource[i];
                if(model.is_Select == YES)
                {
                    [images addObject:model];
                }
            }
            if(images.count >9)
            {
                [MBProgressHUD show:@"选择的美衣图片不可以超过9件哦~" icon:nil view:nil];
                model.is_Select = NO;
                return ;
            }

            weakcell.selectmark.image = [UIImage imageNamed:@"wodexihao_fengge_icon_xuanzhong"];
        }else{
            weakcell.selectmark.image = [UIImage imageNamed:@"wodexihao_fengge_icon_weixuanzhong"];
        }
    };
    
    [cell setPhotoData:model];
    
    return cell;
}

//#pragma mark FJWaterfallFlowLayoutDelegate
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FJWaterfallFlowLayout*)collectionViewLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath
//{
//    CGFloat Heigh = 0;
//
//    Heigh = ceil((kScreenWidth - 50)/4);
//    
//    return Heigh;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat Heigh = 0;
    Heigh = ceil((kScreenWidth - 50)/4);
    return CGSizeMake(Heigh, Heigh);
}

#pragma makr 确定
- (void)okclick:(UIButton*)sender
{
    NSMutableArray *images = [NSMutableArray array];
    for(int i = 0 ;i<self.dataSource.count;i++)
    {
        ShopShareModel *model = self.dataSource[i];
        if(model.is_Select == YES)
        {
            [images addObject:model];
        }
    }
    
    if(images.count)
    {
        if(images.count >9)
        {
            [MBProgressHUD show:@"选择的美衣图片不可以超过9件哦~" icon:nil view:nil];
        }else{
            if(self.selectPhotoBlock)
            {
                self.selectPhotoBlock(images);
            }
            
            [self back];

        }
    }else{
        [MBProgressHUD show:@"你还没有选择美衣图片哦~" icon:nil view:nil];
    }
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout==nil) {
        //确定是水平滚动，还是垂直滚动
        _flowLayout=[[UICollectionViewFlowLayout alloc] init];
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _flowLayout.minimumLineSpacing=0;
        _flowLayout.minimumInteritemSpacing=0;
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, ZOOM(570));  //设置head大小
    }
    return _flowLayout;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSMutableArray*)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
