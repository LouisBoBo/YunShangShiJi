//
//  DShareManager.m
//  dreamer
//
//  Created by ken on 15/1/16.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import "DShareManager.h"
#import "GlobalTool.h"
#import "AppDelegate.h"
#import "ProduceImage.h"
#import "QRCodeGenerator.h"
#import "NavgationbarView.h"
@implementation DShareManager
{
    NSInteger _shareCount;

}

static DShareManager *shareManager = nil;

+(DShareManager *)share{
    @synchronized(self)
    {
        if (shareManager == nil) {
            shareManager = [[DShareManager alloc] init];
        }
        return shareManager;
    }
}

- (NSString*)taskrawardHttp:(NSString*)strtype Price:(NSString*)price Brand:(NSString*)brand
{
    NSString *textstr = @"";
    
    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if (responseObject[@"wxdddfx"] != nil ){
                if(responseObject[@"wxdddfx"][@"title"] != nil)
                {
                    NSString *str0 = responseObject[@"wxdddfx"][@"title"];
                    str0 = [str0 stringByReplacingOccurrencesOfString:@"${replace}元" withString:[NSString stringWithFormat:@"%.1f元",price.floatValue]];
                    
                    brand = ([brand isEqualToString:@"<null>"] || [brand isEqual:[NSNull null]])?@"衣蝠":brand;
                    str0 = [str0 stringByReplacingOccurrencesOfString:@"${replace}品牌" withString:[NSString stringWithFormat:@"%@品牌",brand]];
                    
                    str0 = [str0 stringByReplacingOccurrencesOfString:@"${replace}" withString:[NSString stringWithFormat:@"%@",strtype]];
                    textstr = str0;
                }
            }
        }
    }
    
    return textstr;
}

- (NSArray *)ShareTitleArray
{
//    if(_ShareTitleArray == nil)
    {
//        NSString *sixstr = [NSString stringWithFormat:@"%@不想说话，并想你丢了一堆美衣",[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME]];
        
//        _ShareTitleArray = @[@"时尚不贵，一件到位",@"衣柜里不能没有这件衣服",@"教你正确地打开时尚大门",@"看看最近潮人们都在穿什么",@"GET到重点了，这么穿很时髦",@"好身材，都是搭配出来的",@"对，你就少这一件",@"穿对了，你就是女王",@"时尚搭配，好看不贵",@"你不能错过的经典单品",@"这些单品省去搭配烦恼",@"平价也有大牌范",@"一秒变时尚女王",@"原来这样才叫会穿",@"轻松穿出完美身材",@"这件衣服让你穿搭不失手",@"不推荐这件衣服，良心会痛",@"可以时尚，还可以穿得上",@"不犯同样的错，便宜也有好货",@"好的穿搭，让你时尚感爆棚"];

        _ShareTitleArray = @[@"你没有看错，Zara专柜当季新款29元包邮!",@"MANGO一线大牌，呆萌价29元起！仅限2天！",@"买衣预算不够？VERO MODA,H&M等一线大牌疯狂折扣29包邮！",@"不要花高价乱买衣服了，30元即可买到GAP，欧时力等一线大牌，快来！",@"比去专柜买便宜多了！H&M时尚单品限时特惠29元！",@"价格低到没朋友！优衣库女装仅售25元！",@"谁说大牌就一定贵！Forever21特价26元包邮！",@"GAP大牌女装新品发售，最低24元包邮！"];
    }
    
    return _ShareTitleArray;
}

- (void)shareAppWithType:(ShareType)type View:(UIView *)view Image:(UIImage*)shopImage Title:(NSString*)title WithShareType:(NSString *)sharetype
{
    
    NavgationbarView *mentionview = [[NavgationbarView alloc]init];
    
    //view属性暂时没用
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];

    NSString *shop_title=[user objectForKey:SHOP_TITLE];
    NSString *shop_link =[user objectForKey:SHOP_LINK];
    

    //分享域名替换
    NSString *currentStr = @"www.52yifu.com";
    if ([shop_link containsString:@"www.52yifu.wang"]) {
        currentStr = @"www.52yifu.wang";
    }

    NSString *ShareUrlIP = [[NSUserDefaults standardUserDefaults]objectForKey:@"ShareUrlIP"];
    if (ShareUrlIP.length) {
        if (shop_link.length) {
            [shop_link stringByReplacingOccurrencesOfString:currentStr withString:ShareUrlIP];
        }
    }

    //创建分享内容
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon@2x" ofType:@"png"];
    //imagePath %@", imagePath);
    
    //不同平台分享设置不一样
    //QQ好友分享用SSPublishContentMediaTypeNews
    //QQ空间分享用SSPublishContentMediaTypeApp
    //新浪微博无法直接分享应用 用SSPublishContentMediaTypeNews分享链接
    
    id<ISSContent> publishContent;
    switch (type) {
        case ShareTypeQQ:
        {
            publishContent = [ShareSDK content:@"最潮的大学生社交软件"
                                defaultContent:@""
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:@"Dreamer"
                                           url:@"https://itunes.apple.com/cn/app/yin-xiang-bo-ji-sao-miao-bao/id883338188?mt=8"    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeQQSpace:
        {
            [DataManager sharedManager].shareType = StatisticalTypeQuse;
            publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@%@",shop_title,shop_link]
                                defaultContent:@""
                                         image:nil
                                         title:@""
                                           url:nil   //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeText];
        }
            break;
        case ShareTypeSinaWeibo:
        {
            publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@%@",shop_title,shop_link]
                                defaultContent:@""
                                         image:nil
                                         title:@""
                                           url:nil    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeText];
        }
            break;
        case ShareTypeWeixiSession:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfUse;
            publishContent = [ShareSDK content:@"衣蝠网是深圳云商电子商务有限公司运营的时尚女性电商平台，通过直接打通供应链，对接设计师原创力量，致力于成为移动电商最棒的女性社交电商平台之一。为广大女性消费者带来物美价廉的美与时尚的生活方式。"
                                defaultContent:@""
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:@"衣蝠"
                                           url:@"https://itunes.apple.com/cn/app/yin-xiang-bo-ji-sao-miao-bao/id883338188?mt=8"    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeApp];
            
        }
            break;
        case ShareTypeWeixiTimeline:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfsUse;
            publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@%@",shop_title,shop_link]
                                defaultContent:@"衣蝠 选择它穿出最美的自己2"
                                         image:[ShareSDK jpegImageWithImage:shopImage quality:1]
                              
                                         title:@"衣蝠 选择它穿出最美的自己3!"
                                           url:@""    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeText];
            
        }
            break;
        case ShareTypeRenren:
        {
            publishContent = [ShareSDK content:@"Dreamer 最潮的大学生社交软件"
                                defaultContent:@""
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:@""
                                           url:@"https://itunes.apple.com/cn/app/yin-xiang-bo-ji-sao-miao-bao/id883338188?mt=8"    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeApp];
        }
            break;
            
        default:
        {
            //该分享未设置");
        }
            break;
    }
    
//    ValueObserver *kvo = [ValueObserver shareValueObserver];

    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:view arrowDirect:UIPopoverArrowDirectionRight];

    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
  
    [ShareSDK showShareViewWithType:type
                          container:container
                            content:publishContent
                      statusBarTips:YES
                        authOptions:authOptions
                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                            qqButtonHidden:NO
                                                     wxSessionButtonHidden:NO
                                                    wxTimelineButtonHidden:NO
                                                      showKeyboardOnAppear:NO
                                                         shareViewDelegate:self
                                                       friendsViewDelegate:nil
                                                     picViewerViewDelegate:nil]
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 
                                 if (state == 1)
                                 {

                                     NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功2222222"));
                                     
                                     
                                     if(type == ShareTypeWeixiTimeline)
                                     {
                                         _shareCount ++;
                                         
                                         if(_shareCount < 5)
                                         {
                                             //配置分享平台信息
                                             AppDelegate *app= (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                             [app shardk];
                                             
                                             NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                                             NSString *shop_title=[user objectForKey:SHOP_LINK];
                                             
                                             
                                             [[DShareManager share] shareAppWithType:ShareTypeWeixiTimeline View:nil Image:nil Title:shop_title WithShareType:sharetype];
                                             
                                            
                                         } else if (_shareCount == 2) {
                                             
                                             if([sharetype isEqualToString:@"index"])
                                             {
                                                 gKVO.index = @2;
                                                 
                                             }
                                             else if ([sharetype isEqualToString:@"shopping"]||[sharetype isEqualToString:@"newShare"])
                                             {
                                                 gKVO.shopping = @2;
                                             }
                                             else if ([sharetype isEqualToString:@"detail"])
                                             {
                                                 gKVO.detail = @2;
                                                 
                                             }
                                             else if ([sharetype isEqualToString:@"comdetail"])
                                             {
                                                 gKVO.comdetail = @1;
                                                 
                                             }
                                             
                                         }
                                         
                                         
                                     }

                                     [self shareSuccessStatistic];
                                 }
                                 else if (state == 2)
                                 {
                                     NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                     [mentionview showLable:@"分享失败,请重试" Controller:self];
                                     
                                     if(type == ShareTypeWeixiTimeline)
                                     {
                                         
                                         gKVO.index = @33;
                                         
            
                                     }

                                 }
                                 
                                 else if (state == 3)
                                 {
                                     NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                     
                                     [mentionview showLable:@"分享失败,请重试" Controller:self];
                                     
                                     if(type ==ShareTypeWeixiTimeline)
                                     {
                                         
                                         gKVO.index = @33;
                                         
                                     }

                                 }
                             }];

}

- (void)shareAppWithType:(ShareType)type View:(UIView *)view Image:(UIImage*)shopImage WithShareType:(NSString*)sharetype
{
    MyLog(@"sharetype = %@",sharetype);
    
    //view属性暂时没用11111111
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *shop_link=[user objectForKey:SHOP_LINK];
    NSString *shop_title=[user objectForKey:SHOP_TITLE];
    NSString *shop_pic=[user objectForKey:SHOP_PIC];
    NSString *shopprice =[user objectForKey:SHOP_PRICE];
    NSString *qrlink = [user objectForKey:QR_LINK];
    NSString *shop_brand = [user objectForKey:SHOP_BRAND];
    NSString *shop_name = [user objectForKey:SHOP_NAME];
    NSString *type2 = [user objectForKey:SHOP_TYPE2];
    
    //分享次数
    int shareCount = [[user objectForKey:ShareCount] intValue];
    if(([sharetype isEqualToString:@"Collocationdetail"] || [sharetype isEqualToString:@"detail"] || [sharetype isEqualToString:@"newShare"]) && type == ShareTypeWeixiTimeline)
    {
        shareCount ++;
        [user setObject:[NSString stringWithFormat:@"%d",shareCount] forKey:ShareCount];
    }
    
    NSString *title = @"一件美衣正等待亲爱哒打开哦";
    NSString *discription = @"我挺喜欢的宝贝，分享给你，进来看看还能领现金红包哦~";
    
    int i = arc4random()%self.ShareTitleArray.count;
    title = self.ShareTitleArray[i];
    
    //获取商品分享最新的文案 2017-9-16
    if(([sharetype isEqualToString:@"detail"] || [sharetype isEqualToString:@"newShare"] || [sharetype isEqualToString:@"Collocationdetail"]) && type == ShareTypeWeixiSession)
    {
        title = [self taskrawardHttp:type2 Price:shopprice Brand:shop_brand!=nil?shop_brand:@"衣蝠"];
//        discription = shop_name;
        discription = @"快来和我一起在衣蝠0元购美衣。";
    }

    if([sharetype isEqualToString:@"InviteFriends"]){
        title=@"加入衣蝠！每月多赚600+";
        discription = @"上衣蝠每日做小任务快速赚钱。更有万款美衣1折起哦。";
        qrlink = [NSString stringWithFormat:@"%@view/download/6.html?realm=%@",[NSString baseH5ShareURLStr],[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];
    }
    if([sharetype isEqualToString:@"ShareToFriends"]){
        title=@"加入衣蝠领取30元现金——衣蝠APP";
        discription = @"好的衣服没那么贵";
    }

    //分享域名替换
    NSString *currentStr = @"www.52yifu.com";
    if ([qrlink containsString:@"www.52yifu.wang"]||
        [shop_link containsString:@"www.52yifu.wang"]) {
        currentStr = @"www.52yifu.wang";
    }

    NSString *ShareUrlIP = [[NSUserDefaults standardUserDefaults]objectForKey:@"ShareUrlIP"];
    if (ShareUrlIP.length) {
        if (qrlink.length) {
            [qrlink stringByReplacingOccurrencesOfString:currentStr withString:ShareUrlIP];
        }
        if (shop_link.length) {
            [shop_link stringByReplacingOccurrencesOfString:currentStr withString:ShareUrlIP];
        }
    }
    
    if ([sharetype isEqualToString:@"Indiandetail"])
    {
        discription = [user objectForKey:DISCRIPTION];
        title = [user objectForKey:SHOP_TITLE];
        shop_pic = [user objectForKey:SHOP_PIC];
        UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],shop_pic]]]];
        shopImage =shopimage;
        
    }else if ([sharetype isEqualToString:@"Indiandshare"])
    {
        discription = [user objectForKey:DISCRIPTION];
        discription = [discription stringByReplacingOccurrencesOfString:@"${replace}" withString:[user objectForKey:SHOP_NAME]];
        
        title = [user objectForKey:SHOP_TITLE];
        title = [title stringByReplacingOccurrencesOfString:@"${replace}" withString:[user objectForKey:SHOP_NAME]];
        
        shop_pic = [user objectForKey:SHOP_PIC];
        UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],shop_pic]]]];
        shopImage =shopimage;

    }else if ([sharetype isEqualToString:@"Indiandetailshareshop"])
    {
        if(type == ShareTypeWeixiSession)
        {
            title = [self taskrawardHttp:type2 Price:shopprice Brand:shop_brand!=nil?shop_brand:@"衣蝠"];
            discription = @"快来和我一起在衣蝠0元购美衣。";
        }
    }
    else if([sharetype isEqualToString:@"OneIndiandetail"]){
    
        qrlink = [[NSUserDefaults standardUserDefaults] objectForKey:QR_LINK];
        title = [[NSUserDefaults standardUserDefaults] objectForKey:TIXIAN_SHARE_TITLE];
        discription = [[NSUserDefaults standardUserDefaults] objectForKey:TIXIAN_SHARE_DISCRIPTION];
    }
    else if([sharetype isEqualToString:@"qianDaocomdetail"]){
        
        title = [NSString stringWithFormat:@"我正在参与%.0f元包邮活动",[shopprice floatValue]];
        discription = [NSString stringWithFormat:@"%.0f元带走心爱的商品。首次签到还能领3元现金哦",[shopprice floatValue]];
    }else if ([sharetype isEqualToString:@"comdetail"] )
    {
        title = @"精品超值特卖";
        discription = @"买了肯定不后悔，数量不多，快来抢购吧~";
    }

    
    if([sharetype isEqualToString:@"index"]) //智能分享
        [DataManager sharedManager].shareTabType = StatisticalTabTypeCommodity;
    else if ([sharetype isEqualToString:@"zeroindex"]) //结算分享
        [DataManager sharedManager].shareTabType = StatisticalTabTypeCommodity;
    else if ([sharetype isEqualToString:@"shopping"]||[sharetype isEqualToString:@"newShare"])
        [DataManager sharedManager].shareTabType = StatisticalTabTypeCommodity;
    else if ([sharetype isEqualToString:@"detail"])//普通商品详情普通分享--ok
        [DataManager sharedManager].shareTabType = StatisticalTabTypeCommodity;
    else if ([sharetype isEqualToString:@"comdetail"])//0元购商品详情普通分享--ok
        [DataManager sharedManager].shareTabType = StatisticalTabTypeCommodity;
    else if ([sharetype isEqualToString:@"Collocationdetail"])
        [DataManager sharedManager].shareTabType = StatisticalTabTypeCollocation;
    else
        [DataManager sharedManager].shareTabType = StatisticalTabTypeCommodity;
    
    if(type == ShareTypeQQSpace)//QQ空间
    {
        if(!shopImage)
        {
            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],shop_pic]]]];
            shopImage =shopimage;
            
        }
    }else if (type ==ShareTypeWeixiSession)//微信好友
    {
        if([sharetype isEqualToString:@"sign"])
        {
            title = @"即刻到衣蝠领取现金奖励！";
            discription = @"天天签到，分享有礼！";
            
        }
        else{
            if(!shopImage)
            {
                
                UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
                
                //直接创建二维码图像
                UIImage *qrpicimage = [QRCodeGenerator qrImageForString:qrlink imageSize:165];
                
                NSData *data = UIImagePNGRepresentation(qrpicimage);
                NSString *st = [NSString stringWithFormat:@"%@/Documents/abc.png", NSHomeDirectory()];
                
                //st = %@", st);
                
                [data writeToFile:st atomically:YES];
                
                ProduceImage *pi = [[ProduceImage alloc] init];
                UIImage *newimg = [pi getImage:shopimage withQRCodeImage:qrpicimage withText:sharetype withPrice:shopprice WithTitle:nil];
                MyLog(@"newimg = %@",newimg);
                
                shopImage=newimg;
            }
        }
    }else if (type == ShareTypeWeixiTimeline)//微信朋友圈
    {
        if(!shopImage)
        {
            UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],shop_pic]]]];
    
            //直接创建二维码图像
            UIImage *qrpicimage = [QRCodeGenerator qrImageForString:qrlink imageSize:165];
            
            NSData *data = UIImagePNGRepresentation(qrpicimage);
            NSString *st = [NSString stringWithFormat:@"%@/Documents/abc.png", NSHomeDirectory()];
            
            //st = %@", st);
            
            [data writeToFile:st atomically:YES];
            
            
            ProduceImage *pi = [[ProduceImage alloc] init];
            UIImage *newimg = [pi getImage:shopimage withQRCodeImage:qrpicimage withText:sharetype withPrice:shopprice WithTitle:nil];
            MyLog(@"newimg = %@",newimg);
            
            shopImage=newimg;
        }

//        if(shareCount %2 == 0)
//        {
//            if([sharetype isEqualToString:@"Collocationdetail"] || [sharetype isEqualToString:@"detail"])
//            {
//                UIImage *shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],shop_pic]]]];
//                shopImage =shopimage;
//            }
//        }
    }
    
    //创建分享内容
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon@2x" ofType:@"png"];
    //imagePath %@", imagePath);
    
    //不同平台分享设置不一样
    //QQ好友分享用SSPublishContentMediaTypeNews
    //QQ空间分享用SSPublishContentMediaTypeApp
    //新浪微博无法直接分享应用 用SSPublishContentMediaTypeNews分享链接
    id<ISSContent> publishContent;
    switch (type) {
        case ShareTypeQQ:
        {
            publishContent = [ShareSDK content:@""
                                defaultContent:@""
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:@"Dreamer"
                                           url:@"https://itunes.apple.com/cn/app/yin-xiang-bo-ji-sao-miao-bao/id883338188?mt=8"    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeQQSpace:
        {
            [DataManager sharedManager].shareType = StatisticalTypeQuse;
            publishContent = [ShareSDK content:@""
                                defaultContent:@""
                                         image:[ShareSDK jpegImageWithImage:shopImage quality:1]
                                         title:title
                                           url:qrlink    //参考例子：印象笔记扫描宝
                                   description:[NSString stringWithFormat:@"%@",title]

                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeSinaWeibo:
        {
            publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@%@",shop_title,shop_link]
                                defaultContent:@""
                                         image:[ShareSDK jpegImageWithImage:shopImage quality:1]
                                         title:@""
                                           url:shop_link   //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
        }
            
            break;
        case ShareTypeWeixiSession:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfUse;
            publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@",discription]
                                defaultContent:@""
                                         image:[ShareSDK jpegImageWithImage:shopImage quality:1]
                                         title:title
                                           url:qrlink    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeWeixiTimeline:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfsUse;
            if ([sharetype isEqualToString:@"OneIndiandetail"]) {
                publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@",discription]
                                    defaultContent:@""
                                             image:[ShareSDK jpegImageWithImage:shopImage quality:1]
                                             title:title
                                               url:qrlink    //参考例子：印象笔记扫描宝
                                       description:discription
                                         mediaType:SSPublishContentMediaTypeNews];
            }
            else if([sharetype isEqualToString:@"newShare"] || [sharetype isEqualToString:@"Collocationdetail"] || [sharetype isEqualToString:@"detail"])
            {
                
                if(self.taskValue == 1)//图片
                {
                    publishContent = [ShareSDK content:@"微信朋友圈"
                                        defaultContent:@"微信"
                                                 image:[ShareSDK jpegImageWithImage:shopImage quality:1]
                                                 title:@"衣蝠"
                                                   url:@"www.52yifu.com"
                                           description:@"B"
                                             mediaType:SSPublishContentMediaTypeImage];
                }else{//链接
                    publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@",@"衣蝠 选择它穿出最美的自己"]
                                        defaultContent:@"衣蝠 选择它穿出最美的自己2"
                                                 image:[ShareSDK jpegImageWithImage:shopImage quality:1]
                                      
                                                 title:title
                                                   url:qrlink    //参考例子：印象笔记扫描宝
                                           description:@"衣蝠网是深圳云商电子商务有限公司运营的时尚女性电商平台，通过直接打通供应链，对接设计师原创力量，致力于成为移动电商最棒的女性社交电商平台之一。为广大女性消费者带来物美价廉的美与时尚的生活方式"
                                             mediaType:SSPublishContentMediaTypeNews];
                    
                }
            }
            else{
                publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@",@"衣蝠 选择它穿出最美的自己"]
                                    defaultContent:@"衣蝠 选择它穿出最美的自己2"
                                             image:[ShareSDK jpegImageWithImage:shopImage quality:1]
                                  
                                             title:@"衣蝠 选择它穿出最美的自己3!"
                                               url:@"https://itunes.apple.com/cn/app/yin-xiang-bo-ji-sao-miao-bao/id883338188?mt=8"    //参考例子：印象笔记扫描宝
                                       description:@"衣蝠网是深圳云商电子商务有限公司运营的时尚女性电商平台，通过直接打通供应链，对接设计师原创力量，致力于成为移动电商最棒的女性社交电商平台之一。为广大女性消费者带来物美价廉的美与时尚的生活方式"
                                         mediaType:SSPublishContentMediaTypeImage];
            }            
        }
            break;
        case ShareTypeRenren:
        {
            publishContent = [ShareSDK content:@"Dreamer 最潮的大学生社交软件"
                                defaultContent:@""
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:@""
                                           url:@"https://itunes.apple.com/cn/app/yin-xiang-bo-ji-sao-miao-bao/id883338188?mt=8"    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeApp];
        }
            break;
            
        default:
        {
            //该分享未设置");
        }
            break;
    }
    
//    ValueObserver *kvo = [ValueObserver shareValueObserver];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:view arrowDirect:UIPopoverArrowDirectionRight];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    
    [ShareSDK showShareViewWithType:type
                          container:container
                            content:publishContent
                      statusBarTips:YES
                        authOptions:authOptions
                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                            qqButtonHidden:NO
                                                     wxSessionButtonHidden:NO
                                                    wxTimelineButtonHidden:NO
                                                      showKeyboardOnAppear:NO
                                                         shareViewDelegate:self
                                                       friendsViewDelegate:nil
                                                     picViewerViewDelegate:nil]
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 
#pragma mark 分享回调
                                 
                                 //SSResponseStateBegan = 0, /**< 开始 */
                                 //SSResponseStateSuccess = 1, /**< 成功 */
                                 //SSResponseStateFail = 2, /**< 失败 */
                                 //SSResponseStateCancel = 3 /**< 取消 */

                                 MyLog(@"%d",state);
                                 
                                 if (state == 1)//分享成功
                                 {
                                     
                                     _shareCount =0;
                                     NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功111111111"));
                                     
                                     if(type == ShareTypeWeixiTimeline)
                                     {
                                         _shareCount++;
                                         
                                         if(_shareCount <5)
                                         {
                                             
                                             [self successShare:sharetype];
                                             
                                         }

                                     }
                                     else if (type == ShareTypeQQSpace || type == ShareTypeWeixiSession)
                                     {
                                         [self successShare:sharetype];
                    
                                     }
                                     
                                     
                                    [self shareSuccessStatistic];
                                 }
                                 else if (state == 2 )//分享失败
                                 {
                                     NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                     
                                     [self failShare:sharetype];
                                   
                                 }else if (state == 3)
                                 {
                                     [self failShare:sharetype];
                                 }
//                                 else if (state == 0)
//                                 {
//                                     if ([sharetype isEqualToString:@"Indiandetail"])//df
//                                     {
//                                         if (_detailBlock) {
//                                             _detailBlock();
//                                         }
//                                     }
//                                 }
                             }];

}


#pragma mark 分享成功后调用
- (void)successShare:(NSString*)sharetype
{
    if([sharetype isEqualToString:@"ShareToFriends"]||[sharetype isEqualToString:@"InviteFriends"]||[sharetype isEqualToString:@"newShare"]){
        if (self.ShareSuccessBlock) {
            self.ShareSuccessBlock();
        }
    }
    else  if([sharetype isEqualToString:@"index"])//普通商品智能分享--ok
    {
        if (self.ShareSuccessBlock) {
            self.ShareSuccessBlock();
        }
        NSNotification *notification=[NSNotification notificationWithName:@"Intelligencesharesuccess" object:@"Intelligencesuccess"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
    else if ([sharetype isEqualToString:@"shopping"])//购物车普通分享--ok
    {
        
        NSNotification *notification=[NSNotification notificationWithName:@"Shopcartsharesuccess" object:@"Shopcartsharesuccess"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
    else if ([sharetype isEqualToString:@"detail"])//普通商品详情普通分享--ok
    {
        NSNotification *notification=[NSNotification notificationWithName:@"ShopDetailsharesuccess" object:@"ShopDetailsuccess"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
        if (_detailBlock) {
            _detailBlock();
        }
    }
    
    else if ([sharetype isEqualToString:@"comdetail"])//0元购商品详情普通分享--ok
    {
        
        NSNotification *notification=[NSNotification notificationWithName:@"ComboShopsharesuccess" object:@"ComboShopsuccess"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }else if ([sharetype isEqualToString:@"Collocationdetail"])
    {
        NSNotification *notification=[NSNotification notificationWithName:@"Collocationsharesuccess" object:@"Collocationsharesuccess"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    }
    else if ([sharetype isEqualToString:@"myNewSign"])
    {
        gKVO.comdetail = @1;
        
    }
    else if ([sharetype isEqualToString:@"shareindex"])//普通商品详情取消后再分享
    {
        NSNotification *notification=[NSNotification notificationWithName:@"ShopDetailsharesuccess" object:@"shareIndexsuccess"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
    else if ([sharetype isEqualToString:@"zeroindex"])//0元购智能分享--ok
    {

        NSNotification *notification=[NSNotification notificationWithName:@"zeroIndexsharesuccess" object:@"zeroIndexsuccess"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    else if ([sharetype isEqualToString:@"Indiandetail"] || [sharetype isEqualToString:@"Indiandetailshareshop"] || [sharetype isEqualToString:@"Indiandshare"])
    {
        if (_detailBlock) {
            _detailBlock();
        }
    }else if ([sharetype isEqualToString:@"OneIndiandetail"]){
        if (self.ShareSuccessBlock) {
            self.ShareSuccessBlock();
        }
    }
}

#pragma mark 分享失败后调用
- (void)failShare:(NSString*)sharetype
{
    if([sharetype isEqualToString:@"ShareToFriends"]||[sharetype isEqualToString:@"InviteFriends"]||[sharetype isEqualToString:@"newShare"]){
        if (self.ShareFailBlock) {
            self.ShareFailBlock();
        }
    }
    else if([sharetype isEqualToString:@"index"])//--ok
    {
        if (self.ShareSuccessBlock) {
            self.ShareSuccessBlock();
        }
        NSNotification *notification=[NSNotification notificationWithName:@"Intelligencesharefail" object:@"Intelligencefail"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
    else if ([sharetype isEqualToString:@"shopping"])//--ok
    {
        
        NSNotification *notification=[NSNotification notificationWithName:@"Shopcartsharefail" object:@"Shopcartsharefail"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    else if ([sharetype isEqualToString:@"detail"])//详情普通分享--ok
    {
        
        NSNotification *notification=[NSNotification notificationWithName:@"ShopDetailsharefail" object:@"ShopDetailfail"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
    else if ([sharetype isEqualToString:@"affirm"])
    {
        gKVO.affirm = @33;
        
    }
    else if ([sharetype isEqualToString:@"comdetail"])//0元购商品详情普通分享--ok
    {
    
        NSNotification *notification=[NSNotification notificationWithName:@"ComboShopsharefail" object:@"ComboShopfail"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
    else if ([sharetype isEqualToString:@"Collocationdetail"])
    {
        NSNotification *notification=[NSNotification notificationWithName:@"CollocationShopsharefail" object:@"CollocationShopsharefail"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }

    else if ([sharetype isEqualToString:@"myNewSign"])
    {
        gKVO.comdetail = @33;
        
    }
    
    else if ([sharetype isEqualToString:@"zeroindex"])//0元购智能分享--ok
    {
        NSNotification *notification=[NSNotification notificationWithName:@"zeroIndexsharefail" object:@"zeroIndexfail"];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    else if ([sharetype isEqualToString:@"Indiandetail"] )
    {
        if (_detailBlock) {
            _detailBlock();
        }
    }else if ([sharetype isEqualToString:@"OneIndiandetail"]){
        if(_ShareFailBlock){
            _ShareFailBlock();
        }
    }
}

- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType
{
    
//    viewController.navigationController.navigationBar.barTintColor = kBackgroundColor;
    
    UIBarButtonItem *leftBtn = viewController.navigationItem.leftBarButtonItem;
    UIBarButtonItem *rightBtn = viewController.navigationItem.rightBarButtonItem;
    
    UILabel *titleLable = (UILabel *) viewController.navigationItem.titleView;
    [titleLable setTextColor:[UIColor cyanColor]];

    NSShadow *shadow = [NSShadow.alloc init];
    shadow.shadowColor = [UIColor clearColor];
    
    NSMutableDictionary *itemMd = [NSMutableDictionary dictionary];
    itemMd[NSForegroundColorAttributeName] = [UIColor darkTextColor];
    [rightBtn setTitleTextAttributes:itemMd forState:UIControlStateNormal];
    [leftBtn setTitleTextAttributes:itemMd forState:UIControlStateNormal];
    
}


- (void)shareList:(UIImage*)shopImage Title:(NSString*)title {
    
    id<ISSShareActionSheetItem> item = [ShareSDK shareActionSheetItemWithTitle:@"新浪微博"
                                                                          icon:[UIImage imageNamed:@"sns_icon_1"]
                                                                  clickHandler:^{
                                                                      [self shareAppWithType:ShareTypeSinaWeibo View:nil Image:shopImage WithShareType:nil];
                                                                  }];
    
    id<ISSShareActionSheetItem> item1 = [ShareSDK shareActionSheetItemWithTitle:@"人人网"
                                                                           icon:[UIImage imageNamed:@"sns_icon_7"]
                                                                   clickHandler:^{
                                                                       [self shareAppWithType:ShareTypeRenren View:nil Image:shopImage WithShareType:nil ];
                                                                   }];
    
    id<ISSShareActionSheetItem> item2 = [ShareSDK shareActionSheetItemWithTitle:@"QQ好友"
                                                                           icon:[UIImage imageNamed:@"sns_icon_24"]
                                                                   clickHandler:^{
                                                                       [self shareAppWithType:ShareTypeQQ View:nil Image:shopImage Title:nil WithShareType:nil];
                                                                   }];
    
    id<ISSShareActionSheetItem> item3 = [ShareSDK shareActionSheetItemWithTitle:@"QQ空间"
                                                                           icon:[UIImage imageNamed:@"sns_icon_6"]
                                                                   clickHandler:^{
                                                                       [self shareAppWithType:ShareTypeQQSpace View:nil Image:shopImage WithShareType:nil];
                                                                   }];
    
    id<ISSShareActionSheetItem> item4 = [ShareSDK shareActionSheetItemWithTitle:@"微信好友"
                                                                           icon:[UIImage imageNamed:@"sns_icon_22"]
                                                                   clickHandler:^{
                                                                       [self shareAppWithType:ShareTypeWeixiSession View:nil Image:shopImage Title:nil WithShareType:nil];
                                                                   }];
    
    id<ISSShareActionSheetItem> item5 = [ShareSDK shareActionSheetItemWithTitle:@"微信朋友圈"
                                                                           icon:[UIImage imageNamed:@"sns_icon_23"]
                                                                   clickHandler:^{
                                                                       [self shareAppWithType:ShareTypeWeixiTimeline View:nil Image:shopImage WithShareType:nil];
                                                                       
                                                                       
                                                                   }];
    
    
    NSArray *shareList = [ShareSDK customShareListWithType: item3, item, item5, nil];
    
    if(kIOSVersions < 9.0)
    {
        
        //判断设备是否安装微信，QQ
        if ([WXApi isWXAppInstalled]) {
            
            //判断是否有微信
        }else {
            shareList = [ShareSDK customShareListWithType: item3, item, nil];
            
        }
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        {
            //判断是否有qq
            
        }else{
            
            shareList = [ShareSDK customShareListWithType: item, item5, nil];
        }
        
        
        if(![WXApi isWXAppInstalled] && ![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        {
            
            shareList = [ShareSDK customShareListWithType: item, nil];
        }
        
    }
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];

    //显示分享菜单
    [ShareSDK showShareActionSheet:nil
                         shareList:shareList
                           content:nil
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                          oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                           qqButtonHidden:NO
                                                    wxSessionButtonHidden:NO
                                                   wxTimelineButtonHidden:NO
                                                     showKeyboardOnAppear:NO
                                                        shareViewDelegate:nil
                                                      friendsViewDelegate:nil
                                                    picViewerViewDelegate:nil]
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                                
       
                               
    
                            }];
                                
}

-(void)shareListOne
{
    id<ISSShareActionSheetItem> item4 = [ShareSDK shareActionSheetItemWithTitle:@"微信好友"
                                                                           icon:[UIImage imageNamed:@"sns_icon_22"]
                                                                   clickHandler:^{
                                                                       [self shareAppWithType:ShareTypeWeixiSession View:nil Image:nil Title:nil WithShareType:nil];
     
                                                                }];
    NSArray *shareList = [ShareSDK customShareListWithType: item4, nil];
    
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    
    //显示分享菜单
    [ShareSDK showShareActionSheet:nil
                         shareList:shareList
                           content:nil
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                          oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                           qqButtonHidden:NO
                                                    wxSessionButtonHidden:NO
                                                   wxTimelineButtonHidden:NO
                                                     showKeyboardOnAppear:NO
                                                        shareViewDelegate:nil
                                                      friendsViewDelegate:nil
                                                    picViewerViewDelegate:nil]
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}

//微信分享图片
- (void)shareAppWithType:(ShareType)type withImageShareType:(NSString*)sharetype withImage:(UIImage *)img
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    //分享次数
    int shareCount = [[ud objectForKey:ShareCount] intValue];
    if(([sharetype isEqualToString:@"任务分享"] || [sharetype isEqualToString:@"搭配购"]) && type == ShareTypeWeixiTimeline)
    {
        shareCount ++;
        [ud setObject:[NSString stringWithFormat:@"%d",shareCount] forKey:ShareCount];
    }

    NSString * qrlink = @"";
    NSString * title  = @"";
    NSString * discription = @"";
    if([sharetype isEqualToString:@"分享赢提现额度"])
    {
        qrlink = [ud objectForKey:QR_LINK];
        title = [ud objectForKey:TIXIAN_SHARE_TITLE];
        discription = [ud objectForKey:TIXIAN_SHARE_DISCRIPTION];
    }else if([sharetype isEqualToString:@"任务分享"]){
        
        qrlink = [ud objectForKey:QR_LINK];
        discription = @"我挺喜欢的宝贝，分享给你，进来看看还能领现金红包哦~";
        int i = arc4random()%self.ShareTitleArray.count;
        title = self.ShareTitleArray[i];

//        if(type == ShareTypeWeixiSession)
        {
            NSString *shop_name = [ud objectForKey:SHOP_NAME];
            NSString *shop_price = [ud objectForKey:SHOP_PRICE];
            NSString *shop_brand = [ud objectForKey:SHOP_BRAND];
            NSString *type2 = [ud objectForKey:SHOP_TYPE2];
            
            shop_price = [NSString stringWithFormat:@"%.1f",shop_price.floatValue];
            if(shop_price && shop_brand && type2)
            {
                title = [self taskrawardHttp:type2 Price:shop_price Brand:shop_brand];
                discription = @"快来和我一起在衣蝠0元购美衣。";
            }
        }

    } else{
        qrlink = [ud objectForKey:QR_LINK];
        discription = @"我挺喜欢的宝贝，分享给你，进来看看还能领现金红包哦~";
        int i = arc4random()%self.ShareTitleArray.count;
        title = self.ShareTitleArray[i];
    }

    //分享域名替换
    NSString *currentStr = @"www.52yifu.com";
    if ([qrlink containsString:@"www.52yifu.wang"]) {
        currentStr = @"www.52yifu.wang";
    }

    NSString *ShareUrlIP = [[NSUserDefaults standardUserDefaults]objectForKey:@"ShareUrlIP"];
    if (ShareUrlIP.length) {
        if (qrlink.length) {
            [qrlink stringByReplacingOccurrencesOfString:currentStr withString:ShareUrlIP];
        }
    }
    
    [DataManager sharedManager].shareTabType = StatisticalTabTypeCommodity;
    
    id<ISSContent> publishContent;
    
    switch (type) {
        case ShareTypeQQSpace: {
            [DataManager sharedManager].shareType = StatisticalTypeQuse;
            
            publishContent = [ShareSDK content:@"QQ空间"
                                defaultContent:@"QQ"
                                         image:[ShareSDK jpegImageWithImage:img quality:1]
                                         title:title
                                           url:qrlink
                                   description:discription
                                     mediaType:SSPublishContentMediaTypeNews];
        
        }
            break;
        case ShareTypeWeixiTimeline: {
            [DataManager sharedManager].shareType = StatisticalTypeWxfsUse;
            if(self.taskValue == 2)//签到分享链接
            {
                publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@",@"衣蝠 选择它穿出最美的自己"]
                                    defaultContent:@"衣蝠 选择它穿出最美的自己2"
                                             image:[ShareSDK jpegImageWithImage:img quality:1]
                                  
                                             title:title
                                               url:qrlink    //参考例子：印象笔记扫描宝
                                       description:@"衣蝠网是深圳云商电子商务有限公司运营的时尚女性电商平台，通过直接打通供应链，对接设计师原创力量，致力于成为移动电商最棒的女性社交电商平台之一。为广大女性消费者带来物美价廉的美与时尚的生活方式"
                                         mediaType:SSPublishContentMediaTypeNews];
            }else{
            
                publishContent = [ShareSDK content:@"微信朋友圈"
                                    defaultContent:@"微信"
                                             image:[ShareSDK jpegImageWithImage:img quality:1]
                                             title:@"衣蝠"
                                               url:@"www.52yifu.com"
                                       description:@"B"
                                         mediaType:SSPublishContentMediaTypeImage];
            }
            
            
        }
            break;
        case ShareTypeWeixiSession:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfUse;
            publishContent = [ShareSDK content:discription
                                defaultContent:@""
                                         image:[ShareSDK jpegImageWithImage:img quality:1]
                                         title:title
                                           url:qrlink    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeSinaWeibo: {
            publishContent = [ShareSDK content:@"新浪微博"
                                defaultContent:@"新浪"
                                         image:[ShareSDK jpegImageWithImage:img quality:1]
                                         title:@""
                                           url:@"www.52yifu.com"
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeImage];
        }
            break;
            
        default: {
            //该分享未设置");
        }
            break;
    }
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionRight];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    id<ISSShareOptions> options = [ShareSDK defaultShareOptionsWithTitle:nil oneKeyShareList:[NSArray defaultOneKeyShareList] qqButtonHidden:NO wxSessionButtonHidden:NO wxTimelineButtonHidden:NO showKeyboardOnAppear:NO shareViewDelegate:self friendsViewDelegate:nil picViewerViewDelegate:nil];
    
    
    [ShareSDK showShareViewWithType:type container:container content:publishContent statusBarTips:YES authOptions:authOptions shareOptions:options result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        //
        
        SHARESTATE st = 0;
        
        if ([self.delegate respondsToSelector:@selector(DShareManagerStatus:withType:)]) {
            switch (state) {
                case SSResponseStateBegan:
                    st = STATE_BEGAN;
                    break;
                    
                case SSResponseStateSuccess:
                    st = STATE_SUCCESS;
                    
                    [self shareSuccessStatistic];
                    break;
                    
                case SSResponseStateFail:
                    st = STATE_FAILED;
                    break;
                    
                case SSResponseStateCancel:
                    st = STATE_CANCEL;
                    break;
                    
                default:
                    break;
            }
        }
        
        [self.delegate DShareManagerStatus:st withType:sharetype];
        
    }];

}


- (void)shareAppWithType:(ShareType)type withLinkShareType:(NSString*)sharetype withLink:(NSString *)link andImagePath:(NSString *)imagePath andTitle:(NSString *)title andContent:(NSString *)content
{
    //分享域名替换
    NSString *currentStr = @"www.52yifu.com";
    if ([link containsString:@"www.52yifu.wang"]) {
        currentStr = @"www.52yifu.wang";
    }

    NSString *ShareUrlIP = [[NSUserDefaults standardUserDefaults]objectForKey:@"ShareUrlIP"];
    if (ShareUrlIP.length) {
        if (link.length) {
            [link stringByReplacingOccurrencesOfString:currentStr withString:ShareUrlIP];
        }
    }

    //创建分享内容
//    //imagePath %@", imagePath);
    if (title == nil) {
        title = @"衣蝠 选择它穿出最美的自己";
    }
    if (content == nil) {
        content = @"衣蝠 选择它穿出最美的自己";
    }
    
    NSString *titleTemp = title;
    
    id<ISSContent> publishContent;
    switch (type) {
        case ShareTypeQQ:
        {
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:titleTemp
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeQQSpace:
        {
            [DataManager sharedManager].shareType = StatisticalTypeQuse;
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:titleTemp
                                           url:link   //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeText];
        }
            break;
        case ShareTypeSinaWeibo:
        {
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:titleTemp
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
        }
            break;
        case ShareTypeWeixiSession:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfUse;
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:titleTemp
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeWeixiTimeline:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfsUse;
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:titleTemp
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeRenren:
        {
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK imageWithPath:imagePath]
                                         title:titleTemp
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
        }
            break;
            
        default:
        {
            //该分享未设置");
        }
            break;
    }

    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionRight];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    id<ISSShareOptions> options = [ShareSDK defaultShareOptionsWithTitle:nil oneKeyShareList:[NSArray defaultOneKeyShareList] qqButtonHidden:NO wxSessionButtonHidden:NO wxTimelineButtonHidden:NO showKeyboardOnAppear:NO shareViewDelegate:self friendsViewDelegate:nil picViewerViewDelegate:nil];
    
    
    [ShareSDK showShareViewWithType:type container:container content:publishContent statusBarTips:YES authOptions:authOptions shareOptions:options result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        //
        
        SHARESTATE st = STATE_BEGAN;
        
        if ([self.delegate respondsToSelector:@selector(DShareManagerStatus:withType:)]) {
            switch (state) {
                case SSResponseStateBegan:
                    st = STATE_BEGAN;
                    break;
                    
                case SSResponseStateSuccess:
                    st = STATE_SUCCESS;
                    
                    [self shareSuccessStatistic];
                    
                    break;
                    
                case SSResponseStateFail:
                    st = STATE_FAILED;
                    break;
                    
                case SSResponseStateCancel:
                    st = STATE_CANCEL;
                    break;
                    
                default:
                    break;
            }
        }
        
        [self.delegate DShareManagerStatus:st withType:sharetype];
        
    }];
}

#pragma mark 精选推荐分享
- (void)shareAppWithType:(ShareType)type withLink:(NSString *)link andImagePath:(NSString *)imagePath andContent:(NSString *)content;
{
    //分享域名替换
    NSString *currentStr = @"www.52yifu.com";
    if ([link containsString:@"www.52yifu.wang"]) {
        currentStr = @"www.52yifu.wang";
    }

    NSString *ShareUrlIP = [[NSUserDefaults standardUserDefaults]objectForKey:@"ShareUrlIP"];
    if (ShareUrlIP.length) {
        if (link.length) {
            [link stringByReplacingOccurrencesOfString:currentStr withString:ShareUrlIP];
        }
    }

    UIImage *shopimage;
    if(imagePath)
    {
        shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],imagePath]]]];
    }else{
        shopimage = [UIImage imageNamed:@"share_Icon-60"];
    }
    
    id<ISSContent> publishContent;
    switch (type) {
            case ShareTypeQQSpace:
        {
            if (content.length>30) {
                content=[content substringToIndex:30];
            }
            [DataManager sharedManager].shareType = StatisticalTypeQuse;
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:shopimage quality:1]
                                         title:content
                                           url:link   //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeSinaWeibo:
        {
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:shopimage quality:1]
                                         title:content
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
        }
            break;
        case ShareTypeWeixiTimeline:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfsUse;
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:shopimage quality:1]
                                         title:content
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeWeixiSession:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfUse;
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:shopimage quality:1]
                                         title:content
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeQQ:
        {
            publishContent = [ShareSDK content:@""
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:shopimage quality:1]
                                         title:content
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }

        default:
        {
            //该分享未设置");
        }
            break;
    }
    
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionRight];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    id<ISSShareOptions> options = [ShareSDK defaultShareOptionsWithTitle:nil oneKeyShareList:[NSArray defaultOneKeyShareList] qqButtonHidden:NO wxSessionButtonHidden:NO wxTimelineButtonHidden:NO showKeyboardOnAppear:NO shareViewDelegate:self friendsViewDelegate:nil picViewerViewDelegate:nil];
    
    
    [ShareSDK showShareViewWithType:type container:container content:publishContent statusBarTips:YES authOptions:authOptions shareOptions:options result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        

        SHARESTATE st = STATE_BEGAN;
        
        if ([self.delegate respondsToSelector:@selector(DShareManagerStatus:withType:)]) {
            switch (state) {
                case SSResponseStateBegan:
                    st = STATE_BEGAN;
                    break;
                    
                case SSResponseStateSuccess:
                    st = STATE_SUCCESS;
                    
                    [self shareSuccessStatistic];
                    
                    break;
                    
                case SSResponseStateFail:
                    st = STATE_FAILED;
                    break;
                    
                case SSResponseStateCancel:
                    st = STATE_CANCEL;
                    break;
                    
                default:
                    break;
            }
        }
        
        if(self.fightIndianaBlock)
        {
            self.fightIndianaBlock(state);
        }

        [self.delegate DShareManagerStatus:st withType:nil];

    }];

}
#pragma mark 分享成功统计
- (void)shareSuccessStatistic
{
    //签到分享次数统计
    if([Signmanager SignManarer].shareShopCart > 0)
    {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString *sharecount = [user objectForKey:TASK_SHARE_SHOPCOUNT];
        [user setObject:[NSString stringWithFormat:@"%d",sharecount.intValue+1] forKey:TASK_SHARE_SHOPCOUNT];
    }
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [app shareSuccess];
}

#pragma mark 拼团夺宝
- (void)shareAppWithType:(ShareType)type withLink:(NSString *)link andImagePath:(NSString *)imagePath andContent:(NSString *)content Discription:(NSString *)discription;
{
    //分享域名替换
    NSString *currentStr = @"www.52yifu.com";
    if ([link containsString:@"www.52yifu.wang"]) {
        currentStr = @"www.52yifu.wang";
    }
    
    NSString *ShareUrlIP = [[NSUserDefaults standardUserDefaults]objectForKey:@"ShareUrlIP"];
    if (ShareUrlIP.length) {
        if (link.length) {
            [link stringByReplacingOccurrencesOfString:currentStr withString:ShareUrlIP];
        }
    }
    
    UIImage *shopimage;
    if(imagePath)
    {
        shopimage=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@!280",[NSObject baseURLStr_Upy],imagePath]]]];
    }else{
        shopimage = [UIImage imageNamed:@"share_Icon-60"];
    }
    
    id<ISSContent> publishContent;
    switch (type) {
        case ShareTypeQQSpace:
        {
            if (content.length>30) {
                content=[content substringToIndex:30];
            }
            [DataManager sharedManager].shareType = StatisticalTypeQuse;
            publishContent = [ShareSDK content:discription
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:shopimage quality:1]
                                         title:content
                                           url:link   //参考例子：印象笔记扫描宝
                                   description:discription
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeSinaWeibo:
        {
            publishContent = [ShareSDK content:discription
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:shopimage quality:1]
                                         title:content
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:discription
                                     mediaType:SSPublishContentMediaTypeNews];
        }
            break;
        case ShareTypeWeixiTimeline:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfsUse;
            publishContent = [ShareSDK content:discription
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:shopimage quality:1]
                                         title:content
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:discription
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeWeixiSession:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfUse;
            publishContent = [ShareSDK content:discription
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:shopimage quality:1]
                                         title:content
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:discription
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            break;
        case ShareTypeQQ:
        {
            publishContent = [ShareSDK content:discription
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:shopimage quality:1]
                                         title:content
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:discription
                                     mediaType:SSPublishContentMediaTypeNews];
            
        }
            
        default:
        {
            //该分享未设置");
        }
            break;
    }
    
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionRight];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    id<ISSShareOptions> options = [ShareSDK defaultShareOptionsWithTitle:nil oneKeyShareList:[NSArray defaultOneKeyShareList] qqButtonHidden:NO wxSessionButtonHidden:NO wxTimelineButtonHidden:NO showKeyboardOnAppear:NO shareViewDelegate:self friendsViewDelegate:nil picViewerViewDelegate:nil];
    
    
    [ShareSDK showShareViewWithType:type container:container content:publishContent statusBarTips:YES authOptions:authOptions shareOptions:options result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        
        
        SHARESTATE st = STATE_BEGAN;
        
        if ([self.delegate respondsToSelector:@selector(DShareManagerStatus:withType:)]) {
            switch (state) {
                case SSResponseStateBegan:
                    st = STATE_BEGAN;
                    break;
                    
                case SSResponseStateSuccess:
                    st = STATE_SUCCESS;
                    
                    [self shareSuccessStatistic];
                    
                    break;
                    
                case SSResponseStateFail:
                    st = STATE_FAILED;
                    break;
                    
                case SSResponseStateCancel:
                    st = STATE_CANCEL;
                    break;
                    
                default:
                    break;
            }
        }
        
        if(self.fightIndianaBlock)
        {
            self.fightIndianaBlock(state);
        }
        
        [self.delegate DShareManagerStatus:st withType:nil];
        
    }];

}
#pragma mark - h5Share 点赞
- (void)sharePersonH5WithType:(ShareType)type withLinkShareType:(NSString*)sharetype withLink:(NSString *)link andImagePath:(NSString *)imagePath andTitle:(NSString *)title andContent:(NSString *)content {

    //分享域名替换
    NSString *currentStr = @"www.52yifu.com";
    if ([link containsString:@"www.52yifu.wang"]) {
        currentStr = @"www.52yifu.wang";
    }

    NSString *ShareUrlIP = [[NSUserDefaults standardUserDefaults]objectForKey:@"ShareUrlIP"];
    if (ShareUrlIP.length) {
        if (link.length) {
            [link stringByReplacingOccurrencesOfString:currentStr withString:ShareUrlIP];
        }
    }

    UIImage *img1=imagePath?[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]]]:[UIImage imageNamed:@"ShareToH5.jpg"];

    
    id<ISSContent> publishContent;
    switch (type) {
        case ShareTypeWeixiSession:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfUse;
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:img1 quality:1]

                                         title:title
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:content
                                     mediaType:SSPublishContentMediaTypeNews];

        }
            break;
        case ShareTypeWeixiTimeline:
        {
            [DataManager sharedManager].shareType = StatisticalTypeWxfsUse;
            publishContent = [ShareSDK content:content
                                defaultContent:content
                                         image:[ShareSDK jpegImageWithImage:img1 quality:1]
                                         title:title
                                           url:link    //参考例子：印象笔记扫描宝
                                   description:@""
                                     mediaType:SSPublishContentMediaTypeNews];

        }
            break;
        default:
        {
            //该分享未设置");
        }
            break;
    }

    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionRight];

    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];

    id<ISSShareOptions> options = [ShareSDK defaultShareOptionsWithTitle:nil oneKeyShareList:[NSArray defaultOneKeyShareList] qqButtonHidden:NO wxSessionButtonHidden:NO wxTimelineButtonHidden:NO showKeyboardOnAppear:NO shareViewDelegate:self friendsViewDelegate:nil picViewerViewDelegate:nil];
    [ShareSDK showShareViewWithType:type container:container content:publishContent statusBarTips:YES authOptions:authOptions shareOptions:options result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        //
        SHARESTATE st = STATE_BEGAN;
        if ([self.delegate respondsToSelector:@selector(DShareManagerStatus:withType:)]) {
            switch (state) {
                case SSResponseStateBegan:
                    st = STATE_BEGAN;
                    break;
                case SSResponseStateSuccess:
                    st = STATE_SUCCESS;
                    [self shareSuccessStatistic];
                    break;
                case SSResponseStateFail:
                    st = STATE_FAILED;
                    break;
                case SSResponseStateCancel:
                    st = STATE_CANCEL;
                    break;
                default:
                    break;
            }
        }

        [self.delegate DShareManagerStatus:st withType:sharetype];
    }];
}
@end
