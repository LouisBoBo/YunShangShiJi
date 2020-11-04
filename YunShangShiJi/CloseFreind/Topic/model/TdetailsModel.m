//
//  TdetailsModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/25.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TdetailsModel.h"
#import "TShoplistModel.h"
#import "SqliteManager.h"
#import "TopicTagsModel.h"
#import "SupperLabelModel.h"
@implementation TdetailsModel
+ (NSMutableDictionary *)getMapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:[TShoplistModel mappingWithKey:@"shop_list"],@"shop_list",[SupperLabelModel mappingWithKey:@"supp_label_list"],@"supp_label_list",nil];
    return mapping;
}

- (NSMutableArray *)tagsArray {
    SqliteManager *manager = [SqliteManager sharedManager];
    if (_tagsArray == nil) {
        _tagsArray = [NSMutableArray array];
       
        NSMutableArray *arr1 =[NSMutableArray array];
        NSMutableArray *arr2 =[NSMutableArray array];

        //标签
        for(SupperLabelModel *labelmodel in self.supp_label_list)
        {
            if (labelmodel.label_id) {
                NSString *supp_label_id = [NSString stringWithFormat:@"%@", labelmodel.label_id];
                TypeTagItem *item = [manager getSuppLabelItemForId:supp_label_id];
                if (item) {
                    TopicTagsModel *model = [[TopicTagsModel alloc]init];
                    model.ID = item.ID;
                    model.only_id = [NSString stringWithFormat:@"%@",labelmodel.only_id];
                    model.type = @"品牌";
                    model.title = item.class_name;
                    model.is_show = item.is_hot.intValue==0?YES:NO;
//                    model.shop_code = [NSString stringWithFormat:@"%@",item.shop_code];
                    model.supperLaber_type = labelmodel.label_type.integerValue;
                    if(![model.title isEqualToString:@"其他"])
                    {
                        [arr1 addObject:model];
                    }
                }
            }
            if (labelmodel.style) {
                NSString *style = [NSString stringWithFormat:@"%@", labelmodel.style];
                NSArray *array = [manager getShopTagItemForSuperId:@"2"];
                [array enumerateObjectsUsingBlock:^(ShopTagItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.ID isEqualToString:style]) {
                        if(![obj.tag_name isEqualToString:@"其他"])
                        {
                            TopicTagsModel *model = [[TopicTagsModel alloc]init];
                            model.ID = obj.ID;
                            model.only_id = [NSString stringWithFormat:@"%@",labelmodel.only_id];
                            model.type = @"风格";
                            model.title = obj.tag_name;
                            model.is_show = obj.is_show.intValue==1?YES:NO;
                            [arr2 addObject:model];
                        }
                    }
                }];
            }
        }
        [_tagsArray addObjectsFromArray:arr1];
        [_tagsArray addObjectsFromArray:arr2];
        
        NSArray *supperarray = [manager getTypeTagItemForSuperIdWithShopping:self.supp_label_id];
        [_tagsArray addObjectsFromArray:supperarray];
        
        NSArray *items = [manager getAllForCircleTagItem];
        [self.tags enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *tag = [NSString stringWithFormat:@"%@", obj];
            [items enumerateObjectsUsingBlock:^(ShopTypeItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([item.ID isEqualToString:tag]) {
                    TopicTagsModel *model = [[TopicTagsModel alloc]init];
                    model.ID = item.ID;
                    model.title = item.name;
                    model.is_show = item.type.intValue==1?YES:NO;
                    model.type = @"话题";

                    [_tagsArray addObject:model];
                }
            }];
        }];
        if (self.style) {
            NSString *style = [NSString stringWithFormat:@"%@", self.style];
            NSArray *array = [manager getShopTagItemForSuperId:@"2"];
            [array enumerateObjectsUsingBlock:^(ShopTagItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.ID isEqualToString:style]) {
                    TopicTagsModel *model = [[TopicTagsModel alloc]init];
                    model.ID = obj.ID;
                    model.type = @"风格";
                    model.title = obj.tag_name;
                    model.is_show = obj.is_show.intValue==1?YES:NO;

                    [_tagsArray addObject:model];
                    
                }
            }];
        }
        if (self.supp_label_id) {
            NSString *supp_label_id = [NSString stringWithFormat:@"%@", self.supp_label_id];
            TypeTagItem *item = [manager getSuppLabelItemForId:supp_label_id];
            if (item) {
                TopicTagsModel *model = [[TopicTagsModel alloc]init];
                model.ID = item.ID;
                model.type = @"品牌";
                model.title = item.class_name;
                model.is_show = item.is_hot.intValue==0?YES:NO;

                if(![model.title isEqualToString:@"其他"])
                {
                    [_tagsArray addObject:model];
                }
            }
            
        }

    }
    
    //数组去重
    NSMutableArray *tagsArray = [NSMutableArray array];
    for (int i = 0; i < [_tagsArray count]; i++){
        
        TopicTagsModel *model1 = _tagsArray[i];
        BOOL found = NO;
        for (TopicTagsModel *modle in tagsArray)
        {
            if([model1.ID isEqualToString:modle.ID])
            {
                modle.isrepeat = YES;
                found = YES;
                break;
            }
        }
        if(!found)
        {
            [tagsArray addObject:model1];
        }
    }

    return tagsArray;
}

-(CGFloat)getRowWidth:(NSString *)text fontSize:(CGFloat)fontSize
{
    //文字高度
    CGFloat width;
    if([[[UIDevice currentDevice]systemVersion] floatValue]>=7.0){
        
        CGRect rect=[text boundingRectWithSize:CGSizeMake(kScreenWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName] context:nil];
        
        width=rect.size.width;
        
    }
    else{
        
    }
    
    return width;
}

@end
