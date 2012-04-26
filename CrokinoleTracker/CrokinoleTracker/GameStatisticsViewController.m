//
//  GameStatisticsViewController.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-25.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "Game.h"
#import "GameStatisticsViewController.h"
#import "Player.h"

@implementation GameStatisticsViewController

- (id)initForGame:(Game *)aGame {
    self = [super init];
    
    if (self) {
        game = aGame;
        
        // Set the text on the navigation bar.
        Player *playerOne = [[game players] objectAtIndex:0];
        Player *playerTwo = [[game players] objectAtIndex:1];
        [self setTitle:[NSString stringWithFormat:@"%@ vs %@", [playerOne name], [playerTwo name]]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
