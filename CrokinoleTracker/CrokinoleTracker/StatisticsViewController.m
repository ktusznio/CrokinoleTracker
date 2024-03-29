//
//  StatisticsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "StatisticsViewController.h"

#import "AppDelegate.h"
#import "CoreDataUtilities.h"
#import "Game.h"
#import "GameStatisticsViewController.h"
#import "Player.h"
#import "PlayerStatisticsViewController.h"

@implementation StatisticsViewController

@synthesize playerAndGameTableView;

const int PLAYERS_SECTION = 0;
const int GAMES_SECTION = 1;

- (id)init {
    self = [super init];

    if (self) {
        // Set the text on the navigation bar.
        [self setTitle:@"Players & Games"];
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

- (void)viewDidUnload {
    [self setPlayerAndGameTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    // Reload the table data.
    [playerAndGameTableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // We have two sections: the list of players, and the list of games.
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (section == PLAYERS_SECTION) {
        return [NSString stringWithFormat:@"Players (%d)", [[appDelegate players] count]];
    } else if (section == GAMES_SECTION) {
        return [NSString stringWithFormat:@"Games (%d)", [[appDelegate games] count]];
    }

    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (section == PLAYERS_SECTION) {
        // The number of rows is equal to the number of existing players.
        return [[appDelegate players] count];
    } else if (section == GAMES_SECTION) {
        // The number of rows is equal to the number of existing games.
        return [[appDelegate games] count];
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if ([indexPath section] == PLAYERS_SECTION) {
        NSArray *players = [appDelegate players];

        // Get the player name at the given index.
        NSString *playerName = [[players objectAtIndex:[indexPath row]] name];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:playerName];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:playerName];
        }

        [[cell textLabel] setText:playerName];

        return cell;
    } else if ([indexPath section] == GAMES_SECTION) {
        NSArray *games = [appDelegate games];

        // Get the game at the given index.
        Game *game = [games objectAtIndex:[indexPath row]];
        Player *playerOne = [[game players] objectAtIndex:0];
        Player *playerTwo = [[game players] objectAtIndex:1];

        // Create the cell.
        NSString *cellId = [NSString stringWithFormat:@"Game%d", [indexPath row]];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }

        // Create the cell's label string.
        NSString *cellText = [NSString stringWithFormat:@"%@ %d - %d %@", [playerOne name], [game playerOneScore], [game playerTwoScore], [playerTwo name]];
        [[cell textLabel] setText:cellText];
        [[cell textLabel] setTextAlignment:UITextAlignmentCenter];

        return cell;
    }

    return nil;
}

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    UIViewController *statisticsViewController;
    if ([indexPath section] == PLAYERS_SECTION) {
        // Create the statistics view for the selected player.
        Player *player = [[appDelegate players] objectAtIndex:[indexPath row]];
        statisticsViewController = [[PlayerStatisticsViewController alloc] initForPlayer:player];
    } else if ([indexPath section] == GAMES_SECTION) {
        // Create the statistics view for the selected game.
        Game *game = [[appDelegate games] objectAtIndex:[indexPath row]];
        statisticsViewController = [[GameStatisticsViewController alloc] initForGame:game];
    }

    // Deselect the selected row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // Push the statistics view controller.
    [[self navigationController] pushViewController:statisticsViewController animated:YES];
}

@end
