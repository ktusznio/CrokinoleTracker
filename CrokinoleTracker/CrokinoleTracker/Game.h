//
//  Game.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player;
@class Round;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSDate *datePlayed;
@property (nonatomic, retain) NSOrderedSet *rounds;
@property (nonatomic, retain) NSOrderedSet *players;

- (int)playerOneScore;
- (int)playerTwoScore;
- (Round *)currentRound;
- (Player *)winningPlayer;

@end

@interface Game (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inRoundsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRoundsAtIndex:(NSUInteger)idx;
- (void)insertRounds:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRoundsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRoundsAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceRoundsAtIndexes:(NSIndexSet *)indexes withRounds:(NSArray *)values;
- (void)addRoundsObject:(NSManagedObject *)value;
- (void)removeRoundsObject:(NSManagedObject *)value;
- (void)addRounds:(NSOrderedSet *)values;
- (void)removeRounds:(NSOrderedSet *)values;
- (void)insertObject:(Player *)value inPlayersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPlayersAtIndex:(NSUInteger)idx;
- (void)insertPlayers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePlayersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPlayersAtIndex:(NSUInteger)idx withObject:(Player *)value;
- (void)replacePlayersAtIndexes:(NSIndexSet *)indexes withPlayers:(NSArray *)values;
- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSOrderedSet *)values;
- (void)removePlayers:(NSOrderedSet *)values;

@end
