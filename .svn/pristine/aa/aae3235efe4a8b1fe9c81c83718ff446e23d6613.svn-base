//
//  YFChatViewController.m
//  YunShangShiJi
//
//  Created by zgl on 16/5/25.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YFChatViewController.h"
#import "ShopDetailModel.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "GlobalTool.h"
#import "ShopLinkModel.h"
#import "MBProgressHUD+NJ.h"
#import "NavgationbarView.h"
#import "SRRefreshView.h"
#import "YFTestChatViewController.h"

#define ShopHeight 85
@interface YFChatViewController ()<SRRefreshDelegate>

@property (nonatomic, copy) NSString *link; // 商品链接
@property (nonatomic, strong) SRRefreshView *slimeView; // 下拉加载（水滴效果）

@end

@implementation YFChatViewController

- (void)dealloc {
    NSLog(@"%@,释放了",[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self barBackButton];
    if (_model) {
        // 创建商品视图
        [self creatShopDetailView];
        // 调整聊天界面frame
        CGRect fram = self.conversationMessageCollectionView.frame;
        fram.origin.y += ShopHeight + 10;
        fram.size.height -= ShopHeight + 10;
        self.conversationMessageCollectionView.frame = fram;
        
        // 导航栏 消息列表按钮
        UIButton *setting=[UIButton buttonWithType:UIButtonTypeCustom];
        setting.frame = CGRectMake(kScreenWidth-80, 20, 80, 44 );
        setting.centerY = Height_NavBar/2+10;
        [setting setImage:[UIImage imageNamed:@"消息按钮_正常"] forState:UIControlStateNormal];
        [setting setImage:[UIImage imageNamed:@"消息按钮_高亮"] forState:UIControlStateHighlighted];
        [setting addTarget:self action:@selector(presentChatList) forControlEvents:UIControlEventTouchUpInside];
        [setting setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setting];
    }
    
    // 下拉刷新
    [self.conversationMessageCollectionView addSubview:self.slimeView];
    [UIViewController loginRongCloub];
}

#pragma mark - 创建视图
/// 商品视图
-(void)creatShopDetailView {
    UIView *shopDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar + 10, kApplicationWidth, ShopHeight)];
    shopDetailView.backgroundColor = [UIColor whiteColor];
    
    UIImageView  *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, -5, 70*0.8, 70*900/600*0.8)];
    
    NSString *newimage = nil;
    if(_model.def_pic)
    {
        NSMutableString *code = [NSMutableString stringWithString:_model.shop_code];
        NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
        NSLog(@"supcode =%@",supcode);
        newimage = [NSString stringWithFormat:@"%@/%@/%@",supcode,_model.shop_code,_model.def_pic];
        NSLog(@"newurl = %@",newimage);
    }
    
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],newimage]];
    
    if([self.detailtype isEqualToString:@"0元购"])
    {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],_model.def_pic]];
    }else if ([self.detailtype isEqualToString:@"会员商品"])
    {
        imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],self.imageurl]];
        _model.shop_se_price = @"98.00";
    }
    
    [headImg sd_setImageWithURL:imgUrl placeholderImage:nil];
    [shopDetailView addSubview:headImg];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(headImg.frame.origin.x+headImg.frame.size.width+ZOOM(49), 0, kApplicationWidth - 120,20)];
    
    if(_model.p_type)
    {
        title.text = _model.shop_name;
        
    }else{
        title.text = [NSString stringWithFormat:@"%@",[self exchangeTextWihtString:_model.shop_name]] ;
        
    }
    
    title.font = [UIFont systemFontOfSize:ZOOM(46)];
    title.textColor = kTitleColor;
    [shopDetailView addSubview:title];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+25, title.frame.size.width, 20)];
    price.textColor = tarbarrossred;
    price.font = [UIFont systemFontOfSize:ZOOM(40)];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%.1f   返现:%.1f元",[_model.shop_se_price floatValue],[_model.kickback floatValue]]];
    if([self.detailtype isEqualToString:@"会员商品"] || [self.detailtype isEqualToString:@"0元购"])
    {
        noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%.2f  ",[_model.shop_se_price floatValue]]];
    }
    
    NSRange redRange = NSMakeRange(0, [[noteStr string] rangeOfString:@" "].location);
    [noteStr addAttributes:@{NSForegroundColorAttributeName:kTitleColor,NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(40)]} range:redRange];
    [price setAttributedText:noteStr];
    [shopDetailView addSubview:price];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(price.frame.origin.x, price.frame.origin.y+25, 120, 25);
    [button setTitle:@"发送宝贝链接" forState:UIControlStateNormal];
    button.layer.borderWidth = 1;
    button.layer.borderColor = tarbarrossred.CGColor;
    button.tintColor = tarbarrossred;
    [shopDetailView addSubview:button];
    
    [button addTarget:self action:@selector(getrealmHttp) forControlEvents:UIControlEventTouchUpInside];
    
    if([self.detailtype isEqualToString:@"会员商品"])
    {
        button.hidden = YES;
    }
    
    [self.view addSubview:shopDetailView];
    
}

- (NSString *)exchangeTextWihtString:(NSString *)text {
    if ([text rangeOfString:@"】"].location != NSNotFound){
        NSArray *arr = [text componentsSeparatedByString:@"】"];
        NSString *textStr;
        if (arr.count == 2) {
            textStr = [NSString stringWithFormat:@"%@%@】", arr[1], arr[0]];
        }
        return textStr;
    }
    return text;
}

#pragma mark 获取商品连接
- (void)getrealmHttp {
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *token=[user objectForKey:USER_TOKEN];
    NSString *realm=[user objectForKey:USER_REALM];
    NSString *url = nil;
    if(realm)//自己的登录方式
    {
        if(_model.p_type)
        {
            url=[NSString stringWithFormat:@"shop/getpShopLink?version=%@&p_code=%@&realm=%@&token=%@&share=%@&getPShop=true",VERSION,_model.shop_code,realm,token,@"2"];
        }else{
            
            url=[NSString stringWithFormat:@"shop/getShopLink?version=%@&shop_code=%@&realm=%@&token=%@&share=%@&getShopMessage=true",VERSION,_model.shop_code,realm,token,@"2"];
        }
    }
    
    [MBProgressHUD showHUDAddTo:self.view  animated:YES];
    // 获取商品链接
    __weak typeof(self) weakSelf = self;
    [ShopLinkModel getShopLinkModelWithPath:url success:^(id data) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        ShopLinkModel *model = data;
        if (model.status == 1) {
            weakSelf.link = model.link;
            [weakSelf sendmessage];
        }
    }];
}

/// 发送消息
- (void)sendmessage {
    if(_link.length >10)
    {
        RCTextMessage *message = [RCTextMessage messageWithContent:_link];
        [self sendMessage:message pushContent:nil];
    }else{
        NavgationbarView *mentionview = [[NavgationbarView alloc]init];
        [mentionview showLable:@"获取商品链接失败" Controller:self];
    }
    
}

/// 点击URL跳转
- (void)didTapUrlInMessageCell:(NSString *)url model:(RCMessageModel *)model {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_slimeView scrollViewDidEndDraging];
}

- (void)slimeRefreshStartRefresh:(SRRefreshView*)refreshView {
    [super scrollViewDidEndDragging:self.conversationMessageCollectionView willDecelerate:YES];
    [_slimeView endRefresh];
}

#pragma mark - setter
- (SRRefreshView *)slimeView {
    if (!_slimeView) {
        _slimeView = [[SRRefreshView alloc] init];
        _slimeView.delegate = self;
        _slimeView.upInset = 0;
        _slimeView.slimeMissWhenGoingBack = YES;
        _slimeView.slime.bodyColor = [UIColor grayColor];
        _slimeView.slime.skinColor = [UIColor grayColor];
        _slimeView.slime.lineWith = 1;
        _slimeView.slime.shadowBlur = 4;
        _slimeView.slime.shadowColor = [UIColor grayColor];
        _slimeView.backgroundColor = [UIColor clearColor];
    }
    
    return _slimeView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
