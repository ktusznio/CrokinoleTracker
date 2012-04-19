//
//  ScorekeepingViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-19.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "Game.h"
#import "Player.h"
#import "ScorekeepingViewController.h"

@implementation ScorekeepingViewController

@synthesize playerOneScoreLabel;
@synthesize playerTwoScoreLabel;
@synthesize playerOneNameLabel;
@synthesize playerTwoNameLabel;
@synthesize roundNumberLabel;

- (id)initForGame:(Game *)aGame {
    self = [super init];

    if (self) {
        game = aGame;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [playerOneScoreLabel setText:[NSString stringWithFormat:@"%d", [game playerOneScore]]];
    [playerTwoScoreLabel setText:[NSString stringWithFormat:@"%d", [game playerTwoScore]]];
    
    NSOrderedSet *players = [game players];
    Player *playerOne = [players objectAtIndex:0];
    Player *playerTwo = [players objectAtIndex:1];
    
    [playerOneNameLabel setText:[playerOne name]];
    [playerTwoNameLabel setText:[playerTwo name]];
    
    [roundNumberLabel setText:[NSString stringWithFormat:@"%d", [[game rounds] count]]];
}

- (void)viewDidUnload {
    [self setPlayerOneScoreLabel:nil];
    [self setPlayerTwoScoreLabel:nil];
    [self setPlayerOneNameLabel:nil];
    [self setPlayerTwoNameLabel:nil];
    [self setRoundNumberLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
