//
//  ViewModelClass.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/7/5.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Config.h"
#import "APIClient.h"
#import "Response.h"
#import "Urls.h"

#import "TFCollectionViewService.h"
#import "TFTableViewService.h"
typedef void (^NetWorkBlock)(BOOL netConnetState);

@interface PublicViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *viewModelDataSource;
//获取网络的链接状态
-(void) netWorkStateWithNetConnectBlock:(NetWorkBlock)netConnectBlock WithURlStr: (NSString *) strURl;

@end
