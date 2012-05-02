//
//  PostGameViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "PostGameViewController.h"

#import "CoreDataUtilities.h"
#import "Game.h"
#import "GameStatistics.h"
#import "GameSummaryView.h"
#import "Player.h"
#import "ScorekeepingViewController.h"

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
    UINavigationController *nav = [self navigationController];
    [nav popToRootViewControllerAnimated:NO];

    // Create a new game.
    Game *newGame = [CoreDataUtilities createGameForPlayers:[[game players] array]];

    // Push the scorekeeping screen.
    ScorekeepingViewController *scorekeepingViewController = [[ScorekeepingViewController alloc] initForGame:newGame];
    [nav pushViewController:scorekeepingViewController animated:YES];
}

@end
