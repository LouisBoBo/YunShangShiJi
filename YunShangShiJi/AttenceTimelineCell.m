//
//  AttenceTimelineCell.m
//  Product
//
//  Created by ACTIVATION GROUP on 14-8-7.
//  Copyright (c) 2014年 eKang. All rights reserved.
//

#import "AttenceTimelineCell.h"

@implementation AttenceTimelineCell

#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define DotViewCentX 20//圆点中心 x坐标
#define VerticalLineWidth 2//时间轴 线条 宽度
#define ShowLabTop 3//cell间距
#define ShowLabWidth (kScreenWidth - DotViewCentX - 20)
#define ShowLabFont [UIFont systemFontOfSize:15]
#define greenColor [UIColor colorWithRed:114/255. green:170/255. blue:19/255. alpha:1.0f]

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        verticalLineTopView = [[UIView alloc] init];
        verticalLineTopView.backgroundColor = [UIColor grayColor];
        [self addSubview:verticalLineTopView];
        
        int dotViewRadius = 5;
        dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dotViewRadius * 2, dotViewRadius * 2)];
        dotView.backgroundColor = greenColor;
        dotView.layer.cornerRadius = dotViewRadius;
        [self addSubview:dotView];
        
        verticalLineBottomView = [[UIView alloc] init];
        verticalLineBottomView.backgroundColor = [UIColor grayColor];
        [self addSubview:verticalLineBottomView];
        
        //初始化生成button并把准备好的图片作为其背景图片
        showLab = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [showLab setTitleColor:[UIColor colorWithRed:152/255. green:152/255. blue:152/255. alpha:1.0f] forState:UIControlStateNormal];
        showLab.userInteractionEnabled=NO;
//        UIImage *img = [UIImage imageNamed:@"AttenceTimelineCellMessage2"];
//        img = [img stretchableImageWithLeftCapWidth:20 topCapHeight:20];
//        [showLab setBackgroundImage:img forState:UIControlStateNormal];
        showLab.titleLabel.font = ShowLabFont;
        showLab.titleLabel.numberOfLines = 20;
        showLab.titleLabel.textAlignment = NSTextAlignmentLeft;
        showLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        showLab.titleEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 5);
        [self addSubview:showLab];
    }
    return self;
}


- (void)setFrame:(CGRect)frame{
    super.frame = frame;
    dotView.center = CGPointMake(DotViewCentX, ShowLabTop + 13);
    int cutHeight = dotView.frame.size.height/2.0 - 2;
    verticalLineTopView.frame = CGRectMake(DotViewCentX - VerticalLineWidth/2.0, 0, VerticalLineWidth, dotView.center.y - cutHeight);
    verticalLineBottomView.frame = CGRectMake(DotViewCentX - VerticalLineWidth/2.0, dotView.center.y + cutHeight, VerticalLineWidth, frame.size.height - (dotView.center.y + cutHeight));
}

//赋值
- (void)setDataSource:(NSString *)content isFirst:(BOOL)isFirst isLast:(BOOL)isLast {
    showLab.frame = CGRectMake(DotViewCentX - VerticalLineWidth/2.0 + 5, ShowLabTop, ShowLabWidth, [AttenceTimelineCell cellHeightWithString:content isContentHeight:YES]);
    [showLab setTitle:content forState:UIControlStateNormal];
    
    //设置最上面和最下面是否隐藏
    verticalLineTopView.hidden = isFirst;
    verticalLineBottomView.hidden = isLast;
    
    //判断是否是第一个（是第一个更改背景色）
    dotView.frame=isFirst ? CGRectMake(0, 0, 6 * 2, 6 * 2):CGRectMake(0, 0, 5 * 2, 5 * 2);
    dotView.layer.cornerRadius = isFirst ? 6:5;
    dotView.backgroundColor = isFirst ? greenColor : [UIColor grayColor];
    [showLab setTitleColor:isFirst ? [UIColor colorWithRed:255/255.0 green:63/255.0 blue:139/255.0 alpha:255/255.0] :[UIColor colorWithRed:152/255. green:152/255. blue:152/255. alpha:1.0f] forState:UIControlStateNormal];

    //判断是否是第一个（是第一个的话就换成彩色图片）
//    UIImage *img = [UIImage imageNamed:isFirst ? @"AttenceTimelineCellMessage" : @"AttenceTimelineCellMessage2"];
//    img = [img stretchableImageWithLeftCapWidth:20 topCapHeight:20];
//    //重新赋值给button的背景
//    [showLab setBackgroundImage:img forState:UIControlStateNormal];
}


//根据字符串的高度设置cell的高度
+ (float)cellHeightWithString:(NSString *)content isContentHeight:(BOOL)b{
    float height = [content sizeWithFont:ShowLabFont constrainedToSize:CGSizeMake(ShowLabWidth - 20, 100)].height;
//      CGSize size =  [content boundingRectWithSize:CGSizeMake(ShowLabWidth - 20, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : ShowLabFont} context:nil].size;
    return (b ? height : (height + ShowLabTop * 2)) + 15;
    
}




- (void)awakeFromNib
{
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    // Configure the view for the selected state
}

@end
