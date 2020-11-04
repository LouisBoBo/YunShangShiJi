//
//  PersonPhotosVC.m
//  YunShangShiJi
//
//  Created by yssj on 2017/2/16.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "PersonPhotosVC.h"
#import "DoPhotoCell.h"
#import "PhotoViewController.h"
#import "TopicDetailViewController.h"
#import "ShopDetailViewController.h"

#import "MJPhoto.h"
#import "CFPhotoBrowser.h"
#import "DefaultImgManager.h"

@interface PersonPhotosVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView           *_coverView;
    NSMutableArray   *_frameArr;
    NSMutableArray   *_imgArray;
    NSMutableArray   *_bigUrlArray;
    NSMutableArray   *_titleArray;

}
@property (strong, nonatomic)  UICollectionViewFlowLayout   *flowLayout;
@property (strong, nonatomic)  UICollectionView   *collectionView;
@property (strong, nonatomic)  NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *srcArray;

@end

@implementation PersonPhotosVC
- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout==nil) {
        //确定是水平滚动，还是垂直滚动
        _flowLayout=[[UICollectionViewFlowLayout alloc] init];
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _flowLayout.minimumLineSpacing=5;
        _flowLayout.minimumInteritemSpacing=5;
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, ZOOM(570));  //设置head大小
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if (_collectionView==nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar) collectionViewLayout:self.flowLayout];
        [_collectionView registerNib:[UINib nibWithNibName:@"DoPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"DoPhotoCell"];
        _collectionView.backgroundColor=kBackgroundColor;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
    }
    return _collectionView;
}
- (NSMutableArray *)srcArray
{
    if (!_srcArray) {
        _srcArray = [NSMutableArray array];
        [self.dataArr enumerateObjectsUsingBlock:^(PersonPhoto  *photoModel, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *picSize=@"";
//            if (kDevice_Is_iPhone6Plus) {
//                picSize = @"!450";
//            } else {
//                picSize = @"!382";
//            }
            if ([photoModel.theme_type integerValue] == 1) {
                NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",photoModel.shop_list[@"shop_code"]]];
                NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                NSString *pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,photoModel.shop_list[@"shop_code"],photoModel.shop_list[@"def_pic"]];
                
                NSString *imgUrl = [NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize];
                [_srcArray addObject:imgUrl];
            } else {
               NSString *urlStr=[NSString stringWithFormat:@"%@%@%@/%@%@",[NSObject baseURLStr_Upy] ,@"myq/theme/", photoModel.user_id,[photoModel.pic substringToIndex:photoModel.pic.length-4],picSize];
                [_srcArray addObject:urlStr];
            }
        }];
        
    }
    return _srcArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _frameArr =[NSMutableArray array];
    _imgArray= [NSMutableArray array];
    _bigUrlArray = [NSMutableArray array];
    _titleArray = [NSMutableArray array];
    
    [self setNavigationItemLeft:@"个人相册"];
//    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 63, kScreenWidth, 0.5)];
//    line.backgroundColor=kNavLineColor;
//    [self.navigationView addSubview:line];
    
    [self.view addSubview:self.collectionView];
    
    [self httpGetData];
}

- (void)httpGetData {
    kSelfWeak;
    [PersonPhotosModel httpGetPersonPhotosModelSuccess:^(id data) {
        PersonPhotosModel *model=data;
        if (model.status==1) {
            if (model.data.count) {
                weakSelf.dataArr = [model.data copy];
                [weakSelf.collectionView reloadData];
            }else {
                CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
                [weakSelf showBackgroundType:ShowBackgroundTypeListEmpty message:nil superView:self.view setSubFrame:frame];
            }
        }
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    PersonPhoto *model=self.dataArr[indexPath.row];
//    if (model.theme_type.integerValue==1) {
//        
//    }else
    
    int count = (int)self.srcArray.count;
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:self.srcArray[i]];
        [photos addObject:photo];
    }
    
    //临时解决方案
    PhotoViewController *VC=[[PhotoViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
    CFPhotoBrowser *browser = [[CFPhotoBrowser alloc] init];
    browser.currentPhotoIndex = indexPath.item;
    browser.photos = photos;
    browser.modelArray=self.dataArr;
    browser.dismissBlock = ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    };
    kWeakSelf(nav);
    browser.footBtnClick=^(NSInteger index){
        PersonPhoto *model=self.dataArr[index];
        if (model.theme_type.integerValue==1) {
            ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
            shopdetail.shop_code = model.shop_list[@"shop_code"];
            shopdetail.theme_id = [model.theme_id stringValue];
            shopdetail.stringtype = @"订单详情";
            [weaknav pushViewController:shopdetail animated:YES];
        }else{
            TopicDetailViewController *topic = [[TopicDetailViewController alloc]init];
            topic.theme_id = [NSString stringWithFormat:@"%@",model.theme_id];
            [weaknav pushViewController:topic animated:YES];
        }
    };
    [self presentViewController:nav animated:NO completion:nil];
    [browser show:VC.view];

    //  以下方法有问题
     /*
    {
      
        DoPhotoCell *cell = (DoPhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //    CGRect rect = cell.frame;
        CGRect  rect = CGRectMake(cell.frame.origin.x, cell.frame.origin.y+64, cell.frame.size.width, cell.frame.size.height);
//        if (_coverView == nil) {
//            _coverView = [[UIView alloc] initWithFrame:cell.bounds];
//            _coverView.backgroundColor = [UIColor whiteColor];
//        }
//        [cell addSubview:_coverView];
        
        PhotoViewController *photoVC = [[PhotoViewController alloc] init];
//        photoVC.urlArray = _bigUrlArray;
        photoVC.imgFrame = rect;
        photoVC.index = indexPath.row;
        //    photoVC.imgArray=[_imgArray copy];
//        photoVC.frameArray = [_frameArr copy];
//        photoVC.titleArray=_titleArray;
        photoVC.modelArray=self.dataArr;
        ********
        photoVC.footBtnClick = ^(NSInteger index){
            PersonPhoto *model=self.dataArr[index];
            if (model.theme_type.integerValue==1) {
                ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
                shopdetail.shop_code = model.shop_list[@"shop_code"];
                shopdetail.theme_id = [model.theme_id stringValue];
                shopdetail.stringtype = @"订单详情";
                [self.navigationController pushViewController:shopdetail animated:YES];
            }else{
                TopicdetailsViewController *topic = [[TopicdetailsViewController alloc]init];
                topic.theme_id = [NSString stringWithFormat:@"%@",model.theme_id];
                [self.navigationController pushViewController:topic animated:YES];
            }
        };
        //    photoVC.imgData = [self getImageDataWithUrl:[_urlArray objectAtIndex:indexPath.row]];
//        [self.navigationController pushViewController:photoVC animated:NO];
       *******
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:photoVC];
        [self presentViewController:nav animated:NO completion:nil];
        
//        photoVC.indexBlock = ^(NSInteger index){
//            
//            NSIndexPath *indexP = [NSIndexPath indexPathForItem:index inSection:0];
//            DoPhotoCell *cel = (DoPhotoCell *)[collectionView cellForItemAtIndexPath:indexP];
//            [cel addSubview:_coverView];
//        };
        
//        [photoVC setCompletedBlock:^(void){
//            [_coverView removeFromSuperview];
//            _coverView = nil;
//        }];
      
    }
     */
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DoPhotoCell *cell = (DoPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"DoPhotoCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    
    PersonPhoto *model=self.dataArr[indexPath.row];
    ;
    
    NSString *urlStr;NSURL *url;
    NSString *picSize;
    
    if (kDevice_Is_iPhone6Plus) {
        picSize = @"!382";
    } else {
        picSize = @"!280";
    }
    if (model.theme_type.integerValue==1) {
        NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_list[@"shop_code"]]];
        NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
        
        NSString *pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_list[@"shop_code"],model.shop_list[@"def_pic"]];
        
      
        
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize]];
        

    }else{
        urlStr=[NSString stringWithFormat:@"%@%@%@/%@%@",[NSObject baseURLStr_Upy] ,@"myq/theme/", model.user_id,[model.pic substringToIndex:model.pic.length-4],picSize];
        url = [NSURL URLWithString:urlStr];
        
    }
    [_titleArray addObject:[NSString stringWithFormat:@"%@%@",model.title,model.content]];
    [cell.ivPhoto sd_setImageWithURL:url placeholderImage:[[DefaultImgManager sharedManager] defaultImgWithSize:(cell.ivPhoto.bounds.size)] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [_imgArray addObject:image];
    }];
    cell.ivPhoto.contentMode=UIViewContentModeScaleAspectFill;
    

    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (self.view.frame.size.width-25)/4;
    return CGSizeMake(width, width);
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
