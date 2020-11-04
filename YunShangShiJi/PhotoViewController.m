//
//  PhotoViewController.m
//  CollectionViewPhoto
//
//  Created by Mac on 16/4/19.
//  Copyright © 2016年 jyb. All rights reserved.
//

#import "PhotoViewController.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

#import "TopicDetailViewController.h"

#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height


@implementation PersonPhoto
@end

@implementation PersonPhotosModel

+ (NSMutableDictionary *)getMapping {
    NSMutableDictionary *mapping =  [NSMutableDictionary dictionaryWithObjectsAndKeys:[PersonPhoto mappingWithKey:@"data"],@"data" ,nil];
    return mapping;
}
+ (void)httpGetPersonPhotosModelSuccess:(void(^)(id data))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"fc/circleImageBrowsing?version=%@&token=%@",VERSION,token];
    [self getDataResponsePath:urlStr success:success];
}
+ (void)httpGetPersonPhotoDetail:(NSString *)pic Success:(void(^)(id data))success {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOKEN];
    NSString *urlStr = [NSString stringWithFormat:@"fc/circleSingleImage?version=%@&token=%@&pic=%@",VERSION,token,pic];
    [self getDataResponsePath:urlStr success:success];
}
@end

@interface PhotoViewController ()<UIScrollViewDelegate>
{
    BOOL            _large;
    UIScrollView    *_zoomingScrollView;
    CGFloat         _contentOffsetX;
    UIScrollView    *scroll;
}
@property (nonatomic,strong)UILabel *headLabel;
@property (nonatomic,strong)UIView  *footView;
@property (nonatomic,strong)UILabel *footLabel;
@property (nonatomic,strong)UIButton *footBtn;
@end

@implementation PhotoViewController
/*
- (UIButton *)footBtn {
    if (_footBtn==nil) {
        _footBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _footBtn.frame=CGRectMake(SCREEN_WIDTH-ZOOM6(200), ZOOM6(20), ZOOM6(180), ZOOM6(100)-ZOOM6(40));
        [_footBtn setBackgroundColor:tarbarrossred];
        [_footBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_footBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_footBtn.titleLabel setFont:[UIFont systemFontOfSize:ZOOM6(30)]];
        [_footBtn handleClickEvent:UIControlEventTouchUpInside withClickBlock:^(UIButton *sender) {
//            if (self.footBtnClick) {
//                [self dismissViewControllerAnimated:NO completion:nil];
//                [self leftBarButtonItemPressed];
//                self.footBtnClick(self.index);
                
                PersonPhoto *model=self.modelArray[self.index];
                if (model.theme_type.integerValue==1) {
                    ShopDetailViewController *shopdetail = [[ShopDetailViewController alloc]init];
                    shopdetail.shop_code = model.shop_list[@"shop_code"];
                    shopdetail.theme_id = [model.theme_id stringValue];
                    shopdetail.stringtype = @"订单详情";
                    [self.navigationController pushViewController:shopdetail animated:YES];
                }else{
                    TopicdetailsViewController *topic = [[TopicdetailsViewController alloc]init];
                    topic.theme_id = [NSString stringWithFormat:@"%@",model.theme_id];
                    [self.navigationController pushViewController:topic animated:YES];
                }
//            }
        }];
        _footBtn.layer.cornerRadius=3;
    }
    return _footBtn;
}
- (UILabel *)footLabel {
    if (_footLabel==nil) {
        _footLabel=[[UILabel alloc]initWithFrame:CGRectMake(ZOOM6(20), 0, SCREEN_WIDTH-ZOOM6(220), ZOOM6(100))];
        _footLabel.textColor=[UIColor whiteColor];
        _footLabel.textAlignment=NSTextAlignmentLeft;
        _footLabel.numberOfLines=2;
        _footLabel.font=[UIFont systemFontOfSize:ZOOM6(30)];

    }
    return _footLabel;
}
- (UIView *)footView {
    if (_footView==nil) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-ZOOM6(100), SCREEN_WIDTH, ZOOM6(100))];
        _footView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
        [_footView addSubview:self.footLabel];
        [_footView addSubview:self.footBtn];
    }
    return _footView;
}
- (UILabel *)headLabel {
    if (_headLabel==nil) {
        _headLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ZOOM6(100))];
        _headLabel.textColor=[UIColor whiteColor];
        _headLabel.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
        _headLabel.textAlignment=NSTextAlignmentCenter;
        _headLabel.text=[NSString stringWithFormat:@"%zd / %zd",self.index+1,self.modelArray.count];
    }
    return _headLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.hidden=YES;
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH+20, SCREEN_HEIGHT)];
    scroll.tag = 55;
    scroll.delegate = self;
    scroll.backgroundColor = [UIColor blackColor];
    scroll.contentSize = CGSizeMake((SCREEN_WIDTH+20)*self.modelArray.count, SCREEN_HEIGHT);
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scroll];
    
    [self.view addSubview:self.headLabel];
    [self.view addSubview:self.footView];
    
    [self changeInfo];
    
    [self creatView];
    
}
- (void)creatView {
    for (int i = 0; i < self.modelArray.count; i ++) {
        
        UIScrollView *scl = [[UIScrollView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH+20)*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        scl.tag = 44;
        scl.delegate = self;
        scl.minimumZoomScale = 1.0;
        scl.maximumZoomScale = 2.0;
        scl.decelerationRate = 0.1;
        scl.backgroundColor = [UIColor blackColor];
        [scroll addSubview:scl];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        
        
        
        PersonPhoto *model=self.modelArray[i];
        
        NSString *urlStr;NSURL *url;
        //        NSString *picSize;
        //        if (kDevice_Is_iPhone6Plus) {
        //            picSize = @"!382";
        //        } else {
        //            picSize = @"!280";
        //        }
        if (model.theme_type.integerValue==1) {
            NSMutableString *code = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",model.shop_list[@"shop_code"]]];
            NSString *supcode  = [code substringWithRange:NSMakeRange(1, 3)];
            
            NSString *pic = [NSString stringWithFormat:@"%@/%@/%@",supcode,model.shop_list[@"shop_code"],model.shop_list[@"def_pic"]];
            
            //            NSString *picSize;
            
            //            if (kDevice_Is_iPhone6Plus) {
            //                picSize = @"!382";
            //            } else {
            //                picSize = @"!280";
            //            }
            //
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSObject baseURLStr_Upy],pic]];
            
            
        }else{
            
            urlStr=[NSString stringWithFormat:@"%@%@%@/%@",[NSObject baseURLStr_Upy] ,@"myq/theme/", model.user_id,[model.pic substringToIndex:model.pic.length-4]];
            url = [NSURL URLWithString:urlStr];
            
        }
        
//        [imgView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            
//        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            
//        }];
        [imgView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.clipsToBounds = YES;
        imgView.userInteractionEnabled = YES;
        imgView.tag = 666;
        [scl addSubview:imgView];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [imgView addGestureRecognizer:doubleTap];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleTap.numberOfTapsRequired = 1;
        [imgView addGestureRecognizer:singleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
//        if (i != self.index) {
        
            imgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            
//        }else{
//            
//            CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//            //            imgView.frame = self.imgFrame;
//            imgView.alpha=0;
//            imgView.frame = frame;
//            
//            //            [UIView animateWithDuration:0.15 animations:^{
//            imgView.alpha=1;
//            //            } completion:^(BOOL finished) {
//            //                
//            //            }];
//        }
        
    }
}
- (void)changeInfo {

    self.headLabel.text=[NSString stringWithFormat:@"%zd / %zd",self.index+1,self.modelArray.count];

    PersonPhoto *model=self.modelArray[self.index];
    
    if (model.theme_type.integerValue==1) {
        NSString *title=[model.shop_list[@"shop_name"] length]>10?[NSString stringWithFormat:@"%@...",[model.shop_list[@"shop_name"] substringToIndex:10]]:model.shop_list[@"shop_name"];
        NSString *price=[NSString stringWithFormat:@"¥%@",[model.shop_list[@"shop_price"] stringValue]];
        NSString *allStr=[NSString stringWithFormat:@"%@\n¥%@ %@",title,[model.shop_list[@"shop_se_price"] stringValue],price];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:allStr];
        NSMutableDictionary *stringDict = [NSMutableDictionary dictionary];
        NSRange stringRange = [allStr rangeOfString:price];
        [stringDict setObject:[UIFont systemFontOfSize:ZOOM6(25)] forKey:NSFontAttributeName];
        [stringDict setObject:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
        [attri setAttributes:stringDict range:stringRange];
        [self.footLabel setAttributedText:attri];
        
        
//        [self.footLabel setAttributedText:[NSString getOneColorInLabel:[NSString stringWithFormat:@"%@\n¥%@ %@",model.shop_list[@"shop_name"],[model.shop_list[@"shop_se_price"] stringValue]] ColorString:[model.shop_list[@"shop_se_price"] stringValue] Color:tarbarrossred fontSize:ZOOM6(30)]];

        [_footBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        _footBtn.backgroundColor = [model.shop_list[@"shop_status"] integerValue]==2?tarbarrossred:kbackgrayColor;
        _footBtn.userInteractionEnabled = [model.shop_list[@"shop_status"] integerValue]==2;
    }else{
        if (model.theme_type.integerValue==2) {
            NSString *title=[NSString stringWithFormat:@"#%@#",model.title.length>10?[NSString stringWithFormat:@"%@...",[model.title substringToIndex:10]]:model.title];
            [self.footLabel setAttributedText:[NSString getOneColorInLabel:[NSString stringWithFormat:@"%@\n%@",title,model.content] ColorString:title Color:tarbarrossred fontSize:ZOOM6(30)]];
        }else
            self.footLabel.text=model.content;
        [_footBtn setTitle:@"查看详情" forState:UIWindowLevelNormal];
        _footBtn.backgroundColor=tarbarrossred;
        _footBtn.userInteractionEnabled=YES;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [scroll setContentOffset:CGPointMake(self.index * (SCREEN_WIDTH+20), 0) animated:NO];
    _contentOffsetX = scroll.contentOffset.x;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
  
}

- (void)singleTap:(UITapGestureRecognizer *)gesture
{
//    UIImageView *imgView = (UIImageView *)gesture.view;
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
//    self.view.backgroundColor = [UIColor clearColor];
//    scroll.backgroundColor = [UIColor clearColor];
//    [window addSubview:imgView];
    
//    [UIView animateWithDuration:0.15 animations:^{
    
//        imgView.frame = self.imgFrame;
//        self.view.alpha=0;
        
//    } completion:^(BOOL finished) {
        
        if (_completedBlock) {
            _completedBlock();
        }
        
//        [imgView removeFromSuperview];
//    }];

    [self leftBarButtonItemPressed];
//    [self dismissViewControllerAnimated:NO completion:^{
//        
//    }];
}

- (void)doubleTap:(UITapGestureRecognizer *)gesture
{
    UIScrollView *scl = (UIScrollView *)gesture.view.superview;
    
    if (scl.zoomScale == scl.maximumZoomScale) {
        
        [scl setZoomScale:1.0 animated:YES];
        _large = NO;
        _zoomingScrollView = nil;
        return;
    }
    
    if (_large) {
        
        [scl setZoomScale:1.0 animated:YES];
        _large = NO;
        _zoomingScrollView = nil;
        
    }else{
        
        CGPoint location = [gesture locationInView:gesture.view];
        [scl zoomToRect:CGRectMake(location.x, location.y, 1, 1) animated:YES];
        _large = YES;
        _zoomingScrollView = scl;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return (UIImageView *)[scrollView viewWithTag:666];
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    static CGFloat x,y;
    
    UIScrollView *superscl = (UIScrollView *)scrollView.superview;
    
    CGFloat xcenter = scrollView.center.x-superscl.contentOffset.x , ycenter = scrollView.center.y;
    
    if (_zoomingScrollView == nil) {
        x = xcenter;
        y = ycenter;
    }else{
        xcenter = x;
        ycenter = y;
        _zoomingScrollView = nil;
    }
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    [[scrollView viewWithTag:666] setCenter:CGPointMake(xcenter, ycenter)];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 55) {
        
        if (scrollView.contentOffset.x != _contentOffsetX) {
            _contentOffsetX = scrollView.contentOffset.x;
            
            if (_zoomingScrollView) {
                [_zoomingScrollView setZoomScale:1.0 animated:YES];
                _large = NO;
            }
        }
        
        self.index = (NSInteger)(_contentOffsetX / (SCREEN_WIDTH+20));
        
        [self changeInfo];


    }
    
    if (_indexBlock) {
        _indexBlock(_index);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 55) {
                
        
        NSInteger newSelectedIndex = round(scrollView.contentOffset.x / (scrollView.contentSize.width) * self.modelArray.count);
        newSelectedIndex = MIN(self.modelArray.count - 1, MAX(0, newSelectedIndex));
//        NSLog(@"%f  %zd  %zd %zd",scrollView.contentOffset.x,self.index,newSelectedIndex,MAX(0, newSelectedIndex));

        if (self.index!=newSelectedIndex) {
            self.index=newSelectedIndex;
            [self changeInfo];

        }
        
    }
}
- (void)leftBarButtonItemPressed {
    if ((self.navigationController.viewControllers.firstObject == self) || (self.presentedViewController)) {
        [self dismissViewControllerAnimated:NO completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.hidden=YES;
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
