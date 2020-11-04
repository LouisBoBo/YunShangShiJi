//
//  CFFriendsViewController.m
//  YunShangShiJi
//
//  Created by yssj on 2017/2/25.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "CFFriendsViewController.h"

#import "BaseModel.h"

#import "TFPopBackgroundView.h"

CGFloat FriendsCellHeight = 60;


@interface FriendModel : BaseModel
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSNumber *user_id;
@end
@implementation FriendModel
@end

@interface FriendsData : BaseModel
@property (nonatomic, assign) NSInteger status;      //结果
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) NSArray *list;

+ (void)httpGetFriendsDataWithType:(NSInteger )type currentPage:(NSInteger )page Success:(void(^)(id data))success;
@end
@implementation FriendsData
+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[FriendModel mappingWithKey:@"list"],@"list",nil];
    return mapping;
}
+ (void)httpGetFriendsDataWithType:(NSInteger )type currentPage:(NSInteger )page Success:(void(^)(id data))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"fc/queryFriendList?version=%@&token=%@&type=%zd&page=%zd",VERSION,token,type,page];
    [self getDataResponsePath:urlStr success:success];
}
@end

#pragma mark - -FriendsTableViewCell
@interface FriendsTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headImg;
@property (nonatomic,strong)UILabel *topTextLabel;
@property (nonatomic,strong)UILabel *bottomTextLabel;
@property (nonatomic,strong)UILabel *rightTextLabel;
- (void)loadFriendModel:(FriendModel *)model;

@end
@implementation FriendsTableViewCell
- (void)loadFriendModel:(FriendModel *)model {
    self.topTextLabel.text=model.nickname;
//    self.bottomTextLabel.text=model.
    if ([model.pic hasPrefix:@"http://"]) {
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]]];
    } else{
        [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy],model.pic]]];
    }
    
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
        _headImg=[[UIImageView alloc]initWithFrame:CGRectMake(ZOOM6(30), ZOOM6(20), FriendsCellHeight-ZOOM6(40), FriendsCellHeight-ZOOM6(40))];
        _headImg.layer.cornerRadius=_headImg.frame.size.width/2;
        _headImg.clipsToBounds=YES;
    }
    return _headImg;
}
- (UILabel *)topTextLabel {
    if (!_topTextLabel) {
        _topTextLabel = [self setLabelTextColor:kMainTitleColor textAlignment:NSTextAlignmentLeft font:ZOOM6(28)];
        _topTextLabel.frame=CGRectMake(CGRectGetMaxX(self.headImg.frame)+ ZOOM6(30), FriendsCellHeight/2-20, 300, 20);
    }
    return _topTextLabel;
}
- (UILabel *)bottomTextLabel {
    if (!_bottomTextLabel) {
        _bottomTextLabel = [self setLabelTextColor:kSubTitleColor textAlignment:NSTextAlignmentLeft font:ZOOM6(24)];
        _bottomTextLabel.frame=CGRectMake(self.topTextLabel.x, FriendsCellHeight/2, 200, 20);
    }
    return _bottomTextLabel;
}
- (UILabel *)rightTextLabel {
    if (!_rightTextLabel) {
        _rightTextLabel = [self setLabelTextColor:tarbarrossred textAlignment:NSTextAlignmentRight font:ZOOM6(40)];
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

@interface CFFriendsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,assign)NSInteger pageCount;

@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation CFFriendsViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, self.view.frame.size.width, self.view.frame.size.height-Height_NavBar) style:UITableViewStylePlain];
        _tableView.backgroundColor=kBackgroundColor;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorColor=kTableLineColor;
        _tableView.rowHeight=FriendsCellHeight;
    }
    return _tableView;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItemLeft:self.type==CFFriendsNormal?@"好友":@"蜜友"];
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(kScreenWidth-60, IS_IPHONE_X?30:20, 60, 44);
    [rightBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
        TFPopBackgroundView *view=[[TFPopBackgroundView alloc]initWithTitle:@"好友和蜜友的关系" message:@"好友是你通过分享商品或者是邀请好友成功过来注册的用户，好友在衣蝠购买商品，你将获得商品价格（X10%）的现金奖励。同时你和好友会互相关注为蜜友。\n蜜友是在蜜友圈关注的其它用户。" showCancelBtn:NO leftBtnText:nil rightBtnText:@"取消"];
        [view show];
    }];
    
    rightBtn.contentMode=UIViewContentModeCenter;
    [rightBtn setImage:[UIImage imageNamed:@"friendRightDetailIcon"] forState:UIControlStateNormal];
    [self.navigationView addSubview:rightBtn];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, Height_NavBar-0.5, kScreenWidth, 0.5)];
    line.backgroundColor=kNavLineColor;
    [self.navigationView addSubview:line];
    
    [self.view addSubview:self.tableView];
    
    [self loadData];
    kSelfWeak;
    [self.tableView addFooterWithCallback:^{
        weakSelf.currentPage++;
        if (weakSelf.currentPage<=_pageCount) {
            [weakSelf loadData];
        }else{
            [weakSelf.tableView footerEndRefreshing];
        }
    }];
}

- (void)loadData {
    [FriendsData httpGetFriendsDataWithType:self.type currentPage:self.currentPage Success:^(id data) {
        FriendsData *model=data;
        if (model.status==1) {
            if (model.list.count) {
                self.dataArr = [model.list mutableCopy];
                [self.tableView reloadData];
            }else{
                CGRect frame = CGRectMake(0, kNavigationheightForIOS7, self.view.frame.size.width, kScreenHeight-kNavigationheightForIOS7);
                [self createBackgroundView:self.view andTag:9999 andFrame:frame withImgge:nil andText:nil];
            }
        }else
            [NavgationbarView showMessageAndHide:[NSString stringWithFormat:@"%@",model.message]];
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];

    if (!cell) {
        cell=[[FriendsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    
    [cell loadFriendModel:self.dataArr[indexPath.row]];
    
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
