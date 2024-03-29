//
//  CoreDataUtilities.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-19.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Game;

@interface CoreDataUtilities : NSObject

// CoreData helpers.
+ (NSArray *)fetchEntitiesForEntityName:(NSString *)entityName;
+ (NSManagedObject *)entityForEntityName:(NSString *)entityName
                           attributeName:(NSString *)attributeName
                          attributeValue:(NSString *)attributeValue;
+ (NSManagedObject *)createEntityForEntityName:(NSString *)entityName
                           attributeDictionary:(NSDictionary *)attributes;
+ (void)saveManagedContext;
+ (void)deleteEntity:(NSManagedObject *)entity;

// Game helpers.
+ (Game *)createGameForPlayers:(NSArray *)players;

@end
