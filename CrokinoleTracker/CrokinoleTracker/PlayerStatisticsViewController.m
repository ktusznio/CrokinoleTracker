//
//  PlayerStatisticsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "Player.h"
#import "PlayerStatistics.h"
#import "PlayerStatisticsViewController.h"

@implementation PlayerStatisticsViewController

@synthesize winsLabel;
@synthesize lossesLabel;
@synthesize pointsPerGameLabel;
@synthesize pointsPerRoundLabel;
@synthesize twentiesPerGameLabel;
@synthesize twentiesPerRoundLabel;

- (id)initForPlayer:(Player *)aPlayer {
    self = [super init];

    if (self) {
        player = aPlayer;

        // Set the text on the navigation bar.
        [self setTitle:[NSString stringWithFormat:@"%@'s Statistics", [player name]]];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Get the player statistics for the selected player.
    PlayerStatistics *playerStatistics = [player statistics];

    // Set the statistics labels.
    [winsLabel setText:[NSString stringWithFormat:@"Wins: %d", [playerStatistics wins]]];
    [lossesLabel setText:[NSString stringWithFormat:@"Losses: %d", [playerStatistics losses]]];
    [pointsPerGameLabel setText:[NSString stringWithFormat:@"Points per game: %.2f", [playerStatistics pointsPerGame]]];
    [pointsPerRoundLabel setText:[NSString stringWithFormat:@"Points per round: %.2f", [playerStatistics pointsPerRound]]];
    [twentiesPerGameLabel setText:[NSString stringWithFormat:@"Twenties per game: %.2f", [playerStatistics twentiesPerGame]]];
    [twentiesPerRoundLabel setText:[NSString stringWithFormat:@"Twenties per round: %.2f", [playerStatistics twentiesPerRound]]];
}

- (void)viewDidUnload {
    [self setWinsLabel:nil];
    [self setLossesLabel:nil];
    [self setPointsPerGameLabel:nil];
    [self setPointsPerRoundLabel:nil];
    [self setTwentiesPerGameLabel:nil];
    [self setTwentiesPerRoundLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
