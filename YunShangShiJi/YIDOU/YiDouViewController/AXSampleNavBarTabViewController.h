//
//  AXSampleNavBarTabViewController.h
//  StretchableHeaderTabViewExample
//

#import "AXStretchableHeaderTabViewController.h"


@interface AXSampleNavBarTabViewController : AXStretchableHeaderTabViewController


@property (assign,nonatomic)YDPageVCType type;


/**
 <#Description#>

 @param type <#type description#>
 @param peas 我的余额
 @param peas_freeze 冻结余额
 @param extract 提现额度
 @param freezeMoney 提现冻结
 @return <#return value description#>
 */
- (instancetype)initWithType:(YDPageVCType)type peas:(float)peas peas_freeze:(float)peas_freeze extract:(float)extract freezeMoney:(float)freezeMoney;
@end

//     [vc.tabBar setSelectedItem:vc.tabBar.items[1]];
//[vc.containerView setContentOffset:(CGPoint){1 * kScreenWidth, vc.containerView.contentOffset.y} animated:NO];
