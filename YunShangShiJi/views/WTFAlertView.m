//
//  WTFAlertView.m
//  YunShangShiJi
//
//  Created by yssj on 16/5/18.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "WTFAlertView.h"
#import "WTFAlertViewCell.h"
#import "GlobalTool.h"
#import "MyMD5.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBounds [UIScreen mainScreen].bounds
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define SN ([UIScreen mainScreen].bounds.size.width)/(1080)
#define ZOOM(px) (((px)*(SN)))

#define cellHeight ZOOM(120)

const CGFloat kAlertAnimationDuration = 0.15;

@interface WTFAlertView()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIImageView *backImgView;
@property(nonatomic,strong)UIButton *closeBtn;

@end

@implementation WTFAlertView

+(id)GlodeBottomView{
    return [self new];
}

- (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[MyTabBarController class]]) {
        result = [(MyTabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    MyLog(@"%@",NSStringFromClass([result class]));

    return result;
}
-(void)show{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([NSStringFromClass([[self presentingVC]class])isEqualToString:@"TFShoppingViewController"]) {
            UIWindow *current = [UIApplication sharedApplication].keyWindow;
            self.backgroundColor = RGBA(0, 0, 0, 0.5);
            [current addSubview:self];
            
            [UIView animateWithDuration:kAlertAnimationDuration animations:^{
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                self.backView.frame = CGRectMake(ZOOM(100), 0, ScreenWidth-ZOOM(200), ScreenHeight);
            }];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@%@", [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID]?:@"", [MyMD5 getCurrTimeString:@"year-month-day"]] forKey:RedCash];
        }
    });
}

#pragma mark - 懒加载
-(UIView*)backView{
    if (_backView == nil) {
        self.backView = [UIView new];
        [self addSubview:_backView];
    }
    return _backView;
}
-(UIImageView *)backImgView
{
    if (_backImgView==nil) {
        self.backImgView=[UIImageView new];
        _backImgView.image=[UIImage imageNamed:self.titleArray.count>3?@"80元_弹出框@3x":@"30元_弹出框@3x"];
        _backImgView.userInteractionEnabled=YES;
        _backImgView.contentMode=UIViewContentModeScaleAspectFit;
        [self.backView addSubview:_backImgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isLoginBlock)];
        [_backImgView addGestureRecognizer:tap];
    }
    return _backImgView;
}
-(UIButton *)closeBtn
{
    if (_closeBtn==nil) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"红包_关闭"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(BT:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.backView addSubview:_closeBtn];
    }
    return _closeBtn;
}

- (void)isLoginBlock {
    if (self.toLoginBlock) {
        self.toLoginBlock();
        [self dissMIssView];
    }
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    CGFloat tableViewHeight=4 * ZOOM(120);

    self.backView.frame = CGRectMake(ZOOM(100), -ScreenHeight -  tableViewHeight, ScreenWidth-ZOOM(200), ScreenHeight);
    self.backImgView.frame=CGRectMake(0, (ScreenHeight -  tableViewHeight)/2-ZOOM(200), ScreenWidth-ZOOM(200), ZOOM(150)*4+ZOOM(400));
    self.closeBtn.frame=CGRectMake(CGRectGetWidth(_backImgView.frame)-ZOOM(100),CGRectGetMinY(_backImgView.frame)-ZOOM(50), ZOOM(100), ZOOM(100));
    self.tableView.frame = CGRectMake(ZOOM(160),CGRectGetHeight(_backImgView.frame)-tableViewHeight-ZOOM(110), CGRectGetWidth(_backImgView.frame)-ZOOM(320), tableViewHeight-ZOOM(20));
    
    _tableView.backgroundColor=[UIColor clearColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self dissMIssView];
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    self.frame = ScreenBounds;
    [self setUpCellSeparatorInset];
}
- (void)setUpCellSeparatorInset
{
    //    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
    //        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    //    }
    //    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
    //        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    //    }
}

-(void)dissMIssView{
    [UIView animateWithDuration:kAlertAnimationDuration animations:^{
        [UIView setAnimationCurve:(UIViewAnimationCurveEaseIn)];
        self.alpha=0;
        self.backView.frame = CGRectMake(ZOOM(100), ScreenHeight, ScreenWidth-ZOOM(200), ScreenHeight);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma UITableView-delegate

-(UITableView*)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(ZOOM(100), 0, ScreenWidth-ZOOM(200), ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//        _tableView.bounces=NO;
        [_tableView registerClass:[WTFAlertViewCell class] forCellReuseIdentifier:@"cell"];
        [self.backImgView addSubview:_tableView];
    }
    return _tableView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WTFAlertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    [cell setDataSource:_titleArray[indexPath.row]];
    

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.titleArray.count>3? ZOOM(130):ZOOM(150);
}
/*
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 0, ScreenWidth-100, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:view];
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2-100, 40, 100, 30)];
    [bt setTitle:@"确定" forState:(UIControlStateNormal)];
    [bt setTitleColor:RGB(83, 83, 83) forState:(UIControlStateNormal)];
    [bt addTarget:self action:@selector(BT:) forControlEvents:(UIControlEventTouchUpInside)];
    bt.layer.borderColor = RGB(83, 83, 83).CGColor;
    bt.layer.masksToBounds = YES;
    bt.layer.cornerRadius = 4;
    [bt.layer setBorderWidth:1.0];
    
    [view addSubview:bt];
    return view;
}
*/
-(void)BT:(UIButton*)bt{
    [self dissMIssView];
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
//        [self.delegate clickButton:indexPath.row];
//    }
//    if (self.GlodeBottomView) {
//        self.GlodeBottomView(indexPath.row,self.titleArray[indexPath.row]);
//    }
//    [self dissMIssView];
//}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//    }
//}


@end

