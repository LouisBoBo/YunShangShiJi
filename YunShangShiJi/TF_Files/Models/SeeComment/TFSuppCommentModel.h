//
//  TFSuppCommentModel.h
//  YunShangShiJi
//
//  Created by 云商 on 15/8/11.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFSuppCommentModel : NSObject

@property (nonatomic, assign)BOOL isComment;

@property (nonatomic, copy)NSString *supp_content;
@property (nonatomic, strong)NSNumber *supp_add_date;
@property (nonatomic , copy)NSString *supp_pic;
@property (nonatomic, strong)NSNumber *verify_status;

@end
