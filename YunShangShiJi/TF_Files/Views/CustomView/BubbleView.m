//
//  BubbleView.m
//  YunShangShiJi
//
//  Created by jingaiweiyi on 2017/1/7.
//  Copyright © 2017年 ios-1. All rights reserved.
//

#import "BubbleView.h"
#import "SUTableView.h"
#import "GlobalTool.h"
#import "BaseModel.h"
#import "PagerModel.h"
#pragma mark - ++++++++++++ BubbleViewModel ++++++++++++
#pragma mark - Bubble

@interface BubbleContent : BaseModel
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *nname;
@property (nonatomic, assign) double num;

@property (nonatomic, copy) NSString *money;
@property (nonatomic, assign) BOOL isPublic;
@end

@implementation BubbleContent : BaseModel

@end



@interface BubbleModel: BaseModel

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) PagerModel *pager;            //页码
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *message;       //结果信息

+ (void)getBubbleDataSuccess:( void (^)(id data))success;

@end

@implementation BubbleModel

+ (NSMutableDictionary *)getMapping {
    
//    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[BubbleContent mappingWithKey:@"data"],@"data",[PagerModel mappingWithKey:@"pager"],@"pager" ,nil];
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[PagerModel mappingWithKey:@"pager"],@"pager" ,nil];

    return mapping;
}

// 接口
+ (void)getBubbleDataSuccess:(void (^)(id data))success {
    NSString *path = [NSString stringWithFormat:@"wallet/fkNewData?version=%@", VERSION];
    [self getDataResponsePath:path success:success];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

@end

#pragma mark - ++++++++++++ BubbleViewCell ++++++++++++

static NSString *BubbleViewCellId = @"BubbleViewCellId";
@interface BubbleViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *backgroundImageV;
@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *bubbleLable;
@property (nonatomic, strong) UIImage *bubbleImage;
@end
@implementation BubbleViewCell
{
    BubbleContent *pubModel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.backgroundImageV];
    [self.backgroundImageV addSubview:self.headImageV];
    [self.backgroundImageV addSubview:self.bubbleLable];
}

- (void)layoutSubviews {
    self.backgroundImageV.frame = CGRectMake(0, ZOOM6(10), self.width-1, self.height - ZOOM6(10) * 2);
    self.headImageV.frame = CGRectMake(ZOOM6(12), 0, ZOOM6(60), ZOOM6(60));
    self.headImageV.centerY = self.backgroundImageV.height * 0.5;
    self.bubbleLable.frame = CGRectMake(self.headImageV.right + ZOOM6(20), ZOOM6(20), self.width-self.headImageV.right - ZOOM6(20) - ZOOM6(20), self.height - ZOOM6(20)*2);
    self.bubbleLable.centerY = self.backgroundImageV.height * 0.5;
}

- (UIImageView *)backgroundImageV {
    if (_backgroundImageV != nil) {
        return _backgroundImageV;
    }
    
    UIImageView *backgroundImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, ZOOM6(10), self.width-1, self.height - ZOOM6(10) * 2)];
    backgroundImageV.image = self.bubbleImage;
    _backgroundImageV = backgroundImageV;
    return _backgroundImageV;
}

- (UIImage *)bubbleImage {
    if (!_bubbleImage) {
        UIImage *bubbleImage = [UIImage imageNamed:@"ps_qipao"];
        CGSize imageSize = bubbleImage.size;
        bubbleImage = [bubbleImage stretchableImageWithLeftCapWidth:imageSize.width * 0.5 topCapHeight:imageSize.height * 0.5];
        _bubbleImage = bubbleImage;
    }
    return _bubbleImage;
}


- (UIImageView *)headImageV {
    if (_headImageV != nil) {
        return _headImageV;
    }
    _headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(ZOOM6(12), 0, ZOOM6(60), ZOOM6(60))];
    _headImageV.centerY = self.height * 0.5;
    _headImageV.layer.cornerRadius = ZOOM6(60) * 0.5;
    _headImageV.layer.masksToBounds = YES;
    _headImageV.centerY = self.backgroundImageV.height * 0.5;
//    _headImageV.backgroundColor = COLOR_RANDOM;
    return _headImageV;
}

- (UILabel *)bubbleLable {
    if (_bubbleLable != nil) {
        return _bubbleLable;
    }
    _bubbleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageV.right + ZOOM6(20), ZOOM6(20), self.width-self.headImageV.right - ZOOM6(20) - ZOOM6(20), self.height - ZOOM6(20)*2)];
    _bubbleLable.textColor = [UIColor whiteColor];
    _bubbleLable.font = kFont6px(22);
    _bubbleLable.centerY = self.backgroundImageV.height * 0.5;
    return _bubbleLable;
}

#pragma mark - Public Method

/**
 半透明
 */
- (void)cellTransparentState {
    self.contentView.alpha = 1;
    self.backgroundImageV.alpha = 1;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.contentView.alpha = 0.7;
            self.backgroundImageV.alpha = 0.7;
        }];
//        self.contentView.alpha = 0.7;
//        self.backgroundImageV.alpha = 0.7;
    } completion:^(BOOL finished) {
//        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//        alphaAnimation.fromValue = @(0.8);
//        alphaAnimation.toValue = @(0.5);
//        alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        alphaAnimation.autoreverses = NO;
//        alphaAnimation.repeatCount = HUGE_VALF;
//        alphaAnimation.beginTime = CACurrentMediaTime();
//        alphaAnimation.duration = 0.7;
//        alphaAnimation.removedOnCompletion = NO;
//        alphaAnimation.fillMode = kCAFillModeForwards;
//        
//        [self.contentView.layer addAnimation:alphaAnimation forKey:@"A"];
//        [self.backgroundImageV.layer addAnimation:alphaAnimation forKey:@"B"];

    }];
}

/**
 正常
 */
- (void)cellNormalState {
    self.contentView.alpha = 1;
    self.backgroundImageV.alpha = 1;
}

- (void)setModel:(BubbleContent *)model {
    pubModel = model;
    if([model.pic hasPrefix:@"http"])
    {
         [self.headImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.pic]]];
    }else{
         [self.headImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSObject baseURLStr_Upy], model.pic]]];
    }
   
    [self setName:model.nname withMoney:model.num];
}

- (void)setName:(NSString *)name withMoney:(double)money {
    NSMutableAttributedString *attrText = [NSString attributedSourceString:[NSString stringWithFormat:@"%@  获得提现额度%.2f元", name, money] targetString:[NSString stringWithFormat:@"%.2f", money] addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
    
    if(pubModel.isPublic)
    {
        NSString *str = [name substringToIndex:3];
        NSArray *strarr = @[str,[NSString stringWithFormat:@"%@万", pubModel.money]];
        if(name)
        {
            attrText = [[NSMutableAttributedString alloc]initWithString:name];
        }
        for(int i =0;i < strarr.count; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%@",strarr[i]];
            NSRange range = [name rangeOfString:str];
            [attrText addAttribute:NSForegroundColorAttributeName value:COLOR_ROSERED range:NSMakeRange(range.location, range.length)];
        }
    }
    else if([DataManager sharedManager].IS_Monday)
    {
        attrText = [NSString attributedSourceString:[NSString stringWithFormat:@"%@  抽中%.2f元提现额度", name, money] targetString:[NSString stringWithFormat:@"%.2f", money] addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
    }else if ([DataManager sharedManager].is_SuperZeroShop)
    {
        attrText = [NSString attributedSourceString:[NSString stringWithFormat:@"%@  邀请好友得%.2f元", name, money] targetString:[NSString stringWithFormat:@"%.2f", money] addAttributes:@{NSForegroundColorAttributeName:COLOR_ROSERED}];
    }
    self.bubbleLable.attributedText = attrText;
}

@end

#pragma maek - ++++++++++++ BubbleView ++++++++++++
@interface BubbleView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) SUTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSIndexPath *oldIndexPath;

@end

@implementation BubbleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - private Method
- (void)setupUI {
    [self addSubview:self.tableView];
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"curr: %@", indexPath);
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
    if (oldIndexPath.row >= 0) {
        BubbleViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
        [oldCell cellTransparentState];
    }
    self.oldIndexPath = indexPath;
    
    BubbleViewCell *currCell = (BubbleViewCell *)cell;
    [currCell cellNormalState];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BubbleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BubbleViewCellId];
    if (cell == nil) {
        cell = [[BubbleViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BubbleViewCellId];
    }
    if(indexPath.row < self.dataSource.count)
    {
        [cell setModel:self.dataSource[indexPath.row]];
    }
    return cell;
}

#pragma mark - 加载
- (SUTableView *)tableView {
    if (_tableView != nil) {
        return _tableView;
    }
    _tableView = [[SUTableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.rowHeight = self.height * 0.5;
    _tableView.userInteractionEnabled = NO;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (_dataSource != nil) {
        return _dataSource;
    }
    _dataSource = [NSMutableArray array];
    
    for (int i = 0; i<50; i++) {
        [_dataSource addObject:[self getVirtualModel]];
    }
    
    return _dataSource;
}

- (BubbleContent *)getVirtualModel {
    BubbleContent *content = [[BubbleContent alloc] init];
    content.pic = [NSString stringWithFormat:@"defaultcommentimage/%@", [NSString userHeadRandomProduce]];
    content.nname = [NSString userNameRandomProduce];
    content.num = [[NSString stringWithFormat:@"%d.%d", 100 + arc4random_uniform(900), (5 + arc4random_uniform(5)) * 10 + 5 + arc4random_uniform(5)] doubleValue];
    return content;
}

- (BubbleContent *)getBubbleModel:(NSInteger)index
{
    BubbleContent *content = [[BubbleContent alloc] init];
    content.pic = @"userinfo/head_pic/default.jpg";
    content.nname = self.falseData[index-1];
    content.isPublic = YES;
    
    if(content.nname.length > 0)
    {
        NSRange fromrange = [content.nname rangeOfString:@"共计"];
        NSString *fromstr = [content.nname substringFromIndex:fromrange.location+2];
        NSRange torange = [fromstr rangeOfString:@"万元"];
        NSString *newstr = [fromstr substringToIndex:torange.location];
        
        content.money = [NSString stringWithFormat:@"%@",newstr];
    }
    return content;
}

//第几天
- (NSInteger)getDayCount
{
    NSInteger dayCount = 1;
    NSString *week = [MyMD5 weekdayStringFromDate:[NSDate date]];
    NSDictionary *dic = @{@"周日":@"7",@"周一":@"1",@"周二":@"2",@"周三":@"3",@"周四":@"4",@"周五":@"5",@"周六":@"6"};
    dayCount = [[dic objectForKey:week] integerValue];
    return dayCount;
}
//时间段
#pragma mark 判断某个时间是否在9~12 13~16 17~22点
- (NSInteger)getHourCount
{
    NSInteger hourcount = 0;
    
    NSDate *date9 = [MyMD5 getCustomDateWithHour:9];
    NSDate *date12 = [MyMD5 getCustomDateWithHour:12];
    NSDate *date13 = [MyMD5 getCustomDateWithHour:13];
    NSDate *date16 = [MyMD5 getCustomDateWithHour:16];
    NSDate *date17 = [MyMD5 getCustomDateWithHour:17];
    NSDate *date22 = [MyMD5 getCustomDateWithHour:22];
    
    NSDate *currentDate = [NSDate date];
    if([currentDate compare:date9]==NSOrderedDescending && [currentDate compare:date12]==NSOrderedAscending)
    {
        hourcount = 1;
    }else if ([currentDate compare:date13]==NSOrderedDescending && [currentDate compare:date16]==NSOrderedAscending){
        hourcount = 2;
    }else if ([currentDate compare:date17]==NSOrderedDescending && [currentDate compare:date22]==NSOrderedAscending){
        hourcount = 3;
    }
    return hourcount;
}

#pragma mark - public Method
- (void)startScroll {
    [self.tableView openAutoScroll];
}

- (void)getData {
    [BubbleModel getBubbleDataSuccess:^(id data) {
        BubbleModel *model = data;
        if (model.status == 1) {
            
            NSArray *contentArray = model.data;
            // 处理数据~
            if (contentArray.count) {
                [self.dataSource removeAllObjects];
                
//                for (BubbleContent *content in contentArray) {
//                    [self.dataSource addObject:content];
//                    [self.dataSource addObject:[self getVirtualModel]];
//                }
                
                for(NSString *dataStr in contentArray)
                {
                    if(dataStr)
                    {
                        NSDictionary *dic = [self parseJSONStringToNSDictionary:dataStr];
                        if(dic)
                        {
                            BubbleContent *content = [[BubbleContent alloc] init];
                            [content setValuesForKeysWithDictionary:dic];
                            
                            [self.dataSource addObject:content];
                            [self.dataSource addObject:[self getVirtualModel]];
                        }
                    }
                }
                
                if(self.tag == 898989)
                {
                    NSMutableArray *newdataArray = [NSMutableArray array];
                    for(int i =0; i<self.dataSource.count; i++)
                    {
                        if(i!=0 && i%6==0)
                        {
                            NSInteger hourcount = [self getHourCount];
                            NSInteger daycount = [self getDayCount];
                            hourcount>0?[newdataArray addObject:[self getBubbleModel:(daycount-1)*3+hourcount]]:nil;
                        }else{
                            [newdataArray addObject:self.dataSource[i]];
                        }
                    }
                    
                    [self.dataSource removeAllObjects];
                    [self.dataSource addObjectsFromArray:newdataArray];
                }
                [self.tableView reloadData];
            }
        }
    }];
}

-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

- (NSMutableArray *)falseData
{
    if(_falseData == nil)
    {
        _falseData = [NSMutableArray array];
        NSArray *data = @[@"13人抽中千元大奖，共计1.3万元",@"18人抽中千元大奖，共计1.8万元",@"20人抽中千元大奖，共计2万元",@"22人抽中千元大奖，共计2.2万元",@"25人抽中千元大奖，共计2.5万元",@"27人抽中千元大奖，共计2.7万元",@"29人抽中千元大奖，共计2.9万元",@"36人抽中千元大奖，共计3.6万元",@"41人抽中千元大奖，共计4.1万元",@"45人抽中千元大奖，共计4.5万元",@"50人抽中千元大奖，共计5万元",@"58人抽中千元大奖，共计5.8万元",@"62人抽中千元大奖，共计6.2万元",@"66人抽中千元大奖，共计6.6万元",@"71人抽中千元大奖，共计7.1万元",@"75人抽中千元大奖，共计7.5万元",@"77人抽中千元大奖，共计7.7万元",@"80人抽中千元大奖，共计8万元",@"82人抽中千元大奖，共计8.2万元",@"88人抽中千元大奖，共计8.8万元",@"92人抽中千元大奖，共计9.2万元"];
        [_falseData addObjectsFromArray:data];
    }
    return _falseData;
}
- (void)dealloc {
    NSLog(@"%@释放了...", [self class]);
}


@end
