//
//  DJRoationView.m
//  DJRotainVIew
//
//  Created by Jason on 28/12/15.
//  Copyright © 2015年 Jason. All rights reserved.
//

#import "DJRoationView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "DJRoundLayout.h"
#import "SpecialDetailModel.h"
#import "LuckModel.h"

@interface ScoreLabel : UILabel;

@end
@implementation ScoreLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont boldSystemFontOfSize:14];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
@end


@interface DJCollectViewCell : UICollectionViewCell
@property (nonatomic,strong)ScoreLabel *label;
@end

@implementation DJCollectViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.label = [[ScoreLabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.label];
//        self.label.center = self.contentView.center;
        
    }
    return self;
}


- (void)setTitle:(NSString *)str IndexPath:(NSIndexPath *)indexPath
{
    self.label.text = str;
    if (indexPath) {
        CGFloat angle = (-M_PI/8)+indexPath.row*(M_PI/4);
        self.transform = CGAffineTransformMakeRotation(angle);
    }
}
@end



typedef enum : NSUInteger {
    none,
    increasing,//递增
    diminishing,//递减
} VariableSpeedState;

typedef void(^RotationBlock)(NSInteger,CGFloat,CGFloat,NSInteger);
@interface DJRoationView () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    SystemSoundID soundID;
    CGFloat _al;//角度
    CGFloat moveal;//偏移角度
    CFTimeInterval duration;//时间
    NSInteger titleCount;
    int roationCount;//旋转总次数
    int hasRoationCount;//已转的次数
    int remberRoationCount;//记录已转的次数
    int fictitiousCount;//虚拟已转的次数
    int lastIndex;//最后一次动画的index
    
    int count;
    CGFloat raward; //抽到的额度
    NSInteger rawardtype; //0额度 1现金
    NSInteger cutDowntime;//3秒倒计时
}
@property (nonatomic,strong)UIImageView *turnView;
@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,strong)UILabel *cutdownlab;
@property (nonatomic,assign)VariableSpeedState variableState;//变速方式
@property (nonatomic,copy)RotationBlock block;
@property (nonatomic,strong)NSMutableArray *titles;
@property (nonatomic,strong)UICollectionView *collect;
@property (nonatomic , strong) NSTimer  *Cutmytimer;     //倒计时
@end
@implementation DJRoationView
- (NSMutableArray *)titles
{
    if (!_titles) {
       
        _titles = @[@"1000",@"50",@"20",@"10",@"5",@"3",@"1",@"0"].mutableCopy;
    
    }
    return _titles;
}

- (void)rotatingDidFinishBlock:(void (^)(NSInteger, CGFloat ,CGFloat,NSInteger))block
{
    if (block) {
        self.block = block;
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self initLayOutWithFrame:frame];
    }
    return self;
}

- (void)initLayOutWithFrame:(CGRect)frame
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"iPodClick" withExtension:@"aiff"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    self.speed = 20;
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    self.image.image = self.is_OrderRedLuck?[UIImage imageNamed:@"余额抽奖转盘"]: [UIImage imageNamed:@"zhuanpan"];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/gx/new_sign_zhuanona.png"]]]];
    self.image.image = image;
    
    [self addSubview:self.image];
    
    DJRoundLayout * layout = [[DJRoundLayout alloc]init];
    self.collect  = [[UICollectionView alloc]initWithFrame:CGRectMake(-8, -8, frame.size.width+16, frame.size.height+16) collectionViewLayout:layout];
    _collect.delegate=self;
    _collect.dataSource=self;
    _collect.backgroundColor = [UIColor clearColor];
    [_collect registerClass:[DJCollectViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    [self.image addSubview:_collect];
    
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width*3/4, frame.size.height*3/4)];
    image2.image = [UIImage imageNamed:@"icon-2"];
    image2.center = self.image.center;
//    [self addSubview:image2];
    
    self.turnView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.turnView.image = [UIImage imageNamed:@"icon-3"];
//    [self addSubview:self.turnView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setImage:[UIImage imageNamed:@"zhizhen"] forState:UIControlStateNormal];
    
    self.button.frame = CGRectMake(0, 0, frame.size.width/2, frame.size.height/2);

    self.button.center = self.image.center;
    
    [self addSubview:self.button];
    [self.button addTarget:self action:@selector(startRotain:) forControlEvents:UIControlEventTouchUpInside];
    titleCount = self.titles.count;
    duration = self.is_oneLuck?0.27f:0.2f;
    _al = 0;
    
    self.cutdownlab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ZOOM6(150), ZOOM6(150))];
    self.cutdownlab.center = self.button.center;
    self.cutdownlab.clipsToBounds = YES;
    self.cutdownlab.hidden = YES;
    self.cutdownlab.layer.cornerRadius = ZOOM6(150)/2;
    self.cutdownlab.backgroundColor = [UIColor redColor];
    self.cutdownlab.textColor = [UIColor whiteColor];
    self.cutdownlab.textAlignment = NSTextAlignmentCenter;
    self.cutdownlab.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZOOM6(84)];
    self.cutdownlab.userInteractionEnabled = NO;
    self.cutdownlab.text = @"3";
    
}
- (void)setSpeed:(int)speed
{
    _speed = speed>20?20:speed<1?1:speed;
    NSLog(@"%d",_speed);
}

- (void)setIs_OrderRedLuck:(BOOL)is_OrderRedLuck
{
    _is_OrderRedLuck = is_OrderRedLuck;
//    self.image.image = self.is_OrderRedLuck?[UIImage imageNamed:@"余额抽奖转盘"]: [UIImage imageNamed:@"zhuanpan"];
}
- (void)setIs_oneLuck:(BOOL)is_oneLuck
{
    _is_oneLuck = is_oneLuck;
    if(self.is_oneLuck)
    {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/qingfengpic/onebuy_zhuanpan.png"]]]];
        self.image.image = image;
        
        self.image.transform = CGAffineTransformMakeRotation(-M_PI/360);
        [self.button setImage:[UIImage imageNamed:@"zhizhen_stop"] forState:UIControlStateNormal];
        
        [self addSubview:self.cutdownlab];
        self.button.enabled = self.cutdownlab.hidden;
        
        self.titles = @[@"1000",@"50",@"20",@"10",@"5",@"3",@"1",@"0",@"1000",@"50",@"20",@"10",@"5",@"3",@"1",@"0"].mutableCopy;
        titleCount = self.titles.count;
        [self.collect reloadData];
    }else{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_XCX_Upy],@"small-iconImages/gx/new_sign_zhuanona.png"]]]];
        self.image.image = image;
    }
}

#pragma -mark CollectViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DJCollectViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
//    cell.contentView.backgroundColor = DRandomColor;
//    [cell setTitle:[self.titles objectAtIndex:indexPath.row] IndexPath:indexPath];
    /**
     *  不传indexPath 可以保持分数的位置；
     */
//    [cell setTitle:[self.titles objectAtIndex:indexPath.row] IndexPath:nil];
    return cell;
}

- (void)refreshData:(NSInteger)yidou LotteryNumber:(NSInteger)LotteryNumber Balance:(CGFloat)balance;
{
    self.LotteryNumber = LotteryNumber;
    self.yidou = yidou;
    self.balance = balance;
}
- (void)startRotain:(UIButton *)button
{
    if(self.startRotainBlock)
    {
        if(self.is_oneLuck && self.is_rotating)
        {
            remberRoationCount = hasRoationCount +1 + remberRoationCount % 8;
            hasRoationCount = roationCount-1;

            [self.button setImage:[UIImage imageNamed:@"zhizhen_more"] forState:UIControlStateNormal];
            return;
        }
        
        if(self.LotteryNumber>0)
        {
            self.startRotainBlock(@"1");//可抽奖
        }else{
            if(self.yidou >= 10 || self.balance >= 10)
            {
                self.startRotainBlock(@"1");//可抽奖
            }else{
                self.startRotainBlock(@"0");//不可抽奖
            }
        }
    }
}
- (void)loadMainImage
{
//    self.image.image = [UIImage imageNamed:@"zhuanpan"];
}
- (void)startRotainAnimation:(NSInteger)is_orNotPreze
{
    if(!self.is_oneLuck)
    {
        [self getLuckData];
    }else{
        self.is_orNotPreze = is_orNotPreze;
        [self getOneLuckData];
    }
    
    [self reSet];
    self.button.enabled = self.is_oneLuck?YES:NO;
    self.is_rotating = YES;

    if(!self.is_oneLuck)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"luckgoing"];
        roationCount = count+64;//现在是8个分数，为了概率平衡，随机数范围应为8的倍数
    }else{
        roationCount = count+64*1000000;//现在是8个分数，为了概率平衡，随机数范围应为8的倍数
        
        cutDowntime = 3;
        self.cutdownlab.text = [NSString stringWithFormat:@"%zd",cutDowntime];
        self.cutdownlab.hidden = NO;
        self.button.enabled = self.cutdownlab.hidden;
        
        self.Cutmytimer = [NSTimer weakTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod1:) userInfo:nil repeats:YES];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.Cutmytimer forMode:NSDefaultRunLoopMode];
    }
    hasRoationCount = 0;
    duration = self.is_oneLuck?0.27f:0.2f;
    self.variableState = increasing;
    
    _al += moveal;
    [self startAnimatWithView:self.image];
}
- (void)getLuckData
{
    [LuckModel getLuckHttpRedMoney:self.is_OrderRedLuck Success:^(id data) {
        LuckModel *model = data;
        if(model.status == 1)//抽红包成功
        {
            raward =self.is_OrderRedLuck?model.data:model.raffle;
            rawardtype = (NSInteger)model.t;
            count = [self getCount:raward]; //测试指定

            if(lastIndex == 0)
            {
                roationCount = count+64;
            }else{
                roationCount = count+64+(8-lastIndex);
            }
        }else if (model.status == 404)//没网
        {
            raward = -1;
            count = -1; //测试指定
            roationCount = 15+(8-lastIndex);
        }
        else//抽红包失败
        {
            raward = 0;
            count = -1; //测试指定
            roationCount = 15+(8-lastIndex);
        }
    }];
}

//抽奖初始化
//- (void)getLotteryDraw
//{
//
//    [LuckModel getLuckHttpLotteryDraw:self Success:^(id data) {
//
//    }];
//}
//获取用户是否可以中奖
- (void)getOrNotPreze
{
    [LuckModel getLuckHttpOrNotPrize:^(id data) {
        LuckModel *model = data;
        if(model.status == 1)
        {
            self.is_orNotPreze = model.OrNotPrize;
        }else{
            self.is_orNotPreze = 1;
        }
    }];
}

- (void)getOneLuckData
{
    count = arc4random() %8; //测试指定
    count = 0;
    
    if(lastIndex == 0)
    {
        roationCount = count+64*1000000;
    }else{
        roationCount = count+64*1000000+(8-lastIndex);
    }
}
//根据获奖金额获取段位
- (int)getCount:(CGFloat)raffle
{
    int ct = 0;
    
    if (rawardtype == 1 && raffle != 0)
    {
        ct = 0;
    }else if (raffle >= 20 && raffle <50)
    {
        ct = 1;
    }
    else if (raffle >= 10 && raffle <20)
    {
        ct = 2;
    }
    else if (raffle >= 5 && raffle <10)
    {
        ct = 3;
    }
    else if (raffle >= 3 && raffle <5)
    {
        ct = 4;
    }
    else if (raffle >= 1 && raffle <3)
    {
        ct = 5;
    }
    else if (raffle >= 0.01 && raffle <1)
    {
        ct = 6;
    }
    else
    {
        ct = 7;
    }
    
    return ct;
}

//- (int)getCount:(CGFloat)raffle
//{
//    int ct = 0;
//    if(raffle >= 1000)
//    {
//        ct = 0;
//    }else if (raffle >= 500 && raffle <1000)
//    {
//        ct = 0;
//    }else if (raffle >= 200 && raffle <500)
//    {
//        ct = 1;
//    }
//    else if (raffle >= 100 && raffle <200)
//    {
//        ct = 2;
//    }
//    else if (raffle >= 50 && raffle <100)
//    {
//        ct = 3;
//    }
//    else if (raffle >= 10 && raffle <50)
//    {
//        ct = 4;
//    }
//    else if (raffle >= 5 && raffle <10)
//    {
//        ct = 5;
//    }
//    else if (raffle >= 0.01 && raffle <5)
//    {
//        ct = 6;
//    }
//    else
//    {
//        ct = 7;
//    }
//
//    return ct;
//}

- (void)startAnimatWithView:(UIView *)view
{
    CABasicAnimation *caAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    caAnimation.removedOnCompletion = NO;
    caAnimation.fillMode = kCAFillModeForwards;
    caAnimation.fromValue = @(_al);

    CGFloat flot = _al - M_PI/(titleCount/2);
   
    if(hasRoationCount+1 == roationCount)
    {
        NSInteger ccount;
        if(self.is_oneLuck)//1元购抽奖
        {
            if(self.is_orNotPreze ==0 && remberRoationCount%8 == 0)
            {
                raward = 100;//中奖
                ccount = arc4random()%131 + 50;
            }else{
                raward = 0;//不中奖
//                ccount = arc4random()%13 + 18;//（180/ccount）6度~10度
                //ccount = arc4random()%9 + 22;//（180/ccount）6度~8度
                ccount = arc4random()%11 + 25;//（180/ccount）5度~7度
            }
            
        }else{
            ccount = (arc4random() % 45 + 2*self.titles.count+4);
        }
        
        NSInteger sscount = arc4random() % 2;
        if(sscount == 0)
        {
            flot = flot + M_PI/(ccount);
            moveal = -M_PI/(ccount);
        }else{
            flot = flot - M_PI/(ccount);
            moveal = M_PI/(ccount);
        }
        NSLog(@"^^^^^^^^^^^^^^ moveal=%f flot=%f",moveal,flot);
    }

    caAnimation.toValue = @(flot);
    caAnimation.duration = duration;
    caAnimation.repeatCount = 1;
    caAnimation.delegate = self;
    [view.layer addAnimation:caAnimation forKey:@"anim"];
    _al = [caAnimation.toValue floatValue];
    
}

- (void)animationDidStart:(CAAnimation *)anim
{
    fictitiousCount ++;
    int zero = fictitiousCount %8;
    
    if(count >= 0 && zero ==1)//抽奖成功
    {
        fictitiousCount --;
        hasRoationCount ++;
    }else if(count < 0 && zero ==1){//抽奖失败
        fictitiousCount --;
        hasRoationCount ++;
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    AudioServicesPlaySystemSound(soundID);
    if (hasRoationCount>=roationCount) {
        self.button.enabled = YES;
        self.is_rotating = NO;
        
        int curIndex = (roationCount%titleCount+lastIndex)%titleCount;
        lastIndex = curIndex;
        
        for (int i = 0; i<self.titles.count; i++) {
            DJCollectViewCell *cell = (DJCollectViewCell *)[self.collect cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            if (i==curIndex) {
                cell.label.textColor = [UIColor redColor];
                cell.label.font = [UIFont boldSystemFontOfSize:20];
            }else{
                cell.label.textColor = [UIColor whiteColor];
                cell.label.font = [UIFont boldSystemFontOfSize:14];
            }
        }
        
        if (self.block) {
            CGFloat score = [[self.titles objectAtIndex:curIndex] floatValue];
            self.block(curIndex,score,raward,rawardtype);
        }
        
        return;
    }
    if (hasRoationCount>=self.speed&&hasRoationCount<=roationCount-self.speed) {
        [self startAnimatWithView:self.image];
        return;
    }
    
    if (hasRoationCount<self.speed) {
        self.variableState = increasing;
    }else if (hasRoationCount>roationCount-self.speed){
        self.variableState = diminishing;
    }

    if (self.variableState==increasing) {
        if(self.is_oneLuck)
        {
            duration-=0.01;
        }else
            duration-=0.01;
    }else{
        duration+=0.02;
    }
    
    if (duration<0.01) {
        duration=0.01;
    }

    [self startAnimatWithView:self.image];
}

/**
 *  重置颜色
 */
- (void)reSet
{
    for (int i = 0; i<self.titles.count; i++) {
        DJCollectViewCell *cell = (DJCollectViewCell *)[self.collect cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        cell.label.textColor = [UIColor whiteColor];
        cell.label.font = [UIFont boldSystemFontOfSize:14];
    }
}

#pragma mark 3秒倒计时
- (void)timerFireMethod1:(NSTimer*)timer
{
    cutDowntime--;
    
    if (cutDowntime==0) {
        [self.Cutmytimer invalidate];
        self.Cutmytimer = nil;
        
        self.cutdownlab.hidden = YES;
        self.button.enabled = self.cutdownlab.hidden;
        [self.button setImage:[UIImage imageNamed:@"zhizhen_stop"] forState:UIControlStateNormal];
    }
    
    self.cutdownlab.text = [NSString stringWithFormat:@"%zd",cutDowntime];
}

-(void)dealloc
{
    [self.image.layer removeAllAnimations];
}

@end
