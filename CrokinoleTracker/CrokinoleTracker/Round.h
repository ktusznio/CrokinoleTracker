//
//  Round.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;
@class Player;

@interface Round : NSManagedObject

@property (nonatomic, retain) NSMutableArray *discPositions;
@property (nonatomic, retain) NSNumber *playerOne20s;
@property (nonatomic, retain) NSNumber *playerOne15s;
@property (nonatomic, retain) NSNumber *playerOne10s;
@property (nonatomic, retain) NSNumber *playerOne5s;
@property (nonatomic, retain) NSNumber *playerTwo20s;
@property (nonatomic, retain) NSNumber *playerTwo15s;
@property (nonatomic, retain) NSNumber *playerTwo10s;
@property (nonatomic, retain) NSNumber *playerTwo5s;
@property (nonatomic, retain) Game *game;

- (int)scoreForPlayer:(Player *)player;
- (int)playerOneScore;
- (int)playerTwoScore;
- (int)fivesForPlayer:(Player *)player;
- (int)tensForPlayer:(Player *)player;
- (int)fifteensForPlayer:(Player *)player;
- (int)twentiesForPlayer:(Player *)player;

- (Player *)winner;

@end
