//
//  ScorekeepingViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-19.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "CoreDataUtilities.h"
#import "Game.h"
#import "GameSummaryViewController.h"
#import "Player.h"
#import "Round.h"
#import "ScorekeepingViewController.h"

extern const int WINNING_SCORE;

const int ALERT_VIEW_CANCEL_BUTTON_INDEX = 0;
const int ALERT_VIEW_QUIT_BUTTON_INDEX = 1;

@implementation ScorekeepingViewController

@synthesize playerOneScoreLabel;
@synthesize playerTwoScoreLabel;
@synthesize playerOneNameLabel;
@synthesize playerTwoNameLabel;
@synthesize playerOne20sLabel, playerOne15sLabel, playerOne10sLabel, playerOne5sLabel;
@synthesize playerOne20sStepper, playerOne15sStepper, playerOne10sStepper, playerOne5sStepper;
@synthesize playerTwo20sLabel, playerTwo15sLabel, playerTwo10sLabel, playerTwo5sLabel;
@synthesize playerTwo20sStepper, playerTwo15sStepper, playerTwo10sStepper, playerTwo5sStepper;

- (id)initForGame:(Game *)aGame {
    self = [super init];

    if (self) {
        game = aGame;
        playerOneStartingGameScore = [game playerOneScore];
        playerTwoStartingGameScore = [game playerTwoScore];

        // Set the text on the navigation bar.
        [self setTitle:[NSString stringWithFormat:@"Round %d", [[game rounds] count]]];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize the text on all the labels.
    [playerOneScoreLabel setText:[NSString stringWithFormat:@"%d", playerOneStartingGameScore]];
    [playerTwoScoreLabel setText:[NSString stringWithFormat:@"%d", playerTwoStartingGameScore]];

    NSOrderedSet *players = [game players];
    Player *playerOne = [players objectAtIndex:0];
    Player *playerTwo = [players objectAtIndex:1];

    [playerOneNameLabel setText:[playerOne name]];
    [playerTwoNameLabel setText:[playerTwo name]];

    // Remove the back button on the navigation bar.
    [[self navigationItem] setHidesBackButton:YES];
}

- (void)viewDidUnload {
    [self setPlayerOneScoreLabel:nil];
    [self setPlayerTwoScoreLabel:nil];
    [self setPlayerOneNameLabel:nil];
    [self setPlayerTwoNameLabel:nil];
    [self setPlayerOne20sLabel:nil];
    [self setPlayerOne15sLabel:nil];
    [self setPlayerOne10sLabel:nil];
    [self setPlayerOne5sLabel:nil];
    [self setPlayerOne20sStepper:nil];
    [self setPlayerOne15sStepper:nil];
    [self setPlayerOne10sStepper:nil];
    [self setPlayerOne5sStepper:nil];
    [self setPlayerTwo20sLabel:nil];
    [self setPlayerTwo15sLabel:nil];
    [self setPlayerTwo10sLabel:nil];
    [self setPlayerTwo5sLabel:nil];
    [self setPlayerTwo20sStepper:nil];
    [self setPlayerTwo15sStepper:nil];
    [self setPlayerTwo10sStepper:nil];
    [self setPlayerTwo5sStepper:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)valueChanged:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    UILabel *label = [self labelForStepper:stepper];

    // Update the label.
    [label setText:[NSString stringWithFormat:@"%d", (int)[stepper value]]];

    // Calculate the round score and update the game score labels.
    int playerOneRoundScore = 0;
    playerOneRoundScore += [[playerOne20sLabel text] intValue] * 20;
    playerOneRoundScore += [[playerOne15sLabel text] intValue] * 15;
    playerOneRoundScore += [[playerOne10sLabel text] intValue] * 10;
    playerOneRoundScore += [[playerOne5sLabel text] intValue] * 5;

    int playerTwoRoundScore = 0;
    playerTwoRoundScore += [[playerTwo20sLabel text] intValue] * 20;
    playerTwoRoundScore += [[playerTwo15sLabel text] intValue] * 15;
    playerTwoRoundScore += [[playerTwo10sLabel text] intValue] * 10;
    playerTwoRoundScore += [[playerTwo5sLabel text] intValue] * 5;

    if (playerOneRoundScore > playerTwoRoundScore) {
        playerOneRoundScore -= playerTwoRoundScore;
        playerTwoRoundScore = 0;
    } else if (playerOneRoundScore < playerTwoRoundScore) {
        playerTwoRoundScore -= playerOneRoundScore;
        playerOneRoundScore = 0;
    } else {
        playerOneRoundScore = 0;
        playerTwoRoundScore = 0;
    }

    int playerOneGameScore = playerOneStartingGameScore + playerOneRoundScore;
    [playerOneScoreLabel setText:[NSString stringWithFormat:@"%d", playerOneGameScore]];

    int playerTwoGameScore = playerTwoStartingGameScore + playerTwoRoundScore;
    [playerTwoScoreLabel setText:[NSString stringWithFormat:@"%d", playerTwoGameScore]];
}

- (UILabel *)labelForStepper:(UIStepper *)stepper {
    if (stepper == playerOne20sStepper) {
        return playerOne20sLabel;
    } else if (stepper == playerOne15sStepper) {
        return playerOne15sLabel;
    } else if (stepper == playerOne10sStepper) {
        return playerOne10sLabel;
    } else if (stepper == playerOne5sStepper) {
        return playerOne5sLabel;
    } else if (stepper == playerTwo20sStepper) {
        return playerTwo20sLabel;
    } else if (stepper == playerTwo15sStepper) {
        return playerTwo15sLabel;
    } else if (stepper == playerTwo10sStepper) {
        return playerTwo10sLabel;
    } else if (stepper == playerTwo5sStepper) {
        return playerTwo5sLabel;
    }
    return nil;
}

- (IBAction)onQuitGameButtonTap:(id)sender {
    // Show an alert, asking if the user truly wants to quit the game.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really quit?"
                                                    message:@"The current game will be lost."
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Quit", nil];
    [alert show];
}

- (IBAction)onNextRoundButtonTap:(id)sender {
    // Update and save the current round.
    Round *currentRound = [game currentRound];
    [currentRound setPlayerOne20s:[NSNumber numberWithDouble:[playerOne20sStepper value]]];
    [currentRound setPlayerOne15s:[NSNumber numberWithDouble:[playerOne15sStepper value]]];
    [currentRound setPlayerOne10s:[NSNumber numberWithDouble:[playerOne10sStepper value]]];
    [currentRound setPlayerOne5s:[NSNumber numberWithDouble:[playerOne5sStepper value]]];
    [currentRound setPlayerTwo20s:[NSNumber numberWithDouble:[playerTwo20sStepper value]]];
    [currentRound setPlayerTwo15s:[NSNumber numberWithDouble:[playerTwo15sStepper value]]];
    [currentRound setPlayerTwo10s:[NSNumber numberWithDouble:[playerTwo10sStepper value]]];
    [currentRound setPlayerTwo5s:[NSNumber numberWithDouble:[playerTwo5sStepper value]]];

    [CoreDataUtilities saveManagedContext];

    // If the game is over, redirect to the game summary screen.  Otherwise, create a new round and load a new round screen.
    if ([[playerOneScoreLabel text] intValue] >= WINNING_SCORE || [[playerTwoScoreLabel text] intValue] >= WINNING_SCORE) {
        GameSummaryViewController *gameSummaryViewController = [[GameSummaryViewController alloc] initForGame:game];
        [[self navigationController] pushViewController:gameSummaryViewController animated:YES];
    } else {
        // Create a new round for the game.
        NSMutableDictionary *roundAttributes = [NSMutableDictionary dictionary];
        [roundAttributes setValue:[NSNumber numberWithInt:[[self title] intValue] + 1]
                           forKey:@"roundNumber"];
        [roundAttributes setValue:game
                           forKey:@"game"];
        [CoreDataUtilities createEntityForEntityName:@"Round"
                                 attributeDictionary:roundAttributes];

        // Push a new scorekeeping screen.
        ScorekeepingViewController *scorekeepingViewController = [[ScorekeepingViewController alloc] initForGame:game];
        [[self navigationController] pushViewController:scorekeepingViewController animated:YES];
    }
}

# pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == ALERT_VIEW_CANCEL_BUTTON_INDEX) {
        // Dismiss the alert.
    } else if (buttonIndex == ALERT_VIEW_QUIT_BUTTON_INDEX) {
        // Delete the current game.
        [CoreDataUtilities deleteEntity:game];

        // Pop back to the player selection screen.
        [[self navigationController] popToRootViewControllerAnimated:YES];
    } else {
        // Unknown button! Dismiss the alert.
    }
}

@end
