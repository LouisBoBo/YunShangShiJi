//
//  ShareFreelingBargainViewController.h
//  YunShangShiJi
//
//  Created by hebo on 2019/10/11.
//  Copyright © 2019 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
#import "ShopDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShareFreelingBargainViewController : TFBaseViewController
@property (nonatomic,strong) ShopDetailModel*Ordermodel;
@property (nonatomic,copy)   NSString *comefrome;
@property (nonatomic,copy)   NSString *order_code;
@end

NS_ASSUME_NONNULL_END
