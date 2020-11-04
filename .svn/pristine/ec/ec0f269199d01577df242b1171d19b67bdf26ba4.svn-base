//
//  TFSafetyTipsDetailViewController.m
//  YunShangShiJi
//
//  Created by 云商 on 15/8/3.
//  Copyright (c) 2015年 ios-1. All rights reserved.
//

#import "TFSafetyTipsDetailViewController.h"

@interface TFSafetyTipsDetailViewController () <UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong)UIScrollView *bgScrollView;

@end

@implementation TFSafetyTipsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super setNavigationItemLeft:@"安全贴士"];
    
    
    [self createWebView];
    
    
}

- (void)createWebView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, kScreenHeight-kNavigationheightForIOS7)];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.webView];
    
    NSURL *url;
    if (self.index == 0) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@view/other/howtoImportSafe.html",[NSObject baseURLStr_H5]]];
    } else if (self.index == 1) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@view/other/phoneUpdate.html",[NSObject baseURLStr_H5]]];
    } else if (self.index == 2) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@view/other/howToSetPwd.html",[NSObject baseURLStr_H5]]];
    } else if (self.index == 3) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@view/other/howTofintPwd.html",[NSObject baseURLStr_H5]]];
    } else if (self.index == 4) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@view/other/accountSafeInfo.html",[NSObject baseURLStr_H5]]];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
//    //创建UIActivityIndicatorView背底半透明View
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth , kScreenHeight-kNavigationheightForIOS7)];
//    [view setTag:108];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [view setAlpha:0.2];
//    [self.view addSubview:view];
//    
//    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    [self.activityIndicator setCenter:view.center];
//    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [view addSubview:self.activityIndicator];
//    
//    [self.activityIndicator startAnimating];
    [self createAnimation];
    
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
//    [self.activityIndicator stopAnimating];
//    UIView *view = (UIView*)[self.view viewWithTag:108];
//    [view removeFromSuperview];
//    //webViewDidFinishLoad");
    [self stopAnimation];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //加载失败");
}

- (void)createUI
{
    NSArray *textArr;
    if (self.index == 0) {
        textArr = @[@"1. 为了保证您的衣蝠账户安全，您可以在“设置-账号与安全-登陆密码”中定期修改密码，绑定手机等方式提升账户安全系数，保障账户安全。",
                    @"2. 在陌生的电脑（如：网吧等）上登陆时最好不要直接输入密码，怕陌生电脑上有木马程序，请时刻保持警惕。上网之后最好清理一下上网记录。如果是在自己电脑上不建议使用记住密码，不要为了每次输入密码而感到烦恼，还是多动动手，安全最重要！",
                    @"3. 定时进行系统及杀毒软件的升级，经常性的对电脑进行系统更新。把系统补丁补齐，装防火墙和杀毒软件。杀毒软件要做到定期升级查毒，发现病毒及时处理，保证电脑上网的安全性。",
                    @"4. 对陌生人发来的网站链接，请不要随意点击或输入账号信息。一旦进入极有可能中毒。即使是你认识的卖家或者买家，也不要轻易点击。"];
    } else if (self.index == 1) {
        textArr = @[@"1. 绑定手机：您可以登录衣蝠账户，通过“设置-账户与安全-手机绑定“进行绑定。用户直接填写手机号（手机号务必保证有效），点击发送验证码，接收到验证码后，正确回填，即可绑定手机。",
                    @"2. 更换已绑定手机：您可以登录衣蝠账户，通过”设置-账户与安全-手机绑定“进行绑定。用户需要输入原手机号进行验证，原绑定手机验证完成后，直接填写新手机号，（请务必保证手机号有效），正确回填验证码即可完成新手机号的绑定。若因手机号丢失或其它原因造成的无法进行验证，请联系衣蝠客服。",];
    } else if (self.index == 2) {
        textArr = @[@"1. 密码长度为6-20个字符。",
                    @"2. 设置时使用英文字母、数字和符合的组合，切记不要使用全英文或者全数字、尽量不要有规律。",
                    @"3. 使用自己能够记住的短语的缩写，尽量包含数字和符号。",
                    @"4. 不要单独使用您的个人信息作为密码的内容。如手机号、邮箱地址、生日、身份证号码、亲人或者伴侣的姓名、宿舍号等等。",
                    @"5. 登录密码和支付密码设置为不同的密码，以免一个账户被盗造成其它账户同时被盗。",
                    @"6. 重要账户（常用邮箱、网上交易及钱包支付）的密码请不要与其它网络账号密码一致，尽量做到区分。",
                    @"7. 定期修改密码，以确保的安全性，例如每隔3个月改一次"];
    } else if (self.index == 3) {
        textArr = @[@"1. 当您因密码不正确而导致衣蝠账号不能登录，您可以通过点击登录口处“忘记密码”进行找回，并重新登录。您可以通过手机或邮箱进行找回。",
                    @"2. 手机找回密码：进入找回密码，填写您的平台绑定的手机号-回填手机验证码-重置登录密码-完成密码重置，完成后进行重新登录即可"];
    } else if (self.index == 4) {
        textArr = @[@"1. 衣蝠安全中心为您提供了最近的20条登录信息，包括登录设备、登录行为、登录地区及登录时间、你可以随时进行查看，如发现异常的信息，请及时检查账号的安全性或进行密码的修改，如出现不在经常登录地点即异地登录情况，出现未使用过的设备类型等。"];
    }
    
    //创建UI
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kNavigationheightForIOS7, kScreenWidth, 40)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((20), (view.frame.size.height-(30))/2.0, kScreenWidth-(20), (30))];
    titleLabel.font = [UIFont systemFontOfSize:(17)];
    titleLabel.text = self.title;
    [view addSubview:titleLabel];
    [self.view addSubview:view];
    
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  view.bottom, kScreenWidth, kScreenHeight- view.bottom)];
    //    self.bgScrollView.backgroundColor = COLOR_ROSERED;
    [self.view addSubview:self.bgScrollView];
    
    NSMutableArray *hArr = [[NSMutableArray alloc] init]; //存储高度
    CGFloat H = 0;
    for (NSString *text in textArr) {
        //        //text = %@",text);
        CGFloat h = [self calTextHeight:text];
        H = H+h;
        [hArr addObject:[NSNumber numberWithFloat:h]];
    }
    self.bgScrollView.contentSize = CGSizeMake(kScreenWidth, H);
    CGFloat tH = 0;
    for (int i = 0; i<textArr.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, tH, kScreenWidth, [hArr[i] floatValue])];
        tH = tH+view.frame.size.height;
        [self.bgScrollView addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((20), (20), view.frame.size.width-(20)*2, view.frame.size.height-(20)*2)];
        label.font = [UIFont systemFontOfSize:(15)];
        label.text = textArr[i];
        label.numberOfLines = 0;
        [view addSubview:label];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height-1, view.frame.size.width, 1)];
        lineView.backgroundColor = RGBACOLOR_F(0.5,0.5,0.5,0.4);
        [view addSubview:lineView];
    }

}

- (CGFloat)calTextHeight:(NSString *)text
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(kScreenWidth-(20)*2, (1000)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:(15)]} context:nil].size;
    
    return size.height+(20)*2+(10);
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
