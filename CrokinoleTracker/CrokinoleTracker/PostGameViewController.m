//
//  PostGameViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "PostGameViewController.h"

#import "CoreDataUtilities.h"
#import "Game.h"
#import "GameStatistics.h"
#import "GameSummaryView.h"
#import "Player.h"
#import "VisualScorekeepingViewController.h"

@implementation PostGameViewController

@synthesize gameSummaryView;

- (id)initForGame:(Game *)aGame {
    self = [super init];

    if (self) {
        game = aGame;

        // Set the text on the navigation bar to show the winner.
        Player *winner = [game winningPlayer];
        [self setTitle:[NSString stringWithFormat:@"%@ wins!", [winner name]]];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Compute and retrieve the game's statistics.
    GameStatistics *gameStatistics = [[GameStatistics alloc] initForGame:game];

    // Display the statistics in the game summary view.
    [gameSummaryView displayStatistics:gameStatistics];

    // Remove the back button on the navigation bar.
    [[self navigationItem] setHidesBackButton:YES];
}

- (void)viewDidUnload {
    [self setGameSummaryView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onMainMenuButtonTap:(id)sender {
    // Pop to the main menu.
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (IBAction)onRematchButtonTap:(id)sender {
    // Pop to the root controller to clear the view controller stack.
    UINavigationController *navigationController = [self navigationController];
    [navigationController popToRootViewControllerAnimated:NO];

    // Create a new game.
    Game *newGame = [CoreDataUtilities createGameForPlayers:[[game players] array]];

    // Push the scorekeeping screen.
    Round *firstRound = [[newGame rounds] objectAtIndex:0];
    VisualScorekeepingViewController *scorekeepingViewController = [[VisualScorekeepingViewController alloc] initForRound:firstRound];
    [navigationController pushViewController:scorekeepingViewController animated:YES];
}

@end
