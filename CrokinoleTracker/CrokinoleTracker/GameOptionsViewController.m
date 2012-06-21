//
//  GameOptionsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "GameOptionsViewController.h"

#import "AppDelegate.h"
#import "BoardView.h"
#import "CoreDataUtilities.h"
#import "DiscView.h"
#import "Game.h"
#import "Player.h"
#import "PlayerSelectionViewController.h"
#import "Round.h"
#import "ScorekeepingViewController.h"
#import "VisualScorekeepingViewController.h"

@implementation GameOptionsViewController

@synthesize choosePlayerOneButton;
@synthesize choosePlayerTwoButton;
@synthesize startGameButton;

- (id)init {
    self = [super init];

    if (self) {
        // Set the text on the navigation bar.
        [self setTitle:@"Game Options"];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Draw disc views to represent player colors.
    UIView *playerOneDiscView = [[DiscView alloc] initWithFrame:CGRectMake(50, 121, 20, 20)
                                                          value:0
                                                      fillColor:[[BoardView playerColors] objectAtIndex:0]];
    [[self view] addSubview:playerOneDiscView];

    UIView *playerTwoDiscView = [[DiscView alloc] initWithFrame:CGRectMake(250, 196, 20, 20)
                                                          value:0
                                                      fillColor:[[BoardView playerColors] objectAtIndex:1]];
    [[self view] addSubview:playerTwoDiscView];

    // Change the text on the back bar button item.
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:nil
                                                                         action:nil];
    [[self navigationItem] setBackBarButtonItem:backBarButtonItem];

    // If the button is disabled, grey out the text.
    [startGameButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];

    // The start game button starts off disabled.
    [startGameButton setEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    // The start game button is enabled only if all players have been selected.
    BOOL allPlayersSelected = ![[[choosePlayerOneButton titleLabel] text] isEqualToString:@"Choose Player One"];
    allPlayersSelected &= ![[[choosePlayerTwoButton titleLabel] text] isEqualToString:@"Choose Player Two"];
    [startGameButton setEnabled:allPlayersSelected];
}

- (void)viewDidUnload {
    [self setChoosePlayerOneButton:nil];
    [self setChoosePlayerTwoButton:nil];
    [self setStartGameButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onSelectPlayerButtonTap:(id)sender {
    // Show a player selection view.
    UIButton *button = (UIButton *)sender;
    PlayerSelectionViewController *playerSelectionViewController = [[PlayerSelectionViewController alloc] initWithButton:button];
    [[self navigationController] pushViewController:playerSelectionViewController animated:YES];
}

- (IBAction)onStartGameButtonTap:(id)sender {
    // Ensure two different player names were entered.
    NSString *playerOneName = [[choosePlayerOneButton titleLabel] text];
    NSString *playerTwoName = [[choosePlayerTwoButton titleLabel] text];
    if ([playerOneName isEqualToString:playerTwoName]) {
        // Show an alert, asking the player to choose two different names.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh!"
                                                        message:@"Please choose two different players."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }

    // Get existing player entities, or create entities for new players.
    NSArray *choosePlayerButtons = [NSArray arrayWithObjects:choosePlayerOneButton, choosePlayerTwoButton, nil];
    NSMutableArray *gamePlayers = [NSMutableArray array];
    for (UIButton *button in choosePlayerButtons) {
        // Determine whether we have a new player.
        NSString *playerName = [[button titleLabel] text];
        Player *player = (Player *)[CoreDataUtilities entityForEntityName:@"Player"
                                                            attributeName:@"name"
                                                           attributeValue:playerName];
        if (!player) {
            // Create the new player.
            NSDictionary *playerAttributes = [NSDictionary dictionaryWithObject:playerName
                                                                         forKey:@"name"];
            player = (Player *)[CoreDataUtilities createEntityForEntityName:@"Player"
                                                        attributeDictionary:playerAttributes];

            // Add the new player to the app delegate's player collection.
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [[appDelegate players] addObject:player];
        }

        // Add the chosen players to this game.
        [gamePlayers addObject:player];
    }

    // Create a new game.
    Game *game = [CoreDataUtilities createGameForPlayers:gamePlayers];

    // Push the scorekeeping screen.
    Round *firstRound = [[game rounds] objectAtIndex:0];
    VisualScorekeepingViewController *scorekeepingViewController = [[VisualScorekeepingViewController alloc] initForRound:firstRound];
    [[self navigationController] pushViewController:scorekeepingViewController
                                           animated:YES];
}

@end
