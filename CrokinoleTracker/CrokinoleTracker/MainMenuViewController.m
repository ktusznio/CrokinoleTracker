//
//  MainMenuViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "GameOptionsViewController.h"
#import "MainMenuViewController.h"

@implementation MainMenuViewController
@synthesize playGameButton;

- (id)init {
    self = [super init];

    if (self) {
        // Set the text on the navigation bar.
        [self setTitle:@"Crokinole Tracker"];
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
    [self setPlayGameButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onPlayGameButtonTap:(id)sender {
    // Push the game options screen.
    GameOptionsViewController *gameOptionsViewController = [[GameOptionsViewController alloc] init];
    [[self navigationController] pushViewController:gameOptionsViewController animated:YES];
}

@end
