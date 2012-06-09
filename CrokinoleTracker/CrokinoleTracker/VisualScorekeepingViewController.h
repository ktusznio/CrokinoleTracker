//
//  VisualScorekeepingViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BoardView.h"
#import "TwentiesView.h"

@class Round;

@interface VisualScorekeepingViewController : UIViewController <BoardViewDelegate, TwentiesViewDelegate>

@property (weak, nonatomic) Round *round;
@property (nonatomic) int playerOneStartingGameScore;
@property (nonatomic) int playerTwoStartingGameScore;

@property (strong, nonatomic) BoardView *boardView;
@property (strong, nonatomic) UILabel *playerOneScoreLabel;
@property (strong, nonatomic) UILabel *playerTwoScoreLabel;
@property (strong, nonatomic) UILabel *playerOneNameLabel;
@property (strong, nonatomic) UILabel *playerTwoNameLabel;
@property (strong, nonatomic) TwentiesView *playerOne20sView;
@property (strong, nonatomic) TwentiesView *playerTwo20sView;
@property (strong, nonatomic) UIButton *quitGameButton;
@property (strong, nonatomic) UIButton *nextRoundButton;

- (id)initForRound:(Round *)aRound;
- (void)updateScores;
- (void)saveRound;
- (void)onQuitGameButtonTap:(id)sender;
- (void)onNextRoundButtonTap:(id)sender;

@end
