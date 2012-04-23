//
//  GameSummaryViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 23-04-19.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "Player.h"
#import "GameSummaryViewController.h"

@implementation GameSummaryViewController

@synthesize winnerLabel;

- (id)initForGame:(Game *)aGame {
    self = [super init];

    if (self) {
        game = aGame;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the view title.
    [self setTitle:@"Game Summary"];

    // Remove the back button on the navigation bar.
    [[self navigationItem] setHidesBackButton:YES];

    // Set the winning player label.
    Player *winner = [game winningPlayer];
    [winnerLabel setText:[NSString stringWithFormat:@"%@ wins!", [winner name]]];
}

- (void)viewDidUnload {
    [self setWinnerLabel:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
