//
//  VisualScorekeepingViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "VisualScorekeepingViewController.h"

#import "AppDelegate.h"
#import "BoardView.h"
#import "CoreDataUtilities.h"
#import "Game.h"
#import "Player.h"
#import "PostGameViewController.h"
#import "Round.h"
#import "TwentiesView.h"

extern const int WINNING_SCORE;

const int ALERT_VIEW_VISUAL_CANCEL_QUIT_BUTTON_INDEX = 0;
const int ALERT_VIEW_VISUAL_QUIT_BUTTON_INDEX = 1;

@implementation VisualScorekeepingViewController

@synthesize round, playerOneStartingGameScore, playerTwoStartingGameScore;
@synthesize boardView;
@synthesize playerOneNameLabel, playerTwoNameLabel, playerOneScoreLabel, playerTwoScoreLabel;
@synthesize playerOne20sView, playerTwo20sView;
@synthesize quitButton, undoButton, nextRoundButton;

- (id)initForRound:(Round *)aRound {
    self = [super init];

    if (self) {
        [self setRound:aRound];

        // Set the text on the navigation bar.
        [self setTitle:[NSString stringWithFormat:@"Round %d", [[[round game] rounds] indexOfObject:round] + 1]];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Add the name labels.
    [self setPlayerOneNameLabel:[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 94, 21)]];
    [[self playerOneNameLabel] setTextAlignment:UITextAlignmentCenter];
    [[self view] addSubview:[self playerOneNameLabel]];

    [self setPlayerTwoNameLabel:[[UILabel alloc] initWithFrame:CGRectMake(206, 20, 94, 21)]];
    [[self playerTwoNameLabel] setTextAlignment:UITextAlignmentCenter];
    [[self view] addSubview:[self playerTwoNameLabel]];

    // Add the score labels.
    [self setPlayerOneScoreLabel:[[UILabel alloc] initWithFrame:CGRectMake(20, 45, 94, 21)]];
    [[self playerOneScoreLabel] setTextAlignment:UITextAlignmentCenter];
    [[self view] addSubview:[self playerOneScoreLabel]];

    [self setPlayerTwoScoreLabel:[[UILabel alloc] initWithFrame:CGRectMake(206, 45, 94, 21)]];
    [[self playerTwoScoreLabel] setTextAlignment:UITextAlignmentCenter];
    [[self view] addSubview:[self playerTwoScoreLabel]];

    // Add the 20s views.
    [self setPlayerOne20sView:[[TwentiesView alloc] initWithFrame:CGRectMake(20, 70, 94, 21)
                                                         delegate:self]];
    [[self view] addSubview:[self playerOne20sView]];

    [self setPlayerTwo20sView:[[TwentiesView alloc] initWithFrame:CGRectMake(206, 70, 94, 21)
                                                         delegate:self]];
    [[self view] addSubview:[self playerTwo20sView]];

    // Add the board view.
    [self setBoardView:[[BoardView alloc] initWithFrame:CGRectMake(35, 95, 250, 250)
                                               delegate:self]];
    [[self view] addSubview:[self boardView]];

    // Add the buttons.
    [self setQuitButton:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [[self quitButton] setFrame:CGRectMake(20, 359, 80, 37)];
    [[self quitButton] setTitle:@"Quit"
                       forState:UIControlStateNormal];
    [[self quitButton] addTarget:self
                          action:@selector(onQuitButtonTap:)
                forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self quitButton]];

    [self setUndoButton:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [[self undoButton] setFrame:CGRectMake(110, 359, 80, 37)];
    [[self undoButton] setTitle:@"Undo"
                       forState:UIControlStateNormal];
    [[self undoButton] addTarget:self
                          action:@selector(onUndoButtonTap:)
                forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self undoButton]];

    [self setNextRoundButton:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [[self nextRoundButton] setFrame:CGRectMake(180, 359, 120, 37)];
    [[self nextRoundButton] setTitle:@"Next Round"
                            forState:UIControlStateNormal];
    [[self nextRoundButton] addTarget:self
                              action:@selector(onNextRoundButtonTap:)
                    forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:[self nextRoundButton]];

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

    // Set the twenties view values according to the round's data.
    [[self playerOne20sView] updateValue:[[round playerOne20s] doubleValue]];
    [[self playerTwo20sView] updateValue:[[round playerTwo20s] doubleValue]];

    // Recreate the board view.
    [[self boardView] recreateDiscPositions:[round discPositions]];

    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    // Update and save the current round.
    [self saveRound];

    [super viewWillDisappear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)updateScores {
    // Calculate the round score and update the game score labels.
    int playerOneRoundScore = 0;
    playerOneRoundScore += [playerOne20sView value] * 20;
    playerOneRoundScore += [boardView playerOne15s] * 15;
    playerOneRoundScore += [boardView playerOne10s] * 10;
    playerOneRoundScore += [boardView playerOne5s] * 5;

    int playerTwoRoundScore = 0;
    playerTwoRoundScore += [playerTwo20sView value] * 20;
    playerTwoRoundScore += [boardView playerTwo15s] * 15;
    playerTwoRoundScore += [boardView playerTwo10s] * 10;
    playerTwoRoundScore += [boardView playerTwo5s] * 5;

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

- (void)saveRound {
    [round setPlayerOne20s:[NSNumber numberWithDouble:[playerOne20sView value]]];
    [round setPlayerOne15s:[NSNumber numberWithDouble:[boardView playerOne15s]]];
    [round setPlayerOne10s:[NSNumber numberWithDouble:[boardView playerOne10s]]];
    [round setPlayerOne5s:[NSNumber numberWithDouble:[boardView playerOne5s]]];
    [round setPlayerTwo20s:[NSNumber numberWithDouble:[playerTwo20sView value]]];
    [round setPlayerTwo15s:[NSNumber numberWithDouble:[boardView playerTwo15s]]];
    [round setPlayerTwo10s:[NSNumber numberWithDouble:[boardView playerTwo10s]]];
    [round setPlayerTwo5s:[NSNumber numberWithDouble:[boardView playerTwo5s]]];

    [CoreDataUtilities saveManagedContext];
}

- (void)onQuitButtonTap:(id)sender {
    // Show an alert, asking if the user truly wants to quit the game.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really quit?"
                                                    message:@"The current game will be lost."
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Quit", nil];
    [alert show];
}

- (void)onUndoButtonTap:(id)sender {
    [[self boardView] removeLastDiscForActivePlayer];
}

- (void)onNextRoundButtonTap:(id)sender {
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
            [roundAttributes setValue:[NSMutableArray arrayWithObjects:[NSMutableArray array], [NSMutableArray array], nil]
                               forKey:@"discPositions"];
            nextRound = (Round *)[CoreDataUtilities createEntityForEntityName:@"Round"
                                                          attributeDictionary:roundAttributes];
        } else {
            int currentRoundIndex = [[[round game] rounds] indexOfObject:round];
            nextRound = [[[round game] rounds] objectAtIndex:currentRoundIndex + 1];
        }

        // Push a new scorekeeping screen.
        VisualScorekeepingViewController *scorekeepingViewController = [[VisualScorekeepingViewController alloc] initForRound:nextRound];
        [[self navigationController] pushViewController:scorekeepingViewController animated:YES];
    }
}

# pragma mark - BoardViewDelegate

- (void)boardWasRecreated {
    [self updateScores];
}

- (void)boardWasTapped:(CGPoint)point
           playerIndex:(int)playerIndex {
    [self updateScores];
}

# pragma mark - TwentiesViewDelegate

- (void)valueChanged {
    [self updateScores];
}

# pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == ALERT_VIEW_VISUAL_CANCEL_QUIT_BUTTON_INDEX) {
        // Dismiss the alert.
    } else if (buttonIndex == ALERT_VIEW_VISUAL_QUIT_BUTTON_INDEX) {
        // Pop back to the player selection screen.
        [[self navigationController] popToRootViewControllerAnimated:YES];

        // Delete the current game.
        [CoreDataUtilities deleteEntity:[round game]];
    } else {
        // Unknown button! Dismiss the alert.
    }
}

@end
