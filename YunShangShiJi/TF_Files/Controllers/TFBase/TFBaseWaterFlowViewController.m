//
//  TFBaseWaterFlowViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseWaterFlowViewController.h"
#import "ShopDetailViewController.h"
#import "ShopDetailModel.h"
#import "WaterFlowCell.h"

@interface TFBaseWaterFlowViewController ()

@end

@implementation TFBaseWaterFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:self.titleText];
    [self dataInit];
    [self createUI];
}
- (void)dataInit
{
    [self.waterFlowDataArray addObjectsFromArray:self.receiveArray];
//    //self.waterFlowDataArray = %@",self.waterFlowDataArray);
}

- (void)createUI
{
    WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    flowLayout.minimumColumnSpacing = 5;
    flowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = RGBCOLOR_I(244,244,244);
    [self.view addSubview:self.collectionView];
    
     [self.collectionView registerNib:[UINib nibWithNibName:@"WaterFlowCell" bundle:nil] forCellWithReuseIdentifier:@"WATERFLOWCELLID"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.waterFlowDataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WATERFLOWCELLID" forIndexPath:indexPath];
    cell.selectBtn.hidden = YES;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat imgH = 900;
    CGFloat imgW = 600;
    
    CGFloat W = (kScreenWidth-18)/2.0;
    CGFloat H = imgH*W/imgW;
    
    CGSize size = CGSizeMake(W, H+5);
    
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSMutableArray *)waterFlowDataArray
{
    if (_waterFlowDataArray == nil) {
        _waterFlowDataArray = [[NSMutableArray alloc] init];
    }
    
    return _waterFlowDataArray;
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
