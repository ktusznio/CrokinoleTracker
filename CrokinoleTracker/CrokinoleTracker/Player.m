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

    // For each game, increment the win count if this player won.
    for (Game *game in [self games]) {
        if ([game winningPlayer] == self) {
            wins++;
        }
    }

    return wins;
}

- (int)losses {
    int losses = 0;

    // For each game, increment the loss count if this player lost.
    for (Game *game in [self games]) {
        if ([game winningPlayer] != self) {
            losses++;
        }
    }

    return losses;
}

- (double)pointsPerGame {
    int totalPoints = 0;

    // For each game, add the player's score to the running total.
    for (Game *game in [self games]) {
        if ([[game players] objectAtIndex:0] == self) {
            totalPoints += [game playerOneScore];
        } else if ([[game players] objectAtIndex:1] == self) {
            totalPoints += [game playerTwoScore];
        } else {
            // This shouldn't happen; this game is in the player's list, but the player isn't listed in the game.
        }
    }

    return totalPoints * 1.0 / [[self games] count];
}

- (double)pointsPerRound {
    int totalPoints = 0;
    int totalRounds = 0;

    // For each game, add the player's score and the total number of rounds to the running totals.
    for (Game *game in [self games]) {
        if ([[game players] objectAtIndex:0] == self) {
            totalPoints += [game playerOneScore];
        } else if ([[game players] objectAtIndex:1] == self) {
            totalPoints += [game playerTwoScore];
        } else {
            // This shouldn't happen; this game is in the player's list, but the player isn't listed in the game.
        }

        totalRounds += [[game rounds] count];
    }

    return totalPoints * 1.0 / totalRounds;
}

@end
