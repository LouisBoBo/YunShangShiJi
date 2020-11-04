//
//  UpdatePhotosToYpy.h
//  YunShangShiJi
//
//  Created by ios-1 on 2017/2/14.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdatePhotosToYpy : NSObject

@property (nonatomic , strong) NSMutableString *images;
@property (nonatomic , strong) void(^updateSuccess)(NSMutableString*images);
-(void)creatUPY:(NSArray*)imageArray;
@end
