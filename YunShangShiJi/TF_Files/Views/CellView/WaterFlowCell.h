//
//  WaterFlowCell.h
//  YunShangShiJi
//
//  Created by 云商 on 15/8/5.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFShoppingM.h"
#import "LikeModel.h"
#import "ShopDetailModel.h"
#import "TShoplistModel.h"
#import "GlobalTool.h"
@interface WaterFlowCell : UICollectionViewCell
@property (nonatomic, assign)BOOL isAnimation;

@property (nonatomic,copy)dispatch_block_t selectBlock;

@property (weak, nonatomic) IBOutlet UIImageView *shop_pic;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *defaultImageView;

@property (weak, nonatomic) IBOutlet UILabel *shop_name_new;
@property (weak, nonatomic) IBOutlet UILabel *shop_price_new;
@property (weak, nonatomic) IBOutlet UILabel *shop_old_price;
@property (weak, nonatomic) IBOutlet UILabel *shop_kicback_new;
@property (weak, nonatomic) IBOutlet UILabel *reduce_Price_new;

@property (weak, nonatomic) IBOutlet UILabel *bottomPrice;
@property (weak, nonatomic) IBOutlet UIImageView *priceImageV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_BrandLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_shopKicback;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_shopKicback;
@property (weak, nonatomic) IBOutlet UIView *bottomView_new;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *H_bottomView_new;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *S_shop_name;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *S_shop_price;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Y_defaultImageView;

//何波加的 2016-10-8
@property (weak, nonatomic) IBOutlet UILabel *ManufacturerLable;

@property (weak, nonatomic) IBOutlet UIImageView *shopSaleImageV;
@property (weak, nonatomic) IBOutlet UILabel *shopSaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleNumbelLabel;

@property (weak, nonatomic) IBOutlet UIImageView *diyongImageV;
@property (weak, nonatomic) IBOutlet UILabel *shopReductionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_saleNumbelLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_shopSaleImageV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *W_reductionLabel;

@property (nonatomic, copy) NSString *flag;
@property (strong, nonatomic) IBOutlet UIButton *sharebtn;
@property (weak, nonatomic) IBOutlet UIImageView *freelingImageV;

/**
 详情里面列表
 
 @param model <#model description#>
 */
- (void)receiveDataModel:(ShopDetailModel *)model;

/**
 其他标签

 @param model <#model description#>
 */
- (void)receiveDataModel2:(TFShoppingM *)model;

/**
 活动和热卖商品

 @param model <#model description#>
 */
- (void)receiveDataModel3:(TFShoppingM *)model;

/**
 上新商品

 @param model <#model description#>
 */
- (void)receiveDataModel4:(TFShoppingM *)model;

/**
 拼团商品
 
 */
- (void)receiveDataModel5:(TFShoppingM *)model;
/**
 购物车喜欢商品
 
 @param model <#model description#>
 */
- (void)refreshDataModel:(LikeModel *)model;

/**
 分享品质美衣
 
 @param model <#model description#>
 */
- (void)receiveshareModel:(BOOL)select;
/**
更多推荐
 **/
- (void)refreshTopicShopModel:(TShoplistModel*)model;


/**
 热卖 显示

 @param model <#model description#>
 */
- (void)receiveDataModel6:(TFShoppingM *)model;

/**
 活动商品专区 显示
 
 @param model <#model description#>
 */
- (void)receiveDataModel7:(TFShoppingM *)model;

/**
 生活商品专区 显示
 
 @param model <#model description#>
 */
- (void)receiveDataModel8:(TFShoppingM *)model;
@end
