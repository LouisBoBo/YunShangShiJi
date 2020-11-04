//
//  TFRequest.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2016/11/21.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishBlock)(NSData *data);
typedef void(^FailedBlock)();
@interface TFRequest : NSObject

@property (nonatomic, copy)NSString *url;

@property (nonatomic, copy)FinishBlock finisBlock;

@property (nonatomic, copy)FailedBlock failedBlock;

- (void)startRequest;

+ (void)connectionWithUrl:(NSString *)url FinishBlock:(FinishBlock)finishBlock FaileedBlock:(FailedBlock)failedBlock;

@end
