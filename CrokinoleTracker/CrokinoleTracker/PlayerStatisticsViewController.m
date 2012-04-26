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

@synthesize recordLabel;
@synthesize pointsPerGameLabel;
@synthesize pointsPerRoundLabel;
@synthesize twentiesPerGameLabel;
@synthesize twentiesPerRoundLabel;
@synthesize roundsPerGameLabel;

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
    [recordLabel setText:[NSString stringWithFormat:@"Record: %d-%d", [playerStatistics wins], [playerStatistics losses]]];
    [pointsPerGameLabel setText:[NSString stringWithFormat:@"Points per game: %.2f", [playerStatistics pointsPerGame]]];
    [pointsPerRoundLabel setText:[NSString stringWithFormat:@"Points per round: %.2f", [playerStatistics pointsPerRound]]];
    [twentiesPerGameLabel setText:[NSString stringWithFormat:@"Twenties per game: %.2f", [playerStatistics twentiesPerGame]]];
    [twentiesPerRoundLabel setText:[NSString stringWithFormat:@"Twenties per round: %.2f", [playerStatistics twentiesPerRound]]];
    [roundsPerGameLabel setText:[NSString stringWithFormat:@"Rounds per game: %.2f", [playerStatistics roundsPerGame]]];
}

- (void)viewDidUnload {
    [self setRecordLabel:nil];
    [self setPointsPerGameLabel:nil];
    [self setPointsPerRoundLabel:nil];
    [self setTwentiesPerGameLabel:nil];
    [self setTwentiesPerRoundLabel:nil];
    [self setRoundsPerGameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
