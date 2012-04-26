//
//  PlayerGameListViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-26.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "Game.h"
#import "GameStatisticsViewController.h"
#import "Player.h"
#import "PlayerGameListViewController.h"

@implementation PlayerGameListViewController

@synthesize gameTableView;

- (id)initForPlayer:(Player *)aPlayer {
    self = [super init];

    if (self) {
        player = aPlayer;

        // Set the text on the navigation bar.
        [self setTitle:[NSString stringWithFormat:@"%@'s Games", [player name]]];
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
    [self setGameTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    // Reload the table data.
    [gameTableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // We have one section: the list of the player's games.
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Games (%d)", [[player games] count]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // The number of rows is equal to the number of the player's games.
    return [[player games] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSOrderedSet *games = [player games];

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

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    // Create the statistics view for the selected game.
    Game *game = [[appDelegate games] objectAtIndex:[indexPath row]];
    GameStatisticsViewController *gameStatisticsViewController = [[GameStatisticsViewController alloc] initForGame:game];

    // Deselect the selected row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // Push the statistics view controller.
    [[self navigationController] pushViewController:gameStatisticsViewController animated:YES];
}

@end
