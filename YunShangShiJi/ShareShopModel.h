//
//  ShareShopModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/8/29.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareShopModel : NSObject

//商品图片
@property (nonatomic ,strong)NSString *shopImage;
//二维码图片
@property (nonatomic ,strong)NSString *qr_pic;
//商品链接
@property (nonatomic ,strong)NSString *shopUrl;
//商品描述
@property (nonatomic ,strong)NSString *content;

@end
