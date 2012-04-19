//
//  GameOptionsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "GameOptionsViewController.h"
#import "PlayerSelectionViewController.h"

@implementation GameOptionsViewController

- (id)init {
    self = [super init];

    if (self) {
        // Custom initialization.
        [self setTitle:@"Game Options"];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload {
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
    // Fetch or create players.

    // Create a new game.

    // Create a new round for the game.

    // Push the scorekeeping screen.
}

@end
