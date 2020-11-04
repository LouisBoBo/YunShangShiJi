//
//  YFDPCollectionCell.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//  搭配相关推荐cell

#import <UIKit/UIKit.h>

@interface YFDPCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgView;  //图片
@property (nonatomic, strong) UILabel *titleLabel;   //标题
@property (nonatomic, strong) UILabel *contentLabel; //价格
@property (nonatomic, strong) UILabel *suppLabel;    //供应商名称

@property (nonatomic, strong) UILabel *fengqiangLabel;
@property (nonatomic, strong) UILabel *oneyuanLabel;

@end
