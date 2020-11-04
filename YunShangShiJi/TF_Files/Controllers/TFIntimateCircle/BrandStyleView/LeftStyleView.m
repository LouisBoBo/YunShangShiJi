//
//  LeftStyleView.m
//  BrandStyleView
//
//  Created by yssj on 2017/4/1.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "LeftStyleView.h"
#import "HobbyModel.h"
#import "WaterFallFlowViewModel.h"

@interface StyleViewCollectionCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIButton *selectIco;
- (void)setSelectMode:(BOOL)select;
@end
@implementation StyleViewCollectionCell

- (UIImageView *)imgView {
    if (_imgView==nil) {
        _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _imgView;
}
- (UIButton *)selectIco {
    if (_selectIco==nil) {
        _selectIco=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-7-25, 7, 25, 25)];
        [_selectIco setImage:[UIImage imageNamed:@"wodexihao_fengge_icon_weixuanzhong"] forState:UIControlStateNormal];
        [_selectIco setImage:[UIImage imageNamed:@"wodexihao_fengge_icon_xuanzhong"] forState:UIControlStateSelected];
        _selectIco.userInteractionEnabled=NO;
    }
    return _selectIco;
}
- (UILabel *)title {
    if (_title==nil) {
        _title=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30)];
        _title.textColor=[UIColor whiteColor];
        _title.textAlignment=NSTextAlignmentCenter;
    }
    return _title;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.layer.cornerRadius=5;
        
        [self setUI];
    }
    return self;
}
- (void)setUI {
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.selectIco];
    [self.contentView addSubview:self.title];
}
- (void)setSelectMode:(BOOL)select {
    self.selectIco.selected=select;
}
@end

@interface LeftStyleView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSIndexPath *lastSelectIndex;
}
@property (nonatomic,copy)NSArray *arr;
@end

@implementation LeftStyleView

-(instancetype)initWithFrame:(CGRect)frame WithData:(NSArray *)data withSelectIndex:(void (^)(NSInteger, id, id))selectIndex {
    self=[super initWithFrame:frame];
    if (self) {
        _block          = selectIndex;
        _arr = data;
        [self setUI];
        if (_arr.count==0) {
            [self creatData];
        }
    }
    return self;
}
- (void)creatData {
   WaterFallFlowViewModel *viewModel = [[WaterFallFlowViewModel alloc] init];
    kSelfWeak;
    [viewModel getData:^{
        weakSelf.arr = viewModel.dataArray[1];
        [weakSelf.StyleCollectionView reloadData];
    } Fail:^{
        
    }];
}
- (void)setUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumInteritemSpacing  =5.f;//左右间隔
    flowLayout.minimumLineSpacing       =5.f;
    
//    float leftMargin = 0;
    self.StyleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(ZOOM6(20),ZOOM6(30),self.frame.size.width-ZOOM6(20)*2,self.frame.size.height-ZOOM6(30)*2) collectionViewLayout:flowLayout];
    self.StyleCollectionView.backgroundColor=[UIColor whiteColor];
    self.StyleCollectionView.delegate   = self;
    self.StyleCollectionView.dataSource = self;
    
    [self.StyleCollectionView registerClass:[StyleViewCollectionCell class] forCellWithReuseIdentifier:@"StyleViewCollectionCell"];
    //标签cell
    //        UINib *nib=[UINib nibWithNibName:kMultilevelCollectionViewCell bundle:nil];
    //        [self.rightCollection registerNib: nib forCellWithReuseIdentifier:kMultilevelCollectionViewCell];
//    [self.StyleCollectionView registerClass:[StyleCollectionCell class] forCellWithReuseIdentifier:kMultilevelCollectionViewCell];
    
    //header，此处为图片
//    UINib *header=[UINib nibWithNibName:kMultilevelCollectionHeader bundle:nil];
//    [self.StyleCollectionView registerNib:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMultilevelCollectionHeader];
    
    [self addSubview:self.StyleCollectionView];

}
#pragma mark - UICollectionViewDelegates for photos
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StyleViewCollectionCell *cell = (StyleViewCollectionCell *)[self.StyleCollectionView dequeueReusableCellWithReuseIdentifier:@"StyleViewCollectionCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    
    HobbyModel *model = self.arr[indexPath.item];

//    cell.title.text=[NSString stringWithFormat:@"%zd",indexPath.row];
    model.pic.length>10?([cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]]]):(cell.imgView.image = [UIImage imageNamed:[self getImage:model.title]]);
//    if (indexPath.row==0)
        [cell setSelectMode:NO];
//    else
//        [cell setSelectMode:YES];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StyleViewCollectionCell *cell = (StyleViewCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setSelectMode:YES];
    
    if (lastSelectIndex!=indexPath) {
        StyleViewCollectionCell *lastSelectCell = (StyleViewCollectionCell *)[collectionView cellForItemAtIndexPath:lastSelectIndex];
        [lastSelectCell setSelectMode:NO];
    }

    
    lastSelectIndex = indexPath;
    
    HobbyModel *model = self.arr[indexPath.item];
    
    void (^select)(NSInteger left,id right,id info) = self.block;
    
    select(lastSelectIndex.row,model.ID,model.title);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.frame.size.width-10-ZOOM6(20)*2)/3;
    
    return CGSizeMake(width, width);
}
- (NSString*)getImage:(NSString*)imgname
{
    NSString *imagestr = @"wodexihao_fengge_hanxi";
    if([imgname isEqualToString:@"韩系"])
    {
        imagestr = @"wodexihao_fengge_hanxi";
    }
    else if ([imgname isEqualToString:@"通勤名媛"])
    {
        imagestr = @"wodexihao_fengge_jianyue";
    }
    else if ([imgname isEqualToString:@"欧美街头"])
    {
        imagestr = @"wodexihao_fengge_oumei";
    }
    else if ([imgname isEqualToString:@"轻熟"])
    {
        imagestr = @"wodexihao_fengge_qishu";
    }
    else if ([imgname isEqualToString:@"日系"])
    {
        imagestr = @"wodexihao_fengge_rixi";
    }
    else if ([imgname isEqualToString:@"文艺复古"])
    {
        imagestr = @"wodexihao_fengge_wenyi";
    }
    else if ([imgname isEqualToString:@"学院风"])
    {
        imagestr = @"wodexihao_fengge_xueyuan";
    }
    else if ([imgname isEqualToString:@"运动休闲"])
    {
        imagestr = @"wodexihao_fengge_yundong";
    }
    
    return imagestr;
}

@end
