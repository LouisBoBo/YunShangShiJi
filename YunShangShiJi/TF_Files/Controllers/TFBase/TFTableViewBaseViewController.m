//
//  TFTableViewBaseViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/2.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFTableViewBaseViewController.h"

@interface TFTableViewBaseViewController ()

@end

@implementation TFTableViewBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MyLog(@"%@",NSStringFromClass([self class]));
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Myview.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    Myview.hidden=NO;
}

#pragma mark - 导航设置
- (void)setNavigationItemLeft:(NSString *)title
{
    //导航条
    UIImageView *headview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    headview.image=[UIImage imageNamed:@"导航背景"];
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(headview);
    [backbtn addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
//    [backbtn setImage:[UIImage imageNamed:@"返回按钮_高亮"] forState:UIControlStateHighlighted];
    
    [headview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 120, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= title;
    titlelable.font = [UIFont systemFontOfSize:18];
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
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
    [self.view addSubview:headview];
    headview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
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
    [setbtn setImage:[UIImage imageNamed:@"消息按钮_高亮"] forState:UIControlStateHighlighted];
    [headview addSubview:setbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 120, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, headview.frame.size.height/2+10);
    titlelable.text= title;
    titlelable.font = [UIFont systemFontOfSize:18];
    titlelable.textColor=[UIColor blackColor];
    titlelable.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:titlelable];
}

- (void)rightBarButtonClick
{
    MyLog(@"%s",__func__);
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

- (BOOL)validatePassword:(NSString *)password
{
    NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regular_loginPwd];
    return [passTest evaluateWithObject:password];
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

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createBackgroundView:(UIView *)view andTag:(NSInteger)tag andFrame:(CGRect)frame withImgge:(UIImage *)img andText:(NSString *)text
{
    TFBackgroundView *tb = [[[NSBundle mainBundle] loadNibNamed:@"TFBackgroundView" owner:self options:nil] lastObject];
    //tb = %@",tb);
    
    tb.frame = frame;
    tb.tag = tag;
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
        if ([vv isKindOfClass:[TFBackgroundView class]] && tag == view.tag) {
            [view bringSubviewToFront:vv];
            return;
        }
    }
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
        [anArr addObject:image];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
