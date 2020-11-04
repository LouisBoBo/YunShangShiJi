//
//  TopicdetailsModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/25.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "TdetailsModel.h"
@interface TopicdetailsModel : BaseModel
@property (nonatomic , strong) TdetailsModel *post_details;     //帖子详情
@property (nonatomic , strong) NSArray *hot_comments;           //热门评论
@property (nonatomic , strong) NSArray *related_recommended;    //相关推荐
@end
