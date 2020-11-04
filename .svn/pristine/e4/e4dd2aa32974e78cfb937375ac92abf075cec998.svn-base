//
//  YFDPCell.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFDPCell.h"
#import "GlobalTool.h"
#import "UIImageView+WebCache.h"
#import "YFDPCollectionCell.h"
#import "YFDPImageView.h"
#import "CollocationModel.h"
#import "DefaultImgManager.h"

#define DefaultImg(size) [[DefaultImgManager sharedManager] defaultImgWithSize:(size)]
#define spacing  kZoom6pt(10)  //间隙
#define itemHeight  kZoom6pt(90) //小图高度（宽高1:1）

@interface YFDPCell ()<UICollectionViewDataSource, UICollectionViewDelegate, YFDPImageViewDelegate>
{
    NSMutableArray *_typeData;
    NSArray *_shopData;
    void(^_block)(NSString *shopCode);
}
@property (nonatomic, strong) YFDPImageView *heardImgView; //头部大图（宽＝高＝屏幕宽度）
@property (nonatomic, strong) UICollectionView *collectionView; //底部相关推荐

@end

@implementation YFDPCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _typeData = [NSMutableArray array];
        _shopData = nil;
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self.contentView addSubview:self.heardImgView];
    [self.contentView addSubview:self.collectionView];
}

#pragma mark - 更新数据
- (void)receiveDataModel:(CollocationModel *)model ISCollocation:(BOOL)iscollocation{
    
    self.iscollocation = iscollocation;
    
//    NSString *st = kDevice_Is_iPhone6Plus?@"!450":@"!382";
    NSString *st = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],model.collocation_pic,st];

    [self.heardImgView setImageWithURL:[NSURL URLWithString:url] placeholderImage:DefaultImg(_heardImgView.bounds.size) progress:nil completed:nil];
    
    if ([model.type integerValue] == 2) {
        self.heardImgView.height = kScreen_Width / 1.5;
        [self.collectionView setY:self.heardImgView.bottom];
        
//        self.heardImgView.isTopics = YES;
        self.heardImgView.isTopics = NO;
        self.heardImgView.isTitle = NO;
        self.heardImgView.imageViewType = YFDPImageViewType_Topics;
        self.heardImgView.mainTitleLabel.text = model.collocation_name;
        self.heardImgView.subTitleLabel.text = [NSString stringWithFormat:@"【%@】", model.collocation_name2];
    } else {
        self.heardImgView.height = kScreen_Width;
        [self.collectionView setY:self.heardImgView.bottom];
        
        self.heardImgView.isTopics = NO;
        self.heardImgView.isTitle = YES;
        self.heardImgView.imageViewType = YFDPImageViewType_Nomal;
        self.heardImgView.titleLabel.text = model.collocation_name;
        _shopData = [model.collocation_shop copy];
        [self.heardImgView reloadData];
    }
    
    [_typeData removeAllObjects];
    for (CollocationTypeModel *tModel in model.shop_type_list) {
        [_typeData addObjectsFromArray:tModel.list];
    }
    [_collectionView reloadData];
}

#pragma mark - YFDPImageViewDelegate
- (NSInteger)numberOfTag {
    return _shopData.count;
}

- (void)tagBtn:(YFTagButton *)tagBtn tagForRowAtindex:(NSInteger)index {
    CollocationShopModel *sModel = _shopData[index];
    [tagBtn setTitle:sModel.shop_name
               price:[NSString stringWithFormat:@"¥%.1f",sModel.shop_se_price]
              origin:CGPointMake(sModel.shop_x,sModel.shop_y)
               isImg:!sModel.option_flag
               ispic:sModel.option_flag 
                type:index%2];
}

- (void)imageView:(YFDPImageView *)imageView didSelectRowAtIndex:(NSInteger)index {
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"首页搭配图坐标" success:nil failure:nil];
    CollocationShopModel *model = _shopData[index];
    if (_block) {
        _block(model.shop_code);
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _typeData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YFDPCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CollocationShopModel *model = _typeData[indexPath.item];
    
    NSString *supcode  = [model.shop_code substringWithRange:NSMakeRange(1, 3)];
    NSString *url = [NSString stringWithFormat:@"%@%@/%@/%@",[NSObject baseURLStr_Upy],supcode,model.shop_code,model.def_pic];
    NSURL *imgUrl = [NSURL URLWithString:url];
    [cell.imgView setImageWithURL:imgUrl placeholderImage:DefaultImg(cell.imgView.bounds.size) progress:nil completed:nil];
    cell.titleLabel.text = model.shop_name;
//    if(self.iscollocation)
    {
//        cell.suppLabel.text = model.supp_label.length ? [NSString stringWithFormat:@"%@制造商出品", model.supp_label] : @"";
        cell.suppLabel.text = model.supp_label.length ? [NSString stringWithFormat:@"%@", model.supp_label] : @"";
    }
//    cell.contentLabel.text = [NSString stringWithFormat:@"¥%.1f",model.shop_se_price- (int)model.kickback];
    cell.contentLabel.text = [NSString stringWithFormat:@"¥%.1f",model.shop_se_price];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
    CollocationShopModel *model = _typeData[indexPath.item];
    if (_block) {
        _block(model.shop_code);
    }
    [TFStatisticsClickVM handleDataWithPageType:nil withClickType:@"首页搭配推荐商品图片" success:nil failure:nil];
}

#pragma mark - 赋值
- (void)setShopCodeBlock:(void (^)(NSString *))block {
    _block = [block copy];
}

#pragma mark - getter
- (YFDPImageView *)heardImgView {
    if (nil == _heardImgView) {
        _heardImgView = [[YFDPImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth,kScreenWidth) isTriangle:YES isShade:YES isTitle:YES];
        _heardImgView.backgroundColor = lineGreyColor;
        _heardImgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        _heardImgView.contentMode = UIViewContentModeScaleAspectFill;
        _heardImgView.clipsToBounds = YES;
        _heardImgView.delegate = self;
    }
    return _heardImgView;
}

- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(itemHeight, itemHeight+ZOOMPT(44) + ZOOMPT(11));
        flowLayout.minimumInteritemSpacing = spacing;
//        flowLayout.sectionInset = UIEdgeInsetsMake(spacing + ZOOMPT(3), spacing, spacing + ZOOMPT(7), spacing);
        flowLayout.sectionInset = UIEdgeInsetsMake(spacing , spacing, spacing , spacing);

        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kScreenWidth,
                                                                            self.contentView.bounds.size.width,
                                                                            itemHeight + ZOOMPT(44) + spacing*2 + ZOOMPT(11))
                                            collectionViewLayout:flowLayout];
        [_collectionView registerClass:[YFDPCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.scrollsToTop = NO;
    }
    return _collectionView;
}

#pragma mark - cell高度计算
+ (CGFloat)cellHeight {
    return kScreenWidth + itemHeight + ZOOMPT(44) + spacing*2 + ZOOMPT(11);
}

+ (CGFloat)cellForTopicsHeight {
    return kScreenWidth / 1.5 + itemHeight + ZOOMPT(44) + spacing*2 + ZOOMPT(11);
}


@end
