//
//  LCommentModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/25.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface LCommentModel : BaseModel
/*
 "latest_comments" : [// 最新评论
 { "theme_id" : NumberInt(1), // 帖子id
 "comment_id" : NumberInt(1), // 评论id
 "user_id" :5845,
 "nickname" : "odslsj",  // 昵称
 "head_pic" : "dfjj.png",  // 头像
 "location" : "1,23",  // 位置
 "applaud_num" : NumberInt(500),  // 点赞数
 "report_num" : NumberInt(500),  // 举报数
 "content" : "1234567890qwertyuioplkjhgfdsazxcvbnm",  // 文本
 "base_user_id" :58452,//楼主用户id
 "status":0, // 回复状态
 "send_time" : NumberLong(1585582659659), // 时间
 "applaud_user_list":[121212,323,444] , // 点赞用户id
 "replies_list":[ //回复内评论列表
 */

@property (nonatomic , copy) NSString *theme_id;
@property (nonatomic , copy) NSString *comment_id;
@property (nonatomic , copy) NSString *user_id;
@property (nonatomic , copy) NSString *nickname;
@property (nonatomic , copy) NSString *head_pic;
@property (nonatomic , copy) NSString *location;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , copy) NSString *base_user_id;
@property (nonatomic , copy) NSString *status;
@property (nonatomic , copy) NSString *applaud_user_list;
@property (nonatomic , assign) long long send_time;
@property (nonatomic , assign) NSInteger applaud_num;
@property (nonatomic , assign) NSInteger report_num;
@property (nonatomic, strong) NSArray * replies_list;    
@end
