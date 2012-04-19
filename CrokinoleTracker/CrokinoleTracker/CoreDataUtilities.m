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

@end
