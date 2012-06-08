//
//  Player.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@class PlayerStatistics;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSOrderedSet *games;

- (PlayerStatistics *)statistics;

@end

@interface Player (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inGamesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGamesAtIndex:(NSUInteger)idx;
- (void)insertGames:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGamesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGamesAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceGamesAtIndexes:(NSIndexSet *)indexes withGames:(NSArray *)values;
- (void)addGamesObject:(NSManagedObject *)value;
- (void)removeGamesObject:(NSManagedObject *)value;
- (void)addGames:(NSOrderedSet *)values;
- (void)removeGames:(NSOrderedSet *)values;

@end
