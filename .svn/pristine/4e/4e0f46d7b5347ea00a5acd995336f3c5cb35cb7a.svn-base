//
//  MessageChildTableViewController.m
//  YunShangShiJi
//
//  Created by yssj on 2017/2/22.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "MessageChildTableViewController.h"
#import "TopicDetailViewController.h"
#import "MyOrderViewController.h"
#import "TFMyWalletViewController.h"
#import "AXSampleNavBarTabViewController.h"

CGFloat MessageCellHeight = 60;

#import "BaseModel.h"
#import "PersonMessageModel.h"

/*
 话题消息  /fc/getMessage
 
 获取系统消息  push/sysMsg
 1.订单消息
 2.好友消息
 3.账户消息
 4.衣豆消息
 value统一格式为 消息内容^毫秒时间
 注意:没有消息会为空.注意判断下.
 */
@interface MessagesDataModel : BaseModel
@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray *data;

+ (void)httpGetFriendsDataWithType:(NSInteger )type history:(NSString *)isHistory currentPage:(NSInteger )page Success:(void(^)(id data))success;
@end
@implementation MessagesDataModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[PersonMessageModel mappingWithKey:@"data"],@"data",nil];
    return mapping;
}
+ (void)httpGetFriendsDataWithType:(NSInteger )type history:(NSString *)isHistory currentPage:(NSInteger )page Success:(void(^)(id data))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr;
//    if (type==2) {
//        urlStr = @"push/sysMsg";
//    }else if (type==1)
        urlStr = @"fc/getMessage";
    urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?version=%@&token=%@&type=%zd&curPage=%zd&history=%@",VERSION,token,type,page,isHistory]];
    [self getDataResponsePath:urlStr success:success];
}
@end

@interface MessagesSysDataModel : BaseModel
@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, assign) NSInteger count;


+ (void)httpGetFriendsDataWithType:(NSInteger )type currentPage:(NSInteger )page Success:(void(^)(id data))success;
@end
@implementation MessagesSysDataModel

//+ (NSMutableDictionary *)getMapping {
//    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[PersonMessageModel mappingWithKey:@"data"],@"data",nil];
//    return mapping;
//}
+ (void)httpGetFriendsDataWithType:(NSInteger )type currentPage:(NSInteger )page Success:(void(^)(id data))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr;
//    if (type==2) {
        urlStr = @"push/sysMsg";
//    }else if (type==1)
//        urlStr = @"fc/getMessage";
    urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?version=%@&token=%@&type=%zd&page=%zd",VERSION,token,type,page]];
    [self getDataResponsePath:urlStr success:success];
}
@end

#pragma mark - -MessageTableViewCell
@interface MessageTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headImg;
@property (nonatomic,strong)UILabel *topTextLabel;
@property (nonatomic,strong)UILabel *bottomTextLabel;
@property (nonatomic,strong)UILabel *rightTextLabel;
- (void)reloadDataWithImg:(NSString *)img messageAndDate:(NSString *)msgDate;
- (void)reloadMessageModel:(PersonMessageModel *)model;
@end
@implementation MessageTableViewCell
- (void)reloadMessageModel:(PersonMessageModel *)model {
    if ([model.head_pic hasPrefix:@"http://"]) {
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.head_pic]]];
    } else{
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],model.head_pic]]];
    }
    NSString *nickname=model.nickname;
    if (model.nickname.length>8) {
        nickname=[nickname substringToIndex:8];
    }
    if (model.type.integerValue==1) {
        self.topTextLabel.text = model.num.integerValue<=1 ? [NSString stringWithFormat:@"%@赞了你的话题",nickname] : [NSString stringWithFormat:@"%@等%zd人赞了你的话题",nickname,model.num.intValue];
    }
    else if (model.type.integerValue==2){
        self.topTextLabel.text = model.num.integerValue<=1 ? [NSString stringWithFormat:@"%@赞了你的评论",nickname] : [NSString stringWithFormat:@"%@等%zd人赞了你的评论",nickname,model.num.intValue];
    }
    else
        self.topTextLabel.text=nickname;
    self.bottomTextLabel.text=model.content;
    self.rightTextLabel.text=[NSString getTimeStyle:TimeStrStyleMessage time:[model.date longLongValue]];
}
- (void)reloadDataWithImg:(NSString *)img messageAndDate:(NSString *)msgDate {
    self.headImg.image=[UIImage imageNamed:img];
    self.topTextLabel.text=img;
    NSArray *arr = [msgDate componentsSeparatedByString:@"^"];
    self.bottomTextLabel.text=arr[0];
    self.rightTextLabel.text=[arr[1]length]==0?@"": [NSString getTimeStyle:TimeStrStyleMessage time:[arr[1] longLongValue]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setUI {
    [self.contentView addSubview:self.headImg];
    [self.contentView addSubview:self.topTextLabel];
    [self.contentView addSubview:self.bottomTextLabel];
    [self.contentView addSubview:self.rightTextLabel];
//    _headImg.backgroundColor=DRandomColor;
//    _topTextLabel.backgroundColor=DRandomColor;
//    _bottomTextLabel.backgroundColor=DRandomColor;
//    _rightTextLabel.backgroundColor=DRandomColor;
}
- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(30), ZOOM6(20), MessageCellHeight-ZOOM6(40), MessageCellHeight-ZOOM6(40))];
        _headImg.clipsToBounds=YES;
        _headImg.layer.cornerRadius=_headImg.frame.size.width/2;
    }
    return _headImg;
}
- (UILabel *)topTextLabel {
    if (!_topTextLabel) {
        _topTextLabel = [self setLabelTextColor:kMainTitleColor textAlignment:NSTextAlignmentLeft font:ZOOM6(28)];
        _topTextLabel.frame=CGRectMake(CGRectGetMaxX(self.headImg.frame)+ ZOOM6(30), MessageCellHeight/2-20, kScreenWidth/2, 20);
    }
    return _topTextLabel;
}
- (UILabel *)bottomTextLabel {
    if (!_bottomTextLabel) {
        _bottomTextLabel = [self setLabelTextColor:kSubTitleColor textAlignment:NSTextAlignmentLeft font:ZOOM6(24)];
        _bottomTextLabel.frame=CGRectMake(self.topTextLabel.x, MessageCellHeight/2, kScreenWidth-self.topTextLabel.x-ZOOM6(30), 20);
    }
    return _bottomTextLabel;
}
- (UILabel *)rightTextLabel {
    if (!_rightTextLabel) {
        _rightTextLabel = [self setLabelTextColor:RGBA(168, 168, 168, 1) textAlignment:NSTextAlignmentRight font:ZOOM6(24)];
        _rightTextLabel.frame=CGRectMake(ZOOM6(40), self.topTextLabel.y, kScreenWidth-ZOOM6(80), self.topTextLabel.height);
    }
    return _rightTextLabel;
}
- (NSString *)timeInfoWithTimeInterval:(NSTimeInterval)time
{
    NSDate *oldDate = [NSDate dateWithTimeIntervalSince1970:(time/1000)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString *showtimeNew = [formatter stringFromDate:oldDate];
    return showtimeNew;
}
- (UILabel *)setLabelTextColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment font:(CGFloat)fontSize {
    UILabel *label=[[UILabel alloc]init];
    label.textAlignment=textAlignment;
    label.textColor=color;
    label.font=[UIFont systemFontOfSize:fontSize];
    return label;
}
@end

#pragma mark - -MessageChildTableViewController
@interface MessageChildTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,assign)NSInteger pageCount;

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *messageDataArr;

@end

@implementation MessageChildTableViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, IS_IPHONE_X?-30:0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorColor=kTableLineColor;
        _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _tableView.rowHeight=MessageCellHeight;
    }
    return _tableView;
}
- (NSMutableArray *)messageDataArr {
    if (!_messageDataArr) {
        _messageDataArr=[NSMutableArray arrayWithObjects:@"^",@"^",@"^",@"^", nil];
    }
    return _messageDataArr;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)loadData:(NSInteger )selectIndex {
    self.selectedIndex=selectIndex;
    kSelfWeak;
    if (selectIndex==2) {
        [MessagesSysDataModel httpGetFriendsDataWithType:selectIndex currentPage:_currentPage Success:^(id data) {
            [weakSelf.tableView footerEndRefreshing];
            MessagesSysDataModel *model=data;
            _pageCount=model.count;
            if (model.status==1) {
                
                if (model.data) {
                    [self cleanShowBackground];

                    weakSelf.dataArr = [NSMutableArray arrayWithObjects:@"订单消息",@"好友消息",@"账户消息",@"衣豆消息", nil];
                    if (model.data[@"1"]) {
                        [weakSelf.messageDataArr replaceObjectAtIndex:0 withObject:model.data[@"1"]];
                    }
                    if (model.data[@"2"]) {
                        [weakSelf.messageDataArr replaceObjectAtIndex:1 withObject:model.data[@"2"]];
                    }
                    if (model.data[@"3"]) {
                        [weakSelf.messageDataArr replaceObjectAtIndex:2 withObject:model.data[@"3"]];
                    }
                    if (model.data[@"4"]) {
                        [weakSelf.messageDataArr replaceObjectAtIndex:3 withObject:model.data[@"4"]];
                    }

                }else {
                    CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
                    [weakSelf showBackgroundType:ShowBackgroundTypeListEmpty message:nil superView:self.view setSubFrame:frame];
                }
                [weakSelf.tableView reloadData];

            }else
                [NavgationbarView showMessageAndHide:[NSString stringWithFormat:@"%@",model.message]];
        }];
    }else if (selectIndex==1){
        [self loadHistoryData];
        /*
        [MessagesDataModel httpGetFriendsDataWithType:selectIndex history:@"false" currentPage:_currentPage Success:^(id data) {
            [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"TOPICMESSAGE"];
            if (_currentPage==1) {
                [weakSelf.dataArr removeAllObjects];
            }
            MessagesDataModel *model=data;
            if (model.status==1) {
                
                if (model.data.count) {
                    [weakSelf cleanShowBackground];

                    weakSelf.dataArr=[model.data mutableCopy];
                    
                }
//                else {
//                    CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
//                    [weakSelf showBackgroundType:ShowBackgroundTypeListEmpty message:nil superView:self.view setSubFrame:frame];
//                }
                
                [weakSelf loadHistoryData];
//                [self.tableView reloadData];

            }else
                [NavgationbarView showMessageAndHide:[NSString stringWithFormat:@"%@",model.message]];
        }];
        */
    }
}
- (void)loadNewMsgData {
    kSelfWeak;
    [MessagesDataModel httpGetFriendsDataWithType:1 history:@"false" currentPage:_currentPage Success:^(id data) {
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"TOPICMESSAGE"];
      
        MessagesDataModel *model=data;
        if (model.status==1) {
            
            if (model.data.count) {
                [weakSelf cleanShowBackground];
                
                [model.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [weakSelf.dataArr insertObject:obj atIndex:0];
                }];
//                weakSelf.dataArr=[model.data mutableCopy];
            }
          
            if (weakSelf.dataArr.count==0) {
                CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
                [weakSelf showBackgroundType:ShowBackgroundTypeListEmpty message:nil superView:self.view setSubFrame:frame];
            }
            [weakSelf.tableView reloadData];

        }else
            [NavgationbarView showMessageAndHide:[NSString stringWithFormat:@"%@",model.message]];
    }];
}
- (void)loadHistoryData {
    kSelfWeak;
    [MessagesDataModel httpGetFriendsDataWithType:1 history:@"true" currentPage:_currentPage Success:^(id data) {
        [weakSelf.tableView footerEndRefreshing];
        if (_currentPage==1) {
            [weakSelf.dataArr removeAllObjects];
        }
        
        MessagesDataModel *model=data;
        _pageCount=model.count;
        if (model.data.count) {
            [weakSelf cleanShowBackground];
          
            [weakSelf.dataArr addObjectsFromArray:model.data];
        }
        if (_currentPage==1) {
            [self loadNewMsgData];
        }
        [weakSelf.tableView reloadData];

    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _currentPage=1;
    [self.view addSubview:self.tableView];
    
    kSelfWeak;
    [self.tableView addHeaderWithCallback:^{
        kSelfStrong;
        weakSelf.currentPage=1;
        [weakSelf loadData:weakSelf.selectedIndex];
        [strongSelf.tableView headerEndRefreshing];
    }];
    [self.tableView addFooterWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.currentPage++;
            if (weakSelf.currentPage<=_pageCount) {
                if (weakSelf.selectedIndex==1) {
                    [weakSelf loadHistoryData];
                }else
                    [weakSelf loadData:weakSelf.selectedIndex];
            }else{
                [weakSelf.tableView footerEndRefreshing];
            }
        });
    }];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectedIndex==2 ? 4 : self.dataArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedIndex==1) {
       
        PersonMessageModel *model=self.dataArr[indexPath.row];
        TopicDetailViewController *topic = [[TopicDetailViewController alloc]init];
        topic.theme_id = [NSString stringWithFormat:@"%@",model.theme_id];
        topic.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:topic animated:YES];
        
        
    }else if (self.selectedIndex==2) {
        switch (indexPath.row) {
            case 0:
            {
                MyOrderViewController *myorder=[[MyOrderViewController alloc]init];
                myorder.tag=999;
                myorder.status1=@"0";
                myorder.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:myorder animated:YES];
            }
                break;
            case 2:
            {
                TFMyWalletViewController *wallet=[[TFMyWalletViewController alloc]init];
                wallet.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:wallet animated:YES];
            }
                break;
            case 3:
            {
                AXSampleNavBarTabViewController *vc = [[AXSampleNavBarTabViewController alloc]initWithType:YDPageVCTypeYidouFromMessage peas:0 peas_freeze:0 extract:0 freezeMoney:0];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];

    if (!cell) {
        cell=[[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    if (self.selectedIndex==2) {
        [cell reloadDataWithImg:self.dataArr[indexPath.row] messageAndDate:self.messageDataArr[indexPath.row]];
    }else if(self.selectedIndex==1){
        if (self.dataArr.count>indexPath.row)
            [cell reloadMessageModel:self.dataArr[indexPath.row]];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Stretchable Sub View Controller View Source

- (UIScrollView *)stretchableSubViewInSubViewController:(id)subViewController
{
    return _tableView;
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
