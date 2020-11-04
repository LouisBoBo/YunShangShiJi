//
//  SqliteManager.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SqliteManager;
@class TypeTagItem;
@class ShopTypeItem;
@class ShopTagItem;

@interface SqliteManager : NSObject
+ (SqliteManager*)sharedManager;

//- (BOOL)addShopTypeItem:(ShopTypeItem *)item;
//- (BOOL)addTypeTagItem:(TypeTagItem *)item;

#pragma mark - 查询shop_type

/**
 *  查询所有TYP表内容
 *
 *  @return 存储ShopTypeItem数组
 */
- (NSArray* )getAllForShopTypeItem;

- (NSArray* )getShopTypeItemForSuperId:(NSString *)ID;

- (ShopTypeItem* )getShopTypeItemForId:(NSString *)ID;

- (NSArray *)sortShopTypeArrayWithSequenceFromSourceArray:(NSArray *)sourceArray;

- (ShopTypeItem *)getShopTypeItemFromShopTypeWithName:(NSString *)name;


#pragma mark - 查询 shop_tag

- (NSArray* )getAllForShopTagItem;

- (NSArray* )getShopTagItemForSuperId:(NSString *)ID;
- (ShopTagItem* )getShopTagItemForId:(NSString *)ID;


/**
 获取签到商品广告  banner

 @param ID <#ID description#>
 @return <#return value description#>
 */
- (ShopTagItem* )getSignShopBannerForId:(NSString *)ID;

- (NSArray *)sortShopTagArrayWithSequenceFromSourceArray:(NSArray *)sourceArray;

#pragma mark - 查询 type_tag

- (NSArray* )getAllForTypeTagItem;
- (NSArray* )getTypeTagItemForSuperId:(NSString *)ID;
- (TypeTagItem* )getTypeTagItemForId:(NSString *)ID;

#pragma maek - 查询 supp_label
- (TypeTagItem* )getSuppLabelItemForId:(NSString *)ID;
- (NSArray* )getAllForBrandsItem;

// 分类
- (NSArray* )getTypeTagItemForSuperIdWithShopping:(NSString *)ID;
- (NSArray* )getTypeTagItemForSuperIdWithHomePage:(NSString *)ID;

#pragma mark - 查询 friend_circle_tag
- (NSArray* )getAllForCircleTagItem;
- (NSArray *)sortCircleTagArrayWithSequenceFromSourceArray:(NSArray *)sourceArray;

- (void)deleteCircleTagDataBase;
- (void)insertCircleTagItem:(TypeTagItem *)item;
@end

@interface ShopTagItem : NSObject

@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *tag_name;
@property (nonatomic, copy)NSString *is_show;
@property (nonatomic, copy)NSString *ico;
@property (nonatomic, copy)NSString *banner;
@property (nonatomic, copy)NSString *sequence;
@property (nonatomic, copy)NSString *e_name;
@property (nonatomic, copy)NSString *parent_id;
@property (nonatomic, assign) CGFloat with;
@property (nonatomic, copy)NSString *value;

@end

@interface TypeTagItem : NSObject

/**< 新改 */
@property (nonatomic, copy)NSString *add_time;
@property (nonatomic, copy)NSString *class_name;
@property (nonatomic, copy)NSString *class_type;
@property (nonatomic, copy)NSString *is_hot;
@property (nonatomic, copy)NSString *is_new;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *sort;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *icon;
@property (nonatomic, copy)NSString *remark;
//@property (nonatomic, copy)NSString *shop_code;
@property (nonatomic, assign) CGFloat with;
@property (nonatomic, assign) NSInteger supperLabertype;       //品牌类型2自定义
@property (nonatomic, assign) NSNumber *only_id;               //标签唯一ID
@property (nonatomic, assign) BOOL isrepeat;                   //是否重复
@end

@interface ShopTypeItem : NSObject

@property (nonatomic, copy)NSString *type_name;
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *is_show;
@property (nonatomic, copy)NSString *sequence;
@property (nonatomic, copy)NSString *group_flag;
@property (nonatomic, copy)NSString *ico;
@property (nonatomic, copy)NSString *parent_id;
@property (nonatomic, copy)NSString *dir_level;
@property (nonatomic, assign) CGFloat with;
//@property (nonatomic, copy)NSString *shop_code;
// 新增
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *sort;
@property (nonatomic, copy)NSString *type; // 1后台热门，2用户自定义
@end
