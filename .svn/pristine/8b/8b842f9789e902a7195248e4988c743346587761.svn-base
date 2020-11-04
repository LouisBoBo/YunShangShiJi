//
//  TFHotQuestionViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/17.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFHotQuestionViewController.h"

@interface TFHotQuestionViewController ()

@end

@implementation TFHotQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:self.titleStr];
    
    [self createUI];
}

- (void)createUI
{
    NSString *title = self.model.question;
    CGSize size = [title boundingRectWithSize:CGSizeMake((kScreenWidth-ZOOM(60)*2), (300)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(50)]} context:nil].size;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7+(5), kScreenWidth, size.height+2*ZOOM(35))];
    bgView.tag = 200;
    bgView.backgroundColor = RGBCOLOR_I(244,244,244);
    [self.view addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(60), ZOOM(35), size.width, size.height)];
    titleLabel.numberOfLines = 0;
//    titleLabel.tag = 200;
    titleLabel.font = [UIFont systemFontOfSize:ZOOM(50)];
//    titleLabel.backgroundColor = [UIColor yellowColor];
    titleLabel.text = self.model.question;
    [bgView addSubview:titleLabel];
    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((20),  titleLabel]+(10), kScreenWidth-2*(20), (100))];
    
//    [self httpGetAnswer];
    
    [self createAnswer:_model.answer];
}

- (void)createAnswer:(NSString *)string
{
    UIView *titleLabel = (UIView *)[self.view viewWithTag:200];
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  titleLabel.bottom, kScreenWidth, kScreenHeight- titleLabel.bottom)];
    
    [self.view addSubview:bgScrollView];

    NSString *tmpStr = [NSString stringWithFormat:@"%@",string];
    
    NSArray *stArr = [tmpStr componentsSeparatedByString:@"\\n"];
    
    CGFloat H = 0;
    CGFloat HH = 0;
    CGFloat Margin = ZOOM(34);
    
//    if (stArr.count>1) {
        for (int i = 0; i<stArr.count; i++) {
            CGFloat Y = 0;
            
            NSString *st = stArr[i];
            
//            //i = %d, st = %@", i ,st);
        
            if (i == 0) {
                Y = ZOOM(60);
            } else {
                UILabel *label = (UILabel *)[bgScrollView viewWithTag:500+i-1];
                
                Y =  label.bottom+ZOOM(34);
            }
            
            
//            CGFloat Y = HH+ZOOM(60)+i*Margin;

            CGSize size = [st boundingRectWithSize:CGSizeMake(kScreenWidth-ZOOM(60)*2, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]} context:nil].size;
            
//            //Y = %f, size.height = %f", Y,size.height);
            
            UILabel  *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(60), Y, size.width, size.height)];
            answerLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
            answerLabel.tag = 500+i;
            answerLabel.numberOfLines = 0;
            
            [bgScrollView addSubview:answerLabel];

            
            NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:st];
            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:5];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [st length])];
            [answerLabel setAttributedText:attributedString];
            [answerLabel sizeToFit];
//            answerLabel.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
            
            HH = HH+answerLabel.height;
            
//            //HH = %f" ,HH);
            
        }
        H = HH+stArr.count*Margin;
        bgScrollView.contentSize = CGSizeMake(kScreenWidth, H +ZOOM(60)*2);
//        bgScrollView.backgroundColor = [UIColor yellowColor];

//    } else {
//    
//    
//    
////    CGSize size = [tmpStr boundingRectWithSize:CGSizeMake(kScreenWidth-ZOOM(60)*2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]} context:nil].size;
//
//
//    
//    /**
//     *  更改后
//     *
//     *  @return
//     */
//    
//    CGSize size = [tmpStr boundingRectWithSize:CGSizeMake(kScreenWidth-ZOOM(60)*2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)]} context:nil].size;
//
//    UILabel  *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(ZOOM(60), ZOOM(60), size.width, size.height)];
////    answerLabel.text = tmpStr;
//    answerLabel.font = [UIFont systemFontOfSize:ZOOM(46)];
//    answerLabel.numberOfLines = 0;
//    [bgScrollView addSubview:answerLabel];
//    
//    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:tmpStr];
//    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:5];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tmpStr length])];
//    answerLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    [answerLabel setAttributedText:attributedString];
//    [answerLabel sizeToFit];
//
//    }
}

#pragma mark - 获取回答
- (void)httpGetAnswer
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *ID = [NSString stringWithFormat:@"%@",self.model.ID];
    NSString *urlStr = [NSString stringWithFormat:@"%@/help/questionOne?id=%@&version=%@&token=%@",[NSObject baseURLStr],ID,VERSION,token];
    NSString *URL = [MyMD5 authkey:urlStr];
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                [self createAnswer:[responseObject[@"question"] objectForKey:@"answer"]];
            } else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
        
    }];
    
}

- (void)leftBarButtonClick
{
    if([_typestring isEqualToString:@"聊天"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
