//
//  SharOrderVC.m
//  YunShangShiJi
//
//  Created by zgl on 16/6/1.
//  Copyright © 2016年 ios-1. All rights reserved.
//  晒单详情

#import "SharOrderVC.h"
#import "GlobalTool.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MBProgressHUD+NJ.h"
#import "MBProgressHUD+XJ.h"
#import "SOContentView.h"
#import "SOInputView.h"
#import "SOMessageCell.h"
#import "SONoDataCell.h"
#import "IndianaDetailViewController.h"

@interface SharOrderVC ()<UITableViewDataSource, UITableViewDelegate, SOContentViewDelegate>
{
    UITapGestureRecognizer *_tap;   // 键盘收起手势
    UIPanGestureRecognizer *_pan;
    
    NSString *_msgID;               // 发送消息ID
    SOCommentModel *_contentModel;  // 正文数据源
    NSMutableArray *_replyArray;    // 评论数据
    NSInteger _page;                // 评论当前页码
    NSInteger _cellCount;
}

@property (nonatomic, strong) UITableView *mainTableView;   // 主界面（cell为评论）
@property (nonatomic, strong) SOContentView *contentView;   // 正文
@property (nonatomic, strong) SOInputView *inputView;       // 输入框

@end

@implementation SharOrderVC

- (instancetype)initWithShopCode:(NSString *)shopCode {
    self = [super init];
    if (self) {
        _shopCode = shopCode;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@释放了",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kBackgroundColor];
    [self setNavigationBackWithTitle:@"晒单分享详情"];
    //通知 监听键盘将要出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFramWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //通知 监听键盘将要消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    _replyArray = [NSMutableArray array];
    //创建UI
    [self setUI];
    //加载数据
    [MBProgressHUD showHUDAddTo:self.view animated:YES];
    [self updata];
}

#pragma mark - 创建UI
- (void)setUI {
    [self.view addSubview:self.mainTableView];
//    [self.view addSubview:self.inputView];
    __weak typeof(self) weakSelf = self;
    // 下拉刷新
    [self.mainTableView addHeaderWithCallback:^{
        [weakSelf updata];
    }];
    // 上拉加载
//    [self.mainTableView addFooterWithCallback:^{
//        [weakSelf loadReplyList];
//    }];
    // 加载失败重新加载
    [self loadFailBtnBlock:^{
        [MBProgressHUD showHUDAddTo:weakSelf.view animated:YES];
        weakSelf.inputView.hidden = YES;
        weakSelf.mainTableView.hidden = YES;
        [weakSelf updata];
    }];
    // 键盘收起手势
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
}

#pragma mark - 加载数据
- (void)updata {
    __weak typeof(self) weakSelf = self;
    // 加载正文
    [SelCommentModel getSelCommentModelWithShopCode:_shopCode success:^(id data) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        [MBProgressHUD hideAllHUDsForView:strongSelf.view animated:YES];
        SelCommentModel *model = data;
        if (model.status == 1) {
            [strongSelf.mainTableView headerEndRefreshing];


            [strongSelf loadingDataSuccess];
            strongSelf -> _contentModel = model.comment;
            [strongSelf.contentView receiveDataModel:model.comment];
            strongSelf.mainTableView.tableHeaderView = strongSelf.contentView;
            strongSelf.mainTableView.hidden = NO;
            strongSelf.inputView.hidden = NO;
            // 加载评论
            [strongSelf -> _replyArray removeAllObjects];
            strongSelf -> _page = 0;
//            [strongSelf loadReplyList];
        } else {
            [strongSelf.mainTableView headerEndRefreshing];
            [MBProgressHUD showError:model.message];
            [strongSelf loadingDataFail];
        }
    }];
}

/// 加载评论
- (void)loadReplyList {
    _page++;
    __weak typeof(self) weakSelf = self;
    [ReplyListModel getReplyListModelWithShopCode:_shopCode page:_page success:^(id data) {
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        ReplyListModel *model = data;
        [strongSelf.mainTableView headerEndRefreshing];
        [strongSelf.mainTableView footerEndRefreshing];
        if (model.status == 1) {
            if (model.comments.count) {
                [strongSelf -> _replyArray addObjectsFromArray:model.comments];
            } else if(strongSelf -> _replyArray.count == 0){
                strongSelf -> _cellCount = 1;
            }
            strongSelf -> _contentModel.comment_size = model.pageCount;
            [strongSelf.contentView setCommentSize:strongSelf -> _contentModel.comment_size];
            [strongSelf.mainTableView reloadData];
        } else {
            [MBProgressHUD showError:model.message];
        }
        strongSelf.mainTableView.footerHidden = (strongSelf->_replyArray.count == model.pageCount);
    }];

}

/// 发送消息
- (void)sendMessage:(NSString *)message {
    if (message.length <= 0) {
        [MBProgressHUD showError:@"回复不能为空！"];
    } else {
        __weak typeof(self) weakSelf = self;
        [MBProgressHUD showMessage:@"正在提交评论" afterDeleay:0 WithView:self.view];
        [SelCommentModel sendMessageWithShopCode:_shopCode toUserId:_msgID content:message success:^(id data) {
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            [MBProgressHUD hideHudForView:strongSelf.view];
            SelCommentModel *model = data;
            if (model.status == 1) {
                [MBProgressHUD showSuccess:@"评论成功"];
                // 加载评论
                [strongSelf -> _replyArray removeAllObjects];
                strongSelf -> _page = 0;
                [strongSelf loadReplyList];
            } else {
                [MBProgressHUD showError:model.message];
            }
        }];
    }
    [self keyboardHidden];
}

#pragma mark - 键盘相关
/// 键盘出现
- (void)keyBoardFramWillChange:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        CGRect frame = _inputView.frame;
        frame.origin = CGPointMake(0, endFrame.origin.y - frame.size.height);
        _inputView.frame = frame;
    } completion:nil];
    
    [self.view addGestureRecognizer:_tap];
    [self.view addGestureRecognizer:_pan];
    [self.mainTableView setUserInteractionEnabled:NO];
}

/// 键盘消失
- (void)keyBoardWillDisappear:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        CGRect frame = _inputView.frame;
        frame.origin = CGPointMake(0,self.view.bounds.size.height - frame.size.height);
        _inputView.frame = frame;
    } completion:nil];
    
    [self.view removeGestureRecognizer:_tap];
    [self.view removeGestureRecognizer:_pan];
    [self.mainTableView setUserInteractionEnabled:YES];
}

/// 收回键盘
- (void)keyboardHidden {
    _msgID = nil;
    [self.inputView textFileBecomeFirstResponder:NO placeholder:@"评论"];
}

#pragma mark - UTableViewDataSource
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kZoom6pt(10), self.mainTableView.bounds.size.width, kZoom6pt(50))];
    bgView.backgroundColor = [UIColor whiteColor];
    [view addSubview:bgView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mainTableView.bounds.size.width, 0.5)];
    lineView.backgroundColor = lineGreyColor;
    [bgView addSubview:lineView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kZoom6pt(15), 0, 100, kZoom6pt(50))];
    label.textColor = kTitleColor;
    label.font = [UIFont systemFontOfSize:kZoom6pt(16)];
    label.text = @"全部评论";
    [bgView addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kZoom6pt(60);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _replyArray.count?:_cellCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_replyArray.count) {
        ReplyModel *model = _replyArray[indexPath.row];
        return model.cellHeight;
    }
    return SONoDataCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_replyArray.count) {
        static NSString *cellName = @"cell";
        SOMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SOMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        __weak typeof(self) weakSelf = self;
        ReplyModel *model = _replyArray[indexPath.row];
        [cell receiveDataModel:model btnBlock:^(NSString *reuserID, NSString *nickName) {
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            strongSelf -> _msgID = reuserID;
            [strongSelf.inputView textFileBecomeFirstResponder:YES placeholder:[NSString stringWithFormat:@"回复%@",nickName]];
        }];
        return cell;
    } else {
        SONoDataCell *cell = [[SONoDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoData"];
        return cell;
    }
}

#pragma mark - SOContentViewDelegate
- (void)buttonClick:(UIButton *)sender index:(NSInteger)index {
    switch (index) {
        case 1: {
            NSLog(@"查看详情");
            TreasureRecordsModel *model = [[TreasureRecordsModel alloc] init];
            model.otime = @(_contentModel.otime).stringValue;
            model.in_name = _contentModel.user_name;
            model.in_code = _contentModel.lucky_number;
            model.in_uid = _contentModel.user_id;
            model.in_head = _contentModel.user_url;
            model.num = @(_contentModel.count);
            model.issue_code = _contentModel.issue_code;
            IndianaDetailViewController *shopdetail=[[IndianaDetailViewController alloc]init];
            shopdetail.shop_code= _shopCode;
            shopdetail.recordsModel = model;
            shopdetail.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shopdetail animated:YES];
        }
            break;
        case 2: {
            NSLog(@"点赞");
            __weak typeof(self) weakSelf = self;
            [SelCommentModel addlikeWithShopCode:_shopCode success:^(id data) {
                __strong __typeof__(weakSelf) strongSelf = weakSelf;
                SelCommentModel *model = data;
                if (model.status == 1) {
                    // 刷新页面
                    strongSelf -> _contentModel.click_size++;
                    [sender setTitle:[NSString stringWithFormat:@"%ld",strongSelf -> _contentModel.click_size] forState:UIControlStateNormal];
                    sender.selected = YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:AddLikeNotification object:nil];
                } else {
                    [MBProgressHUD showError:model.message];
                }
            }];
        }
            break;
        case 3: {
            NSLog(@"回复");
            [self.inputView textFileBecomeFirstResponder:YES placeholder:@"评论"];
        }
            break;
        default:
            break;
    }
    
}

/// 正文高度变化时
- (void)contentViewWillChangeHeight {
    [self.mainTableView setTableHeaderView:self.contentView];
}

#pragma mark - getter方法
- (UITableView *)mainTableView {
    if (nil == _mainTableView) {
        CGRect frame = self.view.bounds;
//        frame.size = CGSizeMake(frame.size.width, frame.size.height - kZoom6pt(58) - 63);
        frame.size = CGSizeMake(frame.size.width, frame.size.height - 63);

        frame.origin = CGPointMake(0, 64);
        _mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.tableFooterView = [UIView new];
        _mainTableView.backgroundColor = kBackgroundColor;
        _mainTableView.hidden = YES;
    }
    return _mainTableView;
}

- (SOContentView *)contentView {
    if (nil == _contentView) {
         _contentView = [[SOContentView alloc] initWithFrame:CGRectZero];
        _contentView.delegate = self;
    }
    return _contentView;
}

- (SOInputView *)inputView {
    if (nil == _inputView) {
        CGSize size = self.view.bounds.size;
        _inputView = [[SOInputView alloc] initWithFrame:CGRectMake(0, size.height - kZoom6pt(58),size.width, kZoom6pt(58))];
        __weak typeof(self) weakSelf = self;
        _inputView.hidden = YES;
        [_inputView setSendBlock:^(NSString *message){
            [weakSelf sendMessage:message];
        }];
    }
    return _inputView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
