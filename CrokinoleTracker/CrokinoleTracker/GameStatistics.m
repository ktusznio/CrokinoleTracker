//
//  GameStatistics.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio on 12-04-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameStatistics.h"

#import "Game.h"
#import "Player.h"
#import "Round.h"

@implementation GameStatistics

- (id)initForGame:(Game *)aGame {
    self = [super init];

    if (self) {
        game = aGame;
    }

    return self;
}

- (int)roundsWonForPlayer:(Player *)player {
    int roundsWon = 0;

    for (Round *round in [game rounds]) {
        if ([round winner] == player) {
            roundsWon++;
        }
    }

    return roundsWon;
}

- (double)pointsPerRoundForPlayer:(Player *)player {
    if ([[game rounds] count] <= 0) {
        return 0;
    }

    return [game scoreForPlayer:player] / (1.0 * [[game rounds] count]);
}

- (int)twentiesForPlayer:(Player *)player {
    int twenties = 0;

    for (Round *round in [game rounds]) {
        twenties += [round twentiesForPlayer:player];
    }

    return twenties;
}

- (int)fifteensForPlayer:(Player *)player {
    int fifteens = 0;

    for (Round *round in [game rounds]) {
        fifteens += [round fifteensForPlayer:player];
    }

    return fifteens;
}

- (int)tensForPlayer:(Player *)player {
    int tens = 0;

    for (Round *round in [game rounds]) {
        tens += [round tensForPlayer:player];
    }

    return tens;
}

- (int)fivesForPlayer:(Player *)player {
    int fives = 0;

    for (Round *round in [game rounds]) {
        fives += [round fivesForPlayer:player];
    }

    return fives;
}

@end
