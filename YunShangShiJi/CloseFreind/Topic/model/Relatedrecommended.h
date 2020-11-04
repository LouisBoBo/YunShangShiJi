//
//  Relatedrecommended.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/25.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface Relatedrecommended : BaseModel
/*
 "related_recommended"：[//相关推荐
 
 {
 "theme_id" : "12415485468", // 帖子id
 "user_id" :25648, // 用户id
 "head_pic" : "dfjj.png",  // 头像
 "title" : "#sdfafda#", // 标题
 "nickname" : "odslsj",  // 昵称
 "date":"20170111",//日期
 "send_time" : NumberLong(1585582659659), // 时间
 "content" : "1234567890qwertyuioplkjhgfdsazxcvbnm",  // 文本（内容）
 "pics" : "1.png,2.png,3.png",  // 图片
 "location" : "1,23",  // 位置
 "theme_type" : NumberInt(1), // 类型
 }
 */
@property (nonatomic , copy) NSString *theme_id;
@property (nonatomic , copy) NSString *user_id;
@property (nonatomic , copy) NSString *head_pic;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *nickname;
@property (nonatomic , copy) NSString *date;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , copy) NSString *pics;
@property (nonatomic , copy) NSString *location;
@property (nonatomic , assign) NSInteger theme_type;
@property (nonatomic , assign) long long send_time;

@end
