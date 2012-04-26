//
//  PlayerStatistics.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-25.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "Game.h"
#import "Player.h"
#import "PlayerStatistics.h"
#import "Round.h"

@implementation PlayerStatistics

@synthesize player;
@synthesize wins;
@synthesize losses;
@synthesize pointsPerGame;
@synthesize pointsPerRound;
@synthesize twentiesPerGame;
@synthesize twentiesPerRound;
@synthesize roundsPerGame;

- (id)initForPlayer:(Player *)aPlayer {
    self = [super init];

    if (self) {
        // Set the player.
        [self setPlayer:aPlayer];

        // Initialize counts.
        int totalWins = 0;
        int totalLosses = 0;
        int totalGames = [[[self player] games] count];
        int totalRounds = 0;
        int totalPoints = 0;
        int totalTwenties = 0;

        // Iterate through the player's games.
        for (Game *game in [[self player] games]) {
            // Increment the appropriate win/loss statistic.
            if ([game winningPlayer] == [self player]) {
                totalWins++;
            } else {
                totalLosses++;
            }

            // Add to the total number of rounds, points, and twenties.
            for (Round *round in [game rounds]) {
                totalRounds++;
                totalPoints += [round scoreForPlayer:[self player]];
                totalTwenties += [round twentiesForPlayer:[self player]];
            }
        }

        // Calculate averages.
        double avgPointsPerGame = (totalGames > 0) ? (totalPoints * 1.0 / totalGames) : 0;
        double avgPointsPerRound = (totalRounds > 0) ? (totalPoints * 1.0 / totalRounds) : 0;
        double avgTwentiesPerGame = (totalGames > 0) ? (totalTwenties * 1.0 / totalGames) : 0;
        double avgTwentiesPerRound = (totalRounds > 0) ? (totalTwenties * 1.0 / totalRounds) : 0;
        double avgRoundsPerGame = (totalGames > 0) ? (totalRounds * 1.0 / totalGames) : 0;

        // Set the properties using our results.
        [self setWins:totalWins];
        [self setLosses:totalLosses];
        [self setPointsPerGame:avgPointsPerGame];
        [self setPointsPerRound:avgPointsPerRound];
        [self setTwentiesPerGame:avgTwentiesPerGame];
        [self setTwentiesPerRound:avgTwentiesPerRound];
        [self setRoundsPerGame:avgRoundsPerGame];
    }

    return self;
}

@end
