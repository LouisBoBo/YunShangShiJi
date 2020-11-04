//
//  SelCommentModel.h
//  YunShangShiJi
//
//  Created by zgl on 16/6/2.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单详情

#import "BaseModel.h"

@class SOCommentModel;

@interface SelCommentModel : BaseModel

@property (nonatomic, assign) NSInteger status;         //结果
@property (nonatomic, copy) NSString *message;          //结果信息
@property (nonatomic, strong) SOCommentModel *comment;  //内容

/**
 @brief 晒单详情
 @param shopCode        商品编号
 @param success         请求成功之后的回调
 */
+ (void)getSelCommentModelWithShopCode:(NSString *)shopCode success:(void (^)(id data))success;

/**
 @brief 点赞
 @param shopCode        商品编号
 @param success         请求成功之后的回调
 */
+ (void)addlikeWithShopCode:(NSString *)shopCode success:(void (^)(id data))success;

/**
 @brief 回复
 @param shopCode        商品编号
 @param userId          回复给 用户id(如果为空，回复给作者；否则回复给评论)
 @param content         回复内容
 @param success         请求成功之后的回调
 */
+ (void)sendMessageWithShopCode:(NSString *)shopCode toUserId:(NSString *)userId content:(NSString *)content success:(void (^)(id data))success;

@end


#pragma mark - 分享详情
@interface SOCommentModel : BaseModel

@property (nonatomic, copy) NSString *shop_code;        //商品编号
@property (nonatomic, copy) NSString *shop_name;        //店铺名称
@property (nonatomic, copy) NSNumber *user_id;          //用户ID
@property (nonatomic, copy) NSString *user_name;        //用户昵称
@property (nonatomic, copy) NSString *user_url;         //用户头像
@property (nonatomic, copy) NSString *content;          //评论内容
@property (nonatomic, copy) NSString *pic;              //评论图片
@property (nonatomic, copy) NSString *issue_code;       //期号
@property (nonatomic, copy) NSString *lucky_number;     //幸运号码
@property (nonatomic, copy) NSString *click;            //点赞商品编号（判断与shop_code是否相等来判断点赞）
@property (nonatomic, assign) NSTimeInterval add_date;  //评论时间
@property (nonatomic, assign) NSTimeInterval otime;     //揭晓时间
@property (nonatomic, assign) NSInteger count;          //参与次数
@property (nonatomic, assign) NSInteger comment_size;   //总评论数
@property (nonatomic, assign) NSInteger click_size;     //总点赞数

@end
