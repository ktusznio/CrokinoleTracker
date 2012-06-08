//
//  GameSummaryView.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-05-01.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSummaryView : UIView

@property (weak, nonatomic) IBOutlet UILabel *playerOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOneScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOneRoundsWonLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoRoundsWonLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOnePointsPerRoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoPointsPerRoundLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOneTwentiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoTwentiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOneFifteensLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoFifteensLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOneTensLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoTensLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerOneFivesLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoFivesLabel;

- (void)loadViewFromBundle;
- (void)displayStatistics:(GameStatistics *)gameStatistics;

@end
