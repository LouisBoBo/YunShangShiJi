//
//  MyTreasureGroupsShareCell.m
//  YunShangShiJi
//
//  Created by YF on 2017/9/1.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "MyTreasureGroupsShareCell.h"
#import "GlobalTool.h"
#import "MBProgressHUD+NJ.h"
#import "TreasureTableCollectionCell.h"

@interface MyTreasureGroupsShareCell(){
    NSInteger needGroupsNum;
    NSString *shopShareName;
}
@end

@implementation MyTreasureGroupsShareCell
- (void)loadData:(TreasureGroupsModel *)model needNum:(NSInteger)needNum shopName:(NSString *)shopName{
//    needNum = 6;
    self.dataModel = model;
    needGroupsNum = needNum;
    shopShareName = shopName;
    NSInteger count = (model.user.count + 1) < needNum ? needNum : model.user.count + 1;
    if (count) {
        CGFloat pace;
        if(count>5)
            pace = kScreenWidth-(ZOOM6(120)*5+(kScreenWidth-ZOOM6(120)*5)/6*(4));
        else
            pace = kScreenWidth-(ZOOM6(120)*count+(kScreenWidth-ZOOM6(120)*5)/6*(count-1));
        self.mediaView.frame = CGRectMake(pace/2, 0,kScreenWidth-pace, ZOOM6(20)*(count/5)+ZOOM6(160)*((count/5+(count%5?1:0))));
//        self.mediaView.backgroundColor = DRandomColor;
        [self.mediaView reloadData];
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.mediaView];

    }
    return self;
}

- (UICollectionView *)mediaView {
    if (!_mediaView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = ZOOM6(20);
//        layout.minimumInteritemSpacing = (kScreenWidth-ZOOM6(100)*5)/6;
        UICollectionView *mediaView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(160)) collectionViewLayout:layout];
        mediaView.scrollEnabled = NO;
        [mediaView setBackgroundView:nil];
        [mediaView setBackgroundColor:[UIColor clearColor]];
        [mediaView registerClass:[TreasureTableCollectionCell class] forCellWithReuseIdentifier:@"TreasureCollectionCell"];
        mediaView.backgroundColor = [UIColor whiteColor];
        mediaView.dataSource = self;
        mediaView.delegate = self;
//        mediaView.backgroundColor = DRandomColor;
        _mediaView = mediaView;
    }
    return _mediaView;
}
#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = (self.dataModel.user.count + 1) < needGroupsNum ? needGroupsNum : self.dataModel.user.count + 1;
    return count;
//    return self.dataModel.user.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TreasureTableCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TreasureCollectionCell" forIndexPath:indexPath];
    if (indexPath.row) {
        cell.userIco.hidden=YES;
        if (indexPath.row<self.dataModel.user.count+1) {
            cell.userLabel.hidden=YES;
            TreasureGroupsModel *model = self.dataModel.user[indexPath.row-1];
            [cell loadHeadImg:model.head name:model.nickname];
        }else {
            cell.userLabel.hidden = NO;
            cell.userLabel.text = [NSString stringWithFormat:@"谁要\n%@",shopShareName];
            [cell loadHeadImg:nil name:@""];
        }
    }else {
        cell.userIco.hidden=NO;cell.userLabel.hidden=YES;
        TreasureGroupsModel *model = self.dataModel;
        [cell loadHeadImg:model.thead name:model.nickname];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row>=(self.dataModel.user.count+1)) {
        [MBProgressHUD show:@"快去分享邀请好友参与吧" icon:nil view:self.viewController.view];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = CGSizeZero;
    if (collectionView == _mediaView) {
        itemSize = CGSizeMake(ZOOM6(120), ZOOM6(160));
    }
    return itemSize;
}

@end
