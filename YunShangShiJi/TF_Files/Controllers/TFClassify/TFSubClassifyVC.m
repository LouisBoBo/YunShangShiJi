
//
//  TFSubClassifyVC.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/1/19.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFSubClassifyVC.h"
#import "SqliteManager.h"
#import "TFScreenViewController.h"
static NSString *cellId = @"ClassifyItemCellId";

#pragma mark - cell
@interface ClassifyItemCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLable;
@end
@implementation ClassifyItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self setupUI];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-ZOOM6(50))];
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
        
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_imageView.width-ZOOM6(50), 0, ZOOM6(50), ZOOM6(50))];
        [self.contentView addSubview:_iconImageView];
        
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-ZOOM6(40), frame.size.width, ZOOM6(40))];
        _titleLable.textAlignment=NSTextAlignmentCenter;
        _titleLable.font=[UIFont systemFontOfSize:ZOOM6(24)];
        _titleLable.textColor=kSubTitleColor;
        [self.contentView addSubview:_titleLable];
    }
    return self;
}

- (void)setModel:(TypeTagItem *)item {
    
    self.titleLable.text = item.class_name;
    [self.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], item.pic]] placeholderImage:nil progress:nil completed:nil];
    self.iconImageView.hidden= item.is_hot.integerValue==1||item.is_new.integerValue==1?NO:YES;

    if ([item.is_hot intValue] == 1) {
        self.iconImageView.image = [UIImage imageNamed:@"classify_hot"];
    }
    if ([item.is_new intValue] == 1) {
        self.iconImageView.image = [UIImage imageNamed:@"classify_new"];
    }
}

- (void)setupUI {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLable];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(ZOOM6(40));
        make.left.equalTo(self.contentView.mas_left).offset(ZOOM6(20));
        make.right.equalTo(self.contentView.mas_right).offset(-ZOOM6(20));
        make.height.equalTo(self.imageView.mas_width);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_top).offset(-ZOOM6(10));
        make.right.equalTo(self.imageView.mas_right).offset(ZOOM6(10));
        make.size.mas_equalTo(CGSizeMake(ZOOM6(45), ZOOM6(45)));
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(ZOOM6(20));
        make.height.mas_equalTo(@(ZOOM6(30)));
        make.left.and.right.equalTo(self.imageView);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
//    self.contentView.backgroundColor = [UIColor yellowColor];
}

#pragma mark - getter
- (UIImageView *)imageView {
    if (_imageView != nil) {
        return _imageView;
    }
    UIImageView *imageV = [[UIImageView alloc] init];
//    imageV.backgroundColor = COLOR_RANDOM;
    return _imageView = imageV;
}

- (UIImageView *)iconImageView {
    if (_iconImageView != nil) {
        return _iconImageView;
    }
    UIImageView *iconImageView = [[UIImageView alloc] init];
//    iconImageView.backgroundColor = COLOR_RANDOM;
    return _iconImageView = iconImageView;
}

- (UILabel *)titleLable {
    if (_titleLable != nil) {
        return _titleLable;
    }
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = RGBCOLOR_I(168, 168, 168);
    titleLab.font = kFont6px(25);
    titleLab.textAlignment = NSTextAlignmentCenter;
//    titleLab.backgroundColor = COLOR_RANDOM;
    return _titleLable = titleLab;
}

@end

@interface TFSubClassifyVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TFSubClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setData];
    
    [self setupUI];
}

- (void)setData {
    SqliteManager *manager = [SqliteManager sharedManager];
    NSArray *array = [manager getTypeTagItemForSuperIdWithShopping:self.item.ID];
    [self.dataSource addObjectsFromArray:array];
    [self.collectionView reloadData];
}

- (void)setupUI {
    
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setModel:self.dataSource[indexPath.item]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    /*
    CGFloat cell_W = (kScreen_Width - ZOOM6(20) * 3) / 4;
    CGFloat imageV_W_H = cell_W - ZOOM6(20) * 2;
    
    
    CGSize size = CGSizeMake(cell_W, ZOOM6(40) + imageV_W_H + ZOOM6(20) + ZOOM6(30));
    return size;
    */
    
    CGFloat imgH = ZOOM6(200);
    CGFloat imgW = ZOOM6(140);

    CGFloat W = (self.view.frame.size.width-18)/4.0;
    CGFloat H = imgH*W/imgW;
    
    CGSize size = CGSizeMake(W, H);
    return size;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"item: %zd", indexPath.item);
    TypeTagItem *item = self.dataSource[indexPath.item];
    
    NSString *ID = item.ID;
    NSString *title = item.class_name;
    
    TFScreenViewController *svc = [[TFScreenViewController alloc] init];
    svc.dataStatistics = @"搜索下—输入后确定";
    svc.index = 0;
    svc.class_id=ID;
    svc.titleText = title;
    svc.muStr = title;
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (_collectionView != nil) {
        return _collectionView;
    }
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.minimumInteritemSpacing = ZOOM6(20);
//    flowLayout.minimumLineSpacing = 0;
////    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    _collectionView.scrollsToTop = YES;
//    [_collectionView registerClass:[ClassifyItemCell class] forCellWithReuseIdentifier:cellId];
//    _collectionView.backgroundColor = RGBCOLOR_I(240, 240, 240);
    
    
    WaterFLayout *flowLayout=[[WaterFLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(ZOOM6(30), ZOOM6(20), ZOOM6(30), ZOOM6(20));
    flowLayout.minimumColumnSpacing=ZOOM6(20);
    flowLayout.minimumInteritemSpacing=ZOOM6(30);
    flowLayout.columnCount=4;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.scrollsToTop = YES;
    [_collectionView registerClass:[ClassifyItemCell class] forCellWithReuseIdentifier:cellId];

    [self.view addSubview:_collectionView];
    return _collectionView;
}

- (NSMutableArray *)dataSource {
    if (_dataSource != nil) {
        return _dataSource;
    }
    NSMutableArray *dataSource = [NSMutableArray array];
    return _dataSource = dataSource;
}

@end

