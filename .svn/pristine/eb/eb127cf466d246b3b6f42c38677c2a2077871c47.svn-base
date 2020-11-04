//
//  RawardModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2016/12/15.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "RawardModel.h"
#import "SqliteManager.h"
@implementation RawardModel
- (NSMutableArray*)getPtyaModel:(NSInteger)type
{
    NSMutableArray *yiduArray = [NSMutableArray array];
    NSInteger count = (type==2) ? 50 : 25;//type＝2时要50条随机

    for (int i =0;i<count;i++)
    {
        RawardModel *model = [RawardModel alloc];
        
        NSString *pic = @"";
        NSString *nickname = @"";
        NSString *title = @"";
        NSString *pp = @"";
        
        //头像
        NSString *tt = [NSString userHeadRandomProduce];
        pic = [NSString stringWithFormat:@"defaultcommentimage/%@",tt];
        
        //名称
        nickname  = [NSString userNameRandomProduce];
        title = type==2 ? [NSString stringWithFormat:@"%@ 集赞获得提现额度",nickname]
                        : [NSString stringWithFormat:@"%@ 抽奖获得提现额度",nickname];
        //钱
        pp=[NSString stringWithFormat:@"%.1f",arc4random()%30+20+arc4random()%10*0.1];
        
        if(type == 1)
        {
            title = [NSString stringWithFormat:@"%@ 抽奖获得提现额度",nickname];
        }else if (type == 2)
        {
            title = [NSString stringWithFormat:@"%@ 集赞获得提现额度",nickname];
        }else if (type == 3)
        {
//            NSArray *valueArr = @[@"9.9",@"19.9",@"29.9"];
//            NSString *value = valueArr[arc4random() % valueArr.count];
//            title = [NSString stringWithFormat:@"%@ %@元买走了%@%@",nickname,value,[self getBrandData],[self getTypeData]];
            
            title = [NSString stringWithFormat:@"%@ 免费领走了%@%@",nickname,[self getBrandData],[self getTypeData]];
            pp=[NSString stringWithFormat:@"%.1f",arc4random()%300+100+arc4random()%10*0.1];
        }

        model.headpic = pic;
        model.title = title;
        model.price = pp;
        
        [yiduArray addObject:model];
    }

    return yiduArray;
}
- (NSMutableArray*)getYiduModel:(NSInteger)type
{
    NSMutableArray *yiduArray = [NSMutableArray array];
    for (int i =0;i<25;i++)
    {
        RawardModel *model = [RawardModel alloc];
        
        NSString *pic = @"";
        NSString *nickname = @"";
        NSString *title = @"";
        NSString *pp = @"";
        
        //头像
        NSString *tt = [NSString userHeadRandomProduce];
        pic = [NSString stringWithFormat:@"defaultcommentimage/%@",tt];
        
        //名称
        nickname  = [NSString userNameRandomProduce];
        title = [NSString stringWithFormat:@"%@ 完成订单获得衣豆",nickname];
        
        //衣豆
        pp=[NSString stringWithFormat:@"%d",arc4random()%391+10];
        
        model.headpic = pic;
        model.title = title;
        model.price = pp;
        
        [yiduArray addObject:model];
    }
    
    return yiduArray;

}

//获取随机的品牌制造商
- (NSString*)getBrandData
{
    NSString * typedata = @"ZARA";
    
    if(!self.brandDataArray.count)
    {
        SqliteManager *manager = [SqliteManager sharedManager];
        
        NSArray *brandArray =[[manager getAllForBrandsItem]copy];
        
        [self.brandDataArray addObjectsFromArray:brandArray];
    }
    
    TypeTagItem* shopTypeItem = self.brandDataArray[arc4random() % self.brandDataArray.count];
    typedata = shopTypeItem.class_name.length>0?shopTypeItem.class_name:typedata;
    
    return typedata;
}

//获取随机的商品类目
- (NSString*)getTypeData
{
    
    NSString * typedata = @"大衣";
    
    if(!self.typeDataArray.count)
    {
        SqliteManager *manager = [SqliteManager sharedManager];
        NSArray *typeArr=@[@"0",@"2",@"4",@"3",@"7"];
        for (int i=0; i<typeArr.count; i++) {
            NSArray *arr =[manager getTypeTagItemForSuperIdWithHomePage:[NSString stringWithFormat:@"%@",typeArr[i]]];
            [self.typeDataArray addObjectsFromArray:arr];
        }
    }
    
    TypeTagItem *shopTypeItem = self.typeDataArray[arc4random() % self.typeDataArray.count];
    typedata = shopTypeItem.class_name.length>0?shopTypeItem.class_name:typedata;
    
    return typedata;
}

- (NSMutableArray *)typeDataArray
{
    if(_typeDataArray == nil)
    {
        _typeDataArray = [NSMutableArray array];
    }
    return _typeDataArray;
}
- (NSMutableArray *)brandDataArray
{
    if(_brandDataArray == nil)
    {
        _brandDataArray = [NSMutableArray array];
    }
    return _brandDataArray;
}
@end
