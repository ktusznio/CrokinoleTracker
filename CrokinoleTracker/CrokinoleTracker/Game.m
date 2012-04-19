//
//  Game.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "Game.h"
#import "Player.h"
#import "Round.h"

@implementation Game

@dynamic datePlayed;
@dynamic rounds;
@dynamic players;

- (int)playerOneScore {
    int score = 0;

    for (Round *round in [self rounds]) {
        score += [[round playerOne20s] intValue] * 20;
        score += [[round playerOne15s] intValue] * 15;
        score += [[round playerOne10s] intValue] * 10;
        score += [[round playerOne5s] intValue] * 5;
    }

    return score;
}

- (int)playerTwoScore {
    int score = 0;

    for (Round *round in [self rounds]) {
        score += [[round playerTwo20s] intValue] * 20;
        score += [[round playerTwo15s] intValue] * 15;
        score += [[round playerTwo10s] intValue] * 10;
        score += [[round playerTwo5s] intValue] * 5;
    }

    return score;
}


@end
