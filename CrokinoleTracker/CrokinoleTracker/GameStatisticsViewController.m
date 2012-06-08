//
//  GameStatisticsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-25.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "GameStatisticsViewController.h"

#import "AppDelegate.h"
#import "CoreDataUtilities.h"
#import "Game.h"
#import "GameStatistics.h"
#import "GameSummaryView.h"
#import "Player.h"

const int ALERT_VIEW_CANCEL_DELETE_BUTTON_INDEX = 0;
const int ALERT_VIEW_DELETE_BUTTON_INDEX = 1;

@implementation GameStatisticsViewController

@synthesize gameSummaryView;

- (id)initForGame:(Game *)aGame {
    self = [super init];
    
    if (self) {
        game = aGame;
        
        // Set the text on the navigation bar.
        Player *playerOne = [[game players] objectAtIndex:0];
        Player *playerTwo = [[game players] objectAtIndex:1];
        [self setTitle:[NSString stringWithFormat:@"%@ vs %@", [playerOne name], [playerTwo name]]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Change the text on the back bar button item.
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:nil
                                                                         action:nil];
    [[self navigationItem] setBackBarButtonItem:backBarButtonItem];
}

- (void)viewWillAppear:(BOOL)animated {
    // Compute and retrieve the game's statistics.
    GameStatistics *gameStatistics = [[GameStatistics alloc] initForGame:game];
    
    // Display the statistics in the game summary view.
    [gameSummaryView displayStatistics:gameStatistics];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onDeleteGameButtonTap:(id)sender {
    // Show a dialog to confirm deletion of the game.
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Really delete?"
                                                        message:@"This cannot be undone."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Delete", nil];
    [alertView show];
}

# pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == ALERT_VIEW_CANCEL_DELETE_BUTTON_INDEX) {
        // Dismiss the alert.
    } else if (buttonIndex == ALERT_VIEW_DELETE_BUTTON_INDEX) {
        // Remove the game from the app delegate's loaded games.
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [[appDelegate games] removeObject:game];
        
        // Delete the game.
        [CoreDataUtilities deleteEntity:game];
        
        // Pop to the Players & Games screen.
        [[self navigationController] popViewControllerAnimated:YES];
    } else {
        // Unknown button! Dismiss the alert.
    }
}

- (void)viewDidUnload {
    [self setGameSummaryView:nil];
    [super viewDidUnload];
}

@end
