//
//  GameStatistics.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-26.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "GameStatistics.h"

#import "Game.h"
#import "Player.h"
#import "Round.h"

@implementation GameStatistics

@synthesize game;
@synthesize playerOneRoundsWon;
@synthesize playerTwoRoundsWon;
@synthesize playerOnePointsPerRound;
@synthesize playerTwoPointsPerRound;
@synthesize playerOneTwenties;
@synthesize playerTwoTwenties;
@synthesize playerOneFifteens;
@synthesize playerTwoFifteens;
@synthesize playerOneTens;
@synthesize playerTwoTens;
@synthesize playerOneFives;
@synthesize playerTwoFives;

- (id)initForGame:(Game *)aGame {
    self = [super init];

    if (self) {
        game = aGame;

        int numRounds = [[game rounds] count];
        Player *playerOne = [[game players] objectAtIndex:0];
        Player *playerTwo = [[game players] objectAtIndex:1];

        // Initialize counters.
        int playerOneTotalPoints = 0;
        int playerTwoTotalPoints = 0;

        for (Round *round in [game rounds]) {
            // Increment rounds won counts.
            if ([round winner] == playerOne) {
                playerOneRoundsWon++;
            } else if ([round winner] == playerTwo) {
                playerTwoRoundsWon++;
            }

            // Increment point totals.
            playerOneTotalPoints += [round playerOneScore];
            playerTwoTotalPoints += [round playerTwoScore];

            // Increment shot counts.
            playerOneTwenties += [[round playerOne20s] intValue];
            playerTwoTwenties += [[round playerTwo20s] intValue];
            playerOneFifteens += [[round playerOne15s] intValue];
            playerTwoFifteens += [[round playerTwo15s] intValue];
            playerOneTens += [[round playerOne10s] intValue];
            playerTwoTens += [[round playerTwo10s] intValue];
            playerOneFives += [[round playerOne5s] intValue];
            playerTwoFives += [[round playerTwo5s] intValue];
        }

        // Set points per round for each player.
        playerOnePointsPerRound = (playerOneTotalPoints > 0) ? playerOneTotalPoints * 1.0 / numRounds : 0;
        playerTwoPointsPerRound = (playerTwoTotalPoints > 0) ? playerTwoTotalPoints * 1.0 / numRounds : 0;
    }

    return self;
}

@end
