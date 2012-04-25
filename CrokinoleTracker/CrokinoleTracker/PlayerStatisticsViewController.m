//
//  PlayerStatisticsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "Player.h"
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

    // Set the wins and losses labels.
    [winsLabel setText:[NSString stringWithFormat:@"Wins: %d", [player wins]]];
    [lossesLabel setText:[NSString stringWithFormat:@"Losses: %d", [player losses]]];
    [pointsPerGameLabel setText:[NSString stringWithFormat:@"Points per game: %.2f", [player pointsPerGame]]];
    [pointsPerRoundLabel setText:[NSString stringWithFormat:@"Points per round: %.2f", [player pointsPerRound]]];
    [twentiesPerGameLabel setText:[NSString stringWithFormat:@"Twenties per game: %.2f", [player twentiesPerGame]]];
    [twentiesPerRoundLabel setText:[NSString stringWithFormat:@"Twenties per round: %.2f", [player twentiesPerRound]]];
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
