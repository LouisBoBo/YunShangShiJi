//
//  IntimateCircleModel.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/15.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BaseModel.h"
#import "PagerModel.h"

extern NSString *const kIntimateCirclePicPath;

@interface CircleModel : BaseModel
@property (nonatomic, strong) PagerModel *pager;  //页码
@property (copy, nonatomic) NSString *message;
@property (assign, nonatomic) NSInteger status;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *data2;
@property (nonatomic, strong) NSArray *collect_list;


@property (nonatomic, strong) NSMutableArray *myData;

+ (void)getCircleModelWithCurPage:(NSInteger)curPage success:(void (^)(id data))success;
+ (void)getCircleThemeModelWithCurPage:(NSInteger)curPage success:(void (^)(id data))success;
+ (void)getTagCircleThemeModelWithCurPage:(NSInteger)curPage  tag:(NSString *)tag success:(void (^)(id data))success;
+ (void)getCircleTagThemeModelWithCurPage:(NSInteger)curPage  tag:(NSString *)tag success:(void (^)(id data))success;

//个人中心 穿搭、话题
+ (void)getPersonCollectModelWithCurPage:(NSInteger)curPage success:(void (^)(id data))success;
+ (void)getPersonDressModelWithCurPage:(NSInteger)curPage success:(void (^)(id data))success;
+ (void)getPersonThemeModelWithCurPage:(NSInteger)curPage success:(void (^)(id data))success;
+ (void)getCommendThemeModelWithCurPage:(NSInteger)curPage PageSize:(NSInteger)pagesize Themeid:(NSString*)themeid success:(void (^)(id data))success;
@end

@interface IntimateCircleModel : BaseModel
@property (assign,nonatomic)BOOL isSelect;

@property (strong, nonatomic) NSNumber *theme_id;
@property (strong, nonatomic) NSNumber *user_id;
@property (copy, nonatomic) NSString *head_pic;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *nickname;
@property (assign, nonatomic) NSTimeInterval date;
@property (assign, nonatomic) NSTimeInterval send_time;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *pics;
@property (strong, nonatomic) NSArray *tags;
@property (copy, nonatomic) NSString *location;
@property (strong, nonatomic) NSNumber *theme_type;
@property (strong, nonatomic) NSNumber *applaud_num;
@property (strong, nonatomic) NSNumber *comment_count;
@property (strong, nonatomic) NSArray *shop_list;
@property (strong, nonatomic) NSArray *comments_list;
@property (assign, nonatomic) NSInteger attention_status;
@property (assign, nonatomic) NSInteger applaud_status;
@property (strong, nonatomic) NSArray *supp_label_list;
@property (strong, nonatomic) NSNumber *supp_label_id;
@property (strong, nonatomic) NSNumber *style;

#pragma mark - add property
//@property (copy, nonatomic) NSMutableArray *tagIds;
@property (nonatomic, strong) NSMutableArray *srcArray;
@property (copy, nonatomic) NSMutableArray *tagsArray;
@property (copy, nonatomic) NSMutableArray *tagsNameArray;
@property (copy, nonatomic) NSMutableArray *followArray;
@property (copy, nonatomic) NSMutableArray *totalArray;    //历史所有数据
@property (copy, nonatomic) NSMutableArray *commentArray;  //评论数据
@property (assign, nonatomic) NSInteger collection_status; //是否收藏0为未收藏1为收藏
@property (strong, nonatomic) NSNumber *collect_num;       //收藏的数量
@property (strong, nonatomic) NSNumber *v_ident;       //（0：为普通用户 ，1：为红V，2：为蓝V）

@end
