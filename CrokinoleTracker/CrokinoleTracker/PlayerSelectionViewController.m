//
//  PlayerSelectionViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "PlayerSelectionViewController.h"

#import "AppDelegate.h"

@implementation PlayerSelectionViewController

@synthesize createPlayerTextField;
@synthesize existingPlayersTableView;

- (id)initWithButton:(UIButton *)aButton {
    self = [super init];

    if (self) {
        button = aButton;

        // Set the text on the navigation bar.
        [self setTitle:@"Choose Player"];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [self setCreatePlayerTextField:nil];
    [self setExistingPlayersTableView:nil];
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
    // Update the game options screen's button title.
    NSString *existingPlayerName = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
    [button setTitle:existingPlayerName forState:UIControlStateNormal];

    // Pop this view.
    [[self navigationController] popViewControllerAnimated:YES];
}

# pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Dismiss the keyboard when "return" is pressed.
    [textField resignFirstResponder];
    return NO;
}

# pragma mark -

- (IBAction)editingNewPlayerDidEnd:(id)sender {
    // Update the game options screen's button title.
    NSString *newPlayerName = [createPlayerTextField text];

    if ([newPlayerName length] > 0) {
        // Update the game options screen's button title.
        [button setTitle:newPlayerName forState:UIControlStateNormal];

        // Pop this view.
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

@end
