//
//  SalePListModel.m
//  YunShangShiJi
//
//  Created by 云商 on 15/12/2.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "SalePListModel.h"

@implementation SalePListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

/**
 @property (nonatomic, assign)NSInteger shopNum;
 @property (nonatomic, assign)NSInteger shopCount;
 
 @property (nonatomic, strong)NSNumber *num;
 @property (nonatomic, strong)NSNumber *price;
 @property (nonatomic, copy)NSString *name;
 @property (nonatomic, copy)NSNumber *seq;
 @property (nonatomic, copy)NSString *code;
 @property (nonatomic, copy)NSNumber *type;
 @property (nonatomic, copy)NSNumber *postage;
 */

-(id)copyWithZone:(NSZone *)zone
{
    SalePListModel *spModel = [[SalePListModel alloc] init];
    
//    //copy = %d", self.shopNum);
    
    spModel.shopNum = self.shopNum;
    spModel.shopCount = self.shopCount;
    spModel.num = self.num;
    spModel.price = self.price;
    spModel.name  = self.name;
    spModel.seq = self.seq;
    spModel.type = self.type;
    spModel.postage = self.postage;
    
    return spModel;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    SalePListModel *spModel = [[SalePListModel alloc] init];
    
//    //copy = %d", self.shopNum);
    
    spModel.shopNum = self.shopNum;
    spModel.shopCount = self.shopCount;
    spModel.num = [self.num copy];
    spModel.price = [self.price copy];
    spModel.name  = [self.name mutableCopy];
    spModel.seq = [self.seq copy];
    spModel.type = [self.type copy];
    spModel.postage = [self.postage copy];
    
    return spModel;
}

@end
