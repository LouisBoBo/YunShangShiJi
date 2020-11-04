//
//  TopicdetailsModel.m
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/25.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "TopicdetailsModel.h"
#import "Relatedrecommended.h"
#import "LastCommentsModel.h"
#import "TdetailsModel.h"
@implementation TopicdetailsModel
+ (NSMutableDictionary *)getMapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:[TdetailsModel mappingWithKey:@"post_details"], @"post_details",[LastCommentsModel mappingWithKey:@"hot_comments"],@"hot_comments",[Relatedrecommended mappingWithKey:@"related_recommended"],@"related_recommended",nil];
    return mapping;
}

@end
