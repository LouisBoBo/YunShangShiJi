//
//  CCDraggableContainer.h
//  CCDraggableCard-Master
//
//  Created by jzzx on 16/7/6.
//  Copyright © 2016年 China-SQP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CCDraggableConfig.h"
#import "CCDraggableCardView.h"

@class CCDraggableContainer;

//  -------------------------------------------------
//  MARK: Delegate
//  -------------------------------------------------

@protocol CCDraggableContainerDelegate <NSObject>

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer
        draggableDirection:(CCDraggableDirection)draggableDirection
                widthRatio:(CGFloat)widthRatio
               heightRatio:(CGFloat)heightRatio;

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer
                  cardView:(CCDraggableCardView *)cardView
            didSelectIndex:(NSInteger)didSelectIndex;

//滑动手势结束
- (void)panGesturedraggableContainer:(CCDraggableContainer *)panGesturedraggableContainer
                  cardView:(CCDraggableCardView *)panGesturecardView
            didSelectIndex:(NSInteger)panGesturedidSelectIndex;
//滑动手势
- (void)panGesturedraggaChangebleContainer:(CCDraggableContainer *)panGesturedraggableContainer
                            cardView:(CCDraggableCardView *)panGesturecardView
                      didSelectIndex:(NSInteger)panGesturedidSelectIndex;

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer
 finishedDraggableLastCard:(BOOL)finishedDraggableLastCard;

@end

//  -------------------------------------------------
//  MARK: DataSource
//  -------------------------------------------------

@protocol CCDraggableContainerDataSource <NSObject>

@required
- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer
                               viewForIndex:(NSInteger)index;

- (NSInteger)numberOfIndexs;

@end

//  -------------------------------------------------
//  MARK: CCDraggableContainer
//  -------------------------------------------------

@interface CCDraggableContainer : UIView

@property (nonatomic, weak) IBOutlet id <CCDraggableContainerDelegate>delegate;
@property (nonatomic, weak) IBOutlet id <CCDraggableContainerDataSource>dataSource;


@property (nonatomic) NSInteger loadedIndex;
@property (nonatomic) NSInteger newloadIndex;
@property (nonatomic) NSMutableArray *currentCards;
@property (nonatomic) NSMutableArray *allCards;


@property (nonatomic) CCDraggableStyle     style;
@property (nonatomic) CCDraggableDirection direction;

- (instancetype)initWithFrame:(CGRect)frame style:(CCDraggableStyle)style;
- (void)removeFormDirection:(CCDraggableDirection)direction;
- (void)reloadData;

@end
