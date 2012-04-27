//
//  GameStatisticsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-25.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "GameStatisticsViewController.h"

#import "AppDelegate.h"
#import "CoreDataUtilities.h"
#import "Game.h"
#import "GameStatistics.h"
#import "Player.h"

const int ALERT_VIEW_CANCEL_DELETE_BUTTON_INDEX = 0;
const int ALERT_VIEW_DELETE_BUTTON_INDEX = 1;

@implementation GameStatisticsViewController

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
    // Set the statistics labels.
    GameStatistics *gameStatistics = [[GameStatistics alloc] initForGame:game];
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
    [self setPlayerOneLabel:nil];
    [self setPlayerTwoLabel:nil];
    [self setPlayerOneScoreLabel:nil];
    [self setPlayerTwoScoreLabel:nil];
    [self setPlayerOneRoundsWonLabel:nil];
    [self setPlayerTwoRoundsWonLabel:nil];
    [self setPlayerOnePointsPerRoundLabel:nil];
    [self setPlayerTwoPointsPerRoundLabel:nil];
    [self setPlayerOneTwentiesLabel:nil];
    [self setPlayerTwoTwentiesLabel:nil];
    [self setPlayerOneFifteensLabel:nil];
    [self setPlayerTwoFifteensLabel:nil];
    [self setPlayerOneTensLabel:nil];
    [self setPlayerTwoTensLabel:nil];
    [self setPlayerOneFivesLabel:nil];
    [self setPlayerTwoFivesLabel:nil];
    [super viewDidUnload];
}

@end
