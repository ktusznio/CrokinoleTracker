//
//  GameOptionsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataUtilities.h"
#import "Game.h"
#import "GameOptionsViewController.h"
#import "Player.h"
#import "PlayerSelectionViewController.h"
#import "Round.h"
#import "ScorekeepingViewController.h"

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
    NSMutableDictionary *gameAttributes = [NSMutableDictionary dictionary];
    [gameAttributes setValue:[NSDate date]
                      forKey:@"datePlayed"];
    [gameAttributes setValue:[NSOrderedSet orderedSetWithArray:gamePlayers]
                      forKey:@"players"];
    Game *game = (Game *)[CoreDataUtilities createEntityForEntityName:@"Game"
                                                  attributeDictionary:[NSDictionary dictionaryWithDictionary:gameAttributes]];

    // Create a new round for the game.
    NSMutableDictionary *roundAttributes = [NSMutableDictionary dictionary];
    [roundAttributes setValue:[NSNumber numberWithInt:1]
                       forKey:@"roundNumber"];
    [roundAttributes setValue:game
                       forKey:@"game"];
    [CoreDataUtilities createEntityForEntityName:@"Round"
                             attributeDictionary:roundAttributes];

    // Push the scorekeeping screen.
    ScorekeepingViewController *scorekeepingViewController = [[ScorekeepingViewController alloc] initForGame:game];
    [[self navigationController] pushViewController:scorekeepingViewController animated:YES];
}

@end
