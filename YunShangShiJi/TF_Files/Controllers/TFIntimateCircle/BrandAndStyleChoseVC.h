//
//  BrandAndStyleChoseVC.h
//  YunShangShiJi
//
//  Created by yssj on 2017/4/10.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"

typedef enum : NSUInteger {
    Section_AllType,
    Section_NormalType,
    Section_ShopType,
} SectionType;

typedef void(^AddBrandStyleTypeBlock)(NSString *brandStr,NSString *styleStr,NSString *brandID,NSString *style,NSString *type1,NSString *type2,NSString *shop_code);
@interface BrandAndStyleChoseVC : TFBaseViewController

@property (nonatomic,copy)AddBrandStyleTypeBlock tagMsgblock;
@property (nonatomic,strong)NSMutableArray *detailArr;

@property (nonatomic,strong)NSString *brandStr;
@property (nonatomic,strong)NSString *styleStr;

@property (nonatomic,assign)SectionType sectionType;
@end
