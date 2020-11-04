//
//  TFCommentModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/8/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFAddCommentModel.h"
#import "TFSuppCommentModel.h"

@interface TFCommentModel : NSObject

@property (nonatomic ,assign)int cellType;

@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, strong)NSNumber *add_date;
@property (nonatomic, copy)NSString *user_name;
@property (nonatomic, copy)NSString *user_url;
@property (nonatomic, strong)NSNumber *star;
@property (nonatomic, strong)NSNumber *color;
@property (nonatomic, strong)NSNumber *cost;
@property (nonatomic, strong)NSNumber *type;
@property (nonatomic, strong)NSNumber *work;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, strong)NSNumber *comment_type;
@property (nonatomic, copy)NSString *content;

@property (nonatomic, copy)NSString *shop_price;
@property (nonatomic, copy)NSString *shop_name;
@property (nonatomic, copy)NSString *shop_color;   
@property (nonatomic, copy)NSString *shop_code;
@property (nonatomic, copy)NSString *shop_size;     

@property (nonatomic, strong)NSArray *comment;
@property (nonatomic, strong)NSArray *suppComment;
@property (nonatomic, strong)NSArray *suppEndComment; 

@property (nonatomic, strong)TFAddCommentModel *commentModel;
@property (nonatomic, strong)TFSuppCommentModel *suppCommentModel;
@property (nonatomic, strong)TFSuppCommentModel *suppEndCommentModel;

@property (nonatomic, strong)NSMutableArray *picArr;

@end
