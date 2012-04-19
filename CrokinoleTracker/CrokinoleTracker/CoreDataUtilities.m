//
//  CoreDataUtilities.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-19.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataUtilities.h"

@implementation CoreDataUtilities

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

@end
