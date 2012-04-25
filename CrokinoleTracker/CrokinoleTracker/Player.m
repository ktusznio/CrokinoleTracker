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
    int totalGames = [[self games] count];

    // If the player hasn't played any games, we don't need to do anything.
    if (totalGames == 0) {
        return 0;
    }

    int totalPoints = 0;

    // For each game, add the player's score to the running total.
    for (Game *game in [self games]) {
        totalPoints += [game scoreForPlayer:self];
    }

    return totalPoints * 1.0 / totalGames;
}

- (double)pointsPerRound {
    // If the player hasn't played any games, we don't need to do anything.
    if ([[self games] count] == 0) {
        return 0;
    }

    int totalPoints = 0;
    int totalRounds = 0;

    // For each game, add the player's score and the number of rounds to the running totals.
    for (Game *game in [self games]) {
        totalPoints += [game scoreForPlayer:self];
        totalRounds += [[game rounds] count];
    }

    // If, somehow, the player has a game on record but no rounds, we don't need to do anything.
    if (totalRounds == 0) {
        return 0;
    }

    return totalPoints * 1.0 / totalRounds;
}

- (double)twentiesPerGame {
    int totalGames = [[self games] count];

    // If the player hasn't played any games, we don't need to do anything.
    if (totalGames == 0) {
        return 0;
    }

    int totalTwenties = 0;

    // For each game, add the player's twenties to the running total.
    for (Game *game in [self games]) {
        totalTwenties += [game twentiesForPlayer:self];
    }

    return totalTwenties * 1.0 / totalGames;
}

- (double)twentiesPerRound {
    // If the player hasn't played any games, we don't need to do anything.
    if ([[self games] count] == 0) {
        return 0;
    }

    int totalTwenties = 0;
    int totalRounds = 0;

    // For each game, add the player's twenties and the number of rounds to the running totals.
    for (Game *game in [self games]) {
        totalTwenties += [game twentiesForPlayer:self];
        totalRounds += [[game rounds] count];
    }

    // If, somehow, the player has a game on record but no rounds, we don't need to do anything.
    if (totalRounds == 0) {
        return 0;
    }

    return totalTwenties * 1.0 / totalRounds;
}

@end
