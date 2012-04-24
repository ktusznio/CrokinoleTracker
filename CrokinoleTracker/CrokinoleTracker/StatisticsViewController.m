//
//  StatisticsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "CoreDataUtilities.h"
#import "StatisticsViewController.h"

@implementation StatisticsViewController

@synthesize gamesPlayedLabel;

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

    // Determine the number of played games and write it to the label.
    NSArray *games = [CoreDataUtilities fetchEntitiesForEntityName:@"Game"];
    [gamesPlayedLabel setText:[NSString stringWithFormat:@"Games played: %d", [games count]]];
}

- (void)viewDidUnload {
    [self setGamesPlayedLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
