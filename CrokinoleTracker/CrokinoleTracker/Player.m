//
//  Player.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "Player.h"

@implementation Player

@dynamic name;
@dynamic games;

+ (NSArray *)fetchPlayers {
    // Get the managed object context from the app delegate.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Playa"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Fetch the player objects.
    NSError *error;
    NSArray *players = [context executeFetchRequest:fetchRequest error:&error];
    
    // Handle any errors.
    if (error) {
        [NSException raise:@"Unable to fetch players." format:@"Error: %s", [error description]];
    }
    
    return players;
}

@end
