//
//  commentsCell.m
//  YunShangShiJi
//
//  Created by yssj on 15/10/15.
//  Copyright © 2015年 ios-1. All rights reserved.
//

#import "commentsCell.h"
#import "GlobalTool.h"


@implementation commentsCell


- (void)awakeFromNib {
    // Initialization code
    
    _nameLabel.font=[UIFont systemFontOfSize:ZOOM(48)];
    _contentLabel.font=[UIFont systemFontOfSize:ZOOM(46)];
    _timeLabel.font=[UIFont systemFontOfSize:ZOOM(38)];
    
    _timeLabel.textColor=kTextGreyColor;
    _contentLabel.textColor=RGBCOLOR_I(102, 102, 102);
    
    _headImg.backgroundColor=DRandomColor;
    _contentImgOne.backgroundColor=DRandomColor;
    _contenImgTwo.backgroundColor=DRandomColor;
    _contentImgThree.backgroundColor=DRandomColor;
    
        NSString *string =@"这家店很影响分扫房发生飞机撒发发发生的妇女理论是金额来看吗是浓了发生你垃圾哦近年来拉美了解哦哦就理解\n发烧发烧分散哦啊放松吗哦陌路了耐心了呢露出你的到了姥姥家了老大难浪费今年年初来成交额哦耶女决定问为奴森吗是的领导累了呢嗯啦了吗我了我冷漠为了买房三闾大夫吗发生吗企鹅品味哦吗";
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attrString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:ZOOM(46)],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, string.length)];
    CGRect rect = [attrString boundingRectWithSize:CGSizeMake(kScreenWidth-2*ZOOM(60), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  context:nil];
    _contentLabel.attributedText=attrString;
//    [_contentLabel sizeToFit];
    /*
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_contentLabel.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _contentLabel.text.length)];
    _contentLabel.attributedText=attributedString;
    [_contentLabel sizeToFit];
*/
    
    [_timeLabel sizeToFit];
    const CGFloat starViewWidth = [self getHeight:@"2015"withLabel:_timeLabel];
    
    _headImg.frame=CGRectMake(ZOOM(62), ZOOM(50), _headImg.frame.size.width, _headImg.frame.size.height);
    _headImg.layer.cornerRadius=_headImg.frame.size.height/2;
    _nameLabel.frame=CGRectMake(CGRectGetMaxX(_headImg.frame)+ZOOM(32),CGRectGetMidY(_headImg.frame)-_nameLabel.frame.size.height-3, _nameLabel.frame.size.width, _nameLabel.frame.size.height);
    _starView.frame=CGRectMake(_nameLabel.frame.origin.x, CGRectGetMidY(_headImg.frame)+3,(starViewWidth+3)*5,starViewWidth);
    _timeLabel.frame=CGRectMake(CGRectGetMaxX(_starView.frame)+5, _starView.frame.origin.y, _timeLabel.frame.size.width,[self getHeight:@"2015" withLabel:_timeLabel]);
    _goodBtn.frame=CGRectMake(kApplicationWidth-ZOOM(62)-_goodBtn.frame.size.width, (_headImg.frame.size.height-_goodBtn.frame.size.height)/2+_headImg.frame.origin.y, _goodBtn.frame.size.width, _goodBtn.frame.size.height);
    
    _contentLabel.frame=CGRectMake(_headImg.frame.origin.x, CGRectGetMaxY(_headImg.frame)+ZOOM(50), kApplicationWidth-ZOOM(62)*2, rect.size.height);
    _contentLabel.backgroundColor=DRandomColor;
    
    const CGFloat contenImgWidth = (kApplicationWidth-ZOOM(62)*2-10)/3;
    _contentImgOne.frame=CGRectMake(ZOOM(62),CGRectGetMaxY(_contentLabel.frame)+ZOOM(50), contenImgWidth, contenImgWidth);
    _contenImgTwo.frame=CGRectMake(CGRectGetMaxX(_contentImgOne.frame)+5 , _contentImgOne.frame.origin.y, contenImgWidth, contenImgWidth);
    _contentImgThree.frame=CGRectMake(CGRectGetMaxX(_contenImgTwo.frame)+5 , _contentImgOne.frame.origin.y, contenImgWidth, contenImgWidth);

//    //self size %f",rect.size.height+ZOOM(50)*4+70+contenImgWidth);
}
-(void)drawRect:(CGRect)rect
{

}
-(CGFloat)getHeight:(NSString *)string withLabel:(UILabel *)label
{
    NSString * labelStr = string;

    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:label.font.pointSize]};
    CGSize textSize = [labelStr boundingRectWithSize:CGSizeMake(kApplicationWidth-ZOOM(62)*2, 1000) options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return textSize.height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    // Configure the view for the selected state
}

@end
