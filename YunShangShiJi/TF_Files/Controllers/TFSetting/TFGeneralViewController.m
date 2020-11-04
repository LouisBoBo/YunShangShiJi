//
//  TFGeneralViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/6/30.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFGeneralViewController.h"
#import "TFPopBackgroundView.h"
#import "TFGeneralViewController.h"
#import "TFSwitchCellView.h"
//#import "ChatViewController.h"
//#import "ChatListViewController.h"
#import "RobotManager.h"

@interface TFGeneralViewController () <UIAlertViewDelegate>

{
    NSString *cacheFileSize; //缓存文件大小

}

@end


@implementation TFGeneralViewController
//- (void)dealloc
//{
//    MyLog(@"释放%@", [self class]);
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"通用"];
    
    [self createUI];
}

#pragma mark - 创建UI
- (void)createUI
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *position = [ud objectForKey:@"isPosition"];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"开启衣蝠位置服务",@"清理图片缓存", nil];
    NSArray *subTitleArr = [NSArray arrayWithObjects:@"根据您的位置信息，向您展示丰富资讯",@"包括:图片、数据等", nil];
    
    CGFloat ud_Margin = ZOOM(52);
    CGFloat label_H = ZOOM(50);
    CGFloat H = ud_Margin*2+label_H*2;
    
    CGFloat H_yzero = ZOOM(80);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+H_yzero, kScreenWidth, 1)];
    lineView.backgroundColor = RGBCOLOR_I(220,220,220);
    [self.view addSubview:lineView];
    

    
    for (int i = 0; i<titleArr.count; i++) {
        TFSwitchCellView *tscv = [[TFSwitchCellView alloc] initWithFrame:CGRectMake(0,  lineView.bottom+i*H, kScreenWidth, H)];
        tscv.tag = 200+i;
        if (i == 0) {
            [tscv setImageOrSwitch:YES];
            [tscv.rightSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
            tscv.rightSwitch.tag = 300+i;
//            tscv.rightSwitch.onTintColor = COLOR_ROSERED;
            if ([position isEqualToString:@"YES"]) {
                tscv.rightSwitch.on = YES;
            } else {
                tscv.rightSwitch.on = NO;
            }
        } else {
            [tscv setImageOrSwitch:NO];
            [tscv.imageView removeFromSuperview];
            [tscv.cellBtn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            tscv.cellBtn.tag = 100;
        }
        tscv.titleLabel.text = titleArr[i];
        tscv.subTitleLabel.text = subTitleArr[i];
        [self.view addSubview:tscv];
    }
}
#pragma mark - 按键
- (void)cellBtnClick:(UIButton *)sender
{
//    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"当前缓存文件大小为%.1fM,确定要清理吗?",[self folderSizeAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0]]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    av.tag = 1;
//    [av show];
    
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"缓存文件大小为%.1fM,确定要清理吗?",[self folderSizeAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0]]] showCancelBtn:NO leftBtnText:@"取消" rightBtnText:@"确定"];
    [popView setCancelBlock:^{
        
    } withConfirmBlock:^{
        [self clearAllCaches];
    } withNoOperationBlock:^{
        
    }];
    
    [popView show];
}

- (void)clearAllCaches
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
                   });
}

#pragma mark - 警告框事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self clearAllCaches];
    }
}

#pragma mark - 扫描清理缓存文件
//计算单个文件的缓存
- (float)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (float )folderSizeAtPath:(NSString*)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

-(void)clearCacheSuccess
{
    [MBProgressHUD showSuccess:@"清理成功"];
}


#pragma mark - 开关
- (void)switchClick:(UISwitch *)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (sender.tag == 300&&sender.on) { //开启位置服务
        [ud setObject:@"YES" forKey:@"isPosition"];
    
    } else if (sender.tag == 300&&sender.on == NO) { //未开启位置服务
        [ud setObject:@"NO" forKey:@"isPosition"];
    }
    [ud synchronize];
}

- (void)rightBarButtonClick
{
    [self Message];
}

#pragma mark 聊天
-(void)Message
{
    //begin 赵官林 2016.5.26 跳转到消息列表
    [self presentChatList];
    //end
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
