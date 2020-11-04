//
//  TopicviewModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/23.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "TopicdetailsModel.h"
@interface TopicviewModel : BaseModel
@property (nonatomic, assign) NSInteger status;          //状态
@property (nonatomic, copy) NSString *message;           //提示
@property (nonatomic, strong)TopicdetailsModel *data;        //详情数据

//帖子详情
+ (void)getDataTheme_id:(NSString*)theme_id Success:(void(^)(id data))sucess;
@end
