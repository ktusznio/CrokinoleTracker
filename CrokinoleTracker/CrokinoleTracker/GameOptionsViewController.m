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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload {
    [self setChoosePlayerOneButton:nil];
    [self setChoosePlayerTwoButton:nil];
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
    [self presentModalViewController:playerSelectionViewController animated:YES];
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
