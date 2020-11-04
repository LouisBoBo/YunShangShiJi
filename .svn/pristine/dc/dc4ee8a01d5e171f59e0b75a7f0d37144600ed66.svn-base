//
//  InvitationViewController.h
//  YunShangShiJi
//
//  Created by ios-1 on 15/5/21.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumModel.h"
#import "FaceBoard.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface InvitationViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,FaceBoardDelegate>

@property (nonatomic , strong)NSString *circle_id;
@property (nonatomic , strong)ForumModel *model;
@property (nonatomic , strong)NSString *circle_name;
@property (nonatomic , strong)NSString *circle_content;
@end
