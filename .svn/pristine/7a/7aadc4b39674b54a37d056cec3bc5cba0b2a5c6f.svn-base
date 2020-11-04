//
//  ReplyListModel.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/3.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单详情评论列表

#import "ReplyListModel.h"

@implementation ReplyListModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[ReplyModel mappingWithKey:@"comments"],@"comments",nil];
    return mapping;
}

+ (void)getReplyListModelWithShopCode:(NSString *)shopCode page:(NSInteger)page success:(void (^)(id))success {
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *path = [NSString stringWithFormat:@"shareOrder/replyList?token=%@&version=%@&shop_code=%@&pager.curPage=%ld&pager.pageSize=10",token,VERSION,shopCode,page];
    [self getDataResponsePath:path success:success];
}

@end


@implementation ReplyModel
@synthesize cellHeight = _cellHeight;

- (CGFloat)cellHeight {
    if (0 == _cellHeight) {
        _cellHeight = [NSString heightWithString:_content font:[UIFont systemFontOfSize:kZoom6pt(14)] constrainedToWidth:kApplicationWidth - kZoom6pt(70)] + kZoom6pt(60.0);
    }
    return _cellHeight;
}

@end