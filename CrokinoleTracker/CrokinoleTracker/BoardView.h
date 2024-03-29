//
//  BoardView.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Round;

@interface BoardView : UIView <UIGestureRecognizerDelegate>

@property (strong, nonatomic) Round *round;

@property (nonatomic) CGPoint boardCenter;
@property (nonatomic) double boardYInset;
@property (nonatomic) double discRadius;
@property (nonatomic) double twentiesRadiusThreshold;
@property (nonatomic) double fifteensRadiusThreshold;
@property (nonatomic) double tensRadiusThreshold;
@property (nonatomic) double fivesRadiusThreshold;
@property (nonatomic) CGRect twentiesCircleBounds;
@property (nonatomic) CGRect outerCircleBounds;
@property (nonatomic) CGRect middleCircleBounds;
@property (nonatomic) CGRect innerCircleBounds;

@property (nonatomic) int playerOneStartingGameScore;
@property (nonatomic) int playerTwoStartingGameScore;

@property (strong, nonatomic) NSMutableArray *playerDiscViews;

@property (nonatomic) double lineWidth;

@property (strong, nonatomic) UISegmentedControl *activePlayerSegmentControl;

- (id)initWithFrame:(CGRect)frame
              round:(Round *)aRound;

- (double)radiusOfPosition:(CGPoint)position;
- (void)updateScores;
- (BOOL)shouldConsiderDrawingNewDiscAtPosition:(CGPoint)position;
- (NSValue *)discThatCollidesWithDiscAtPosition:(CGPoint)newDiscPosition;
- (CGPoint)adjustedPositionForNewDisc:(CGPoint)newDisc
                    collidingWithDisc:(CGPoint)existingDisc;
- (void)addDiscViewAtPosition:(CGPoint)position
                  playerIndex:(int)playerIndex
                     animated:(BOOL)animated;
- (void)removeLastDiscForActivePlayer;
- (int)valueForPoint:(CGPoint)point;
+ (NSArray *)playerColors;

@end
