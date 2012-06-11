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
@property (nonatomic) double fifteensRadiusThreshold;
@property (nonatomic) double tensRadiusThreshold;
@property (nonatomic) double fivesRadiusThreshold;

@property (nonatomic) int playerOneStartingGameScore;
@property (nonatomic) int playerTwoStartingGameScore;

@property (strong, nonatomic) NSArray *playerColors;

@property (strong, nonatomic) UISegmentedControl *activePlayerSegmentControl;

- (id)initWithRound:(Round *)aRound andFrame:(CGRect)frame;

- (void)recreateDiscPositions:(NSMutableArray *)someDiscPositions;
- (double)calculateRadiusOfPosition:(CGPoint)position;
- (void)updateCountsForDiscWithCenterAtRadius:(double)radius
                                  playerIndex:(int)playerIndex;
- (void)updateScores;
- (BOOL)canDrawNewDiscAtPosition:(CGPoint)newDiscPosition;
- (void)removeLastDiscForActivePlayer;
- (int)valueForPoint:(CGPoint)point;

@end
