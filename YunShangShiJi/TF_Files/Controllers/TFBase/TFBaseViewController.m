//
//  TFBaseViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/1.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFBaseViewController.h"
//
//手机号的正则表达
//#define Regular_phone @"1([3|5|8|7][0-9])\\d{8}"
//#define Regular_phone @"^\\d{11}$"
//邮编的正则表达式
//#define Regular_post @"^[0-9]\\d{5}$"
//密码正则表达式
//#define Regular_loginPwd @"^[A-Za-z0-9]+$"
//邮箱
//#define Regular_email @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

NSString *const Regular_phone = @"^\\d{11}$";
NSString *const Regular_post = @"^[0-9]\\d{5}$";
NSString *const Regular_loginPwd = @"^[A-Za-z0-9]+$";
NSString *const Regular_email = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

@interface TFBaseViewController ()

@end

@implementation TFBaseViewController

- (void)dealloc
{
//    printf("obj retain count = %ld\n",CFGetRetainCount((__bridge CFTypeRef)(self)));
    MyLog(@"%@ release", [self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MyLog(@"%@", [self class]);

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)setNavigationItemLeft:(NSString *)title
{

    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview: _navigationView = headview];
    
    self.navigationView.backgroundColor = [UIColor whiteColor];
    
    headview.userInteractionEnabled=YES;

    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(46, 0, headview.frame.size.width-46*2, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= title;
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment= NSTextAlignmentCenter;
    [headview addSubview:titlelable];
}

- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavigationItemLeftAndRight:(NSString *)title;
{

    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview: _navigationView = headview];
    headview.userInteractionEnabled=YES;

    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 46, 46);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:backbtn];
  
    UIButton *setbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    setbtn.frame=CGRectMake(kScreenWidth-80, 20, 80, 44);
    setbtn.centerY = View_CenterY(headview);
    [setbtn addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [setbtn setImage:[UIImage imageNamed:@"消息按钮_正常"] forState:UIControlStateNormal];
//    [setbtn setImage:[UIImage imageNamed:@"消息按钮_高亮"] forState:UIControlStateHighlighted];
    
    [headview addSubview:setbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, headview.frame.size.width, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= title;
    titlelable.font = kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
    
}

- (void)rightBarButtonClick
{

}


- (BOOL)isString:(NSString *)Sstring toCompString:(NSString *)CompString
{
    if (Sstring.length!=0) {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CompString] invertedSet];
        NSArray *arrayStr = [Sstring componentsSeparatedByCharactersInSet:cs];
        
        NSString *tmpStr = [arrayStr componentsJoinedByString:@""];
       
        BOOL bl = [Sstring isEqualToString:tmpStr];
        return bl;
    } else
        return NO;
}


- (BOOL)validateMobile:(NSString *)mobile
{
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regular_phone];
    return [phoneTest evaluateWithObject:mobile];
}


- (BOOL)validateEmail:(NSString *)email
{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regular_email];
    return [emailTest evaluateWithObject:email];
}

//^[A-Za-z0-9]+$

- (BOOL)validatePassword:(NSString *)password
{
    NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regular_loginPwd];
    return [passTest evaluateWithObject:password];
}

- (BOOL)validatePostCode:(NSString *)postCode
{
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regular_post];
    return [codeTest evaluateWithObject:postCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)TFNSDictionaryOfVariableBindings:(NSArray *)strArr
{
    NSMutableDictionary *muDic = [[NSMutableDictionary alloc] init];
    for (NSString *s in strArr) {
        NSString *tmpStr = [s substringWithRange:NSMakeRange(1, s.length-1)];
        NSNumber *fnum = [NSNumber numberWithFloat:([tmpStr floatValue])];
        [muDic setValue:fnum forKey:s];
    }
    return muDic;
}

- (void)createBackgroundView:(UIView *)view andTag:(NSInteger)tag andFrame:(CGRect)frame withImgge:(UIImage *)img andText:(NSString *)text
{
    TFBackgroundView *tb = [[[NSBundle mainBundle] loadNibNamed:@"TFBackgroundView" owner:self options:nil] lastObject];
    tb.frame = frame;
    tb.tag = tag;
    tb.backgroundColor = [UIColor clearColor];
//    tb.backgroundColor = [UIColor yellowColor];
    if (img != nil) {
        tb.headImageView.image = img;
    } else {
        tb.headImageView.image = [UIImage imageNamed:@"笑脸21"];
    }
    if (text != nil) {
        tb.textLabel.text = text;
    } else {
        tb.textLabel.text = @"亲,暂时没有相关数据哦";
    }
    for (UIView *vv in view.subviews) {
//        //vv = %@", vv);
        if ([vv isKindOfClass:[TFBackgroundView class]] && vv.tag == tag) {
//            //置前");
            [view bringSubviewToFront:vv];
            return;
        }
    }
//    //重建");
    [view addSubview:tb];
    [view bringSubviewToFront:tb];
}
- (void)clearBackgroundView:(UIView *)view withTag:(NSInteger)tag
{
    TFBackgroundView *tb = (TFBackgroundView *)[view viewWithTag:tag];
    [tb removeFromSuperview];
}

- (void)createAnimation
{
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    animationView.backgroundColor = [UIColor clearColor];
    //    animationView.alpha = 0;
    animationView.tag = 777;
    [self.view addSubview:animationView];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    iv.center = CGPointMake(animationView.center.x, animationView.frame.size.height*0.4);
    iv.tag = 778;
    [animationView addSubview:iv];
    
    NSMutableArray *anArr = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i<20; i++) {
        NSString *gStr = [NSString stringWithFormat:@"%d",i+1];
        NSString *file = [[NSBundle mainBundle] pathForResource:gStr ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        if(image)
        {
            [anArr addObject:image];
        }
        
    }
    iv.animationImages = anArr;
    iv.animationDuration = 2;
    iv.animationRepeatCount = 0;  
    [iv startAnimating];
}

- (void)stopAnimation
{
    UIView *view = (UIView *)[self.view viewWithTag:777];
    UIImageView *iv = (UIImageView *)[view viewWithTag:778];
    [iv stopAnimating];
    [view removeFromSuperview];
}


- (NSString *)getCurrTimeString:(NSString *)type
{
    NSDate *curDate = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *showCurDate = [formatter stringFromDate:curDate];
    
    if ([type isEqualToString:@"year"]) {
        return [showCurDate substringToIndex:4];
    } else if ([type isEqualToString:@"month"]) {
        return [showCurDate substringWithRange:NSMakeRange(5, 2)];
    } else if ([type isEqualToString:@"day"]) {
        return [showCurDate substringWithRange:NSMakeRange(8, 2)];
    } else if ([type isEqualToString:@"hour"]) {
        return [showCurDate substringWithRange:NSMakeRange(11, 2)];
    } else if ([type isEqualToString:@"min"]) {
        return [showCurDate substringWithRange:NSMakeRange(14, 2)];
    } else if ([type isEqualToString:@"sec"]) {
        return [showCurDate substringWithRange:NSMakeRange(17, 2)];
    } else if ([type isEqualToString:@"year-month-day"]) {
        return [showCurDate substringToIndex:10];
    } else if ([type isEqualToString:@"year-month"]) {
        return [showCurDate substringToIndex:7];
    } else if ([type isEqualToString:@"month-day"]) {
        return [showCurDate substringWithRange:NSMakeRange(5, 5)];
    } else if ([type isEqualToString:@"hour-min-sec"]) {
        return [showCurDate substringWithRange:NSMakeRange(11, 8)];
    } else if ([type isEqualToString:@"hour-min"]) {
        return [showCurDate substringWithRange:NSMakeRange(11, 5)];
    } else if ([type isEqualToString:@"min-sec"]) {
        return [showCurDate substringWithRange:NSMakeRange(14, 5)];
    } else if ([type isEqualToString:@"week"]) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        
        comps = [calendar components:unitFlags fromDate:curDate];
        NSInteger week = [comps weekday];
        return [NSString stringWithFormat:@"%d",(int)week-1];
    }
    return showCurDate;
}

- (NavgationbarView *)showMessage
{
    if (!_showMessage)  {
        _showMessage = [[NavgationbarView alloc] init];
    }
    return _showMessage;
}


@end
