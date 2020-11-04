//
//  TopicModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/23.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject
@property (nonatomic , strong) NSString *headimageurl;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *location;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , assign) CGFloat replyCellHeigh;        //评论cell总高度
@property (nonatomic , assign) CGFloat replyHeadHeigh;        //评论head的高度
@property (nonatomic , strong) NSMutableArray *replyArray;
@end
