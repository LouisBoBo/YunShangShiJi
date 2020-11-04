//
//  SqliteManager.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/6/16.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "SqliteManager.h"
#import "FMDatabase.h"
#import "GlobalTool.h"
#define KICTagsFont kFont6px(25)
#define MAXFLOAT    0x1.fffffep+127f
#define kICTagsCellLeftRight_Width ZOOM6(15)
@interface SqliteManager ()
{
    FMDatabase* _db;
}

@end

static SqliteManager *sqManager = nil;

@implementation SqliteManager
+ (SqliteManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sqManager == nil) {
            sqManager = [[SqliteManager alloc] init];
        }
    });
    return sqManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        //数据库路径
        NSString* path = [NSString stringWithFormat:@"%@/Documents/attr.db", NSHomeDirectory()];
 #if 0
        NSString* path = [NSString stringWithFormat:@"%@/Documents/shopDB.db", NSHomeDirectory()];
#endif
        _db = [[FMDatabase alloc] initWithPath:path];
        //打开
        if (![_db open]) {
            NSLog(@"数据库打开失败");
        }
        
#if 0
        
        BOOL res = [_db executeUpdate:@"create table if not exists shop_type(uid integer primary key autoincrement,id, type_name, parent_id, dir_level, ico, sequence, is_show, group_flag)"];
        if (res == NO) {
            NSLog(@"shop_type表创建失败");
        }
        BOOL res1 = [_db executeUpdate:@"create table if not exists shop_tag(uid integer primary key autoincrement,id, tag_name, parent_id, is_show, ico, sequence, e_name)"];
        if (res1 == NO) {
            NSLog(@"shop_tag表创建失败");
        }
#endif
    }
    return self;
}

#pragma mark - 查询shop_type
- (NSArray* )getAllForShopTypeItem
{
    FMResultSet* set = [_db executeQuery:@"select * from TYPDB"];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]) {
        ShopTypeItem* shopTypeItem = [[ShopTypeItem alloc] init];
        shopTypeItem.ID = [set stringForColumn:@"ID"];
        shopTypeItem.type_name = [set stringForColumn:@"NAME"];
        shopTypeItem.ico = [set stringForColumn:@"ICO"];
        shopTypeItem.is_show = [set stringForColumn:@"ISSHOW"];
        shopTypeItem.group_flag = [set stringForColumn:@"GROUPFLAG"];
        shopTypeItem.sequence = [set stringForColumn:@"SEQUENCE"];
        [array addObject:shopTypeItem];
    }
    [set close];
    return array;
}
- (TypeTagItem* )getSuppLabelItemForId:(NSString *)ID {
    FMResultSet* set = [_db executeQuery:@"select * from BRANDSDATA where ID = ?",ID];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]){
        TypeTagItem* shopTypeItem = [[TypeTagItem alloc] init];
        shopTypeItem.ID = [set stringForColumn:@"ID"];
        shopTypeItem.class_name = [set stringForColumn:@"NAME"];
        shopTypeItem.icon = [set stringForColumn:@"ICON"];
        shopTypeItem.pic = [set stringForColumn:@"pic"];
        shopTypeItem.sort = [set stringForColumn:@"sort"];
        shopTypeItem.remark = [set stringForColumn:@"remark"];
        shopTypeItem.add_time = [set stringForColumn:@"addtime"];
//        shopTypeItem.shop_code = [set stringForColumn:@"shop_code"];
        shopTypeItem.with = [self SizeWithObj:shopTypeItem.class_name];
        [array addObject:shopTypeItem];
    }
    [set close];
    return array.firstObject;
}
- (NSArray* )getAllForBrandsItem
{
    FMResultSet* set = [_db executeQuery:@"select * from BRANDSDATA"];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]) {
        TypeTagItem* shopTypeItem = [[TypeTagItem alloc] init];
        shopTypeItem.ID = [set stringForColumn:@"ID"];
        shopTypeItem.class_name = [set stringForColumn:@"NAME"];
        shopTypeItem.icon = [set stringForColumn:@"ICON"];
        shopTypeItem.pic = [set stringForColumn:@"pic"];
        shopTypeItem.sort = [set stringForColumn:@"sort"];
        shopTypeItem.remark = [set stringForColumn:@"remark"];
        shopTypeItem.add_time = [set stringForColumn:@"addtime"];
        shopTypeItem.type = [set stringForColumn:@"type"];
        if (shopTypeItem.type.integerValue==1) {
            [array addObject:shopTypeItem];
        }
    }
    [set close];
    
    //按sort从大到小排序
    for(int k=0;k<array.count;k++)
    {
        NSComparator cmptr = ^(TypeTagItem* obj1, TypeTagItem* obj2){
            if ([obj1.sort integerValue] < [obj2.sort integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1.sort integerValue] > [obj2.sort integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        };
        //排序后数组
        NSArray *afterarray = [array sortedArrayUsingComparator:cmptr];
        
//        MyLog(@"afterarray = %@",afterarray);
        
        if(afterarray.count)
        {
            [array removeAllObjects];
            [array addObjectsFromArray:afterarray];
        }
    }
    
    return array;
}
- (NSArray* )getShopTypeItemForSuperId:(NSString *)ID
{
    FMResultSet* set = [_db executeQuery:@"select * from TYPDB where ADDRESS = ?",ID];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]){
        ShopTypeItem* shopTypeItem = [[ShopTypeItem alloc] init];
        shopTypeItem.ID = [set stringForColumn:@"ID"];
        shopTypeItem.type_name = [set stringForColumn:@"NAME"];
        shopTypeItem.ico = [set stringForColumn:@"ICO"];
        shopTypeItem.is_show = [set stringForColumn:@"ISSHOW"];
        shopTypeItem.group_flag = [set stringForColumn:@"GROUPFLAG"];
        shopTypeItem.sequence = [set stringForColumn:@"SEQUENCE"];
        [array addObject:shopTypeItem];
    }
    [set close];
    return array;
}

- (ShopTypeItem *)getShopTypeItemForId:(NSString *)ID
{
    FMResultSet* set = [_db executeQuery:@"select * from TYPDB where ID = ?",ID];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]){
        ShopTypeItem* shopTypeItem = [[ShopTypeItem alloc] init];
        shopTypeItem.ID = [set stringForColumn:@"ID"];
        shopTypeItem.type_name = [set stringForColumn:@"NAME"];
        shopTypeItem.ico = [set stringForColumn:@"ICO"];
        shopTypeItem.is_show = [set stringForColumn:@"ISSHOW"];
        shopTypeItem.group_flag = [set stringForColumn:@"GROUPFLAG"];
        shopTypeItem.sequence = [set stringForColumn:@"SEQUENCE"];
        [array addObject:shopTypeItem];
    }
    [set close];
    return array.firstObject;
}

- (ShopTypeItem *)getShopTypeItemFromShopTypeWithName:(NSString *)name
{
    FMResultSet* set = [_db executeQuery:@"select * from TYPDB where NAME = ?",name];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]){
        ShopTypeItem* shopTypeItem = [[ShopTypeItem alloc] init];
        shopTypeItem.ID = [set stringForColumn:@"ID"];
        shopTypeItem.type_name = [set stringForColumn:@"NAME"];
        shopTypeItem.ico = [set stringForColumn:@"ICO"];
        shopTypeItem.is_show = [set stringForColumn:@"ISSHOW"];
        shopTypeItem.group_flag = [set stringForColumn:@"GROUPFLAG"];
        shopTypeItem.sequence = [set stringForColumn:@"SEQUENCE"];
        [array addObject:shopTypeItem];
    }
    [set close];
    
    return array.firstObject;

}

- (NSArray* )getAllForShopTagItem
{
    FMResultSet* set = [_db executeQuery:@"select * from TAGDB"];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]) {
        ShopTagItem* shopFilterItem = [[ShopTagItem alloc] init];
        shopFilterItem.ID = [set stringForColumn:@"ID"];
        shopFilterItem.tag_name = [set stringForColumn:@"NAME"];
        shopFilterItem.ico = [set stringForColumn:@"ICO"];
        shopFilterItem.is_show = [set stringForColumn:@"PHONE"];
        shopFilterItem.sequence = [set stringForColumn:@"SEQUENCE"];
        shopFilterItem.e_name = [set stringForColumn:@"ENAME"];
        [array addObject:shopFilterItem];
    }
    [set close];
    return array;
}

- (NSArray *)getShopTagItemForSuperId:(NSString *)ID
{
    FMResultSet* set = [_db executeQuery:@"select * from TAGDB where ADDRESS = ?",ID];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]){
        ShopTagItem* shopFilterItem = [[ShopTagItem alloc] init];
        shopFilterItem.ID = [set stringForColumn:@"ID"];
        shopFilterItem.tag_name = [set stringForColumn:@"NAME"];
        shopFilterItem.ico = [set stringForColumn:@"ICO"];
        shopFilterItem.is_show = [set stringForColumn:@"PHONE"];
        shopFilterItem.sequence = [set stringForColumn:@"SEQUENCE"];
        shopFilterItem.e_name = [set stringForColumn:@"ENAME"];
        shopFilterItem.with = [self SizeWithObj:shopFilterItem.tag_name];
        [array addObject:shopFilterItem];

    }
    [set close];
    return array;
}

- (ShopTagItem* )getShopTagItemForId:(NSString *)ID
{
    FMResultSet* set = [_db executeQuery:@"select * from TAGDB where ID = ?",ID];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]){
        ShopTagItem* shopFilterItem = [[ShopTagItem alloc] init];
        shopFilterItem.ID = [set stringForColumn:@"ID"];
        shopFilterItem.tag_name = [set stringForColumn:@"NAME"];
        shopFilterItem.ico = [set stringForColumn:@"ICO"];
        shopFilterItem.is_show = [set stringForColumn:@"PHONE"];
        shopFilterItem.sequence = [set stringForColumn:@"SEQUENCE"];
        shopFilterItem.e_name = [set stringForColumn:@"ENAME"];
        [array addObject:shopFilterItem];
        
    }
    [set close];
    return array.firstObject;
}
//签到商品集合
- (ShopTagItem* )getSignShopBannerForId:(NSString *)ID
{
    FMResultSet* set = [_db executeQuery:@"select * from shopGroupList where ID = ?",ID];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]){
        ShopTagItem* shopFilterItem = [[ShopTagItem alloc] init];
        shopFilterItem.ID = [set stringForColumn:@"ID"];
        shopFilterItem.tag_name = [set stringForColumn:@"NAME"];
        shopFilterItem.ico = [set stringForColumn:@"ICON"];
        shopFilterItem.value = [set stringForColumn:@"VALUE"];
        shopFilterItem.banner = [[set stringForColumn:@"banner"]containsString:@"null"]?nil:[set stringForColumn:@"banner"];
        [array addObject:shopFilterItem];

    }
    [set close];
    return array.firstObject;
}

- (NSArray *)sortShopTypeArrayWithSequenceFromSourceArray:(NSArray *)sourceArray
{
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:sourceArray];
    NSArray *sorted = [muArr sortedArrayUsingComparator:^(id obj1, id obj2){
        if ([obj1 isKindOfClass:[ShopTypeItem class]] && [obj2 isKindOfClass:[ShopTypeItem class]]) {
            ShopTypeItem *s1 = (ShopTypeItem*)obj1;
            ShopTypeItem *s2 = (ShopTypeItem*)obj2;
            
            if ([s1.sequence intValue]> [s2.sequence intValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            } else if ([s1.sequence intValue]< [s2.sequence intValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        return (NSComparisonResult)NSOrderedSame;  
    }];
    return sorted;
}

- (NSArray *)sortShopTagArrayWithSequenceFromSourceArray:(NSArray *)sourceArray
{
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:sourceArray];
    NSArray *sorted = [muArr sortedArrayUsingComparator:^(id obj1, id obj2){
        if ([obj1 isKindOfClass:[ShopTagItem class]] && [obj2 isKindOfClass:[ShopTagItem class]]) {
            ShopTagItem *s1 = (ShopTagItem*)obj1;
            ShopTagItem *s2 = (ShopTagItem*)obj2;
            
            if ([s1.sequence intValue]> [s2.sequence intValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            } else if ([s1.sequence intValue]< [s2.sequence intValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    return sorted;
}

#pragma mark - 查询 type_tag
- (NSArray* )getAllForTypeTagItem {
    FMResultSet* set = [_db executeQuery:@"select * from TYPE_TAGDB"];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]) {
        TypeTagItem* typeTagItem = [[TypeTagItem alloc] init];
        
        // 新的
        typeTagItem.class_name = [set stringForColumn:@"NAME"];
        typeTagItem.sort = [set stringForColumn:@"SORT"];
        typeTagItem.pic = [set stringForColumn:@"PIC"];
        typeTagItem.is_hot = [set stringForColumn:@"ISHOT"];
        typeTagItem.is_new = [set stringForColumn:@"ISNEW"];
        typeTagItem.type = [set stringForColumn:@"TYPE"];
        typeTagItem.class_type = [set stringForColumn:@"CLASSTYPE"];
        typeTagItem.ID = [set stringForColumn:@"ID"];
        
        [array addObject:typeTagItem];
    }
    [set close];
    return array;

}
- (NSArray* )getTypeTagItemForSuperId:(NSString *)ID
{
    FMResultSet* set = [_db executeQuery:@"select * from TYPE_TAGDB where TYPE = ?",ID];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]){
        TypeTagItem* typeTagItem = [[TypeTagItem alloc] init];
        
        // 新的
        typeTagItem.class_name = [set stringForColumn:@"NAME"];
        typeTagItem.sort = [set stringForColumn:@"SORT"];
        typeTagItem.pic = [set stringForColumn:@"PIC"];
        typeTagItem.is_hot = [set stringForColumn:@"ISHOT"];
        typeTagItem.is_new = [set stringForColumn:@"ISNEW"];
        typeTagItem.type = [set stringForColumn:@"TYPE"];
        typeTagItem.class_type = [set stringForColumn:@"CLASSTYPE"];
        typeTagItem.ID = [set stringForColumn:@"ID"];
        
        [array addObject:typeTagItem];
    }
    [set close];
    return array;
}

- (TypeTagItem* )getTypeTagItemForId:(NSString *)ID {
    FMResultSet* set = [_db executeQuery:@"select * from TYPE_TAGDB where CLASSTYPE = ?",ID];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]){
        TypeTagItem* typeTagItem = [[TypeTagItem alloc] init];
        
        // 新的
        typeTagItem.class_name = [set stringForColumn:@"NAME"];
        typeTagItem.sort = [set stringForColumn:@"SORT"];
        typeTagItem.pic = [set stringForColumn:@"PIC"];
        typeTagItem.is_hot = [set stringForColumn:@"ISHOT"];
        typeTagItem.is_new = [set stringForColumn:@"ISNEW"];
        typeTagItem.type = [set stringForColumn:@"TYPE"];
        typeTagItem.class_type = [set stringForColumn:@"CLASSTYPE"];
        typeTagItem.ID = [set stringForColumn:@"ID"];
        
        [array addObject:typeTagItem];
        
    }
    [set close];
    return array.firstObject;
}

- (NSArray *)getTypeTagItemsForSuperId:(NSString *)ID withClassType:(NSString *)class_type {
    NSMutableArray* array = [NSMutableArray array];
    NSArray *typeTagItems = [self getTypeTagItemForSuperId:ID];
    for (TypeTagItem *item in typeTagItems) {
        if ([item.class_type isEqualToString:class_type]) {
            [array addObject:item];
        }
    }
    return array;
}

- (NSArray* )getTypeTagItemForSuperIdWithShopping:(NSString *)ID {
    return [self getTypeTagItemsForSuperId:ID withClassType:@"2"];
}
- (NSArray* )getTypeTagItemForSuperIdWithHomePage:(NSString *)ID {
    return [self getTypeTagItemsForSuperId:ID withClassType:@"1"];
}


//
//- (BOOL)addShopTypeItem:(ShopTypeItem *)item
//{
//    NSString *sql = @"insert or replace into shop_type(id, type_name, parent_id, dir_level, ico, sequence, is_show, group_flag) values(?,?,?,?,?,?,?,?)";
//    
//    BOOL newRes = [_db executeUpdate:sql withArgumentsInArray:@[item.id_new, item.type_name, item.parent_id, item.dir_level, item.ico, item.sequence, item.is_show, item.group_flag]];
//    if (!newRes) {
//        NSLog(@"插入失败");
//    }
//    return newRes;
//    
////    BOOL res = [_db executeUpdate:@"insert into shop_type(id, type_name, parent_id, dir_level, ico, sequence, is_show, group_flag) values(?,?,?,?,?,?,?,?)", item.id_new, item.type_name, item.parent_id, item.dir_level, item.ico, item.sequence, item.is_show, item.group_flag];
////    if (res == NO) {
////        NSLog(@"type插入失败");
////        return;
////    }
//    
//}
//- (BOOL)addTypeTagItem:(TypeTagItem *)item
//{
//    
//    NSString *sql = @"insert or replace into shop_tag(id, tag_name, parent_id, is_show, ico, sequence, e_name) values(?,?,?,?,?,?,?)";
//    
//    BOOL newRes = [_db executeUpdate:sql withArgumentsInArray:@[item.id_new, item.tag_name, item.parent_id, item.is_show, item.ico, item.sequence, item.e_name]];
//    if (!newRes) {
//        NSLog(@"插入失败");
//    }
//    return newRes;
//    
////    BOOL res = [_db executeUpdate:@"insert into shop_tag(id, tag_name, parent_id, is_show, ico, sequence, e_name) values(?,?,?,?,?,?,?)", item.id_new, item.tag_name, item.parent_id, item.is_show, item.ico, item.sequence, item.e_name];
////    if (res == NO) {
////        NSLog(@"tag插入失败");
////        return;
////    }
//}
- (void)deleteCircleTagDataBase {
    [_db executeUpdate:@"DROP TABLE IF EXISTS BRANDSDATA;"];
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS BRANDSDATA(ID INTEGER PRIMARY KEY AUTOINCREMENT,addtime TEXT,icon TEXT,pic TEXT,name TEXT,sort TEXT,remark TEXT,type TEXT)"];
}
- (void)insertCircleTagItem:(TypeTagItem *)item {
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO BRANDSDATA (ID,addtime,icon,pic,name,sort,remark,type) VALUES(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",item.ID,item.add_time,item.icon,item.pic,item.class_name,item.sort,item.remark,item.type];
    BOOL res = [_db executeUpdate:sql];
    
    if (res == NO) {
//        NSLog(@"tag插入失败");  //已有的会插入失败
        return;
    }
}
#pragma mark - 查询 friend_circle_tag
- (NSArray* )getAllForCircleTagItem {
    FMResultSet* set = [_db executeQuery:@"select * from HotTagData"];
    NSMutableArray* array = [NSMutableArray array];
    while ([set next]) {
        ShopTypeItem* tagItem = [[ShopTypeItem alloc] init];
        
        // 新的
        tagItem.ID = [set stringForColumn:@"ID"];
        tagItem.name = [set stringForColumn:@"name"];
        tagItem.is_show = [set stringForColumn:@"isShow"];
        tagItem.type = [set stringForColumn:@"type"];
        tagItem.sort = [set stringForColumn:@"sort"];
        tagItem.with = [self SizeWithObj:tagItem.name];

        if ([tagItem.is_show integerValue] != 0) {
            
        }
        [array addObject:tagItem];
    }
    [set close];
    return array;
}

- (NSArray *)sortCircleTagArrayWithSequenceFromSourceArray:(NSArray *)sourceArray {
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:sourceArray];
    NSArray *sorted = [muArr sortedArrayUsingComparator:^(id obj1, id obj2){
        if ([obj1 isKindOfClass:[ShopTypeItem class]] && [obj2 isKindOfClass:[ShopTypeItem class]]) {
            ShopTypeItem *s1 = (ShopTypeItem*)obj1;
            ShopTypeItem *s2 = (ShopTypeItem*)obj2;
            
            if ([s1.sort intValue]> [s2.sort intValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if ([s1.sort intValue]< [s2.sort intValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    return sorted;
}

-(CGFloat)SizeWithObj:(NSString *)text {
    CGSize itemSize = CGSizeZero;
    if ([text isKindOfClass:[NSString class]]) {
        CGFloat width = [text getWidthWithFont:KICTagsFont constrainedToSize:CGSizeMake(MAXFLOAT, ZOOM6(56))];
        itemSize = CGSizeMake(width + 2 * kICTagsCellLeftRight_Width, ZOOM6(56));
        
    }
    return itemSize.width+ZOOM6(20);
}

@end

@implementation ShopTagItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

@implementation ShopTypeItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end

@implementation TypeTagItem
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
