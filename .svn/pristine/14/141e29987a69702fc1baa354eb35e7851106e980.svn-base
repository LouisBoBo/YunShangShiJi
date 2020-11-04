//
//  TopicPublicModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/21.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"

@interface TopicPublicModel : BaseModel
@property (nonatomic, assign) NSInteger status;          //状态
@property (nonatomic, copy) NSString *message;           //提示
@property (nonatomic, strong) NSArray *list;             //楼主的最新评论
@property (nonatomic, strong) NSArray *hotlist;          //楼主的热门评论
@property (nonatomic, strong) NSArray *shop_list;        //推荐商品
@property (nonatomic, strong) NSDictionary *pager;       //分页信息
@property (nonatomic, assign) BOOL isMonday;             //是否疯狂星期一
@property (nonatomic, assign) BOOL zero_buy;             //是否0元购
@property (nonatomic, assign) BOOL sup_day;              //超级分享日
@property (nonatomic, assign) BOOL fri_win;              //好友赢提现
@property (nonatomic, assign) BOOL red_rain;             //千元红包雨
@property (nonatomic, assign) BOOL monthly;              //每月惊喜任务
@property (nonatomic, assign) NSDictionary *monday_info; //疯狂星期一任务类型
//点赞
/*
 * this_id  帖子id或评论id
 * type :1  帖子，2 评论
 * theme_id 当前帖子id
 */
+ (void)ThumbstData:(NSInteger)type This_id:(NSString*)this_id Theme_id:(NSString*)theme_id Success:(void(^)(id data))success;

//取消点赞
+ (void)DisThumbstData:(NSInteger)type This_id:(NSString*)this_id  Theme_id:(NSString*)theme_id Success:(void(^)(id data))success;

//关注/取消关注接口 type 1为添加，2为删除
+ (void)FollowData:(NSInteger)type Friend_user_id:(NSString*)friend_user_id Success:(void(^)(id data))success;

//评论
/*
 * theme_id 帖子id
 * base_user_id 楼主id
 * content 文本
 * location 位置
*/
+ (void)CommentData:(NSString*)content Location:(NSString*)location Theme_id:(NSString*)theme_id Base_user_id:(NSString*)base_user_id Success:(void(^)(id data))success;

//评论内回复接口
/*
 * comment_id 评论id
 * receive_user_id 被评论用户id（为空则对为直接对当前楼用户）
 * content 文本
 * 常规参数
 */
+ (void)ReplyData:(NSString*)content Comment_id:(NSString*)comment_id Receive_user_id:(NSString*)receive_user_id Success:(void(^)(id data))success;

//最新评论
+ (void)LastComments:(NSString*)theme_id Page:(NSInteger)page Pagesize:(NSInteger)pagesize Success:(void(^)(id data))success;

//只看楼主
/*
 theme_user_id 帖子用户id
 theme_id 帖子id
 */
+ (void)LandlordComments:(NSString*)theme_id Theme_user_id:(NSString*)theme_user_id Page:(NSInteger)page Pagesize:(NSInteger)pagesize Success:(void(^)(id data))success;

//删除帖子
+ (void)DtleateTheme:(NSString*)theme_id Success:(void(^)(id data))success;

//收藏帖子
+ (void)AddCollectionTheme:(NSString*)theme_id Success:(void(^)(id data))success;

//删除收藏的帖子
+ (void)DelCollectionTheme:(NSString*)theme_id Success:(void(^)(id data))success;

//推荐的商品列表
+ (void)DetailRecommendShop:(NSString*)theme_id Onlyid:(NSString*)nolyid Page:(NSInteger)page Success:(void(^)(id data))success;

//获取是否有疯狂星期一任务
+ (void)GetisMandayDataSuccess:(void(^)(id data))success;

@end
