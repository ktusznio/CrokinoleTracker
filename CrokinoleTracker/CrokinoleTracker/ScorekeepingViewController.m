//
//  ScorekeepingViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-19.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "ScorekeepingViewController.h"

#import "AppDelegate.h"
#import "CoreDataUtilities.h"
#import "Game.h"
#import "Player.h"
#import "PostGameViewController.h"
#import "Round.h"

extern const int WINNING_SCORE;

const int ALERT_VIEW_CANCEL_QUIT_BUTTON_INDEX = 0;
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

- (id)initForRound:(Round *)aRound {
    self = [super init];

    if (self) {
        round = aRound;

        // Set the text on the navigation bar.
        [self setTitle:[NSString stringWithFormat:@"Round %d", [[[round game] rounds] indexOfObject:round] + 1]];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // If this is the first round, remove the back button on the navigation bar.
    if (round == [[[round game] rounds] objectAtIndex:0]) {
        [[self navigationItem] setHidesBackButton:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    // Initialize the text on all the labels.
    NSOrderedSet *players = [[round game] players];
    Player *playerOne = [players objectAtIndex:0];
    Player *playerTwo = [players objectAtIndex:1];

    [playerOneNameLabel setText:[playerOne name]];
    [playerTwoNameLabel setText:[playerTwo name]];

    playerOneStartingGameScore = [[round game] playerOneScoreAtRound:round];
    playerTwoStartingGameScore = [[round game] playerTwoScoreAtRound:round];

    [playerOneScoreLabel setText:[NSString stringWithFormat:@"%d", playerOneStartingGameScore + [round playerOneScore]]];
    [playerTwoScoreLabel setText:[NSString stringWithFormat:@"%d", playerTwoStartingGameScore + [round playerTwoScore]]];

    // Set the stepper and label values according to the round's data.
    [[self playerOne20sStepper] setValue:[[round playerOne20s] doubleValue]];
    [[self playerOne15sStepper] setValue:[[round playerOne15s] doubleValue]];
    [[self playerOne10sStepper] setValue:[[round playerOne10s] doubleValue]];
    [[self playerOne5sStepper] setValue:[[round playerOne5s] doubleValue]];
    [[self playerTwo20sStepper] setValue:[[round playerTwo20s] doubleValue]];
    [[self playerTwo15sStepper] setValue:[[round playerTwo15s] doubleValue]];
    [[self playerTwo10sStepper] setValue:[[round playerTwo10s] doubleValue]];
    [[self playerTwo5sStepper] setValue:[[round playerTwo5s] doubleValue]];

    [[self playerOne20sLabel] setText:[NSString stringWithFormat:@"%d", (int)[playerOne20sStepper value]]];
    [[self playerOne15sLabel] setText:[NSString stringWithFormat:@"%d", (int)[playerOne15sStepper value]]];
    [[self playerOne10sLabel] setText:[NSString stringWithFormat:@"%d", (int)[playerOne10sStepper value]]];
    [[self playerOne5sLabel] setText:[NSString stringWithFormat:@"%d", (int)[playerOne5sStepper value]]];
    [[self playerTwo20sLabel] setText:[NSString stringWithFormat:@"%d", (int)[playerTwo20sStepper value]]];
    [[self playerTwo15sLabel] setText:[NSString stringWithFormat:@"%d", (int)[playerTwo15sStepper value]]];
    [[self playerTwo10sLabel] setText:[NSString stringWithFormat:@"%d", (int)[playerTwo10sStepper value]]];
    [[self playerTwo5sLabel] setText:[NSString stringWithFormat:@"%d", (int)[playerTwo5sStepper value]]];

    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    // Update and save the current round.
    [self saveRound];

    [super viewWillDisappear:animated];
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

- (void)saveRound {
    [round setPlayerOne20s:[NSNumber numberWithDouble:[playerOne20sStepper value]]];
    [round setPlayerOne15s:[NSNumber numberWithDouble:[playerOne15sStepper value]]];
    [round setPlayerOne10s:[NSNumber numberWithDouble:[playerOne10sStepper value]]];
    [round setPlayerOne5s:[NSNumber numberWithDouble:[playerOne5sStepper value]]];
    [round setPlayerTwo20s:[NSNumber numberWithDouble:[playerTwo20sStepper value]]];
    [round setPlayerTwo15s:[NSNumber numberWithDouble:[playerTwo15sStepper value]]];
    [round setPlayerTwo10s:[NSNumber numberWithDouble:[playerTwo10sStepper value]]];
    [round setPlayerTwo5s:[NSNumber numberWithDouble:[playerTwo5sStepper value]]];

    [CoreDataUtilities saveManagedContext];
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
    [self saveRound];

    // If the game is over, redirect to the game summary screen.  Otherwise, create a new round and load a new round screen.
    if ([[playerOneScoreLabel text] intValue] >= WINNING_SCORE || [[playerTwoScoreLabel text] intValue] >= WINNING_SCORE) {
        // If there are subsequent rounds, delete them because they're now obsolete.
        NSOrderedSet *rounds = [[round game] rounds];
        if (round != [rounds lastObject]) {
            for (int i = [rounds count] - 1; i > [rounds indexOfObject:round]; i--) {
                [CoreDataUtilities deleteEntity:[rounds objectAtIndex:i]];
            }
        }

        // Add the completed game to the app delegate's game collection.
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [[appDelegate games] addObject:[round game]];

        // Initialize and push the game summary screen.
        PostGameViewController *postGameViewController = [[PostGameViewController alloc] initForGame:[round game]];
        [[self navigationController] pushViewController:postGameViewController animated:YES];
    } else {
        // Determine whether the next round already exists.  If it does, go to it.  If it doesn't, create one.
        Round *nextRound;

        if (round == [[[round game] rounds] lastObject]) {
            // Create a new round for the game.
            NSMutableDictionary *roundAttributes = [NSMutableDictionary dictionary];
            [roundAttributes setValue:[NSNumber numberWithInt:[[self title] intValue] + 1]
                               forKey:@"roundNumber"];
            [roundAttributes setValue:[round game]
                               forKey:@"game"];
            nextRound = (Round *)[CoreDataUtilities createEntityForEntityName:@"Round"
                                                                 attributeDictionary:roundAttributes];
        } else {
            int currentRoundIndex = [[[round game] rounds] indexOfObject:round];
            nextRound = [[[round game] rounds] objectAtIndex:currentRoundIndex + 1];
        }

        // Push a new scorekeeping screen.
        ScorekeepingViewController *scorekeepingViewController = [[ScorekeepingViewController alloc] initForRound:nextRound];
        [[self navigationController] pushViewController:scorekeepingViewController animated:YES];
    }
}

# pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == ALERT_VIEW_CANCEL_QUIT_BUTTON_INDEX) {
        // Dismiss the alert.
    } else if (buttonIndex == ALERT_VIEW_QUIT_BUTTON_INDEX) {
        // Pop back to the player selection screen.
        [[self navigationController] popToRootViewControllerAnimated:YES];

        // Delete the current game.
        [CoreDataUtilities deleteEntity:[round game]];
    } else {
        // Unknown button! Dismiss the alert.
    }
}

@end
