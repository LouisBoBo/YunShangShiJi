//
//  TFFeedBackViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/7/3.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFFeedBackViewController.h"
//#import "ChatListViewController.h"

@interface TFFeedBackViewController () <UITextViewDelegate>

{
    BOOL isFirstEdit;
    
    UITextView *_textView;
    
    NSString *_version_no;
}

@end

@implementation TFFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeft:@"意见反馈"];
    
    [self createUI];
}
#pragma mark - 创建UI

- (void)createUI
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    bgView.tag = 200;
    bgView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    [self.view addSubview:bgView];
    
    
    CGFloat lr_Margin = ZOOM(62);
    
    CGFloat ud_Margin = ZOOM(150);
    
    NSString *str = [NSString stringWithFormat:@"亲，您遇到什么系统问题啦，或有什么功能建议吗？欢迎提供给我们，谢谢！"];
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(lr_Margin, ZOOM(60), bgView.frame.size.width-2*lr_Margin, ZOOM(300))];
    _textView.tag = 201;
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = ZOOM(15);
    _textView.layer.borderColor = [RGBCOLOR_I(220,220,220) CGColor];
    _textView.layer.borderWidth = ZOOM(3);
    _textView.font = [UIFont systemFontOfSize:ZOOM(40)];
    _textView.delegate = self;
    _textView.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.4];
    _textView.text = str;
    _textView.scrollEnabled = YES;
    [bgView addSubview:_textView];
    
    
    CGFloat btn_H = ZOOM(120);
    
    //发表
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(_textView.frame.origin.x,  _textView.bottom+ud_Margin, _textView.frame.size.width, btn_H);
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框"] forState:UIControlStateNormal];
    btn.titleLabel.font = kFont6px(32);
    [btn setBackgroundImage:[UIImage imageNamed:@"退出账号框高亮"] forState:UIControlStateHighlighted];
    [btn setTitle:@"发表" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];

}

- (void)commitBtnClick
{
    if (_textView.text.length!=0&&isFirstEdit) {
        
        BOOL result= [MyMD5 stringContainsEmoji:_textView.text];
        if(result == YES)
        {
            [MBProgressHUD showError:@"不能使用表情符号!"];
        }else{
            [self httpCommit];
        }
        
    } else if (_textView.text.length==0) {
        [MBProgressHUD showError:@"意见不能为空!"];
    } else if (_textView.text.length!=0&&isFirstEdit == NO) {
        [MBProgressHUD showError:@"请填写意见!"];
    }
}

#pragma mark - 网络发表评论
- (void)httpCommit
{
    //要获取版本号
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paraments=[NSMutableDictionary dictionary];
    NSString *url=[NSString stringWithFormat:@"%@getVersion?version=%@&type=2",[NSObject baseURLStr],VERSION];
    NSString *URL=[MyMD5 authkey:url];
    
    [[Animation shareAnimation] createAnimationAt:self.view];
    
    [manager POST:URL parameters:paraments success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view];
//        responseObject = [NSDictionary changeType:responseObject];
        [[Animation shareAnimation] stopAnimationAt:self.view];
        
        MyLog(@"responseObject = %@",responseObject);
        
        NSUserDefaults *userdefaul = [NSUserDefaults standardUserDefaults];
        NSString *token = [userdefaul objectForKey:USER_TOKEN];
        
        
        if (responseObject!=nil) {
            if ([responseObject[@"status"] intValue] == 1) {
                _version_no = [NSString stringWithFormat:@"%@",responseObject[@"version_no"]];
                //进行提交
                NSString *urlStr;
                if([_version_no isEqualToString:@"<null>"]) //版本号为空
                {
                    //进行提交
                    urlStr = [NSString stringWithFormat:@"%@user/addUserFeedBackInfo?version=%@&content=%@&version_no=%@&token=%@",[NSObject baseURLStr],VERSION,_textView.text,nil,token];
                    
                } else{ // 存在版本号
                    
                    urlStr = [NSString stringWithFormat:@"%@user/addUserFeedBackInfo?version=%@&content=%@&version_no=%@&token=%@",[NSObject baseURLStr],VERSION,_textView.text,_version_no,token];
                }
                
                NSString *URL = [MyMD5 authkey:urlStr];
                
                [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                    responseObject = [NSDictionary changeType:responseObject];
                    if ([responseObject[@"status"] intValue] == 1) {
                        [MBProgressHUD showSuccess:@"提交成功,谢谢反馈"];
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        [MBProgressHUD showError:responseObject[@"message"]];
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                    [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
                    
                    NavgationbarView *mentionview=[[NavgationbarView alloc]init];
                    [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
                }];
            }

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
        
        NavgationbarView *mentionview=[[NavgationbarView alloc]init];
        [mentionview showLable:@"网络开小差啦,请检查网络" Controller:self];
    }];
    
}


#pragma mark - textView的代理方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (isFirstEdit == NO&&[textView.text isEqualToString:@"亲，您遇到什么系统问题啦，或有什么功能建议吗？欢迎提供给我们，谢谢！"]) {
        isFirstEdit = YES;
        _textView.text = @"";
        _textView.textColor = [UIColor blackColor];
        return YES;
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *view = (UIView *)[self.view viewWithTag:200];
    [view endEditing:YES];
}

- (void)rightBarButtonClick
{
    [self message];
}
- (void)message
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
