//
//  TopicTagsModel.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/26.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicTagsModel : NSObject
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *only_id;
@property (assign, nonatomic) BOOL is_show;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) CGFloat width;
@property (strong, nonatomic) NSString *type;              //类型
@property (assign, nonatomic) NSInteger supperLaber_type;  //品牌类型 2是自定义
@property (assign, nonatomic) BOOL isrepeat;               //是否重复
@property (copy, nonatomic) NSString *shop_code;
@end
