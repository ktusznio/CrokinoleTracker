//
//  GameStatistics.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio on 12-04-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Game;
@class Player;

@interface GameStatistics : NSObject {
    Game *game;
}

- (id)initForGame:(Game *)aGame;

- (int)roundsWonForPlayer:(Player *)player;
- (double)pointsPerRoundForPlayer:(Player *)player;
- (int)twentiesForPlayer:(Player *)player;
- (int)fifteensForPlayer:(Player *)player;
- (int)tensForPlayer:(Player *)player;
- (int)fivesForPlayer:(Player *)player;

@end
