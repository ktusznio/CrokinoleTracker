//
//  CoreDataUtilities.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-19.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "CoreDataUtilities.h"

#import "AppDelegate.h"

@implementation CoreDataUtilities

# pragma mark - CoreData

+ (NSArray *)fetchEntitiesForEntityName:(NSString *)entityName {
    // Get the managed object context from the app delegate.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    // Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    // Fetch the objects.
    NSError *error;
    NSArray *entities = [context executeFetchRequest:fetchRequest error:&error];

    // Handle any errors.
    if (error) {
        [NSException raise:@"Unable to fetch objects." format:@"Error: %s", [error description]];
    }

    return entities;
}

+ (NSManagedObject *)entityForEntityName:(NSString *)entityName
                           attributeName:(NSString *)attributeName
                          attributeValue:(NSString *)attributeValue {
    NSArray *entities = [CoreDataUtilities fetchEntitiesForEntityName:entityName];
    for (NSManagedObject *entity in entities) {
        NSString *value = (NSString *)[entity valueForKey:attributeName];
        if ([value isEqualToString:attributeValue]) {
            return entity;
        }
    }

    return nil;
}

+ (NSManagedObject *)createEntityForEntityName:(NSString *)entityName
                           attributeDictionary:(NSDictionary *)attributes {
    // Get the managed object context from the app delegate.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    // Create the entity object.
    NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                            inManagedObjectContext:context];

    // Assign its attributes.
    for (NSString *key in [attributes allKeys]) {
        [entity setValue:[attributes valueForKey:key]
                  forKey:key];
    }

    // Save and check for errors.
    NSError *error;
    if (![context save:&error]) {
        [NSException raise:@"Unable to create object." format:@"Error: %s", [error description]];
    }

    return entity;
}

+ (void)saveManagedContext {
    // Get the managed object context from the app delegate.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    // Save and check for errors.
    NSError *error;
    if (![context save:&error]) {
        [NSException raise:@"Unable to save context." format:@"Error: %s", [error description]];
    }
}

+ (void)deleteEntity:(NSManagedObject *)entity {
    // Get the managed object context from the app delegate.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    // Delete the entity.
    [context deleteObject:entity];

    // Save and check for errors.
    NSError *error;
    if (![context save:&error]) {
        [NSException raise:@"Unable to delete object." format:@"Error: %s", [error description]];
    }
}

#pragma mark - Game

+ (Game *)createGameForPlayers:(NSArray *)players {
    NSMutableDictionary *gameAttributes = [NSMutableDictionary dictionary];
    [gameAttributes setValue:[NSDate date]
                      forKey:@"datePlayed"];
    [gameAttributes setValue:[NSOrderedSet orderedSetWithArray:players]
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

    return game;
}

@end
