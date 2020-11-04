//
//  AddMemberCardViewController.h
//  YunShangShiJi
//
//  Created by hebo on 2019/2/14.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddMemberCardViewController : TFBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *MytableView;
@property (nonatomic,strong) UIView *TableHeadView;
@property (nonatomic,strong) UIView *TableFootView;
@property (nonatomic,strong) UIView *PayFootView;
@property (nonatomic,strong) UILabel *PriceLab;
@property (nonatomic,strong) UILabel *oldPriceLab;
@property (nonatomic,strong) UILabel *priceLineLab;
@property (nonatomic,strong) UIButton *PayButton;
@property (nonatomic,copy)   NSString * ruleData;
@property (nonatomic,copy)   NSString * from_vipType;
@property (nonatomic,copy)   NSString * vip_type;
@end

NS_ASSUME_NONNULL_END
