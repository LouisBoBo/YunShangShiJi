//
//  ReplyListModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/3.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单详情评论列表

#import "BaseModel.h"

@interface ReplyListModel : BaseModel

@property (nonatomic, assign) NSInteger status;     //结果
@property (nonatomic, copy) NSString *message;      //结果信息
@property (nonatomic, assign) NSInteger pageCount;  //总页数
@property (nonatomic, copy) NSArray *comments;      //评论列表（ReplyModel）

/**
 @brief  晒单详情
 @param shopCode        商品编号
 @param page            页码
 @param success         请求成功之后的回调
 */
+ (void)getReplyListModelWithShopCode:(NSString *)shopCode page:(NSInteger)page success:(void (^)(id data))success;

@end


#pragma mark - 评论
@interface ReplyModel : BaseModel

@property (nonatomic, copy) NSString *to_user_id;       //回复给用户id
@property (nonatomic, copy) NSString *to_user_name;     //回复给用户昵称
@property (nonatomic, copy) NSString *reuser_id;        //评论用户id
@property (nonatomic, copy) NSString *user_url;         //用户头像
@property (nonatomic, copy) NSString *user_name;        //用户昵称
@property (nonatomic, copy) NSString *content;          //评论内容
@property (nonatomic, assign) NSTimeInterval add_date;  //回复时间

@property (nonatomic, assign, readonly) CGFloat cellHeight; //cell高度

@end