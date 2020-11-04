
//
//  MyTreasureGroupsShareVC.m
//  YunShangShiJi
//
//  Created by YF on 2017/8/29.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "MyTreasureGroupsShareVC.h"

#import "MyTreasureGroupsShareCell.h"
#import "ShareModel.h"


@interface MyTreasureGroupsShareVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *_remindDetail;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation MyTreasureGroupsShareVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationItemLeft:@"我的0元团"];
    [self.view addSubview:self.tableView];

    [self httpData];
}
- (void)httpData {
//    self.shop_code = @"CAAX201708316WWhWNDp";
//    self.shop_batch_num = @"170831002";

    NSString *url = [NSString stringWithFormat:@"rollTrea/getMyRoll?shop_code=%@&issue_code=%@&",self.model.shop_code,self.model.shop_batch_num];
    kSelfWeak;
    [[APIClient sharedManager] netWorkGeneralRequestWithApi:url caches:NO cachesTimeInterval:0 token:YES success:^(id data, Response *response) {

        if (response.status == 1) {
            NSArray *arr = data[@"data"];
            TreasureGroupsModel *tempModel,*tempModel2;//用来记录 （未满团）  自己开的团  参加的团
            for (NSDictionary *dic in arr) {
                TreasureGroupsModel *model = [[TreasureGroupsModel alloc]init];
                model.issue_code = [NSString stringWithFormat:@"%@",dic[@"issue_code"]];
                model.tuserId = dic[@"tuserId"];
                model.btime = dic[@"btime"];
                model.shop_code = dic[@"shop_code"];
                model.thead = dic[@"thead"];
                model.num = dic[@"num"];
                model.nickname = dic[@"nickname"];
                model.u_code = dic[@"u_code"];
                for (NSDictionary *dic2 in dic[@"user"]) {
                    TreasureGroupsModel *model2 = [[TreasureGroupsModel alloc]init];
                    model2.head = dic2[@"head"];
                    model2.uid = dic2[@"uid"];
                    model2.btime = dic2[@"btime"];
                    model2.nickname = dic2[@"nickname"];
                    [model.user addObject:model2];
                }
                //期号 (==0 时表示没满足人数)
                if ([model.issue_code containsString:@"null"]||[model.issue_code isEqualToString:@"0"]) {
                    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID] ;

                    if (model.tuserId.integerValue==user_id.integerValue) {
                        tempModel = model;
                    }else
                        tempModel2 = model;
                }else
                    [weakSelf.data addObject:model];

            }
            //最后（未满团）  自己开的团  参加的团 加入数组
            if (tempModel2) {
                [weakSelf.data insertObject:tempModel2 atIndex:0];
            }
            kSelfStrong;
            if (tempModel) {
                NSString *colorStr = [NSString stringWithFormat:@"%zd",                weakSelf.model.group_number.integerValue - tempModel.num.integerValue];
                NSString *str = [NSString stringWithFormat:@"还差%@位就成团了，赶快邀请好友来参团吧！",colorStr];
                [strongSelf -> _remindDetail setAttributedText:[NSString getOneColorInLabel:str ColorString:colorStr Color:tarbarrossred font:[UIFont boldSystemFontOfSize:ZOOM6(40)]]];
                [weakSelf.data insertObject:tempModel atIndex:0];
            }

            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {

    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(160))];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.textColor = kMainTitleColor;
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = kFont6px(32);
    UILabel *num = [[UILabel alloc]init];
    num.textColor = kMainTitleColor;
    num.textAlignment = NSTextAlignmentCenter;
    num.font = kFont6px(28);
    [view addSubview:topLabel];
    [view addSubview:num];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(ZOOM6(60));
        make.left.right.offset(0);
    }];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(ZOOM6(10));
        make.width.equalTo(topLabel);
    }];

    TreasureGroupsModel *model = self.data[section];

    NSString *colorStr = [NSString stringWithFormat:@"%zd",section+1];
    NSString *str = [NSString stringWithFormat:@"第%@团，%@",colorStr,[model.issue_code containsString:@"null"]||[model.issue_code isEqualToString:@"0"]?@"未满":@"满员"];
    [topLabel setAttributedText:[NSString getOneColorInLabel:str ColorString:colorStr Color:tarbarrossred font:kFont6px(32)]];

    num.text = [model.issue_code containsString:@"null"]||[model.issue_code isEqualToString:@"0"] ? @"" : [NSString stringWithFormat:@"（幸运号码：%@）",model.u_code];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    TreasureGroupsModel *model = self.data[section];

    return [model.issue_code containsString:@"null"]||[model.issue_code isEqualToString:@"0"] ? ZOOM6(130) : ZOOM6(180) ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TreasureGroupsModel *model = self.data[indexPath.section];

    NSInteger groupNum = model.user.count+1;
    if ([model.issue_code containsString:@"null"]||[model.issue_code isEqualToString:@"0"]) {
        groupNum = self.model.group_number.integerValue;
    }
    NSInteger count = (model.user.count + 1) < groupNum ? groupNum : model.user.count + 1;
//    NSInteger count = model.user.count+1;

    return ZOOM6(20)*(count/5)+ZOOM6(160)*((count/5+(count%5?1:0)));//ZOOM6(20)*(count/5)+
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MyTreasureGroupsShareCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];

    TreasureGroupsModel *model = self.data[indexPath.section];

    NSInteger groupNum = model.user.count+1;
    if ([model.issue_code containsString:@"null"]||[model.issue_code isEqualToString:@"0"]) {
        groupNum = self.model.group_number.integerValue;
    }
    [cell loadData:model needNum:groupNum shopName:self.model.shop_name];
    return cell;
}
- (void)btnClick:(UIButton *)sender {
//    [self goShare:sender.tag];
    [self goShare:9000];
}
#pragma mark 分享
- (void)goShare:(NSInteger)tag
{
    NSString *imgUrl = self.shareImgUrl;
//    NSString *title = [NSString stringWithFormat:@"衣蝠特惠，%@人成团就有机会，%@元团购%@",_model.group_number,_model.shop_price,_model.shop_name];
//    NSString *discription = [NSString stringWithFormat:@"%@成功开团，现在报名，马上参团！",[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME]];

    NSMutableDictionary *dictionary = [self taskrawardHttp:@"ptdbfx"];
    NSString *title = [dictionary objectForKey:@"title"];
    NSString *discription = [dictionary objectForKey:@"text"];
    
    NSString *realm = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    NSString *link  = [NSString stringWithFormat:@"%@/view/activity/signDetail.html?i_c=%@&r=%@&s_c=%@",[NSObject baseH5ShareURLStr],self.model.shop_batch_num,realm,self.model.shop_code];

    ShareModel *model = [[ShareModel alloc]init];
    switch (tag) {
        case 9001:
            MyLog(@"微信朋友圈");
            model.sharetype = shareType_weixin_pyq;
            break;
        case 9000:
            MyLog(@"微信好友");
            model.sharetype = shareType_weixin_hy;
            break;
        default:
            break;
    }

    [model goshare:model.sharetype ShareImage:imgUrl ShareTitle:title ShareLink:link Discription:discription];
}

- (NSMutableDictionary*)taskrawardHttp:(NSString*)strtype
{
    NSMutableDictionary *strDictionary = [NSMutableDictionary dictionary];
    
    NSString *URL= [NSString stringWithFormat:@"%@paperwork/paperwork.json",[NSObject baseURLStr_Upy]];
    NSURL *httpUrl=[NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpUrl];
    request.timeoutInterval = 3;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        responseObject = [NSDictionary changeType:responseObject];
        if (responseObject!=nil) {
            
            if (responseObject[@"ptdbfx"] != nil ){
                if(responseObject[@"ptdbfx"][@"text"] != nil)
                {
                    
                    NSString *title = responseObject[@"ptdbfx"][@"title"];
                    title = [title stringByReplacingOccurrencesOfString:@"${replace}人" withString:[NSString stringWithFormat:@"%@人",_model.group_number]];
                    title = [title stringByReplacingOccurrencesOfString:@"${replace}元" withString:[NSString stringWithFormat:@"%.1f元",[_model.shop_se_price floatValue]]];
                    title = [title stringByReplacingOccurrencesOfString:@"${replace}" withString:[NSString stringWithFormat:@"%@",_model.shop_name]];
                    
                    NSString *text = responseObject[@"ptdbfx"][@"text"];
                    text = [text stringByReplacingOccurrencesOfString:@"${replace}人" withString:[NSString stringWithFormat:@"%@人",_model.group_number]];
                    text = [text stringByReplacingOccurrencesOfString:@"${replace}" withString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME]]];
                    if(title)
                    {
                        [strDictionary setValue:title forKey:@"title"];
                    }
                    if(text)
                    {
                        [strDictionary setValue:text forKey:@"text"];
                    }
                }
                
            }
        }
    }
    
    return strDictionary;
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, kScreenWidth, kScreenHeight-Height_NavBar) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MyTreasureGroupsShareCell class] forCellReuseIdentifier:@"cell"];
        _tableView.tableHeaderView = [self headerView];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(40))];
        view.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}
- (UIView *)headerView {
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ZOOM6(910))];
    header.backgroundColor = [UIColor whiteColor];
    UIImageView *topImg = [[UIImageView alloc]init];
    [topImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],self.model.banner]]];
    [header addSubview:topImg];
    UIImageView *icon = [[UIImageView alloc]init];
    icon.image = [UIImage imageNamed:@"成功"];
    [header addSubview:icon];
    UILabel *title = [[UILabel alloc]init];
    title.textColor=kMainTitleColor;
    title.font = [UIFont boldSystemFontOfSize:ZOOM6(36)];
    [header addSubview:title];
   UILabel *remindDetail = [[UILabel alloc]init];
    remindDetail.textColor = kSubTitleColor;
    remindDetail.font = kFont6px(32);
    [header addSubview:remindDetail];
    _remindDetail = remindDetail;
    UILabel *shareTitle = [[UILabel alloc]init];
    shareTitle.textColor = kSubTitleColor;
    shareTitle.font = kFont6px(28);
    [header addSubview:shareTitle];

    UIButton *wxFriend = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    [wxFriend setImage:[UIImage imageNamed:@"微信好友"] forState:UIControlStateNormal];
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wxBtn setImage:[UIImage imageNamed:@"icon_weinxinqun"] forState:UIControlStateNormal];
    [wxFriend addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [wxBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    wxFriend.tag = 9000;
    wxBtn.tag = 9001;
    [header addSubview:wxFriend];
    [header addSubview:wxBtn];

    UILabel *wxFriendLabel = [[UILabel alloc]init];
    wxFriendLabel.textColor = kSubTitleColor;
    wxFriendLabel.font = kFont6px(24);
    wxFriendLabel.text = @"微信";
    wxFriendLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:wxFriendLabel];
    UILabel *wxLabel = [[UILabel alloc]init];
    wxLabel.textColor = kSubTitleColor;
    wxLabel.font = kFont6px(24);
    wxLabel.text = @"微信群";
    wxLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:wxLabel];

    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.textColor = tarbarrossred;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.font = kFont6px(28);
    [header addSubview:bottomLabel];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, header.height-1, kScreenWidth, 0.5)];
    line.backgroundColor = kTableLineColor;
    [header addSubview:line];

    title.text = @"已为你自动创建新团";
    remindDetail.text = @"还差2位就成团了，赶快邀请好友来参团吧！";
    shareTitle.text = @"分享至";
    bottomLabel.text = @"分享到3个群后，成团率高达98%！";


    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
//        make.height.offset(ZOOM6(100));
    }];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(title.mas_left).offset(ZOOM6(-12));
        make.width.height.offset(ZOOM6(46));
        make.top.equalTo(topImg.mas_bottom).offset(ZOOM6(60));
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(icon);
        make.centerX.equalTo(header);
    }];
    [remindDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(ZOOM6(16));
        make.centerX.equalTo(header);
        make.height.offset(ZOOM6(50));
    }];
    [shareTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remindDetail.mas_bottom).offset(ZOOM6(60));
        make.centerX.equalTo(header);
        make.height.offset(ZOOM6(40));
    }];
    [wxFriend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareTitle.mas_bottom).offset(ZOOM6(20));
        make.left.offset(header.centerX-ZOOM6(150));
        make.width.height.offset(ZOOM6(100));
    }];
    [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(wxFriend);
        make.left.offset(header.centerX+ZOOM6(50));
    }];
    [wxFriendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxFriend.mas_bottom).offset(ZOOM6(20));
        make.left.equalTo(wxFriend);
        make.width.offset(ZOOM6(100));
        make.height.offset(ZOOM6(30));
    }];

    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wxFriendLabel.mas_bottom).offset(ZOOM6(30));
        make.centerX.equalTo(header);
        make.height.offset(ZOOM6(40));
        make.bottom.equalTo(header).offset(-ZOOM6(60));
    }];
    [wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wxFriendLabel);
        make.top.equalTo(wxFriend.mas_bottom).offset(ZOOM6(20));
        make.left.width.equalTo(wxBtn);
        make.height.offset(ZOOM6(30));

    }];

//    topImg.backgroundColor = DRandomColor;


    return header;
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray array];
//        _data  = @[@"",@"",@"",@""];
    }
    return _data;
}


@end
