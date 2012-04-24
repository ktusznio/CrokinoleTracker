//
//  Player.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "Game.h"
#import "Player.h"

@implementation Player

@dynamic name;
@dynamic games;

- (int)wins {
    int wins = 0;

    for (Game *game in [self games]) {
        if ([game winningPlayer] == self) {
            wins++;
        }
    }

    return wins;
}

- (int)losses {
    int losses = 0;

    for (Game *game in [self games]) {
        if ([game winningPlayer] != self) {
            losses++;
        }
    }

    return losses;
}

@end
