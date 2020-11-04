//
//  YDTableViewController.m
//  YunShangShiJi
//
//  Created by yssj on 2016/12/14.
//  Copyright © 2016年 ios-1. All rights reserved.
//

#import "YDTableViewController.h"
#import "GlobalTool.h"

#import "MJRefresh.h"
//model
#import "BaseModel.h"



CGFloat CellHeight = 60;

#pragma mark - -YiDouModel
/*
 衣豆相关参数
 add_date:添加时间
 p_name:明细名称
 num:数量
 type:分类  1任务 2下单 3官方奖励 4抽奖 5官方减少 6点赞消耗 7冻结衣豆抽奖
 注: 下单 的冻结和解冻这两个字需自己判断增加上去
 freeze:冻结状态 0否1是2已退款3失效
 */
/*
 额度相关参数
 num:数量
 type:分类 1抽红包增加 2 夺宝退款 3粉丝购物 4官方赠送 5余额提现 6官方减少
 */
/*
 冻结提现额度明细列表
 add_date:添加时间
 num[double]:数量
 type:1疯狂星期一
 r_code[string]:订单编号
 */
@interface YiDouTableDataModel : BaseModel
@property (nonatomic,strong)NSString *add_date;
@property (nonatomic,strong)NSString *p_name;
@property (nonatomic,strong)NSNumber *num;
@property (nonatomic,strong)NSNumber *type;
@property (nonatomic,strong)NSNumber *freeze;
@property (nonatomic,strong)NSString *r_code;
@end
@implementation YiDouTableDataModel


@end

@interface YiDouModel : BaseModel
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;       //结果信息

+ (void)httpGetYidouModelWithCurrentPage:(NSInteger)currentPage andNum:(NSInteger)num Success:(void(^)(id data))success;    //衣豆
+ (void)httpGetExtractDetailWithCurrentPage:(NSInteger)currentPage andType:(NSInteger)num isFrozen:(BOOL)isFrozen Success:(void(^)(id data))success;//额度

@end

@implementation YiDouModel

//num
//1,查询消耗
//2.查询增加
//3.查询冻结

//type
//不给为查询所有的
//1,新增额度
//2 使用额度

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[YiDouTableDataModel mappingWithKey:@"data"],@"data",nil];
    return mapping;
}
+ (void)httpGetYidouModelWithCurrentPage:(NSInteger)currentPage andNum:(NSInteger)num Success:(void(^)(id data))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"wallet/getPeasDetail?version=%@&token=%@&page=%zd&order=desc&sort=add_date&num=%zd",VERSION,token,currentPage,num];
    [self getDataResponsePath:urlStr success:success];
}
+ (void)httpGetExtractDetailWithCurrentPage:(NSInteger)currentPage andType:(NSInteger)num isFrozen:(BOOL)isFrozen Success:(void (^)(id))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr;
    if (isFrozen) {
        urlStr = [NSString stringWithFormat:@"wallet/getExtractUnDetail?version=%@&token=%@&page=%zd&&order=desc&sort=add_date",VERSION,token,currentPage];
    }else
        urlStr = [NSString stringWithFormat:@"wallet/getExtractDetail?version=%@&token=%@&page=%zd&&order=desc&sort=add_date&type=%zd",VERSION,token,currentPage,num];
    [self getDataResponsePath:urlStr success:success];
}


@end


#pragma mark - -YDTableCell
@interface YDTableCell : UITableViewCell

@property (nonatomic,strong)UILabel *topTextLabel;
@property (nonatomic,strong)UILabel *bottomTextLabel;
@property (nonatomic,strong)UILabel *rightTextLabel;

- (void)reloadDataModel:(YiDouTableDataModel *)model isYiDou:(BOOL)isYiDou selectedIndex:(NSInteger)selectedIndex;

@end
@implementation YDTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setUI {
    [self.contentView addSubview:self.topTextLabel];
    [self.contentView addSubview:self.bottomTextLabel];
    [self.contentView addSubview:self.rightTextLabel];
}
- (UILabel *)topTextLabel {
    if (!_topTextLabel) {
        _topTextLabel = [self setLabelTextColor:kMainTitleColor textAlignment:NSTextAlignmentLeft font:ZOOM6(28)];
        _topTextLabel.frame=CGRectMake(ZOOM6(40), CellHeight/2-20, 300, 20);
    }
    return _topTextLabel;
}
- (UILabel *)bottomTextLabel {
    if (!_bottomTextLabel) {
        _bottomTextLabel = [self setLabelTextColor:kSubTitleColor textAlignment:NSTextAlignmentLeft font:ZOOM6(24)];
        _bottomTextLabel.frame=CGRectMake(ZOOM6(40), CellHeight/2, 200, 20);
    }
    return _bottomTextLabel;
}
- (UILabel *)rightTextLabel {
    if (!_rightTextLabel) {
        _rightTextLabel = [self setLabelTextColor:tarbarrossred textAlignment:NSTextAlignmentRight font:ZOOM6(40)];
        _rightTextLabel.frame=CGRectMake(ZOOM6(40), 0, kScreenWidth-ZOOM6(80), CellHeight);
    }
    return _rightTextLabel;
}
- (void)reloadDataModel:(YiDouTableDataModel *)model isYiDou:(BOOL)isYiDou selectedIndex:(NSInteger)selectedIndex{
    
    if (isYiDou) {
        NSString *typeStr=@"";
        if (model.type.integerValue==2) {
            if (model.freeze.integerValue==0) {
                typeStr=@"完结衣豆解冻";
            }else if(model.freeze.integerValue==1) {
                typeStr=@"冻结";
            }else if(model.freeze.integerValue==2) {
                typeStr=@"已退款";
            }else if(model.freeze.integerValue==3) {
                typeStr=@"失效";
            }
        }
        self.topTextLabel.text = [NSString stringWithFormat:@"%@%@",model.p_name,typeStr];
       
        self.bottomTextLabel.text = [self timeInfoWithTimeInterval:[model.add_date doubleValue]];
        NSString *str=@"";
        
        if (selectedIndex==0) {
            str=@"";
        }else if(selectedIndex==1) {
            str=@"+";
        }
        
        self.rightTextLabel.text = [NSString stringWithFormat:@"%@%g",str,[model.num floatValue]];
    }else {
        if (selectedIndex==2) {//冻结提现额度明细列表
            if (model.type.integerValue==3) {
                self.topTextLabel.text = @"冻结衣豆抽奖";
            }else
                self.topTextLabel.text = [NSString stringWithFormat:@"订单%@冻结",model.r_code];
            
            self.bottomTextLabel.text = [self timeInfoWithTimeInterval:[model.add_date doubleValue]];
            self.rightTextLabel.text = [NSString stringWithFormat:@"%g元",[model.num floatValue]];
        }else {
        NSArray *arr=@[@"抽红包增加",@"抽奖退款",@"粉丝购物",@"官方赠送",@"余额提现",@"官方减少",@"签到",@"邀请好友",@"提现失败退回",@"新用户注册赠送",@"疯狂新衣节",@"购买任务",@"集赞",@"集赞奖励",@"抽奖",@"分享返现",@"余额抽奖",@"好友提现奖励"];
        NSString *typeStr=arr[model.type.integerValue-1];
        
        self.topTextLabel.text = [NSString stringWithFormat:@"%@",typeStr];
        self.bottomTextLabel.text = [self timeInfoWithTimeInterval:[model.add_date doubleValue]];
        
        NSString *str=@"";
        if (selectedIndex==1) {
            str=@"";
        }else if(selectedIndex==0) {
            str=@"+";
        }
        self.rightTextLabel.text = [NSString stringWithFormat:@"%@%g元",str,[model.num floatValue]];
        }
    }
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

#pragma mark - -YDTableViewController

@interface YDTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)NSInteger selectedIndex;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,assign)NSInteger pageCount;

@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation YDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tab C" image:nil tag:0];
    [self.view addSubview:self.tableView];
    
    kSelfWeak;
    [self.tableView addFooterWithCallback:^{
        weakSelf.currentPage++;
        if (weakSelf.currentPage<=_pageCount) {
            [weakSelf loadData];
        }else{
            [weakSelf.tableView footerEndRefreshing];
        }
    }];
    
//    [self reloadData:0];
}

- (void)reloadData:(NSInteger)index {
    _selectedIndex=index;
    _currentPage=1;
    [self loadData];
}
- (void)loadData {
    
    if (_type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage)) {
        kSelfWeak;
        [YiDouModel httpGetYidouModelWithCurrentPage:_currentPage andNum:_selectedIndex+1 Success:^(id data) {
            [weakSelf.tableView footerEndRefreshing];
            if (_currentPage==1) {
                [weakSelf.dataArr removeAllObjects];
            }
            
            YiDouModel *model=data;
            if (model.status==1) {
                weakSelf.pageCount=model.pageCount;
                [weakSelf.dataArr addObjectsFromArray:model.data];
            }
            
            if (weakSelf.dataArr.count<=0) {
                [self loadSmileView:self.tableView];
//                [self loadingDataBackgroundView:self.tableView img:nil text:nil];
            }else{
                [self loadingDataSuccess];
            }
            [weakSelf.tableView reloadData];
        }];
    }
    else{
        kSelfWeak;
       
        [YiDouModel httpGetExtractDetailWithCurrentPage:_currentPage andType:_selectedIndex+1 isFrozen:_selectedIndex==2 Success:^(id data) {
            [weakSelf.tableView footerEndRefreshing];
            if (_currentPage==1) {
                [weakSelf.dataArr removeAllObjects];
            }
            YiDouModel *model=data;
            if (model.status==1) {
                weakSelf.pageCount=model.pageCount;
                [weakSelf.dataArr addObjectsFromArray:model.data];
            }
            
            if (weakSelf.dataArr.count<=0) {
                [self loadSmileView:self.tableView];
            }else{
                [self loadingDataSuccess];
                [weakSelf.tableView reloadData];
            }
        }];
    }

}
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        _tableView.separatorColor=kTableLineColor;
    }
    return _tableView;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_selectedIndex==2)?self.dataArr.count+1:self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if (!cell) {
        cell=[[YDTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    if (_selectedIndex==2 && indexPath.row==0) {
        
        cell=[[YDTableCell alloc]init];
        cell.rightTextLabel.text=_type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage)?@"订单签收7天后衣豆才解冻喔～":@"订单签收7天后额度才解冻喔";
        cell.rightTextLabel.textAlignment=NSTextAlignmentCenter;
        cell.rightTextLabel.font=[UIFont systemFontOfSize:ZOOM6(24)];
        cell.rightTextLabel.frame=CGRectMake(ZOOM6(40), 0, kScreenWidth-ZOOM6(80), ZOOM6(80));
//        cell.topTextLabel.hidden=YES;
//        cell.bottomTextLabel.hidden=YES;
        return cell;
    }
    [cell reloadDataModel:
                self.dataArr[(_selectedIndex==2)?indexPath.row-1:indexPath.row]
          isYiDou:_type&(YDPageVCTypeYidou|YDPageVCTypeYidouFromMessage)
          selectedIndex:_selectedIndex];
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _selectedIndex==2 && indexPath.row==0
            ? ZOOM6(80) : CellHeight;
}

#pragma mark - Stretchable Sub View Controller View Source

- (UIScrollView *)stretchableSubViewInSubViewController:(id)subViewController
{
    return _tableView;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
