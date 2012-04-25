//
//  StatisticsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataUtilities.h"
#import "PlayerStatisticsViewController.h"
#import "StatisticsViewController.h"

@implementation StatisticsViewController

@synthesize gamesPlayedLabel;
@synthesize playerTableView;

- (id)init {
    self = [super init];

    if (self) {
        // Set the text on the navigation bar.
        [self setTitle:@"Statistics"];
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

    // Determine the number of played games and write it to the label.
    NSArray *games = [CoreDataUtilities fetchEntitiesForEntityName:@"Game"];
    [gamesPlayedLabel setText:[NSString stringWithFormat:@"Total games played: %d", [games count]]];
}

- (void)viewDidUnload {
    [self setGamesPlayedLabel:nil];
    [self setPlayerTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // We only have one section: the list of players.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // The number of rows is equal to the number of existing players.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [[appDelegate players] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray *players = [appDelegate players];

    // Get the player name at the given index.
    NSString *playerName = [[players objectAtIndex:[indexPath row]] name];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:playerName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:playerName];
    }

    [[cell textLabel] setText:playerName];

    return cell;
}

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Fetch the selected player.
    NSString *playerName = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    Player *player = (Player *)[CoreDataUtilities entityForEntityName:@"Player"
                                                        attributeName:@"name"
                                                       attributeValue:playerName];

    // Create and push the statistics screen for the selected player.
    PlayerStatisticsViewController *playerStatisticsViewController = [[PlayerStatisticsViewController alloc] initForPlayer:player];
    [[self navigationController] pushViewController:playerStatisticsViewController animated:YES];

    // Deselect the selected row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
