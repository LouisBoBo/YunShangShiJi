//
//  CollecLikeTaskVC.m
//  YunShangShiJi
//
//  Created by zgl on 17/5/26.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CollecLikeTaskVC.h"
#import "GlobalTool.h"
#import "BaseModel.h"
#import "DShareManager.h"
#import "AppDelegate.h"

#import "TaskSignModel.h"
#import "VitalityModel.h"
#import "YFShareModel.h"

#import "TFWithdrawCashViewController.h"
#import "AXSampleNavBarTabViewController.h"
#import "SelectShareTypeViewController.h"

#import "TFPopBackgroundView.h"
#import "CFPopView.h"
#import "SUTableView.h"
#import "RawardTableViewCell.h"
#import "CLCountDownView.h"
#import "WSShiningLabel.h"

/*
 “ ranking”: “1”                             //名次
 “number”:” 3”                           //数量
 “content” :”啦啦啦啦”                             //内容
 “pic”:”1.png”                             //图片
 */
@interface RewardModel : NSObject
@property (nonatomic,strong)NSString *ranking;
@property (nonatomic,strong)NSString *number;
@property (nonatomic,strong)NSString *pic;
@property (nonatomic,strong)NSString *content;
@end
@implementation RewardModel

@end
#pragma mark - 1️⃣➢➢➢ WinnerModel
/*
 *
 user_id用户id
 nickname 用户昵称
 location 位置
 pic头像
 audio 语音
 ranking 名次
 content 内容
 period  期数
 */
@interface WinnerModel : BaseModel
@property (nonatomic,strong)NSString *user_id;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *location;
@property (nonatomic,strong)NSString *pic;
@property (nonatomic,strong)NSString *audio;
@property (nonatomic,strong)NSNumber *audioLength;
@property (nonatomic,strong)NSString *ranking;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSNumber *period;
@end
@implementation WinnerModel

@end

@interface WinnerVoiceModel : BaseModel
@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) NSArray *voice_list;
+ (void)httpGetVoiceListDataSuccess:(void(^)(id data))success;
@end
@implementation WinnerVoiceModel
+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[WinnerModel mappingWithKey:@"voice_list"],@"voice_list",nil];
    return mapping;
}
+ (void)httpGetVoiceListDataSuccess:(void(^)(id data))success {
    NSString *urlStr;
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];
    urlStr = [NSString stringWithFormat:@"point/praise_voice_list?version=%@&token=%@",VERSION,token];
    [self getDataResponsePath:urlStr success:success];
}
@end
/*
 user_id用户id
 nickname 用户昵称
 location 位置
 pic头像
 point_count 收到的总点赞数
 */
@interface AwardModel : BaseModel
@property (nonatomic,strong)NSNumber *user_id;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *location;
@property (nonatomic,strong)NSString *pic;
@property (nonatomic,strong)NSString *point_count;
@end
@implementation AwardModel

@end
@interface PraiseListModel : BaseModel
@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) NSArray *point_list;
+ (void)httpGetPraiseListDataSuccess:(void(^)(id data))success;
@end
@implementation PraiseListModel
+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[AwardModel mappingWithKey:@"point_list"],@"point_list",nil];
    return mapping;
}
+ (void)httpGetPraiseListDataSuccess:(void(^)(id data))success {
    NSString *urlStr;
    urlStr = [NSString stringWithFormat:@"point/praise_List?version=%@",VERSION];
    [self getDataResponsePath:urlStr success:success];
}
@end

#import "CFVoiceBubble.h"

#pragma mark - 1️⃣➢➢➢ CFWinnerTableViewCell
@interface CFWinnerTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *numLabel;
@property (nonatomic,strong)UIImageView *headImg;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *address;
@property (nonatomic,strong)CFVoiceBubble *bubble;
- (void)loadDataModel:(WinnerModel *)model;
@end
@implementation CFWinnerTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;

        CGFloat space = 7;
        _headImg=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), space, 40, 40)];
        _headImg.layer.cornerRadius=_headImg.height/2;
        _headImg.clipsToBounds=YES;
        [self addSubview:_headImg];
        _name=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImg.frame)+ZOOM6(10), space, kScreenWidth/2-ZOOM6(60)-40, 20)];
        _name.font=kFont6px(25);
        _name.textColor=kMainTitleColor;
        [self addSubview:_name];
        _address=[[UILabel alloc]initWithFrame:CGRectMake(_name.x, CGRectGetMaxY(_name.frame), _name.width, 20)];
        _address.textColor=kSubTitleColor;
        _address.font=kFont6px(25);
        [self addSubview:_address];
        _numLabel=[[UILabel alloc]initWithFrame:CGRectMake(_headImg.x, _headImg.bottom, kScreenWidth-ZOOM6(40), 80-50)];
        _numLabel.font=kFont6px(32);
        _numLabel.textColor=tarbarrossred;
        [self addSubview:_numLabel];

        _bubble = [[CFVoiceBubble alloc]initWithFrame:CGRectMake(kScreenWidth/2, space, ZOOM6(280), 40)];
        [self addSubview:_bubble];
    }
    return self;
}
- (void)loadDataModel:(WinnerModel *)model
{
    self.name.text = model.nickname;
    self.numLabel.text = [NSString stringWithFormat:@"获得%@等奖：%@",model.ranking,model.content];
    self.address.text = model.location.length!=0 && model.location && ![model.location containsString:@"null"] ? model.location : @"来自喵星";
    self.bubble.URLStr = [NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.audio];
    /*
    if (model.audioLength.length) {
        NSString *strTime = [NSString stringWithFormat:@"%@",model.audioLength];
        NSArray *array = [strTime componentsSeparatedByString:@":"];
        NSString *HH = array[0];
        NSString *MM= array[1];
        NSString *ss = array[2];
        NSInteger h = [HH integerValue];
        NSInteger m = [MM integerValue];
        NSInteger s = [ss integerValue];
        NSInteger hms = h*3600 + m*60 +s;
        self.bubble.audioLength=@(hms).stringValue;
    }
    */
    self.bubble.audioLength=model.audioLength.stringValue;

    //            cell.bubble.audioLength = model.audioLength;
    [model.pic hasPrefix:@"http"]?[self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]]]:[self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]]];
    if (model.audioLength.integerValue>=10) {
        self.bubble.frame = CGRectMake(kScreenWidth/2, 7, 35+ZOOM6(280)>kScreenWidth/2-ZOOM6(60)?kScreenWidth/2-ZOOM6(60):ZOOM6(280)+35, 40);
    }else if(model.audioLength.integerValue<=5){
        self.bubble.frame = CGRectMake(kScreenWidth/2, 7, ZOOM6(100), 40);
    }else {
        CGFloat width = ZOOM6(180)*model.audioLength.integerValue/5+ZOOM6(100);
        self.bubble.frame = CGRectMake(kScreenWidth/2, 7, width, 40);
    }
}
@end
#pragma mark - 1️⃣➢➢➢ CollecLikeTableViewCell
@interface CollecLikeTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *numImg;
@property (nonatomic,strong)UILabel *numLabel;
@property (nonatomic,strong)UIImageView *headImg;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *address;
@property (nonatomic,strong)UILabel *numLike;
@end
@implementation CollecLikeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        CGFloat space=5;
        _numImg=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), 25-ZOOM6(66)/2, ZOOM6(40), ZOOM6(66))];
        _numImg.contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:_numImg];
        _numLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), space, _numImg.width, 50-space*2)];
        _numLabel.textAlignment=NSTextAlignmentCenter;
        _numLabel.font=kFont6px(36);
        _numLabel.textColor=tarbarrossred;
        [self addSubview:_numLabel];
        _headImg=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numImg.frame)+ZOOM6(20), space, 50-space*2, 50-space*2)];
        _headImg.layer.cornerRadius=_headImg.height/2;
        _headImg.clipsToBounds=YES;
        [self addSubview:_headImg];
        _name=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImg.frame)+ZOOM6(10), 5, 150, 20)];
        _name.font=kFont6px(25);
        _name.textColor=kMainTitleColor;
        [self addSubview:_name];
        _address=[[UILabel alloc]initWithFrame:CGRectMake(_name.x, CGRectGetMaxY(_name.frame), 150, 20)];
        _address.textColor=kSubTitleColor;
        _address.font=kFont6px(25);
        [self addSubview:_address];
        _numLike=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-ZOOM6(20)*2-ZOOM6(20)-100, 0, 100, 50)];
        _numLike.font=kFont6px(30);
        _numLike.textAlignment=NSTextAlignmentRight;
        _numLike.textColor=tarbarrossred;
        [self addSubview:_numLike];
    }
    return self;
}

@end

#pragma mark - 1️⃣➢➢➢ CollecLikeTaskVC

@interface CollecLikeTaskVC ()<UITableViewDelegate,UITableViewDataSource,CLCountDownViewDelegate,DShareManagerDelegate,CFVoiceBubbleDelegate>
@property (assign, nonatomic) NSInteger currentRow;

@property (nonatomic, strong) NSTimer *mytimer;
@property (strong, nonatomic) UIImageView *tabheadview;          //导航条
@property (strong, nonatomic) UIScrollView *myScrollview;        //滑动视图
@property (strong, nonatomic) UIImageView *headView;             //头部
@property (strong, nonatomic) UITableView *ptyaRwardTableView;   //额度奖励列表
//@property (strong, nonatomic) UITableView *yiduRwardTableView;   //衣豆奖励列表
@property (strong, nonatomic) UITableView *collecLikeTableView;   //

@property (strong , nonatomic) UILabel *totalbalanceLab;         //总余额
@property (strong , nonatomic) UILabel *availablebalanceLab;     //可提现余额
@property (strong , nonatomic) UILabel *frozenyidouLab;          //可用衣豆
@property (strong , nonatomic) UILabel *availableyidouLab;       //累计集赞

//额度数据
@property (strong, nonatomic) NSMutableArray*fictitiousPtyaArray;//虚拟奖励数据
@property (strong, nonatomic) NSMutableArray*realPtyaArray;      //真实奖励数据
@property (strong, nonatomic) NSMutableArray*totalPtyaArray;     //总奖励数据
@property (strong, nonatomic) NSMutableArray*dataArr;   //排行榜奖励数据
@property (strong, nonatomic) NSMutableArray*rewardDataArr;   //排行榜奖励数据
@property (strong, nonatomic) NSMutableArray*winnerDataArr;   //获奖者数据
@property (strong, nonatomic) NSMutableArray*collecLikeArray;     //集赞

@property (strong, nonatomic) UIView *shareView;                   //分享视图
@property (nonatomic , strong) DShareManager *shareManager;

@end

@implementation CollecLikeTaskVC
{
    int _ptyacount;
    
    int _peas;               //可用衣豆
    int _peas_free;          //冻结衣豆
    int _point_count;        //累计集赞
    float _extract;          //可提现额度
    float _ex_free;          //冻结额度
    float _balance;          //总余额
    float _freeze_balance;
    NSString *today_rewards,*oldFriends,*newFriends;
    NSString *shareDiscription,*shareTitle,*imgPathUrl,*linkUrl;

    UIView *ScrContainer;
    UIView *activityRulesView;
    UIView *monthRewardView;
    UIImageView *rewardView;
    UIView *collecLikeView;
    UIView *winnerView;
    UILabel *winnerPeriodNum;
    UITableView *winnerTable;

    UIView *shareBG;
    WSShiningLabel *wssLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentRow=-1;
    
    [self creatUI];
    [self creatData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        wssLabel.isPlaying = false;
        [wssLabel startShimmer];
    });

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /*
    NSString *popcount = [[NSUserDefaults standardUserDefaults]objectForKey:JIZAN_POPUP];
    if(popcount.intValue <2)
    {
        [self creatActivityRulesView];
        popcount = [NSString stringWithFormat:@"%d",popcount.intValue+1];
        [[NSUserDefaults standardUserDefaults] setObject:popcount forKey:JIZAN_POPUP];
    }
    */
}
- (void)creatData
{
    RawardModel *model = [RawardModel alloc];
    
    [self.fictitiousPtyaArray addObjectsFromArray:[model getPtyaModel:2]];
    
    [self.totalPtyaArray addObjectsFromArray:self.fictitiousPtyaArray];
    
    [self.ptyaRwardTableView reloadData];

    [self httpActivityRule];
    [self httpGetData];
    [self geteduHttp];
    [self httpActivityAward];
    [self httpDayReward];
    [self httpPraiseList];
    [self httpWinnerVoiceList];
}
- (NSTimeInterval )getMonthBeginAndEndWith:(NSDate *)newDate{
    if (newDate == nil) {
        newDate = [NSDate date];
    }
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return 0;
    }
    /*
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];

    NSString *nowDate = [myDateFormatter stringFromDate:[NSDate date]];
    NSString *s = [NSString stringWithFormat:@"%@-%@",beginString,endString];
    */
    
//    NSLog(@"%@ %@ %f %f",s,nowDate,nowTime,endTime);
    NSTimeInterval nowTime = [NSDate date].timeIntervalSince1970;
    NSTimeInterval endTime = [endDate timeIntervalSince1970];
    return endTime-nowTime;
}

- (void)httpWinnerVoiceList {
    kSelfWeak;
    [WinnerVoiceModel httpGetVoiceListDataSuccess:^(id data) {
        WinnerVoiceModel *model=data;
        kSelfStrong;
        if (model.voice_list.count) {
            [strongSelf.winnerDataArr addObjectsFromArray:model.voice_list];
            [strongSelf -> winnerTable reloadData];
            [strongSelf updateWinnerViewConstraint];
        }else{
            winnerView.hidden=YES;
            [winnerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(monthRewardView.mas_bottom);
                make.height.offset(0);
            }];
        }
    }];
}
/**
 集赞奖励排行榜
 */
- (void)httpPraiseList {
    kSelfWeak;
    [PraiseListModel httpGetPraiseListDataSuccess:^(id data) {
        PraiseListModel *model=data;
        if (model.point_list.count) {
            [weakSelf.dataArr addObjectsFromArray:model.point_list];
            [weakSelf.collecLikeTableView reloadData];
        }
    }];
}
/**
 每日奖励
 */
- (void)httpDayReward {
   
    [[APIClient sharedManager] netWorkGeneralRequestWithApi: @"point/dailyRewards?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {
            oldFriends = [NSString stringWithFormat:@"%@",data[@"oldFriends"]];
            newFriends = [NSString stringWithFormat:@"%@",data[@"newFriends"]];
            today_rewards = [NSString stringWithFormat:@"%.2f",[data[@"today_rewards"]floatValue]];
        }
    } failure:^(NSError *error) {
        
    }];
}
//获取余额
- (void)httpGetData
{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *token = [ud objectForKey:USER_TOKEN];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@wallet/myWallet?version=%@&token=%@",[NSObject baseURLStr],VERSION,token];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                
                _balance = [[NSString stringWithFormat:@"%@",responseObject[@"balance"]] floatValue];
                _freeze_balance = [[NSString stringWithFormat:@"%@",responseObject[@"freeze_balance"]] floatValue];

                _extract = [[NSString stringWithFormat:@"%@",responseObject[@"extract"]] floatValue];
                _peas = [[NSString stringWithFormat:@"%@",responseObject[@"peas"]] intValue];
                _peas_free = [[NSString stringWithFormat:@"%@",responseObject[@"peas_free"]] intValue];
                _ex_free = [[NSString stringWithFormat:@"%@",responseObject[@"ex_free"]] floatValue];
                _point_count = [[NSString stringWithFormat:@"%@",responseObject[@"point_count"]] intValue];
                [self refrestHeadUI];
            } else {
                //                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
    
}
//获取额度
- (void)geteduHttp
{
    NSString *urlStr1 = [NSString stringWithFormat:@"%@point/popup_List?version=%@",[NSObject baseURLStr],VERSION];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            NSArray *dataArr ;

            if ([responseObject[@"status"] intValue] == 1)
            {
                if(responseObject[@"popup_List"])
                {
                    dataArr = responseObject[@"popup_List"];
                    for(int i = 0;i<dataArr.count;i++)
                    {
                        NSString *jsonstr = dataArr[i];
                        
                        [self getDataFromstr:jsonstr Type:1];
                    }
                    
                    [self getNeWArray];
                }
            }
            else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}
//查询集赞活动奖品

- (void)httpActivityAward {
    NSString *urlStr1 = [NSString stringWithFormat:@"%@signIn2_0/queryCollectionPraise?version=%@&token=%@",[NSObject baseURLStr],VERSION,[[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN]];
    NSString *URL1 = [MyMD5 authkey:urlStr1];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URL1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        responseObject = [NSDictionary changeType:responseObject];
        
        if (responseObject!=nil) {
            
            NSArray *dataArr ;
            
            if ([responseObject[@"status"] intValue] == 1)
            {
                if(responseObject[@"data"])
                {
                    dataArr = responseObject[@"data"];
                    for(int i = 0;i<dataArr.count;i++)
                    {
                        NSDictionary *dic=dataArr[i];
                        RewardModel *model=[[RewardModel alloc]init];
                        model.pic=dic[@"pic"];
                        model.content=dic[@"content"];
                        model.number=dic[@"number"];
                        model.ranking=dic[@"ranking"];
                        [self.rewardDataArr addObject:model];
                    }
                    
                }
                [self reloadRewardView];
            }
            else {
                [MBProgressHUD showError:responseObject[@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络连接失败,请检查网络设置"];
    }];
}
- (void)httpActivityRule {
    NSString *url= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];

    NSURL *httpUrl=[NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];

        if (responseObject!=nil) {
            shareDiscription=responseObject[@"fxyq"][@"text"];
            shareTitle=responseObject[@"fxyq"][@"title"];
            NSString *pic=[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], responseObject[@"fxyq"][@"icon"]];

            imgPathUrl=[[NSUserDefaults standardUserDefaults]objectForKey:USER_WX_HEADPIC];
            linkUrl = [NSString stringWithFormat:@"%@view/activity/mission.html?realm=%@",[NSObject baseURLStr_H5],[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];

            if (imgPathUrl==nil) {
                imgPathUrl=pic;
            }
            if (responseObject[@"jzjl"]) {
                [self reloadActivityRulesView:responseObject[@"jzjl"][@"n1"] label2Str:responseObject[@"jzjl"][@"n2"] lablel3Str:responseObject[@"jzjl"][@"n3"] label5_1Str:responseObject[@"jzjl"][@"n4-1"] label5_2Str:responseObject[@"jzjl"][@"n4-2"] label7Str:responseObject[@"jzjl"][@"n6"]];

            }
        }
    }

    /*
    [[APIClient sharedManager]netWorkGeneralRequestWithApi:@"signIn2_0/queryText?" caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {
        if (response.status == 1) {

            NSDictionary *responseDic=data;
            NSString *str=responseDic[@"data"];
            NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&err];

            if (arr.count) {
                NSDictionary *dic=arr[0];

                //                NSString *discription=@"快来为我点赞，即奖10元现金，每月更可赢千元任务奖励。";
                //                NSString *title = @"对方不想和你说话，并且向你扔了10元。";
                shareDiscription=dic[@"txt"];
                shareTitle=dic[@"title"];
                NSString *pic=[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy], dic[@"png"]];

                imgPathUrl=[[NSUserDefaults standardUserDefaults]objectForKey:USER_WX_HEADPIC];
                linkUrl = [NSString stringWithFormat:@"%@view/activity/mission.html?realm=%@",[NSObject baseURLStr_H5],[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];

                if (imgPathUrl==nil) {
                    imgPathUrl=pic;
                }
            }
            NSString *str2=responseDic[@"jzjl"];
            NSData *jsonData2 = [str2 dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err2;
            NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:jsonData2
                                                           options:NSJSONReadingMutableContainers
                                                             error:&err2];
            [self reloadActivityRulesView:dic2[@"n1"] label2Str:dic2[@"n2"] lablel3Str:dic2[@"n3"] label5_1Str:dic2[@"n4-1"] label5_2Str:dic2[@"n4-2"] label7Str:dic2[@"n6"]];
        }
    } failure:^(NSError *error) {

    }];
     */
}
#pragma mark - *********************UI界面***********************
- (void)creatUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatNavagationbar];
    
    [self creatLuckMainView];
}
//主界面
- (void)creatLuckMainView
{
    
    self.myScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.tabheadview.bottom, kScreenWidth, kScreenHeight-Height_NavBar-ZOOM6(120))];
    self.myScrollview.userInteractionEnabled = YES;
    self.myScrollview.backgroundColor = RGBCOLOR_I(242, 24, 64);
    self.myScrollview.contentMode =UIViewContentModeScaleAspectFill;
    self.myScrollview.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:self.myScrollview];

    ScrContainer = [UIView new];
    [self.myScrollview addSubview:ScrContainer];
    [ScrContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_myScrollview);
        make.width.equalTo(_myScrollview);
    }];
//    [self.myScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tabheadview.mas_bottom);
//        make.left.right.equalTo(self.view);
//        make.height.equalTo(@(kScreenHeight-64-ZOOM6(120)));
//
//    }];

    UIButton *getyibtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    getyibtn.backgroundColor = tarbarrossred;
    [getyibtn setTintColor:[UIColor whiteColor]];
    getyibtn.layer.cornerRadius = 5;
    getyibtn.titleLabel.font = [UIFont systemFontOfSize:ZOOM6(36)];
    NSString *title = @"马上去集赞";
    [getyibtn setTitle:title forState:UIControlStateNormal];
    [getyibtn addTarget:self action:@selector(collecLike) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getyibtn];
   
    
    [getyibtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myScrollview.mas_bottom).offset(ZOOM6(20));
        make.left.equalTo(self.myScrollview).offset(ZOOM6(20));
        make.right.equalTo(self.myScrollview).offset(-ZOOM6(20));
        make.height.equalTo(@ZOOM6(80));
    }];
    
    
    [self creatHeadView];
    [self creatActivityRulesView];
    [self creatMonthRewardView];
//    [self creatLuckView];
    [self creatWinnerView];

    [self creatCollecLikeTableView];
    [self creatTabview];
//    [self creatDayRewardView];
}
- (void)updateWinnerViewConstraint
{
    WinnerModel *model = self.winnerDataArr[0];
    winnerPeriodNum.text = [NSString stringWithFormat:@"%zd期",model.period.intValue];
    [winnerTable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(self.winnerDataArr.count*80);
    }];
}
- (void)creatWinnerView
{
    winnerView = [[UIView alloc]init];
    winnerView.backgroundColor=[UIColor clearColor];
    [ScrContainer addSubview:winnerView];

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, kScreenWidth-ZOOM6(20)*2, 55+ZOOM6(20))];
    title.backgroundColor=[UIColor whiteColor];
    title.textColor = tarbarrossred;
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"获奖者感言";
    title.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
    [winnerView addSubview:title];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(40), ZOOM6(20), 60, 50)];
    img.image = [UIImage imageNamed:@"集赞语音00"];
    img.contentMode = UIViewContentModeScaleAspectFit;
    [winnerView addSubview:img];
    winnerPeriodNum=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(10), 0, img.width, img.height/2)];
    winnerPeriodNum.text = @"01期";
    winnerPeriodNum.textColor = [UIColor whiteColor];
    winnerPeriodNum.font = kFont6px(20);
    [img addSubview:winnerPeriodNum];

    winnerTable=[[UITableView alloc]init];
    winnerTable.layer.cornerRadius=5;
    [winnerTable registerClass:[CFWinnerTableViewCell class] forCellReuseIdentifier:@"winnerTable"];
    winnerTable.dataSource=self;
    winnerTable.delegate=self;
//    winnerTable.scrollEnabled = NO;
    winnerTable.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    winnerTable.showsVerticalScrollIndicator = NO;
    winnerTable.separatorColor=kTableLineColor;
    [winnerView addSubview:winnerTable];

    [winnerTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(50+ZOOM6(20));
        make.left.offset(ZOOM6(20));
        make.height.offset(0);
        make.width.offset(kScreenWidth-ZOOM6(20)*2);
    }];

    [winnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(monthRewardView.mas_bottom).offset(-5);
        make.left.offset(0);
        make.bottom.equalTo(winnerTable.mas_bottom);
        make.width.offset(kScreenWidth);
    }];

}
//头部
- (void)creatHeadView
{
//    CGFloat headheight = kScreenWidth*1.29;

    self.headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(710))];
    self.headView.userInteractionEnabled = YES;
    self.headView.image = [UIImage imageNamed:@"点赞-bg"];
    [ScrContainer addSubview:self.headView];
    
    UIImageView *headimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, kScreenWidth-ZOOM6(20)*2, ZOOM6(130))];
    headimage.image = [UIImage imageNamed:@"bg_top"];
    headimage.userInteractionEnabled = YES;
    [self.headView addSubview:headimage];
    
    CGFloat labwith = CGRectGetWidth(headimage.frame)/3;
    CGFloat labheigh = CGRectGetHeight(headimage.frame);
    
    //总余额 提现额度
    for(int i = 0;i<3;i++)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(30)+labwith*i, ZOOM6(10), labwith, labheigh-ZOOM6(20))];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:ZOOM6(30)];
        lable.numberOfLines = 0;;
        lable.textColor = [UIColor redColor];
        if(i==0)
        {
            NSString *str = @"0.00";
            lable.text = [NSString stringWithFormat:@"%.2f\n总金额(元)",[str floatValue]];
            [self getBalancemutable:lable Text:str];
            
            self.totalbalanceLab = lable;
            
        }else if (i == 1)
        {
            NSString *str = @"0.00";
            lable.text = [NSString stringWithFormat:@"%.2f\n可提现(元)",[str floatValue]];
            [self getBalancemutable:lable Text:str];
            
            self.availablebalanceLab = lable;
        }else{
            lable.frame = CGRectMake(CGRectGetWidth(headimage.frame)-ZOOM6(180), (labheigh - ZOOM6(60))/2+ZOOM6(10), ZOOM6(160), ZOOM6(60));
            lable.userInteractionEnabled = YES;
            lable.backgroundColor = tarbarrossred;
            lable.textColor = [UIColor whiteColor];
            lable.clipsToBounds = YES;
            lable.layer.cornerRadius = 5;
            lable.text = @"提现";
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tixian)];
            [lable addGestureRecognizer:tap];
        }
        
        [headimage addSubview:lable];
    }
    
    CGFloat yilabWith =(CGRectGetWidth(self.headView.frame) - ZOOM6(40)*3)/3;
    //可用衣豆 提现衣豆
    for(int i =0;i<2;i++)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(40)+(yilabWith+ZOOM6(40))*i, ZOOM6(160), yilabWith, ZOOM6(40))];
        lable.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//        RGBCOLOR_I(87, 66, 129);
        lable.font = [UIFont systemFontOfSize:ZOOM6(24)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        lable.layer.cornerRadius = ZOOM6(40)/2;
        lable.clipsToBounds = YES;
        lable.tag = 20000+i;
        
        NSString *str = @"0";
        if(i == 0)
        {
            lable.text = [NSString stringWithFormat:@"累计集赞:%@",str];
            self.availableyidouLab = lable;
            
        }else if (i == 1)
        {
            lable.text = [NSString stringWithFormat:@"可用衣豆:%@",str];
            self.frozenyidouLab = lable;
        }
        if (i == 1){
        lable.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(yidoumingxi:)];
        [lable addGestureRecognizer:tap];
        }
        NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lable.text];
        [mutable addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(30)] range:NSMakeRange(5, str.length)];
        [lable setAttributedText:mutable];
        
        [self.headView addSubview:lable];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(CGRectGetWidth(self.headView.frame)-ZOOM6(200), ZOOM6(160), ZOOM6(160), ZOOM6(40));
    [button setBackgroundImage:[UIImage imageNamed:@"edmx"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Quotadetail) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:button];
    /*
    UIButton *activtyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [activtyBtn setTitle:@"活\n动\n规\n则" forState:UIControlStateNormal];
    activtyBtn.layer.cornerRadius=3;
    [activtyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [activtyBtn setBackgroundColor:RGBA(255, 207, 0, 1)];
    activtyBtn.frame=CGRectMake(kScreenWidth-ZOOM6(65), 64+CGRectGetMaxY(button.frame)+ZOOM6(30), ZOOM6(70), ZOOM6(180));
    [activtyBtn addTarget:self action:@selector(creatActivityRulesView) forControlEvents:UIControlEventTouchUpInside];
    activtyBtn.titleLabel.font=[UIFont boldSystemFontOfSize:ZOOM6(30)];
    activtyBtn.titleLabel.numberOfLines=4;
    activtyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:activtyBtn];
    
    wssLabel = [[WSShiningLabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(activtyBtn.frame)-ZOOM6(30))/2, ZOOM6(30)/2, CGRectGetWidth(activtyBtn.frame), CGRectGetHeight(activtyBtn.frame))];
    wssLabel.text = @"活\n动\n规\n则\n";
    wssLabel.textColor = [UIColor redColor];
    wssLabel.font = [UIFont boldSystemFontOfSize:ZOOM6(30)];
    wssLabel.numberOfLines=5;
    wssLabel.durationTime = 1.5;
    wssLabel.shimmerColor = [UIColor whiteColor];
    wssLabel.userInteractionEnabled=YES;
    [wssLabel startShimmer];
    [activtyBtn addSubview:wssLabel];

    
    UIButton *clickbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    clickbutton.frame = CGRectMake(0, 0, CGRectGetWidth(activtyBtn.frame), CGRectGetHeight(activtyBtn.frame));
    clickbutton.backgroundColor = [UIColor clearColor];
    [clickbutton addTarget:self action:@selector(creatActivityRulesView) forControlEvents:UIControlEventTouchUpInside];
    [activtyBtn addSubview:clickbutton];
     */

    UIButton *todayReward=[UIButton buttonWithType:UIButtonTypeCustom];
    [todayReward setTitle:@"今\n日\n奖\n励" forState:UIControlStateNormal];
    todayReward.layer.cornerRadius=3;
    [todayReward setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [todayReward setBackgroundColor:RGBA(255, 207, 0, 1)];
    todayReward.frame=CGRectMake(kScreenWidth-ZOOM6(65), 64+CGRectGetMaxY(button.frame)+ZOOM6(100)+ZOOM6(12), ZOOM6(70), ZOOM6(160));
    [todayReward addTarget:self action:@selector(creatDayRewardView) forControlEvents:UIControlEventTouchUpInside];
    todayReward.titleLabel.font=[UIFont boldSystemFontOfSize:ZOOM6(30)];
    todayReward.titleLabel.numberOfLines=4;
    todayReward.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:todayReward];
}

- (void)reloadActivityRulesView:(NSString *)label1Str label2Str:(NSString *)label2Str lablel3Str:(NSString *)label3Str label5_1Str:(NSString *)label5_1Str label5_2Str:(NSString *)label5_2Str label7Str:(NSString *)label7Str   {
    UILabel *label1=[activityRulesView viewWithTag:100+1];
    UILabel *label2=[activityRulesView viewWithTag:100+2];
    UILabel *label3=[activityRulesView viewWithTag:100+3];
    UILabel *label4=[activityRulesView viewWithTag:100+4];
    UILabel *label7=[activityRulesView viewWithTag:100+7];

    NSString *str1=[NSString stringWithFormat:@"1、点击底部%@按钮即可分享集赞任务页到朋友圈或微信好友，让好友们来帮助集赞。",label1Str];
    NSString *str2=[NSString stringWithFormat:@"2、好友未注册衣蝠，首次为你点赞，你可获得平台%@提现奖励。",label2Str];
    NSString *str3=[NSString stringWithFormat:@"3、好友已注册衣蝠，每次为你点赞，你可获得平台%@提现奖励",label3Str];
    NSString *str4=[NSString stringWithFormat:@"如你今日邀请了25名微信好友为你点赞，当日你即可获得%@首次点赞奖励，外加每日5元点赞奖励。每月轻松得到%@提现现金奖励哦。",label5_1Str,label5_2Str];
    NSString *str7=[NSString stringWithFormat:@"6、每月集赞数排名前6的同学更可获得当月%@大奖，加油吧。",label7Str];
    [label1 setAttributedText:[NSString getOneColorInLabel:str1 ColorString:label1Str Color:RGBA(255, 207, 0, 1) fontSize:ZOOM6(30)]];
    [label2 setAttributedText:[NSString getOneColorInLabel:str2 ColorString:label2Str Color:RGBA(255, 207, 0, 1) fontSize:ZOOM6(30)]];
    [label3 setAttributedText:[NSString getOneColorInLabel:str3 ColorString:label3Str Color:RGBA(255, 207, 0, 1) fontSize:ZOOM6(30)]];
    [label4 setAttributedText:[NSString getOneColorInLabel:str4 strs:@[label5_1Str,label5_2Str] Color:RGBA(255, 207, 0, 1) fontSize:ZOOM6(24)]];
    [label7 setAttributedText:[NSString getOneColorInLabel:str7 ColorString:label7Str Color:RGBA(255, 207, 0, 1) fontSize:ZOOM6(30)]];

}
//活动规则
- (void)creatActivityRulesView {
    /*
    CFPopView *view=[[CFPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) textStr:@"活动规则" popType:CFPopTypeRed];
    view.discriptionData=@[@"1.分享集赞任务页到朋友圈或微信好友，即可让好友来帮助集赞",
                           @"2.好友未注册衣蝠，首次为你点赞，你可获得平台1元提现奖励",
                           @"3.好友已注册衣蝠，每次为你点赞，你可获得平台0.1元提现奖励",
                           @"4.每月平台集赞数排名前5的同学即可获得当月大奖",
                           @"5.每个用户每天仅有一次免费点赞的机会，可以使用5个衣豆兑换一次点赞机会哦",
                           @"6.衣蝠是女装平台，仅限女性好友点赞。只能为他人点赞，不能为自己点赞哦。(苹果不是赞助商)"];
    [view show];
    */

    activityRulesView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)-ZOOM6(70), kScreenWidth, 35+ZOOM6(80)*8+ZOOM6(20)*8)];
    [ScrContainer addSubview:activityRulesView];

    UIImageView *titleimage = [[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), 15, kScreenWidth-ZOOM6(20)*2, 20)];
    titleimage.image=[UIImage imageNamed:@"点赞-hdgz"];
//    titleimage.backgroundColor=[UIColor whiteColor];
    titleimage.contentMode=UIViewContentModeScaleAspectFit;
    [activityRulesView addSubview:titleimage];

    UILabel *label1=[[UILabel alloc]init];
    label1.font=kFont6px(30);
    label1.numberOfLines=0;
    label1.tag=100+1;
    label1.textColor=[UIColor whiteColor];
//    [label1 setAttributedText:[NSString getOneColorInLabel:@"1、点击底部“马上去集赞”按钮即可分享集赞任务页到朋友圈或微信好友，让好友们来帮助集赞。" ColorString:@"“马上去集赞”" Color:RGBA(255, 207, 0, 1) fontSize:ZOOM6(30)]];
    [activityRulesView addSubview:label1];
    UILabel *label2=[[UILabel alloc]init];
    label2.font=kFont6px(30);
    label2.numberOfLines=0;
    label2.tag=100+2;
    label2.textColor=[UIColor whiteColor];
//    [label2 setAttributedText:[NSString getOneColorInLabel:@"2、好友未注册衣蝠，首次为你点赞，你可获得平台1元提现奖励。" ColorString:@"1元" Color:RGBA(255, 207, 0, 1) fontSize:ZOOM6(30)]];
    [activityRulesView addSubview:label2];
    UILabel *label3=[[UILabel alloc]init];
    label3.font=kFont6px(30);
    label3.numberOfLines=0;
    label3.tag=100+3;
    label3.textColor=[UIColor whiteColor];
//    [label3 setAttributedText:[NSString getOneColorInLabel:@"3、好友已注册衣蝠，每次为你点赞，你可获得平台0.1元提现奖励" ColorString:@"0.1元" Color:RGBA(255, 207, 0, 1) fontSize:ZOOM6(30)]];
    [activityRulesView addSubview:label3];
    UILabel *label4=[[UILabel alloc]init];
    label4.font=kFont6px(24);
    label4.numberOfLines=0;
    label4.tag=100+4;
    label4.textColor=[UIColor whiteColor];
//    [label4 setAttributedText:[NSString getOneColorInLabel:@"如你今日邀请了25名微信好友为你点赞，当日你即可获得50元首次点赞奖励，外加每日5元点赞奖励。每月轻松得到200元提现现金奖励哦。" strs:@[@"100元",@"400元"] Color:RGBA(255, 207, 0, 1) fontSize:ZOOM6(24)]];
    [activityRulesView addSubview:label4];
    UILabel *label5=[[UILabel alloc]init];
    label5.font=kFont6px(30);
    label5.numberOfLines=0;
    label5.tag=100+5;
    label5.textColor=[UIColor whiteColor];
    label5.text=@"4、邀请的好友必须下载并注册成为衣蝠用户方可点赞。每个用户每天仅有一次免费点赞机会，可以使用5个衣豆兑换一次点赞机会。";
    [activityRulesView addSubview:label5];
    UILabel *label6=[[UILabel alloc]init];
    label6.text=@"5、只能为他人点赞，不能为自己点赞哦。你也可以每天为你的好友点赞。";
    label6.font=kFont6px(30);
    label6.numberOfLines=0;
    label6.tag=100+6;
    label6.textColor=[UIColor whiteColor];
    [activityRulesView addSubview:label6];
    UILabel *label7=[[UILabel alloc]init];
    label7.font=kFont6px(30);
    label7.numberOfLines=0;
    label7.tag=100+7;
    label7.textColor=[UIColor whiteColor];
//    [label7 setAttributedText:[NSString getOneColorInLabel:@"6、每月集赞数排名前6的同学更可获得当月5000元大奖，加油吧。" ColorString:@"5000元" Color:RGBA(255, 207, 0, 1) fontSize:ZOOM6(30)]];
    [activityRulesView addSubview:label7];
    UILabel *label8=[[UILabel alloc]init];
    label8.text=@"7、集赞活动仅限女性用户参与哦，最终解释权归衣蝠平台所有。(苹果不是赞助商)";
    label8.font=kFont6px(30);
    label8.numberOfLines=0;
    label8.tag=100+8;
    label8.textColor=[UIColor whiteColor];
    [activityRulesView addSubview:label8];

    [activityRulesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(CGRectGetMaxY(self.headView.frame)-ZOOM6(70));
        make.width.offset(kScreenWidth);
        make.height.offset(35+ZOOM6(80)*8+ZOOM6(20)*7);
    }];
    [titleimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kScreenWidth);
        make.height.offset(20);
    }];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(ZOOM6(20));
        make.top.equalTo(titleimage.mas_bottom).offset(ZOOM6(20));
        make.width.equalTo(@(kScreenWidth-ZOOM6(20)*2));
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label1.mas_bottom).offset(ZOOM6(20));;
        make.width.equalTo(label1.mas_width);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label2.mas_bottom).offset(ZOOM6(20));;
        make.width.equalTo(label1.mas_width);
    }];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label3.mas_bottom);
        make.width.equalTo(label1.mas_width);
    }];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label4.mas_bottom).offset(ZOOM6(20));
        make.width.equalTo(label1.mas_width);
    }];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label5.mas_bottom).offset(ZOOM6(20));;
        make.width.equalTo(label1.mas_width);
    }];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label6.mas_bottom).offset(ZOOM6(20));;
        make.width.equalTo(label1.mas_width);
    }];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_left);
        make.top.equalTo(label7.mas_bottom).offset(ZOOM6(20));;
        make.bottom.equalTo(activityRulesView.mas_bottom);
        make.width.equalTo(label1.mas_width);
    }];

}
//本月大奖
- (void)creatMonthRewardView {
    monthRewardView=[[UIView alloc]init];
//    monthRewardView.frame=CGRectMake(ZOOM6(20), CGRectGetMaxY(self.headView.frame)-ZOOM6(70), kScreenWidth-ZOOM6(20)*2, 35+ZOOM6(210)+ZOOM6(720)+ZOOM6(20));
    monthRewardView.frame=CGRectMake(ZOOM6(20), CGRectGetMaxY(activityRulesView.frame)+ZOOM6(20), kScreenWidth-ZOOM6(20)*2, 35+ZOOM6(210)+ZOOM6(720)+ZOOM6(20));
    monthRewardView.backgroundColor=[UIColor whiteColor];
    monthRewardView.layer.cornerRadius=5;
    
    CGFloat imageHeigh = 20;
    UIImageView *titleimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(monthRewardView.frame)-imageHeigh*7.5)/2, 15, imageHeigh*7.5, imageHeigh)];
    titleimage.image=[UIImage imageNamed:@"点赞-bydj"];
    [monthRewardView addSubview:titleimage];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleimage.frame)+ZOOM6(50), monthRewardView.width, ZOOM6(40))];
    titleLabel.textColor=kMainTitleColor;
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=kFont6px(30);
    [titleLabel setAttributedText:[NSString getAllColorStringInLabel:@"——— 活动结束倒计时 ———" ColorString:@"———" Color:RGBA(168, 168, 168, 1) fontSize:ZOOM6(30)]];
//    titleLabel.text=@"———— 活动结束倒计时 ————";
    [monthRewardView addSubview:titleLabel];
    
    CLCountDownView *countDownView =  [[CLCountDownView alloc] initWithFrame:CGRectMake(monthRewardView.width/2-ZOOM6(200), CGRectGetMaxY(titleLabel.frame)+ZOOM6(10), ZOOM6(400), ZOOM6(60))];
    countDownView.delegate = self;
    countDownView.themeColor = [UIColor blackColor];
    countDownView.countDownTimeInterval = [self getMonthBeginAndEndWith:nil];
    countDownView.textTimeColor = [UIColor whiteColor];
    countDownView.countDownType=CountDownUseChar;
    [monthRewardView addSubview:countDownView];

    rewardView=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(countDownView.frame)+ZOOM6(50), monthRewardView.width-ZOOM6(20)*2, ZOOM6(720))];
    rewardView.image=[UIImage imageNamed:@"点赞-Prize02"];
    [monthRewardView addSubview:rewardView];
    
    NSArray *arr=@[@"5000",@"3000",@"1000"];
    for (int i=0; i<arr.count; i++) {
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(104), ZOOM6(160)+i*(ZOOM6(42)+ZOOM6(140)), ZOOM6(160), ZOOM6(140))];
        img.image=[UIImage imageNamed:[NSString stringWithFormat:@"点赞-%@",arr[i]]];
        img.tag=100+i;
        [rewardView addSubview:img];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img.frame)+ZOOM6(50), img.y, rewardView.width/2, img.height)];
        label.textColor=tarbarrossred;
        label.font=kFont6px(36);
        label.numberOfLines=2;
        label.tag=110+i;
        NSString *str;NSString *colorStr;
        if (i==0) {
            str=@"一等奖：1名\n现金5000元";colorStr=@"现金5000元";
        }else if (i==1) {
            str=@"二等奖：2名\n现金3000元";colorStr=@"现金3000元";
        }else if (i==2) {
            str=@"三等奖：3名\n现金1000元";colorStr=@"现金1000元";
        }
        [label setAttributedText:[self getOneColorInLabel:str ColorString:colorStr Color:tarbarrossred fontSize:ZOOM6(40)]];
        [rewardView addSubview:label];
    }

    [ScrContainer addSubview:monthRewardView];

    [monthRewardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CGRectGetMaxY(activityRulesView.frame)+ZOOM6(20));
        make.left.offset(ZOOM6(20));
        make.width.offset(kScreenWidth-ZOOM6(20)*2);
        make.height.offset(35+ZOOM6(210)+ZOOM6(720)+ZOOM6(20));
    }];
}
- (void)reloadRewardView {
    for (int i=0; i<self.rewardDataArr.count; i++) {
        RewardModel *model = self.rewardDataArr[i];

        UIImageView *img=[rewardView viewWithTag:100+i];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]]];
        UILabel *label=[rewardView viewWithTag:110+i];

        NSString *colorStr=[NSString stringWithFormat:@"%@",model.content];
        NSString *num;
        if (i==0) {
            num=@"一";
        }else if (i==1) {
            num=@"二";
        }else if (i==2) {
            num=@"三";
        }
        NSString *str=[NSString stringWithFormat:@"%@等奖：%@名\n%@",num,model.number,colorStr];
        
        [label setAttributedText:[self getOneColorInLabel:str ColorString:colorStr Color:tarbarrossred fontSize:ZOOM6(40)]];
    }
}
- (void)countDownDidFinished {
    
}
//列表 集赞排名（显示前六名） 额度奖励
- (void)creatCollecLikeTableView {
    collecLikeView=[[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(monthRewardView.frame)+ZOOM6(20), kScreenWidth-ZOOM6(20)*2, 55+50*6)];
    collecLikeView.backgroundColor=[UIColor whiteColor];
    collecLikeView.layer.cornerRadius=5;
    //collecLikeView.clipsToBounds=YES;
    
    
    CGFloat imageHeigh = 20;
    UIImageView *titleimage = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(collecLikeView.frame)-imageHeigh*7.5)/2, 15, imageHeigh*7.5, imageHeigh)];
//    titleimage.contentMode=UIViewContentModeScaleAspectFit;
    titleimage.image = [UIImage imageNamed:@"点赞-jzpm"];
    [collecLikeView addSubview:titleimage];
    
    UITableView *tabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(collecLikeView.frame), 50*6) style:UITableViewStylePlain];
    tabview.delegate = self;
    tabview.dataSource = self;
    tabview.scrollEnabled = NO;
//    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabview.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    tabview.showsVerticalScrollIndicator = NO;
    tabview.separatorColor=kTableLineColor;
    self.collecLikeTableView=tabview;
    [collecLikeView addSubview:tabview];
    
    [ScrContainer addSubview:collecLikeView];

    [collecLikeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(winnerView.mas_bottom).offset(ZOOM6(20));
        make.left.offset(ZOOM6(20));
        make.height.offset(55+50*6);
        make.width.offset(kScreenWidth-ZOOM6(20)*2);
    }];

}
- (void)creatTabview
{
//    int count = 1; int i=0;
    CGFloat viewHeigh = 305;
//    for(int i=0; i <count; i++)
//    {
//        UIView * backview = [[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20), (viewHeigh+ZOOM6(20))*i+CGRectGetMaxY(collecLikeView.frame)+ZOOM6(20), kScreenWidth-ZOOM6(20)*2, viewHeigh)];
    UIView * backview = [[UIView alloc]init];
        backview.backgroundColor = [UIColor whiteColor];
        backview.layer.cornerRadius = 5;
        [ScrContainer addSubview:backview];
        
        CGFloat imageHeigh = 20;
        UIImageView *titleimage = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-ZOOM6(20)*2-imageHeigh*7.5)/2, 15, imageHeigh*7.5, imageHeigh)];
        
        UITableView *tabview = [[SUTableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth-ZOOM6(20)*2, viewHeigh-55) style:UITableViewStylePlain];
        tabview.delegate = self;
        tabview.dataSource = self;
        tabview.scrollEnabled = NO;
        tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabview.showsVerticalScrollIndicator = NO;
        [tabview registerNib:[UINib nibWithNibName:@"RawardTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        
//        if(i==0)
//        {
            titleimage.image = [UIImage imageNamed:@"edjl"];
            self.ptyaRwardTableView = tabview;
//        }else{
//            backview.tag=100+i;
//
//            titleimage.image = [UIImage imageNamed:@"ydjl"];
//            self.yiduRwardTableView = tabview;
//        }

        UIView *clearview = [[UIView alloc]initWithFrame:backview.bounds];
        clearview.backgroundColor = [UIColor clearColor];
        clearview.userInteractionEnabled = YES;
        
        [backview addSubview:titleimage];
        [backview addSubview:tabview];
        [backview addSubview:clearview];

    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(collecLikeView.mas_bottom).offset(ZOOM6(20));
        make.left.offset(ZOOM6(20));
        make.height.offset(viewHeigh);
        make.width.offset(kScreenWidth-ZOOM6(20)*2);
    }];
    [clearview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backview);
    }];
//    }
    [ScrContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backview.mas_bottom);
    }];

//    self.myScrollview.contentSize = CGSizeMake(0, CGRectGetMaxY(collecLikeView.frame)+ZOOM6(20)+count*(305+ZOOM6(20)));

    self.mytimer= [NSTimer weakTimerWithTimeInterval:2.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
//    self.mytimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}
//每日奖励
- (void)creatDayRewardView {
    CFPopView *view=[[CFPopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) newFriend:newFriends oldFriend:oldFriends reward:today_rewards];
    [view show];
    /*
    UIView *view=[self.myScrollview viewWithTag:101];
    UIView *dayRewardView=[[UIView alloc]initWithFrame:CGRectMake(ZOOM6(20), CGRectGetMaxY(view.frame)+ZOOM6(20), kScreenWidth-ZOOM6(20)*2, 200)];
    dayRewardView.backgroundColor=[UIColor whiteColor];
    dayRewardView.layer.cornerRadius=5;
    [ScrContainer addSubview:dayRewardView];
    */
    
}
- (void)creatNavagationbar
{
    self.tabheadview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kApplicationWidth, Height_NavBar)];
    [self.view addSubview:self.tabheadview];
    self.tabheadview.userInteractionEnabled=YES;
    
    UIButton *backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame=CGRectMake(0, 20, 44, 44);
    backbtn.centerY = View_CenterY(self.tabheadview);
    [backbtn setImage:[UIImage imageNamed:@"返回按钮_正常"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.tabheadview addSubview:backbtn];
    
    UILabel *titlelable=[[UILabel alloc]init];
    titlelable.frame=CGRectMake(0, 0, 300, 40);
    titlelable.center=CGPointMake(kApplicationWidth/2, self.tabheadview.frame.size.height/2+10);
    titlelable.text=@"集赞奖励";
    titlelable.font=kNavTitleFontSize;
    titlelable.textColor=kMainTitleColor;
    titlelable.textAlignment=NSTextAlignmentCenter;
    [self.tabheadview addSubview:titlelable];
    
//    UIButton* discriptionBtn=[[UIButton alloc]init];
//    discriptionBtn.frame=CGRectMake(kApplicationWidth-ZOOM6(180), 23, ZOOM6(160), 40);
//    [discriptionBtn setTitle:@"额度说明" forState:UIControlStateNormal];
//    discriptionBtn.titleLabel.font=[UIFont systemFontOfSize:ZOOM6(32)];
//    [discriptionBtn setTitleColor:RGBCOLOR_I(125, 125, 125) forState:UIControlStateNormal];
//    discriptionBtn.tag=1111;
//    [discriptionBtn addTarget:self action:@selector(discription) forControlEvents:UIControlEventTouchUpInside];
//    [self.tabheadview addSubview:discriptionBtn];
    
}
- (UIView*)shareView
{
    if(_shareView == nil)
    {
        shareBG=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        shareBG.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self.view addSubview:shareBG];

        UIButton *shareBGBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-ZOOM6(250))];
        [shareBGBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [shareBG addSubview:shareBGBtn];

        _shareView = [[UIView alloc]init];
        _shareView.frame=CGRectMake(0, kScreenHeight, kScreenWidth, ZOOM6(250));
        _shareView.backgroundColor=[UIColor whiteColor];
        [shareBG addSubview:_shareView];

        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20),ZOOM6(20), kScreenWidth-2*ZOOM6(20), ZOOM6(40))];
        titlelabel.textAlignment = NSTextAlignmentCenter;
        titlelabel.text = @"分享到";
        titlelabel.textColor = RGBCOLOR_I(62, 62, 62);
        titlelabel.font = [UIFont systemFontOfSize:ZOOM6(30)];
        [_shareView addSubview:titlelabel];

        //分享的平台
        //        NSArray *shareArray = @[@"微信",@"朋友圈",@"QQ空间"];
        NSMutableArray *shareArray=[NSMutableArray array];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            [shareArray addObject:@"微信"];
//            [shareArray addObject:@"朋友圈"];
        }
        //        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        //            [shareArray addObject:@"QQ空间"];
        CGFloat buttonwith = ZOOM6(100);
        CGFloat spacewith = (kScreenWidth-shareArray.count*buttonwith)/(shareArray.count + 1);
        for(int i =0; i<shareArray.count; i++)
        {
            UIButton *shareButton = [[UIButton alloc]init];
            shareButton.frame = CGRectMake(spacewith+(buttonwith+spacewith)*i, CGRectGetMaxY(titlelabel.frame)+ZOOM6(20), buttonwith, buttonwith);
            shareButton.tag = 10000+i;
            [_shareView addSubview:shareButton];

            if(i == 0)
            {
                [shareButton setImage:[UIImage imageNamed:@"icon_weinxinqun"] forState:UIControlStateNormal];
            }else if (i == 1)
            {
                [shareButton setImage:[UIImage imageNamed:@"朋友圈-1"] forState:UIControlStateNormal];
            }else if (i == 2)
            {
                [shareButton setImage:[UIImage imageNamed:@"qq空间-1"] forState:UIControlStateNormal];
            }

            [shareButton addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];

            UILabel *sharelab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(shareButton.frame), CGRectGetMaxY(shareButton.frame)+ZOOM6(10),CGRectGetWidth(shareButton.frame), ZOOM6(30))];
            sharelab.text = shareArray[i];
            sharelab.textAlignment = NSTextAlignmentCenter;
            sharelab.textColor = RGBCOLOR_I(168, 168, 168);
            sharelab.font = [UIFont systemFontOfSize:ZOOM6(24)];
            [_shareView addSubview:sharelab];
        }
    }

    return _shareView;
}
- (void)DShareManagerStatus:(SHARESTATE)shareStatus withType:(NSString *)type {
    if(shareStatus != STATE_BEGAN){
        if (shareStatus == STATE_SUCCESS || shareStatus == STATE_FAILED|| shareStatus==STATE_CANCEL) {
//            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
//            [mentionview showLable:@"分享成功" Controller:self];
            if (self.isFiristInvit) {
                [self shareSuccess:YES];
            }else{
                if (self.TaskFinishBlock) {
                    self.TaskFinishBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
//        else if (shareStatus == STATE_FAILED|| shareStatus==STATE_CANCEL) {
//            NavgationbarView *mentionview = [[NavgationbarView alloc]init];
//            [mentionview showLable:@"分享失败" Controller:self];
//        }
    }
}
- (void)shareSuccess:(BOOL)shareSuccess {
    kSelfWeak;
    [TaskSignModel getTaskHttp:[Signmanager SignManarer].share_indexid Day:[Signmanager SignManarer].share_day Success:^(id data) {
        TaskSignModel *model = data;
        if(model.status == 1)
        {
            if(shareSuccess)
            {
                if (self.TaskFinishBlock) {
                    self.TaskFinishBlock();
                }
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}
#pragma mark- tableview
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==winnerTable) {
        return self.winnerDataArr.count;
    }
    if (tableView==self.collecLikeTableView) {
        return 6;
    }
    if(tableView == self.ptyaRwardTableView)
    {
        return self.self.totalPtyaArray.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==winnerTable) {
        return 80;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==winnerTable) {
        CFWinnerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"winnerTable"];

        if (self.winnerDataArr.count>indexPath.row) {
            WinnerModel *model = self.winnerDataArr[indexPath.row];
            [cell loadDataModel:model];
            cell.bubble.tag = indexPath.row;
        }else {//默认的
            cell.name.text=@"hello";cell.numLabel.text=@"获得一等奖： 5000";
            cell.address.text = @"来自喵星";
            cell.bubble.URLStr=@"http://up.mcyt.net/md5/53/NTkwNzI2Nw_Qq4329912.mp3";
//            CGFloat width = ZOOM6(arc4random()%(180))+ZOOM6(100);
            cell.bubble.frame = CGRectMake(kScreenWidth/2, 7, ZOOM6(280), 40);
            cell.bubble.tag = indexPath.row;
            cell.bubble.delegate=self;
            RawardModel *model = self.totalPtyaArray[indexPath.row];
            [model.headpic hasPrefix:@"http"]?[cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headpic]]]:[cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.headpic]]];
            cell.name.text=[model.title substringToIndex:4];
        }

        if (indexPath.row == _currentRow) {
            [cell.bubble startAnimating];
        } else {
            [cell.bubble stopAnimating];
        }

        return cell;
    }
    if (tableView==self.collecLikeTableView) {
        static NSString *cellName = @"CollecLikeTableViewCell";
        CollecLikeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell=[[CollecLikeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.numLabel.text=[NSString stringWithFormat:@"%zd",indexPath.row+1];
        cell.numLabel.hidden=indexPath.row==0||indexPath.row==1||indexPath.row==2;
        cell.numImg.hidden=indexPath.row==3||indexPath.row==4||indexPath.row==5;
        if (indexPath.row==0) {
            cell.numImg.image=[UIImage imageNamed:@"点赞-1"];
        }else if (indexPath.row==1) {
            cell.numImg.image=[UIImage imageNamed:@"点赞-2"];
        }else if (indexPath.row==2) {
            cell.numImg.image=[UIImage imageNamed:@"点赞-3"];
        }
        if (self.dataArr.count>indexPath.row) {
            AwardModel *model = self.dataArr[indexPath.row];
            [model.pic hasPrefix:@"http"]?[cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]]]:[cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.pic]]];
            cell.name.text=model.nickname.length>8?[model.nickname substringToIndex:8]:model.nickname;
            cell.address.text=model.location.length!=0 && model.location && ![model.location containsString:@"null"]? model.location : @"来自喵星";
            NSString *str=[NSString stringWithFormat:@"%@个赞",model.point_count];
            [cell.numLike setAttributedText:[self getOneColorInLabel:str ColorString:[NSString stringWithFormat:@"%@",model.point_count] Color:tarbarrossred fontSize:ZOOM6(40)]];
        }else {
        
        RawardModel *model = self.totalPtyaArray[indexPath.row];
        [model.headpic hasPrefix:@"http"]?[cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headpic]]]:[cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],model.headpic]]];
        cell.name.text=[model.title substringToIndex:4];
        cell.address.text=@"喵星";
        NSString *count=[NSString stringWithFormat:@"%zd",labs((indexPath.row-6))];
        NSString *allstring=[NSString stringWithFormat:@"%@个赞",count];
        NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:allstring];
        NSRange stringRange = [allstring rangeOfString:count];
        NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
        [stringDict setObject:[UIFont boldSystemFontOfSize:ZOOM6(40)] forKey:NSFontAttributeName];
        [allString setAttributes:stringDict range:stringRange];
        [cell.numLike setAttributedText:allString];
//        cell.numLike.text=[NSString stringWithFormat:@"2323个赞"];
        }
        return cell;
    }
//    static NSString *identifier=@"Cell";
    RawardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];

    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
   
    if(tableView == self.ptyaRwardTableView)
    {
        RawardModel *model = self.totalPtyaArray[indexPath.row];
        [cell refreshData:model];
    }
    return cell;
    
}
- (void)voiceBubbleDidStartPlaying:(CFVoiceBubble *)voiceBubble
{
    _currentRow = voiceBubble.tag;
}
- (NSMutableAttributedString *)getOneColorInLabel:(NSString *)allstring ColorString:(NSString *)string Color:(UIColor*)color fontSize:(float)size
{
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:allstring];
    NSRange stringRange = [allstring rangeOfString:string];
    NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
    [stringDict setObject:color forKey:NSForegroundColorAttributeName];
    [stringDict setObject:[UIFont boldSystemFontOfSize:size] forKey:NSFontAttributeName];
    
    [allString setAttributes:stringDict range:stringRange];
    
    return allString;
}
#pragma mark- *********** 按钮 ***********
- (void)dismiss {
    [UIView animateWithDuration:0.35 animations:^{
        self.shareView.frame=CGRectMake(0, kScreenHeight, kScreenWidth, ZOOM6(250));
        shareBG.alpha=0;
    }];
}
- (void)collecLike {
    [YFShareModel getShareModelWithKey:@"point" type:StatisticalTypeToShare tabType:StatisticalTabTypeLikeCollect success:nil];

    self.shareView.frame=CGRectMake(0, kScreenHeight, kScreenWidth, ZOOM6(250));

    [UIView animateWithDuration:0.35 animations:^{
        self.shareView.frame=CGRectMake(0, kScreenHeight-ZOOM6(250), kScreenWidth, ZOOM6(250));
        shareBG.alpha=1;
    }];
    //    SelectShareTypeViewController *sharetype = [[SelectShareTypeViewController alloc]init];
//    sharetype.ISInvit = YES;
//    [self.navigationController pushViewController:sharetype animated:YES];
}
- (void)shareclick:(UIButton *)sender {
    ShareType sharetype=ShareTypeWeixiTimeline;
    NSInteger tag=sender.tag-10000;
    switch (tag) {
        case 1:{
            MyLog(@"微信朋友圈");
            sharetype = ShareTypeWeixiTimeline;
            [YFShareModel getShareModelWithKey:@"point" type:StatisticalTypeToSharePYQ tabType:StatisticalTabTypeLikeCollect success:nil];

            break;
        }
        case 0:{
            MyLog(@"微信好友");
            sharetype = ShareTypeWeixiSession;
            [YFShareModel getShareModelWithKey:@"point" type:StatisticalTypeToShareWX tabType:StatisticalTabTypeLikeCollect success:nil];

            break;
        }
        default:
            break;
    }
    if (shareTitle==nil) {
        NSString *discription=@"快来为我点赞，即奖10元现金，每月更可赢千元任务奖励。";
        NSString *title = @"对方不想和你说话，并且向你扔了10元。";
        imgPathUrl=[[NSUserDefaults standardUserDefaults]objectForKey:USER_WX_HEADPIC];
        linkUrl = [NSString stringWithFormat:@"%@view/activity/mission.html?realm=%@",[NSObject baseURLStr_H5],[[NSUserDefaults standardUserDefaults]objectForKey:USER_ID]];
        [self.shareManager sharePersonH5WithType:sharetype withLinkShareType:@"" withLink:linkUrl andImagePath:imgPathUrl andTitle:title andContent:discription];
    }else
        [self.shareManager sharePersonH5WithType:sharetype withLinkShareType:@"" withLink:linkUrl andImagePath:imgPathUrl andTitle:shareTitle andContent:shareDiscription];

}
- (void)tixian
{
    NSString *usertype = [[NSUserDefaults standardUserDefaults] objectForKey:USER_CLASSIFY];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    if([usertype isEqualToString:@"0"]||[usertype isEqualToString:@"1"]||[usertype isEqualToString:@"2"])//提现引导
    {
        if(token.length > 8)  {
//            [self popViewWithDrawCashGuide];
            [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台
                
            }];
            
            TFWithdrawCashViewController *VC = [[TFWithdrawCashViewController alloc] init];
            VC.bindNameAndIdenfBlock = ^(NSInteger sguidance) {
                
            };
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else {
        TFWithdrawCashViewController *cash = [[TFWithdrawCashViewController alloc]init];
        [self.navigationController pushViewController:cash animated:YES];
    }
}
#pragma mark 提现引导
- (void)popViewWithDrawCashGuide {
    TFPopBackgroundView *popView = [[TFPopBackgroundView alloc] init];
    popView.showCancelBtn = YES;
    popView.rightText = @"下一步";
    popView.title = @"提现引导";
    UIView *contentV = [[UIView alloc] init];
    popView.contentView = contentV;

    UILabel *contentLabel = [UILabel new];
    NSString *text = @"欢迎加入衣蝠，为了让新用户能快速体验提现功能，我们特意在你的提现可提现额度中存入了1.00元现金，现在可以立即提现了哦~";
    contentLabel.textColor = RGBCOLOR_I(125, 125, 125);
    contentLabel.font = kFont6px(28);
    contentLabel.numberOfLines = 0;
    contentLabel.text = text;
    [contentV addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(contentV);
    }];

    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(popView.contentViewWidth);
    }];
    [contentV setNeedsLayout];

    [popView showCancelBlock:^{

        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台

        }];
    } withConfirmBlock:^{

        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台

        }];

        TFWithdrawCashViewController *VC = [[TFWithdrawCashViewController alloc] init];
        VC.bindNameAndIdenfBlock = ^(NSInteger sguidance) {

        };
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } withNoOperationBlock:^{

        [VitalityModel posguide:^(id data) {//弹了引导弹框告诉后台

        }];
    }];
}

- (void)Quotadetail
{
    AXSampleNavBarTabViewController *vc = [[AXSampleNavBarTabViewController alloc]initWithType:YDPageVCTypeMoney peas:_balance peas_freeze:_freeze_balance extract:_extract freezeMoney:_ex_free];

    [self.navigationController pushViewController:vc animated:YES];
}
- (void)yidoumingxi:(UITapGestureRecognizer*)tap
{
    
    //    int tag = tap.view.tag % 20000; //0衣豆 1冻结衣豆
//    if(!self.is_fromMessage)
    {
        AXSampleNavBarTabViewController *vc = [[AXSampleNavBarTabViewController alloc]initWithType:YDPageVCTypeYidou peas:_peas peas_freeze:_peas_free extract:_extract freezeMoney:_ex_free];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) tick:(NSTimer *)time {
    
    _ptyacount ++;
    //(25.0 / 30.0) * (float)self.count) ---> (tableview需要滚动的contentOffset / 一共调用的次数) * 第几次调用
    //比如该demo中 contentOffset最大值为 = cell的高度 * cell的个数 ,5秒执行一个循环则调用次数为 300,没1/60秒 count计数器加1,当count=300时,重置count为0,实现循环滚动.
    kSelfWeak;

    if(_ptyacount == 0)
    {
        [self.ptyaRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_ptyacount) animated:NO];
        
    }else{
        [UIView animateWithDuration:3.0 animations:^{
            
            [weakSelf.ptyaRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_ptyacount) animated:NO];
        }];
        
        //        [self.ptyaRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_ptyacount) animated:YES];
        
    }
    /*
    if(_yiducount == 0)
    {
        [self.yiduRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_yiducount) animated:NO];
    }else{
        
        [UIView animateWithDuration:3.0 animations:^{
            
            [weakSelf.yiduRwardTableView setContentOffset:CGPointMake(0, 50 * (float) _yiducount) animated:NO];
            
        }];
        
        //        [self.yiduRwardTableView setContentOffset:CGPointMake(0, 50 * (float)_yiducount) animated:YES];
    }
    */
    
    if (_ptyacount >= self.totalPtyaArray.count*2) {
        
        _ptyacount = -1;
    }
    
}
//刷新头部
- (void)refrestHeadUI
{
    if(_balance)
    {
        CGFloat bb = 0;
        if ([DataManager sharedManager].isOligible&&[DataManager sharedManager].isOpen&&([DataManager sharedManager].twofoldness > 0)) {
            
            bb = [DataManager sharedManager].twofoldness *_balance;
        }else{
            bb = _balance;
        }
        
        self.totalbalanceLab.text = [NSString stringWithFormat:@"%.2f\n总金额(元)",bb];
        [self getBalancemutable:self.totalbalanceLab Text:[NSString stringWithFormat:@"%.2f",bb]];
    }
    
    if(_extract+_ex_free >0)
    {
        self.availablebalanceLab.text = [NSString stringWithFormat:@"%.2f\n可提现(元)",_extract+_ex_free];
        [self getBalancemutable:self.availablebalanceLab Text:[NSString stringWithFormat:@"%.2f",_extract+_ex_free]];
    }
    
    
    self.availableyidouLab.text = [NSString stringWithFormat:@"累计集赞:%d",_point_count];
    [self getYidoumutable:self.availableyidouLab Yidou:_point_count];
    
    
    if(_peas)
    {
        self.frozenyidouLab.text = [NSString stringWithFormat:@"可用衣豆:%d",_peas];
        [self getYidoumutable:self.frozenyidouLab Yidou:_peas];
    }
    

}
- (void)getBalancemutable:(UILabel*)lab Text:(NSString*)text
{
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lab.text];
    
    [mutable addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(48)] range:NSMakeRange(0, text.length)];
    [lab setAttributedText:mutable];
    
}
- (void)getYidoumutable:(UILabel*)lab Yidou:(int)yidou
{
    NSString *str = [NSString stringWithFormat:@"%d",yidou];
    
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc]initWithString:lab.text];
    [mutable addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZOOM6(30)] range:NSMakeRange(5, str.length)];
    [lab setAttributedText:mutable];
}
- (void)getDataFromstr:(NSString*)strdata Type:(NSInteger)type
{
    //type 1是额度 2是衣豆
    NSData *jsonData = [strdata dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];

    if(dic){
        RawardModel *model = [[RawardModel alloc]init];
                model.headpic = [NSString stringWithFormat:@"%@",dic[@"pic"]];
        if(type == 1) {
            model.price = [NSString stringWithFormat:@"%@",dic[@"today_reward"]];
            model.type = [NSString stringWithFormat:@"%@",dic[@"type"]];
            model.title = [NSString stringWithFormat:@"%@ %@",dic[@"nickname"],@"集赞获得提现额度"];

            [self.realPtyaArray addObject:model];
        }
    }

//    NSArray *arr=[strdata componentsSeparatedByString:@","];
////    MyLog(@"dic = %@",dic);
//    if(arr.count>0) {
//        RawardModel *model = [[RawardModel alloc]init];
//        model.headpic = [NSString stringWithFormat:@"%@",arr[arr.count-2]];
//        if(type == 1) {
//            model.price = [NSString stringWithFormat:@"%@",arr[3]];
//            model.title = [NSString stringWithFormat:@"%@ %@",arr[1],@"集赞获得提现额度"];
//            [self.realPtyaArray addObject:model];
//        }
//
//    }

}
//真实数据 虚拟数据交替合并在一起
- (void)getNeWArray
{
    if(self.realPtyaArray.count)
    {
        [self.totalPtyaArray removeAllObjects];
        
        for(int i = 0;i<self.fictitiousPtyaArray.count;i++)
        {
            if(self.realPtyaArray.count>i)
            {
                RawardModel *model = self.realPtyaArray[i];
                [self.totalPtyaArray addObject:model];
            }
            
            RawardModel *model1 = self.fictitiousPtyaArray[i];
            
            [self.totalPtyaArray addObject:model1];
            
        }
        
        [self.ptyaRwardTableView reloadData];
    }
    /*
    if(self.realYiduArray.count)
    {
        [self.totalYiduArray removeAllObjects];
        
        for(int i = 0;i<self.fictitiousYiduArray.count;i++)
        {
            if(self.realYiduArray.count>i)
            {
                RawardModel *model = self.realYiduArray[i];
                [self.totalYiduArray addObject:model];
            }
            
            RawardModel *model1 = self.fictitiousYiduArray[i];
            
            [self.totalYiduArray addObject:model1];
            
        }
        
        [self.yiduRwardTableView reloadData];
        
    }
    */
}
/*
- (NSString*)gettitileStr:(NSInteger)type
{
    /*
    NSString *str;
    switch (type) {
        case 1:
            str = @"抽红包";
            break;
        case 2:
            str = @"夺宝退款";
            break;
        case 3:
            str = @"粉丝购物";
            break;
        case 4:
            str = @"官方赠送";
            break;
            
        default:
            break;
    }
    
    str = [NSString stringWithFormat:@"%@获得提现额度",str];
//    return str;
    *
    return @"集赞获得提现额度";
}
*/
#pragma mark - 懒加载
- (DShareManager*)shareManager
{
    if(_shareManager == nil) {
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app shardk];
        _shareManager = [DShareManager share];
        _shareManager.delegate = self;
    }
    return _shareManager;
}
- (NSMutableArray *)rewardDataArr {
    if (!_rewardDataArr) {
        _rewardDataArr=[NSMutableArray array];
    }
    return _rewardDataArr;
}
- (NSMutableArray *)winnerDataArr
{
    if (!_winnerDataArr) {
        _winnerDataArr=[NSMutableArray array];
    }
    return _winnerDataArr;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray*)fictitiousPtyaArray
{
    if(_fictitiousPtyaArray == nil)
    {
        _fictitiousPtyaArray = [NSMutableArray array];
    }
    
    return _fictitiousPtyaArray;
}

- (NSMutableArray*)realPtyaArray
{
    if(_realPtyaArray == nil)
    {
        _realPtyaArray = [NSMutableArray array];
    }
    return _realPtyaArray;
}

- (NSMutableArray*)totalPtyaArray
{
    if(_totalPtyaArray == nil)
    {
        _totalPtyaArray = [NSMutableArray array];
    }
    return _totalPtyaArray;
}


- (void)dealloc
{
    [self.mytimer invalidate];
    self.mytimer=nil;
    MyLog(@"%@ release",[self class]);
}

@end
