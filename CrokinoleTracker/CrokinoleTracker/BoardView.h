//
//  BoardView.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlayerActivationButton.h"

@protocol BoardViewDelegate

- (void)boardWasRecreated;
- (void)boardWasTapped:(CGPoint)point;

@end

@interface BoardView : UIView <PlayerActivationButtonDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) id<BoardViewDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *discPositions;
@property (nonatomic) int playerOne15s;
@property (nonatomic) int playerOne10s;
@property (nonatomic) int playerOne5s;
@property (nonatomic) int playerTwo15s;
@property (nonatomic) int playerTwo10s;
@property (nonatomic) int playerTwo5s;
@property (strong, nonatomic) UIColor *playerOneColor;
@property (strong, nonatomic) UIColor *playerTwoColor;

@property (strong, nonatomic) PlayerActivationButton *playerOneActivationButton;
@property (strong, nonatomic) PlayerActivationButton *playerTwoActivationButton;

- (id)initWithFrame:(CGRect)frame
           delegate:(id<BoardViewDelegate>)aDelegate;
- (void)recreateDiscPositions:(NSMutableArray *)someDiscPositions;
+ (double)calculateRadiusOfPosition:(CGPoint)position;
- (void)updateCountsForDiscWithCenterAtRadius:(double)radius;

@end
