//
//  SignCalendarViewController.m
//  YunShangShiJi
//
//  Created by hebo on 2019/9/23.
//  Copyright © 2019年 ios-1. All rights reserved.
//

#import "SignCalendarViewController.h"
#import "TaskSignModel.h"
#import "STCalendar.h"
#import "NSCalendar+ST.h"
#import "GlobalTool.h"
#import "MyMD5.h"
#define ScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
@interface SignCalendarViewController ()<STCalendarDelegate>
@property (nonatomic, weak, nullable)STCalendar *calender; //
@property (nonatomic, weak, nullable)UILabel *labelDate; //
@property (nonatomic, weak, nullable)UILabel *labelResult; //

@property ( nonatomic, weak, nullable) UIButton *buttonNext; //
@property ( nonatomic, weak, nullable) UIButton *buttonUp; //
@property ( nonatomic, weak, nullable) UIButton *buttonCurrent; //
@property (nonatomic , copy) NSString* clockin_start_date;
@property (nonatomic , copy) NSString* clockin_now_date;
@property (nonatomic , strong) NSMutableArray *clockin_list;
@end

@implementation SignCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth-20, ScreenWidth+50)];
    [backview setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.9]];
    backview.clipsToBounds = YES;
    backview.layer.cornerRadius = 10;
    [self.view addSubview:backview];
    
    UILabel *labelDate = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth-40, 44)];
    labelDate.textColor = tarbarrossred;
    [labelDate setTextAlignment:NSTextAlignmentCenter];
    [backview addSubview:labelDate];
    self.labelDate = labelDate;
    
    CGFloat weekwidth = (ScreenWidth-40)/7;
    NSArray *weekdata = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for(NSInteger i=0 ;i<7;i++){
        UILabel *labelweek = [[UILabel alloc]initWithFrame:CGRectMake(weekwidth*i+10, 50, weekwidth, 50)];
        labelweek.text = weekdata[i];
        [labelweek setTextAlignment:NSTextAlignmentCenter];
        [backview addSubview:labelweek];
    }
    
    CGFloat buttonW = (ScreenWidth-40) / 3;
    CGFloat buttonH = 44;
    CGFloat buttonX = 10;
    CGFloat buttonY = CGRectGetMinY(labelDate.frame);
    
    UIButton *buttonNext = [[UIButton alloc]initWithFrame:CGRectMake(buttonX + 2 * buttonW,
                                                                     buttonY,
                                                                     buttonW,
                                                                     buttonH)];
    
    [buttonNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonNext addTarget:self
                   action:@selector(nextMonth:)
         forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:buttonNext];
    
    CGFloat goimgwidth = 24*0.6;
    CGFloat goimgheigh = 34*0.6;
    UIImageView *rightimg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(buttonNext.frame)-goimgwidth-15, (CGRectGetHeight(buttonNext.frame)-goimgheigh)/2, goimgwidth, goimgheigh)];
    rightimg.image = [UIImage imageNamed:@"rilijiantou_right.png"];
    [buttonNext addSubview:rightimg];
    
    UIButton *buttonUp = [[UIButton alloc]initWithFrame:CGRectMake(buttonX,
                                                                   buttonY,
                                                                   buttonW,
                                                                   buttonH)];
    [buttonUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonUp addTarget:self
                 action:@selector(upMonth:)
       forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:buttonUp];
    
    UIImageView *lefeimg = [[UIImageView alloc]initWithFrame:CGRectMake(15, (CGRectGetHeight(buttonUp.frame)-goimgheigh)/2, goimgwidth, goimgheigh)];
    lefeimg.image = [UIImage imageNamed:@"rilijiantou_left.png"];
    [buttonUp addSubview:lefeimg];
    
    STCalendar *calender = [[STCalendar alloc]initWithFrame:CGRectMake(10,
                                                                       100,
                                                                       ScreenWidth-40,
                                                                       ScreenWidth-40)];
    
    [calender returnDate:^(NSString * _Nullable stringDate) {
        self.labelDate.text = stringDate;
    }];
    calender.delegate = self;
    [calender setTextSelectedColor:[UIColor greenColor]];
    [backview addSubview:calender];
    self.calender = calender;
    
    self.calender.year = [NSCalendar currentYear];
    self.calender.month = [NSCalendar currentMonth];
    self.labelDate.text = [NSString stringWithFormat:@"%zd年%zd月",self.calender.year,self.calender.month];
    
    
    [self getCurrentSign];
}

#pragma mark - event response 事件相应

- (void)nextMonth:(UIButton *)button
{
    ++self.calender.month;
    [self getCurrentSign];
}

- (void)upMonth:(UIButton *)button
{
    --self.calender.month;
    [self getCurrentSign];
}

- (void)getCurrentSign
{
    NSString *cur_month = self.calender.month <10?[NSString stringWithFormat:@"0%ld",self.calender.month]:[NSString stringWithFormat:@"%ld",self.calender.month];
    NSString *cur_year_month = [NSString stringWithFormat:@"%ld%@",self.calender.year,cur_month];
    [TaskSignModel clockInHttp:cur_year_month :^(id data) {
        TaskSignModel *model = data;
        if(model.status == 1){
            
            //测试用
//            self.clockin_start_date = @"1568209258000";
//            self.clockin_now_date = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]*1000];
//            self.clockin_list = [NSMutableArray arrayWithArray:@[@"11",@"15",@"16"]];
//            if(self.calender.month !=9)
//            {
//                self.clockin_list =  [NSMutableArray arrayWithArray:@[]];
//            }
//            self.calender.lockIn_startdate = [MyMD5 timeInfoWithDateTimeInterval:[self.clockin_start_date longLongValue]];
//            self.calender.lockIn_nowdate = [MyMD5 timeInfoWithDateTimeInterval:[self.clockin_now_date longLongValue]];
//            self.calender.lockIn_list = [NSMutableArray arrayWithArray:self.clockin_list];
            
            
            if(model.data[@"clock_in_start_date"] != nil)
            {
                self.clockin_start_date = model.data[@"clock_in_start_date"];
                self.calender.lockIn_startdate = [MyMD5 timeInfoWithDateTimeInterval:[self.clockin_start_date longLongValue]];
            }
            if(model.data[@"list"] != nil)
            {
                self.clockin_list = [NSMutableArray arrayWithArray:model.data[@"list"]];
                self.calender.lockIn_list = [NSMutableArray arrayWithArray:self.clockin_list];
            }
            self.clockin_now_date = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]*1000];
            self.calender.lockIn_nowdate = [MyMD5 timeInfoWithDateTimeInterval:[self.clockin_now_date longLongValue]];
            [self.calender reloadData];
        }
    }];
}


- (NSMutableArray*)clockin_list{
    if(_clockin_list == nil)
    {
        _clockin_list = [NSMutableArray array];
    }
    return _clockin_list;
}
@end
