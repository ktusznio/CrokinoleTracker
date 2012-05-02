//
//  GameSummaryView.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-05-01.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "Game.h"
#import "GameStatistics.h"
#import "GameSummaryView.h"
#import "Player.h"

@implementation GameSummaryView

@synthesize playerOneLabel;
@synthesize playerTwoLabel;
@synthesize playerOneScoreLabel;
@synthesize playerTwoScoreLabel;
@synthesize playerOneRoundsWonLabel;
@synthesize playerTwoRoundsWonLabel;
@synthesize playerOnePointsPerRoundLabel;
@synthesize playerTwoPointsPerRoundLabel;
@synthesize playerOneTwentiesLabel;
@synthesize playerTwoTwentiesLabel;
@synthesize playerOneFifteensLabel;
@synthesize playerTwoFifteensLabel;
@synthesize playerOneTensLabel;
@synthesize playerTwoTensLabel;
@synthesize playerOneFivesLabel;
@synthesize playerTwoFivesLabel;

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];

    if (self) {
        [self loadViewFromBundle];
    }

    return self;
}

- (void)loadViewFromBundle {
    // Create the game summary view.
    UIView *gameSummaryView = [[[NSBundle mainBundle] loadNibNamed:@"GameSummaryView"
                                                             owner:self
                                                           options:nil] lastObject];

    CGRect outerFrame = [self frame];
    CGRect innerFrame = CGRectMake(0, 0, outerFrame.size.width, outerFrame.size.height);
    [gameSummaryView setFrame:innerFrame];

    [self addSubview:gameSummaryView];
}

- (void)displayStatistics:(GameStatistics *)gameStatistics {
    Game *game = [gameStatistics game];

    Player *playerOne = [[game players] objectAtIndex:0];
    Player *playerTwo = [[game players] objectAtIndex:1];

    [playerOneLabel setText:[playerOne name]];
    [playerTwoLabel setText:[playerTwo name]];

    [playerOneScoreLabel setText:[NSString stringWithFormat:@"%d", [game playerOneScore]]];
    [playerTwoScoreLabel setText:[NSString stringWithFormat:@"%d", [game playerTwoScore]]];

    [playerOneRoundsWonLabel setText:[NSString stringWithFormat:@"%d", [gameStatistics playerOneRoundsWon]]];
    [playerTwoRoundsWonLabel setText:[NSString stringWithFormat:@"%d", [gameStatistics playerTwoRoundsWon]]];

    [playerOnePointsPerRoundLabel setText:[NSString stringWithFormat:@"%.2f", [gameStatistics playerOnePointsPerRound]]];
    [playerTwoPointsPerRoundLabel setText:[NSString stringWithFormat:@"%.2f", [gameStatistics playerTwoPointsPerRound]]];

    [playerOneTwentiesLabel setText:[NSString stringWithFormat:@"%d", [gameStatistics playerOneTwenties]]];
    [playerTwoTwentiesLabel setText:[NSString stringWithFormat:@"%d", [gameStatistics playerTwoTwenties]]];

    [playerOneFifteensLabel setText:[NSString stringWithFormat:@"%d", [gameStatistics playerOneFifteens]]];
    [playerTwoFifteensLabel setText:[NSString stringWithFormat:@"%d", [gameStatistics playerTwoFifteens]]];

    [playerOneTensLabel setText:[NSString stringWithFormat:@"%d", [gameStatistics playerOneTens]]];
    [playerTwoTensLabel setText:[NSString stringWithFormat:@"%d", [gameStatistics playerTwoTens]]];

    [playerOneFivesLabel setText:[NSString stringWithFormat:@"%d", [gameStatistics playerOneFives]]];
    [playerTwoFivesLabel setText:[NSString stringWithFormat:@"%d", [gameStatistics playerTwoFives]]];
}



@end
