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

extern const int WINNING_SCORE;

const int ALERT_VIEW_VISUAL_CANCEL_QUIT_BUTTON_INDEX = 0;
const int ALERT_VIEW_VISUAL_QUIT_BUTTON_INDEX = 1;

@implementation VisualScorekeepingViewController

@synthesize round;
@synthesize boardView;
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

    // Add the board view.
    [self setBoardView:[[BoardView alloc] initWithRound:round andFrame:CGRectMake(20, 10, 280, 340)]];
    [[self view] addSubview:boardView];

    // Add the buttons.
    [self setQuitButton:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [quitButton setFrame:CGRectMake(20, 360, 70, 37)];
    [[quitButton titleLabel] setTextAlignment:UITextAlignmentCenter];
    [quitButton setTitle:@"Quit"
                forState:UIControlStateNormal];
    [quitButton addTarget:self
                   action:@selector(onQuitButtonTap:)
         forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:quitButton];

    [self setUndoButton:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [undoButton setFrame:CGRectMake(105, 360, 70, 37)];
    [[undoButton titleLabel] setTextAlignment:UITextAlignmentCenter];
    [undoButton setTitle:@"Undo"
                forState:UIControlStateNormal];
    [undoButton addTarget:self
                   action:@selector(onUndoButtonTap:)
         forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:undoButton];

    [self setNextRoundButton:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [nextRoundButton setFrame:CGRectMake(190, 360, 110, 37)];
    [[nextRoundButton titleLabel] setTextAlignment:UITextAlignmentCenter];
    [nextRoundButton setTitle:@"Next Round"
                     forState:UIControlStateNormal];
    [nextRoundButton addTarget:self
                        action:@selector(onNextRoundButtonTap:)
              forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:nextRoundButton];

    // If this is the first round, remove the back button on the navigation bar.
    if (round == [[[round game] rounds] objectAtIndex:0]) {
        [[self navigationItem] setHidesBackButton:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    // Update and save the current round.
    [CoreDataUtilities saveManagedContext];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [boardView removeLastDiscForActivePlayer];
}

- (void)onNextRoundButtonTap:(id)sender {
    // Update and save the current round.
    [CoreDataUtilities saveManagedContext];

    // If the game is over, redirect to the game summary screen.  Otherwise, create a new round and load a new round screen.
    if ([[round game] playerOneScore] >= WINNING_SCORE || [[round game] playerTwoScore] >= WINNING_SCORE) {
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
