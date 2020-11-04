//
//  TFIndianaRecordViewController.h
//  YunShangShiJi
//
//  Created by jingaiweiyi on 16/5/27.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFBaseViewController.h"
#import "TFIndianaRecordSubViewController.h"

//typedef enum : NSUInteger {
//    IndianaRecords, //夺宝记录
//    IndianaAnnounce,//往期揭晓
//} IndianaRecordViewType;

typedef NS_ENUM(NSUInteger, IndianaRecordViewType) {
    IndianaRecords = 1 << 0,                 //夺宝记录
    IndianaAnnounce = 1 << 1,                //往期揭晓
    IndianaRecords_TreasureGrop = 1 << 2,    //夺宝记录_拼团夺宝
    IndianaAnnounce_TreasureGrop = 1 << 3,   //往期揭晓_拼团夺宝
};
@interface TFIndianaRecordViewController : TFBaseViewController


@property (nonatomic,assign)IndianaRecordViewType type;

@end
