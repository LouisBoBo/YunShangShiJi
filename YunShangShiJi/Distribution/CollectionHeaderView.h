//
//  CollectionHeaderView.h
//  YunShangShiJi
//
//  Created by yssj on 15/10/26.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFDPImageView.h"
#import "CollocationShopModel.h"
#import "CollocationModel.h"
#import "UIImageView+WebCache.h"
@interface CollectionHeaderView : UICollectionReusableView

@property(nonatomic,strong)UIImageView *headImgView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *freezeMoneyLabel;
@property(nonatomic,strong)UILabel *availableMoneyLabel;
@property(nonatomic,strong)UILabel *allMoneyLabel;
@property(nonatomic,strong)UILabel *depositMoneySuccessSumLabel;
@property(nonatomic,strong)UIButton *arrowBtn;

@end
