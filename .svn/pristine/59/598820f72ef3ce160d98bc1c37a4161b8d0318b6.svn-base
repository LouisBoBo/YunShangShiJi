//
//  IntimateCircleModel.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/2/15.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "IntimateCircleModel.h"
#import "TFShopModel.h"
#import "SqliteManager.h"
#import "LastCommentsModel.h"
#import "CommetReplyModel.h"
#import "LreplistModel.h"
#import "SupperLabelModel.h"
NSString *const kIntimateCirclePicPath = @"/myq/theme/";

@implementation CircleModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[IntimateCircleModel  mappingWithKey:@"data"],@"data", [IntimateCircleModel  mappingWithKey:@"data2"],@"data2", [PagerModel mappingWithKey:@"pager"],@"pager",[IntimateCircleModel  mappingWithKey:@"collect_list"],@"collect_list",nil];
    return mapping;
}


+ (void)getCircleModelWithCurPage:(NSInteger)curPage success:(void (^)(id data))success {
    NSString *kApi = @"fc/circleHomepage?";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"%@&token=%@&curPage=%zd&pageSize=30&version=%@", kApi,token,curPage, VERSION];
    if (token) {
        [self getDataResponsePath:path success:success];
    }
}

//秘密友圈
+ (void)getCircleTagThemeModelWithCurPage:(NSInteger)curPage  tag:(NSString *)tag success:(void (^)(id data))success {
    NSString *kApi = @"fc/circleHomepage?";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"%@&token=%@&curPage=%zd&pageSize=30&version=%@&tag=%@", kApi,token, curPage, VERSION, tag];
    [self getDataResponsePath:path success:success];
}
//话题广场
+ (void)getCircleThemeModelWithCurPage:(NSInteger)curPage success:(void (^)(id data))success {
    NSString *kApi = @"fc/circleTopicSquare?";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSString *path;
    if (token) {
        path = [NSString stringWithFormat:@"%@token=%@&curPage=%zd&pageSize=30&version=%@", kApi, token, curPage, VERSION];
    }else
        path = [NSString stringWithFormat:@"%@curPage=%zd&pageSize=30&version=%@", kApi, curPage, VERSION];
    
    [self getDataResponsePath:path success:success];
}
//话题标签
+ (void)getTagCircleThemeModelWithCurPage:(NSInteger)curPage  tag:(NSString *)tag success:(void (^)(id data))success {
    NSString *kApi = @"fc/circleTopicSquare?";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    
    NSString *path;
    if (token) {
        path = [NSString stringWithFormat:@"%@token=%@&curPage=%zd&pageSize=30&version=%@&tag=%@", kApi, token, curPage, VERSION,tag];
    }else
        path = [NSString stringWithFormat:@"%@curPage=%zd&pageSize=30&version=%@&tag=%@", kApi, curPage, VERSION,tag];
    
    [self getDataResponsePath:path success:success];
}

+ (void)getPersonDressModelWithCurPage:(NSInteger)curPage success:(void (^)(id data))success {
    NSString *kApi = @"fc/wearTopic?";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
//    NSString *path = [NSString stringWithFormat:@"%@&token=%@&curPage=%zd&pageSize=30&version=%@&theme_type=2", kApi,token, curPage, VERSION];
    NSString *path = [NSString stringWithFormat:@"%@&token=%@&curPage=%zd&pageSize=30&version=%@&theme_type=4", kApi,token, curPage, VERSION];

    [self getDataResponsePath:path success:success];
}

+ (void)getPersonThemeModelWithCurPage:(NSInteger)curPage success:(void (^)(id data))success {
    NSString *kApi = @"fc/wearTopic?";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"%@&token=%@&curPage=%zd&pageSize=30&version=%@&theme_type=3", kApi,token, curPage, VERSION];
    [self getDataResponsePath:path success:success];
}

+ (void)getPersonCollectModelWithCurPage:(NSInteger)curPage success:(void (^)(id data))success {
    NSString *kApi = @"fc/queryCollectList?";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"%@&token=%@&curPage=%zd&pageSize=30&version=%@", kApi,token, curPage, VERSION];
    [self getDataResponsePath:path success:success];
}

+ (void)getCommendThemeModelWithCurPage:(NSInteger)curPage PageSize:(NSInteger)pagesize Themeid:(NSString*)themeid success:(void (^)(id data))success;
{
    NSString *kApi = @"fc/subjectRecommend?";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path ;
    if(token.length >10)
    {
        path = [NSString stringWithFormat:@"%@token=%@&theme_id=%@&curPage=%zd&pageSize=%zd&version=%@&theme_type=3", kApi, token,themeid,curPage,pagesize, VERSION];
    }else{
        path = [NSString stringWithFormat:@"%@&theme_id=%@&curPage=%zd&pageSize=%zd&version=%@&theme_type=3", kApi,themeid,curPage,pagesize, VERSION];
    }
    [self getDataResponsePath:path success:success];

}
- (NSMutableArray *)myData {
    if (_myData == nil) {
        _myData = [NSMutableArray array];
        
        int k =0;
        int h =0;
        int l =0;
        if (self.collect_list) {//如果是收藏列表
             [_myData addObjectsFromArray:self.collect_list];
        }else
        if (self.data2) {
            for(int i =0 ; i<self.data.count+self.data2.count; i++)
            {
                if(l==5 && i != 0)
                {
                    if(k < self.data2.count)
                    {
                        [_myData addObject:self.data2[k]];
                        k++;
                        l =0;
                    }else{
                        if(h <self.data.count)
                        {
                            [_myData addObject:self.data[h]];
                            h ++;
                            l ++;
                        }
                    }
                }else{
                    if(h <self.data.count)
                    {
                        [_myData addObject:self.data[h]];
                        h ++;
                        l ++;
                    }
                }
            }
            if(k < self.data2.count)
            {
                for(int j =k ;j<self.data2.count; j ++)
                {
                    [_myData addObject:self.data2[j]];
                }
            }
            
        }else{
            [_myData addObjectsFromArray:self.data];
        }
    }

    //数组去重
    NSMutableArray *categoryArray = [NSMutableArray array];
    
    for (int i = 0; i < [_myData count]; i++){
        
        IntimateCircleModel *model1 = _myData[i];
        BOOL found = NO;
        for (IntimateCircleModel *modle in categoryArray)
        {
            if(model1.theme_id == modle.theme_id)
            {
                found = YES;
                break;
            }
        }
        if(!found)
        {
            [categoryArray addObject:model1];
        }
    }
    
    return categoryArray;
}

@end

@implementation IntimateCircleModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[TFShopModel  mappingWithKey:@"shop_list"],@"shop_list",[LastCommentsModel mappingWithKey:@"comments_list"], @"comments_list",[SupperLabelModel mappingWithKey:@"supp_label_list"], @"supp_label_list",nil];
    
    return mapping;
}


- (NSMutableArray *)srcArray
{
    if (!_srcArray) {
        _srcArray = [NSMutableArray array];
        if ([self.theme_type integerValue] == 1) {
            [self.shop_list enumerateObjectsUsingBlock:^(TFShopModel *shopModel, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",shopModel.shop_code]];
                NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
                NSString *pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,shopModel.shop_code,shopModel.def_pic];
                NSString *picSize;
                if (kDevice_Is_iPhone6Plus) {
                    picSize = @"!382";
                } else {
                    picSize = @"!280";
                }
                
                NSString *imgUrl = [NSString stringWithFormat:@"%@%@%@",[NSObject baseURLStr_Upy],pic,picSize];
                if(imgUrl.length > 10)
                {
                    [_srcArray addObject:imgUrl];
                }
                
            }];
        } else {
            if (self.pics.length) {
                NSArray *srcArr = [self.pics componentsSeparatedByString:@","];
                if (srcArr.count >= 1) {
                    NSMutableArray *muArray = [NSMutableArray array];
                    [srcArr enumerateObjectsUsingBlock:^(NSString   *st, NSUInteger idx, BOOL * _Nonnull stop) {

                        NSString *stTemp=@"";
                        if (st.length>4)
                        {
                            NSArray *urlarr =[st componentsSeparatedByString:@":"];
                            NSString *imagestr = @"";
                            if(urlarr.count)
                            {
                                imagestr = urlarr[0];
                            }
                            stTemp = [NSString stringWithFormat:@"%@%@%@/%@", [NSObject baseURLStr_Upy], kIntimateCirclePicPath, self.user_id ,imagestr];
                        }
                        
                        if(stTemp.length >10)
                        {
                            [muArray addObject:stTemp];
                        }
                    }];
                    [_srcArray addObjectsFromArray:muArray];
                }
            }
        }
    }
    
    return _srcArray;
}

- (NSMutableArray *)tagsArray {
    if (_tagsArray == nil) {
        _tagsArray = [NSMutableArray array];
        SqliteManager *manager = [SqliteManager sharedManager];
        //标签
        if ([self.theme_type integerValue] == 4) {
            NSMutableArray *arr1 =[NSMutableArray array];
            NSMutableArray *arr2 =[NSMutableArray array];
            for(SupperLabelModel *labelmodel in self.supp_label_list)
            {
                if (labelmodel.label_id) {
                    NSString *supp_label_id = [NSString stringWithFormat:@"%@", labelmodel.label_id];
                    TypeTagItem *item = [manager getSuppLabelItemForId:supp_label_id];
                    if (item) {
                        if(![item.class_name isEqualToString:@"其他"])
                        {
                            item.supperLabertype = labelmodel.label_type.integerValue;
                            item.only_id = labelmodel.only_id;
                            [arr1 addObject:item];
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
                                
                                [arr2 addObject:obj];
                            }
                        }
                    }];
                }
            }
            [_tagsArray addObjectsFromArray:arr1];
            [_tagsArray addObjectsFromArray:arr2];
        }
        if ([self.theme_type intValue] == 3 || [self.theme_type intValue] == 2 || [self.theme_type intValue] == 4) {
            NSArray *items = [manager getAllForCircleTagItem];
            [self.tags enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *tag = [NSString stringWithFormat:@"%@", obj];
                [items enumerateObjectsUsingBlock:^(ShopTypeItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([item.ID isEqualToString:tag]) {
                        
                        [_tagsArray addObject:item];
                    }
                }];
            }];
        }
        
        if ([self.theme_type integerValue] == 2 ) {
            
            if (self.style) {
                NSString *style = [NSString stringWithFormat:@"%@", self.style];
                NSArray *array = [manager getShopTagItemForSuperId:@"2"];
                [array enumerateObjectsUsingBlock:^(ShopTagItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.ID isEqualToString:style]) {
                        if(![obj.tag_name isEqualToString:@"其他"])
                        {
                            [_tagsArray addObject:obj];
                        }
                    }
                }];
            }
            if (self.supp_label_id) {
                NSString *supp_label_id = [NSString stringWithFormat:@"%@", self.supp_label_id];
                TypeTagItem *item = [manager getSuppLabelItemForId:supp_label_id];
                if (item) {
                    if(![item.class_name isEqualToString:@"其他"])
                    {
                        [_tagsArray addObject:item];
                    }
                }
                
            }
        }
        
        if ([self.theme_type integerValue] == 1) {
            [_tagsArray addObject:@"精选推荐"];
        }
    }

    //数组去重
    NSMutableArray *tagsArray = [NSMutableArray array];
    for (int i = 0; i < [_tagsArray count]; i++){
        id obj1 = _tagsArray[i];
        BOOL found = NO;
        for (id obj in tagsArray)
        {
            if([obj1 isKindOfClass:[ShopTagItem class]] && [obj isKindOfClass:[ShopTagItem class]] )
            {
                ShopTagItem *tag1 = obj1;
                ShopTagItem *tag = obj;
                
                if([tag1.ID isEqualToString:tag.ID])
                {
                    found = YES;
                    break;
                }
            }
            else if([obj1 isKindOfClass:[ShopTypeItem class]] && [obj isKindOfClass:[ShopTypeItem class]] )
            {
                ShopTypeItem *tag1 = obj1;
                ShopTypeItem *tag = obj;
                
                if([tag1.ID isEqualToString:tag.ID])
                {
                    found = YES;
                    break;
                }
            }
            else if([obj1 isKindOfClass:[TypeTagItem class]] && [obj isKindOfClass:[TypeTagItem class]] )
            {
                TypeTagItem *tag1 = obj1;
                TypeTagItem *tag = obj;
                
                if([tag1.ID isEqualToString:tag.ID])
                {
                    tag.isrepeat = YES;
                    found = YES;
                    break;
                }
            }
        }
        if(!found)
        {
            [tagsArray addObject:obj1];
        }
    }
    
    return tagsArray;
}


//- (NSMutableArray *)tagsArray {
//    if (_tagsArray == nil) {
//        _tagsArray = [NSMutableArray array];
//        SqliteManager *manager = [SqliteManager sharedManager];
//        if ([self.theme_type intValue] == 3 || [self.theme_type intValue] == 2) {
//            NSArray *items = [manager getAllForCircleTagItem];
//            [self.tags enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSString *tag = [NSString stringWithFormat:@"%@", obj];
//                [items enumerateObjectsUsingBlock:^(ShopTypeItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
//                    if ([item.ID isEqualToString:tag]) {
//                        [_tagsArray addObject:item];
//                    }
//                }];
//            }];
//        } else if ([self.theme_type integerValue] == 2) {
//            
//            if (self.style) {
//                NSString *style = [NSString stringWithFormat:@"%@", self.style];
//                NSArray *array = [manager getShopTagItemForSuperId:@"2"];
//                [array enumerateObjectsUsingBlock:^(ShopTagItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    if ([obj.ID isEqualToString:style]) {
//                        if(![obj.tag_name isEqualToString:@"其他"])
//                        {
//                            [_tagsArray addObject:obj];
//                        }
//                    }
//                }];
//            }
//            if (self.supp_label_id) {
//                NSString *supp_label_id = [NSString stringWithFormat:@"%@", self.supp_label_id];
//                TypeTagItem *item = [manager getSuppLabelItemForId:supp_label_id];
//                if (item) {
//                    if(![item.class_name isEqualToString:@"其他"])
//                    {
//                        [_tagsArray addObject:item];
//                    }
//                }
//               
//            }
//        } else if ([self.theme_type integerValue] == 1) {
//            [_tagsArray addObject:@"精选推荐"];
//        }
//        
//    }
//    return _tagsArray;
//}

- (NSMutableArray *)followArray {
    if (_followArray == nil) {
        _followArray = [NSMutableArray array];
        if ([self.theme_type integerValue] != 1) {
            [_followArray addObjectsFromArray:self.shop_list];
        }
    }
    return _followArray;
}

- (NSMutableArray *)commentArray
{
    if(_commentArray == nil)
    {
        _commentArray = [NSMutableArray array];
       
        for(int i =0 ; i<self.comments_list.count;i++)
        {
            CommetReplyModel *model1 = [[CommetReplyModel alloc]init];
            LastCommentsModel *lastmodel = self.comments_list[i];
            
            model1.send_nickname = lastmodel.nickname;
            model1.receive_nickname = nil;
            model1.content = lastmodel.content;
        
            if(lastmodel.base_user_id.intValue == lastmodel.user_id.intValue)
            {
                model1.send_nickname = @"楼主";
            }
            NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
            if(lastmodel.status.intValue==0 || (lastmodel.status.intValue == 1 && user_id.intValue == lastmodel.user_id.intValue))
            {
                [_commentArray addObject:model1];
            }
            
            for(int j =0;j<lastmodel.replies_list.count;j++)
            {
                CommetReplyModel *model2 = [[CommetReplyModel alloc]init];
                LreplistModel *lremodel = lastmodel.replies_list[j];
                
                model2.send_nickname = lremodel.send_nickname;
                model2.receive_nickname = lremodel.receive_nickname;
                model2.content = lremodel.content;
               
                if(lremodel.send_user_id.intValue == lastmodel.base_user_id.intValue)
                {
                    model2.send_nickname = @"楼主";
                }
                if(lremodel.receive_user_id.intValue == lastmodel.base_user_id.intValue)
                {
                    model2.receive_nickname = @"楼主";
                }

                if(lremodel.status.intValue==0 || (lremodel.status.intValue == 1 && lremodel.base_user_id.intValue == lremodel.send_user_id.intValue))
                {
                    [_commentArray addObject:model2];
                }

//                [_commentArray addObject:model2];
            }
            
            if(_commentArray.count == 5)
            {
                break;
            }
        }
        
    }
    return _commentArray;
}

- (NSMutableArray *)tagsNameArray
{
    if(_tagsNameArray == nil)
    {
        _tagsNameArray = [NSMutableArray array];
    }
    
    return _tagsNameArray;
}
- (NSMutableArray *)totalArray
{
    if(_totalArray == nil)
    {
        _totalArray = [NSMutableArray array];
        
    }
    return _totalArray;
}

@end
