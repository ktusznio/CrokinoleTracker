//
//  Player.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "Game.h"
#import "Player.h"
#import "PlayerStatistics.h"
#import "Round.h"

@implementation Player

@dynamic name;
@dynamic games;

- (PlayerStatistics *)statistics {
    PlayerStatistics *playerStatistics = [[PlayerStatistics alloc] initForPlayer:self];

    int wins = 0;
    int losses = 0;
    int totalGames = [[self games] count];
    int totalRounds = 0;
    int totalPoints = 0;
    int totalTwenties = 0;

    for (Game *game in [self games]) {
        // Increment the appropriate win/loss statistic.
        if ([game winningPlayer] == self) {
            wins++;
        } else {
            losses++;
        }

        // Determine the total number of rounds, points, and twenties.
        for (Round *round in [game rounds]) {
            totalRounds++;
            totalPoints += [round scoreForPlayer:self];
            totalTwenties += [round twentiesForPlayer:self];
        }
    }

    double pointsPerGame = (totalGames > 0) ? (totalPoints * 1.0 / totalGames) : 0;
    double pointsPerRound = (totalRounds > 0) ? (totalPoints * 1.0 / totalRounds) : 0;
    double twentiesPerGame = (totalGames > 0) ? (totalTwenties * 1.0 / totalGames) : 0;
    double twentiesPerRound = (totalRounds > 0) ? (totalTwenties * 1.0 / totalRounds) : 0;

    [playerStatistics setWins:wins];
    [playerStatistics setLosses:losses];
    [playerStatistics setPointsPerGame:pointsPerGame];
    [playerStatistics setPointsPerRound:pointsPerRound];
    [playerStatistics setTwentiesPerGame:twentiesPerGame];
    [playerStatistics setTwentiesPerRound:twentiesPerRound];

    return playerStatistics;
}

@end
