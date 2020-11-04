//
//  TFDoTestViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/6.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFExpViewController.h"

#import "TFLedBrowseShopViewController.h"
#import "NSDate+TFCommon.h"
#include<AssetsLibrary/AssetsLibrary.h>
#import "YiFuUserInfoManager.h"

#import "BubbleView.h"
#import "TFPopBackgroundView.h"
@interface TFExpViewController ()

@end

@implementation TFExpViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
    
    [super setNavigationItemLeft:@"测试页面(Debug模式)"];
    
    [self popView];
}

- (void)popView {
    
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"monday_hongbao-"];
    backgroundView.userInteractionEnabled = YES;
    image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:image.size.height * 0.5];
    backgroundView.image = image;
    popView.backgroundView = backgroundView;
    
    UIView *contentV = [[UIView alloc] init];

    popView.contentView = contentV;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"哇喔~";
    titleLabel.textColor = RGBCOLOR_I(253, 225, 40);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(48)];
    [contentV addSubview:titleLabel];
    
    UILabel *desLabel = [UILabel new];
    desLabel.text = @"抽中了一个疯狂红包!";
    desLabel.textColor = RGBCOLOR_I(253, 225, 40);
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(48)];
    [contentV addSubview:desLabel];
    
    UILabel *subLabel = [UILabel new];
    subLabel.text = @"点击拆红包可以获得随机提现额度";
    subLabel.textColor = RGBCOLOR_I(253, 229, 229);
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.font = kFont6px(30);
    [contentV addSubview:subLabel];
    
    UIButton *openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [openButton setBackgroundImage:[UIImage imageNamed:@"md_chai"] forState:UIControlStateNormal];
    [contentV addSubview:openButton];
    
    /**< 布局 */
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentV.mas_top).offset(ZOOM6(160));
        make.left.and.right.equalTo(@0);
    }];
    
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(ZOOM6(15));
        make.left.and.right.equalTo(@0);
    }];
    
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(desLabel.mas_bottom).offset(ZOOM6(20));
        make.left.and.right.equalTo(@0);
    }];
    
    [openButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subLabel.mas_bottom).offset(ZOOM6(40));
        make.centerX.equalTo(contentV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(ZOOM6(180), ZOOM6(180)));
        make.bottom.equalTo(contentV.mas_bottom).offset(-ZOOM6(20));
    }];
    
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    [contentV setNeedsLayout];
    [popView show];
    
    [openButton handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        // 拆红包
        [popView dismissAlert:YES];
        
    }];
}

- (void)exp6 {
    BubbleView *bubbleV = [[BubbleView alloc] initWithFrame:CGRectMake(0, 100, (int)ZOOM6(370), (int)(ZOOM6(72) + ZOOM6(20)) * 2)];
    [self.view addSubview:bubbleV];
    [bubbleV startScroll];
    [bubbleV getData];
}

- (void)exp5
{
    
    MyLog(@"userCount: %lu", (unsigned long)[[YiFuUserInfoManager shareInstance] userInfoCount]);
    
    YiFuUserInfo *user = [self getUserInfo:1024];
    YiFuUserInfo *user2 = [self getUserInfo:1024];
    YiFuUserInfo *user3 = [self getUserInfo:1025];
    
    NSMutableArray *userList = [NSMutableArray new];
    [userList addObject:user];
    [userList addObject:user2];
    [userList addObject:user3];
    
    [YiFuUserInfoManager insertUserInfoList:userList];
    
    YiFuUserInfo *user4 = [self getUserInfo:1024];
    [YiFuUserInfoManager deleteUserInfo:user4];
    
    YiFuUserInfo *user5 = [self getUserInfo:1026];
    [YiFuUserInfoManager insertUserInfo:user5];
    MyLog(@"userCount: %lu", (unsigned long)[[YiFuUserInfoManager shareInstance] userInfoCount]);
    
    // 搜索
    YiFuUserInfo *searchUser = [YiFuUserInfoManager searchUserInfoWithUserId:@1026];
    MyLog(@"searchUser: %@", searchUser);
    
    
}

- (YiFuUserInfo *)getUserInfo:(NSInteger)userId
{
    YiFuUserInfo *user = [[YiFuUserInfo alloc] init];
    user.userId = @(userId);
//    user.userName = [NSString stringWithFormat:@"%c%c%c", arc4random_uniform(26)+65, arc4random_uniform(26)+65, arc4random_uniform(26)+65];
    user.userIdenf = [NSString stringWithFormat:@"%d%d%d", arc4random_uniform(10), arc4random_uniform(10), arc4random_uniform(10)];
    
    return user;
}

- (void)exp4
{
    [self doLocalNotifition:YES];
}
// iOS本地通知&定时通知
- (void)doLocalNotifition:(BOOL)isOpen
{
    BOOL swith = isOpen;
    if (swith==YES) {
        //初始化一个 UILocalNotification
        UILocalNotification * notification = [[UILocalNotification alloc] init];
        NSDate * pushDate = [NSDate dateWithTimeIntervalSinceNow:10.0];
        
//// 1.设置弹出通知的时间
//        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"HH:mm"];
//        NSDate *nowDate = [dateFormatter dateFromString:@"11:15"];
//        //设置通知弹出的时间
//        notification.fireDate = nowDate;
        
//// 2.设置通知的提醒时间
//        NSDate *currentDate   = [NSDate date];
//        notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
//        notification.fireDate = [currentDate dateByAddingTimeInterval:5.0];
        
        
        if (notification!=nil) {
            
            //设置 推送时间
            notification.fireDate= pushDate;
            //设置 时区
            notification.timeZone = [NSTimeZone defaultTimeZone];
            //设置 重复间隔
            notification.repeatInterval = kCFCalendarUnitDay; //设置重复重复间隔为每天
            // 设置启动通知的声音
            notification.soundName = UILocalNotificationDefaultSoundName;
            //设置 推送提示语
            notification.alertBody = @"提示框内容5";
            //设置 icon 上 红色数字
            notification.applicationIconBadgeNumber = 1;
            
            // 设置应用程序右上角的提醒个数
//            notification.applicationIconBadgeNumber++;
            
            //取消 推送 用的 字典  便于识别
            NSDictionary * inforDic = [NSDictionary dictionaryWithObject:@"LocalNotificationID" forKey:@"LocalNotificationID"];
            notification.userInfo =inforDic;
            //添加推送到 Application 启动通知
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
        NSLog(@"开启本地通知");
    } else if(swith == NO){
        
        //拿到 存有 所有 推送的数组
        NSArray * array = [[UIApplication sharedApplication] scheduledLocalNotifications];
        //便利这个数组 根据 key 拿到我们想要的 UILocalNotification
        for (UILocalNotification * loc in array) {
            if ([[loc.userInfo objectForKey:@"LocalNotificationID"] isEqualToString:@"LocalNotificationID"]) {
                //取消 本地推送
                [[UIApplication sharedApplication] cancelLocalNotification:loc];
            }
        }
        
        NSLog(@"关闭本地通知");
    }
}

- (void)exp3
{
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImage *image = [UIImage imageNamed:@"J63MI042Z4P8.jpg"];
    NSData *sourceImageData = UIImageJPEGRepresentation(image, 1);
    MyLog(@"sourceImageData.length: %ld", (unsigned long)sourceImageData.length);
    
    CGFloat W = 300;
    CGFloat H = image.size.height*W/image.size.width;
    
    //UIImage *newImage = [UIImage scaleToSize:image size:CGSizeMake(100, 100)];
    //UIImage *newImage = [UIImage imageCompressForSizeSourceImage:image targetSize:CGSizeMake(100, 100)];
    UIImage *newImage = [UIImage imageCompressForWidthSourceImage:image targetWidth:200];
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.1);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:@"/Users/yunshang/Desktop/imageExp/变化图.jpg" contents:imageData attributes:nil];
    
    UIImageView *imageV1 = [UIImageView new];
    imageV1.backgroundColor = COLOR_RANDOM;
    imageV1.image = image;
    [self.view addSubview:imageV1];
    
    UIImageView *imageV2 = [UIImageView new];
    imageV2.backgroundColor = COLOR_RANDOM;
    imageV2.image = newImage;
    [self.view addSubview:imageV2];

    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom).offset(10);
        make.centerX.equalTo(@[imageV2, self.view]);
        make.size.mas_equalTo(CGSizeMake(W, H));
    }];
    
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(newImage.size.width, newImage.size.height));
    }];
    
    [self.view distributeSpacingVerticallyWith:@[imageV1, imageV2]];

}
- (void)exp2
{
    MyLog(@"%@", [NSDate stringCurrDateWithFormatterString:@"yyyy/MM/dd/ hh/mm/ss"])
    
    MyLog(@"%ld, %ld, %ld, %ld, %ld, %ld", (long)[NSDate dateComponentsWithTimeInterval:6000].year, (long)[NSDate dateComponentsWithTimeInterval:6000].month, (long)[NSDate dateComponentsWithTimeInterval:6000].day, (long)[NSDate dateComponentsWithTimeInterval:6000].hour, (long)[NSDate dateComponentsWithTimeInterval:6000].minute, (long)[NSDate dateComponentsWithTimeInterval:6000].second)
    ;
    MyLog(@"%@", [NSDate dateWithtimeIntervalSince1970ms:36000]);
    
    MyLog(@"%f", [NSDate timeIntervalSince1970WithDate]);
    
}

- (void)exp
{
    UIButton *nextPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextPageBtn setTitle:@"next" forState:UIControlStateNormal];
    nextPageBtn.backgroundColor = [UIColor yellowColor];
    [self.navigationView addSubview:nextPageBtn];
    [nextPageBtn addTarget:self action:@selector(nextPageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [nextPageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView).offset(20);
        make.right.equalTo(self.navigationView.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 44));
    }];
    
    
    UIImageView *imageV = [UIImageView new];
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];

}

- (void)nextPageBtnClick
{
    TFLedBrowseShopViewController *vc = [[TFLedBrowseShopViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
