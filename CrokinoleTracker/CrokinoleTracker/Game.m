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

const int WINNING_SCORE = 100;

- (int)playerOneScore {
    int gameScore = 0;

    for (Round *round in [self rounds]) {
        int roundScore = 0;

        // Add up the round score player one achieved.
        roundScore += [[round playerOne20s] intValue] * 20;
        roundScore += [[round playerOne15s] intValue] * 15;
        roundScore += [[round playerOne10s] intValue] * 10;
        roundScore += [[round playerOne5s] intValue] * 5;

        // Subtract the round score player two achieved.
        roundScore -= [[round playerTwo20s] intValue] * 20;
        roundScore -= [[round playerTwo15s] intValue] * 15;
        roundScore -= [[round playerTwo10s] intValue] * 10;
        roundScore -= [[round playerTwo5s] intValue] * 5;

        // If the round score is negative, player one scored zero points this round.
        if (roundScore < 0) {
            roundScore = 0;
        }

        // Add the round score to the game score.
        gameScore += roundScore;
    }

    return gameScore;
}

- (int)playerTwoScore {
    int gameScore = 0;

    for (Round *round in [self rounds]) {
        int roundScore = 0;

        // Add up the round score player two achieved.
        roundScore += [[round playerTwo20s] intValue] * 20;
        roundScore += [[round playerTwo15s] intValue] * 15;
        roundScore += [[round playerTwo10s] intValue] * 10;
        roundScore += [[round playerTwo5s] intValue] * 5;

        // Subtract the round score player one achieved.
        roundScore -= [[round playerOne20s] intValue] * 20;
        roundScore -= [[round playerOne15s] intValue] * 15;
        roundScore -= [[round playerOne10s] intValue] * 10;
        roundScore -= [[round playerOne5s] intValue] * 5;

        // If the round score is negative, player two scored zero points this round.
        if (roundScore < 0) {
            roundScore = 0;
        }

        // Add the round score to the game score.
        gameScore += roundScore;
    }

    return gameScore;
}

- (Round *)currentRound {
    return (Round *)[[self rounds] lastObject];
}

- (Player *)winningPlayer {
    if ([self playerOneScore] >= WINNING_SCORE) {
        return [[self players] objectAtIndex:0];
    }

    if ([self playerTwoScore] >= WINNING_SCORE) {
        return [[self players] objectAtIndex:1];
    }

    return nil;
}

@end
