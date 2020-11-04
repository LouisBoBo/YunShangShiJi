//
//  ShopCarManager.m
//  YunShangShiJi
//
//  Created by zgl on 16/8/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "ShopCarManager.h"
#import "QueryCartModel.h"
#import "YFShareModel.h"

static NSInteger const timeOut = 30*60; //倒计时时间
//根据model返回相应的查询条件
static NSString *whereFromModel(NSObject *model) {
    NSString *where = nil;
    if ([model isKindOfClass:ShopCarModel.class]) {
        ShopCarModel *sModel = (ShopCarModel *)model;
        
        where = [NSString stringWithFormat:@"shop_code='%@' and stock_type_id=%ld",sModel.shop_code,sModel.stock_type_id];
    } else if ([model isKindOfClass:ShopSaleModel.class]) {
        ShopSaleModel *sModel = (ShopSaleModel *)model;
        
        where = [NSString stringWithFormat:@"p_code='%@' and p_s_t_id='%@'",sModel.p_code,sModel.p_s_t_id];
    }
    return where;
}

#pragma mark ---------------倒计时-------------------
@interface ShopTimeModel : BaseModel
@property (nonatomic, copy) NSString *type; //时间类型
@property (nonatomic, assign) NSTimeInterval date; //最后加入购物车时间
@end

@implementation ShopTimeModel
+ (instancetype)modelWidthType:(NSString *)type date:(NSTimeInterval)date {
    ShopTimeModel *model = [[self alloc] init];
    model.type = type;
    model.date = date;
    return model;
}

/// 时间表格
+ (LKDBHelper *)getUsingLKDBHelper {
    return [[LKDBHelper alloc] initWithDBName:[self getUserDBName]];
}

/// 主键
+ (NSString *)getPrimaryKey {
    return @"type";
}
@end


#pragma mark ---------------商品-------------------
@interface ShopCarManager ()
@property (nonatomic, assign) BOOL isDB;//数据库是否存在
@end

@implementation ShopCarManager

@synthesize p_deadline = _p_deadline, s_deadline = _s_deadline;

+ (ShopCarManager *)sharedManager {
    static ShopCarManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        assert(sharedManager != nil);
    });
    
    sharedManager.isDB = [LKDBUtils isFileExists:[LKDBHelper getDBPathWithDBName:[BaseModel getUserDBName]]];
    return sharedManager;
}

- (NSInteger)p_count {
    
    if (_isDB && [ShopCarModel isTableCreated]) {
        return [ShopCarModel sumWidthVariable:@"shop_num" where:@{@"expired":[NSNumber numberWithBool:NO]}];
    }
    return 0;
}

- (NSInteger)s_count {
    if (_isDB && [ShopSaleModel isTableCreated]) {
        return [ShopSaleModel sumWidthVariable:@"shop_num" where:@{@"expired":[NSNumber numberWithBool:NO]}];
    }
    return 0;
}

- (NSInteger)p_deadline {
    
    if (self.p_count == 0||![ShopTimeModel isTableCreated]) {
        return 0;
    }
    return _p_deadline > 0?_p_deadline:0;
}

- (NSInteger)s_deadline {
    
    if (self.s_count == 0||![ShopTimeModel isTableCreated]) {
        return 0;
    }
    return _s_deadline > 0?_s_deadline:0;
}

/// 购物未失效商品
- (NSArray<ShopCarModel *> *)pData {
    
    if (_isDB && [ShopCarModel isTableCreated]) {
        return [ShopCarModel searchWithWhere:@{@"expired":[NSNumber numberWithBool:NO]}
                                     orderBy:@"date_time DESC"
                                      offset:0
                                       count:0];
    }
    return nil;
}

/// 购物失效商品
- (NSArray<ShopCarModel *> *)peData {
    if (_isDB && [ShopCarModel isTableCreated]) {
        
        [self p_deadline];
        NSArray *array = [ShopCarModel searchWithWhere:@{@"expired":[NSNumber numberWithBool:YES]}
                                               orderBy:@"date_time DESC"
                                                offset:0
                                                 count:0];
        NSMutableArray *muarray = [NSMutableArray array];
        NSInteger num = 0;
        for (ShopCarModel *model in array) {
            num++;
            if (num <= 10) {
                [muarray addObject:model];
            } else {
                //超过十条删除
                [YFShareModel getShopCartDelWidthID:model.ID type:0 success:^(YFShareModel *data) {
                    if (data.status == 1) {
                        [self.class deleteToDB:model];
                    }
                }];
            }
        }
        return [muarray copy];
    }
    return nil;
}

- (NSArray<ShopSaleModel *> *)sData {
    if (_isDB && [ShopSaleModel isTableCreated]) {
        return [ShopSaleModel searchWithWhere:@{@"expired":[NSNumber numberWithBool:NO]}
                                      orderBy:@"date_time DESC"
                                       offset:0
                                        count:0];
    }
    return nil;
}

- (NSArray<ShopSaleModel *> *)seData {
    if (_isDB && [ShopSaleModel isTableCreated]) {
        [self s_deadline];
        NSArray *array = [ShopSaleModel searchWithWhere:@{@"expired":[NSNumber numberWithBool:YES]}
                                                orderBy:@"date_time DESC"
                                                 offset:0
                                                  count:0];
        NSMutableArray *muarray = [NSMutableArray array];
        NSInteger num = 0;
        for (ShopSaleModel *model in array) {
            num++;
            if (num <= 10) {
                [muarray addObject:model];
            } else {
                //超过十条删除
                [YFShareModel getShopCartDelWidthID:model.ID type:1 success:^(YFShareModel *data) {
                    if (data.status == 1) {
                        [self.class deleteToDB:model];
                    }
                }];
            }
        }
        return [muarray copy];
    }
    return nil;
}

///插入
+ (BOOL)insertToDB:(NSObject *)model {
    
    NSTimeInterval time = [[model valueForKey:@"date_time"] doubleValue];
    if (time < 1000000000000) {
        NSString *where = [NSString stringWithFormat:@"type='%@'",NSStringFromClass(model.class)];
        
        ShopTimeModel *tmodel = [ShopTimeModel searchSingleWithWhere:where orderBy:nil];
        
        if (tmodel == nil) {
            
            tmodel = [ShopTimeModel modelWidthType:NSStringFromClass(model.class) date:time];
            [tmodel saveToDB];
        } else if (time > tmodel.date) {
            tmodel.date = time;
            [tmodel updateToDB];
        }
    } else {
        time /= 1000;
    }
    
    
    if ([self isExistsWithModel:model]) {
        return [self adddateToDB:model];
    } else {
        [model setValue:[NSNumber numberWithDouble:time] forKey:@"date_time"];
        return [model saveToDB];
    }
}

+ (void)insertToDBWidthArray:(NSArray *)array {
    for (NSObject *model in array) {
        [self insertToDB:model];
    }
}

///更新
+ (BOOL)updateToDB:(NSObject *)model {
    return [self updateToDBWithModel:model type:2];
}

+ (void)updateToDBWidthArray:(NSArray *)array {
    for (NSObject *model in array) {
        [self updateToDB:model];
    }
}

+ (BOOL)updateToDBWidthType:(ShopCarType)type ID:(NSString *)ID shopNum:(NSInteger)shopNum {
    switch (type) {
        case ShopCarTypeCar:
            return [ShopCarModel updateToDBWithSet:[NSString stringWithFormat:@"shop_num=%ld",(long)shopNum]
                                             where:@{@"ID":ID}];
        case ShopCarTypeSale:
            return [ShopSaleModel  updateToDBWithSet:[NSString stringWithFormat:@"shop_num=%ld",(long)shopNum]
                                               where:@{@"ID":ID}];
        default:
            return NO;
    }
}

///删除
+ (BOOL)deleteToDB:(NSObject *)model {
    return [model deleteToDB];
}

+ (void)deleteToDBWidthArray:(NSArray *)array {
    for (NSObject *model in array) {
        [model deleteToDB];
    }
}

///重新加入
+ (BOOL)againdateToDBWidthType:(ShopCarType)type ID:(NSString *)ID {
    NSTimeInterval time = [NSDate date].timeIntervalSince1970;
    NSDictionary *where = @{@"ID":ID};
    
    
    NSString *set = [NSString stringWithFormat:@"expired=0,date_time=%lf",time];
    Class class;
    if (type&ShopCarTypeCar) {
        class = ShopCarModel.class;
    } else if (type&ShopCarTypeSale){
        class = ShopSaleModel.class;
    }
    NSString *twhere = [NSString stringWithFormat:@"type='%@'",NSStringFromClass(class)];
    
    
    ShopTimeModel *tmodel = [ShopTimeModel searchSingleWithWhere:twhere orderBy:nil];
    if (tmodel == nil) {
        tmodel = [ShopTimeModel modelWidthType:NSStringFromClass(class) date:time];
        [tmodel saveToDB];
    } else if (time > tmodel.date) {
        tmodel.date = time;
        [tmodel updateToDB];
    }
    
    switch (type) {
        case ShopCarTypeCar: {
            
            return [ShopCarModel updateToDBWithSet:set where:where];
        }
        case ShopCarTypeSale: {
           return [ShopSaleModel updateToDBWithSet:set where:where];
        }
        default:
            return NO;
    }

}

+ (void)againdateToDBWidthType:(ShopCarType)type Array:(NSArray *)array {
    for (NSString *ID in array) {
        [self againdateToDBWidthType:type ID:ID];
    }
}

+ (void)deleteAllWidthType:(ShopCarType)type {
    if (type&ShopCarTypeCar) {
        [ShopCarModel deleteWithWhere:@{@"expired":[NSNumber numberWithBool:NO]}];
    }
    
    if (type&ShopCarTypeSale) {
        [ShopSaleModel deleteWithWhere:@{@"expired":[NSNumber numberWithBool:NO]}];
    }
}

+ (BOOL)deleteToDBWidthType:(ShopCarType)type ID:(NSString *)ID {
    switch (type) {
        case ShopCarTypeCar:
            return [ShopCarModel deleteWithWhere:@{@"ID":ID}];
        case ShopCarTypeSale:
            return [ShopSaleModel deleteWithWhere:@{@"ID":ID}];
        default:
            return NO;
    }
}
+ (BOOL)removeToDBWidthType:(ShopCarType)type ID:(NSString *)ID {
    NSString *set = [NSString stringWithFormat:@"expired=1,date_time=%lf",[NSDate date].timeIntervalSince1970];
    switch (type) {
        case ShopCarTypeCar:
            return [ShopCarModel updateToDBWithSet:set where:@{@"ID":ID}];
        case ShopCarTypeSale:
            return [ShopSaleModel updateToDBWithSet:set where:@{@"ID":ID}];
        default:
            return NO;
    }

}

+ (BOOL)adddateToDB:(NSObject *)model {
    return [self updateToDBWithModel:model type:0];
}

+ (BOOL)minusdateToDB:(NSObject *)model {
    return [self updateToDBWithModel:model type:1];
}
+ (BOOL)updateToDBWithModel:(NSObject *)model type:(NSInteger)type {
    id where = whereFromModel(model);
    if (where == nil) {
        return NO;
    }
    
    if (type == 2) {
        return [model.class updateToDB:model where:where];
    }
    
    NSString *sign = type == 0?@"+":@"-";
    NSString *set = [NSString stringWithFormat:@"shop_num=shop_num%@%@,date_time=%@,expired=%@",sign,[model valueForKey:@"shop_num"],[model valueForKey:@"date_time"],[model valueForKey:@"expired"]];
    return [model.class updateToDBWithSet:set where:where];
}

+ (BOOL)isExistsWithModel:(NSObject *)model {
    if (![model.class isTableCreated]) {
        return NO;
    }

    NSString *where = whereFromModel(model);
    if (where == nil) {
        return NO;
    }
    return [[model.class getUsingLKDBHelper] isExistsClass:model.class where:where];
}

+ (id)isExistsWithType:(ShopCarType)type shopCode:(NSString *)shopCode andStid:(NSString *)stid {
    switch (type) {
        case ShopCarTypeCar: {
            NSString *where = [NSString stringWithFormat:@"shop_code='%@' and stock_type_id=%@",shopCode,stid];
            ShopCarModel *model = [ShopCarModel searchSingleWithWhere:where orderBy:nil];
            return model;
        }
        case ShopCarTypeSale: {
            NSString *where = [NSString stringWithFormat:@"p_code='%@' and p_s_t_id='%@'",shopCode,stid];
            ShopSaleModel *model = [ShopSaleModel searchSingleWithWhere:where orderBy:nil];
            return model;
        }
        default:
            return nil;
    }
}

+ (BOOL)expiredWidthModel:(NSObject *)model {
    NSString *where = whereFromModel(model);
    if (where == nil) {
        return NO;
    }
    return NO;
}

+ (void)loadDataNetwork {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if (token == nil) {
        return;
    }

    BOOL isfile = [LKDBUtils isFileExists:[LKDBHelper getDBPathWithDBName:[BaseModel getUserDBName]]];
    MyLog(@"isfile: %d", isfile);
    
    [QueryCartModel getQueryCartWithSuccess:^(QueryCartModel *data) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            if (data.status == 1) {
                if (!isfile) {
                    [LKDBUtils deleteWithFilepath:[LKDBUtils getPathForDocuments:@"YFSHOPCAR" inDir:@"db"]];
                }
                NSInteger stime = MIN(data.s_deadline/1000 - data.sys_time/1000,timeOut),
                ptime = MIN(data.p_deadline/1000 - data.sys_time/1000,timeOut);
        
                NSTimeInterval time = [NSDate date].timeIntervalSince1970;
            
                ShopTimeModel *ptmodel = [ShopTimeModel modelWidthType:@"ShopCarModel" date:time + stime - timeOut];
                [ptmodel saveToDB];
                ShopTimeModel *stmodel = [ShopTimeModel modelWidthType:@"ShopSaleModel" date:time + ptime - timeOut];
                [stmodel saveToDB];
                
                //有效／失效处理
                //1、倒计时小于0：全部失效
                //2、倒计时大于0:如果数据库存在则用本地数据，如果不存在则全部有效
                //3、加入时间：如果数据库存则用本地时间，如果不存在则将服务器时间转换为手机时间（用于排序）
                for (ShopCarModel *model in data.shop_list) {
                    
                    model.expired = NO;
                    ShopCarModel *sModel = isfile?[self isExistsWithType:ShopCarTypeCar shopCode:model.shop_code andStid:@(model.stock_type_id).stringValue]:nil;
                    
                    model.date_time = sModel == nil?MIN(time - (data.sys_time - model.date_time)/1000, time):sModel.date_time;
                    
                }
                for (ShopSaleModel *model in data.p_shop_list) {
                    
                    model.expired = NO;
                    ShopSaleModel *sModel = isfile?[self isExistsWithType:ShopCarTypeSale shopCode:model.p_code andStid:model.p_s_t_id]:nil;
                    
                    model.date_time = sModel == nil?MIN(time - (data.sys_time - model.date_time)/1000,time):sModel.date_time;
                    
                }

                
                if (isfile) {
                    [[ShopSaleModel getUsingLKDBHelper] dropTableWithClass:ShopSaleModel.class];
                    [[ShopCarModel getUsingLKDBHelper] dropTableWithClass:ShopCarModel.class];
                }
                
                [self insertToDBWidthArray:data.shop_list];
                [self insertToDBWidthArray:data.p_shop_list];
            }
        });
    }];
}

@end
