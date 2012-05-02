//
//  GameStatistics.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-26.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Game;
@class Player;

@interface GameStatistics : NSObject {
    Game *game;

    int playerOneRoundsWon;
    int playerTwoRoundsWon;
    double playerOnePointsPerRound;
    double playerTwoPointsPerRound;
    int playerOneTwenties;
    int playerTwoTwenties;
    int playerOneFifteens;
    int playerTwoFifteens;
    int playerOneTens;
    int playerTwoTens;
    int playerOneFives;
    int playerTwoFives;
}

@property (strong, nonatomic) Game *game;

@property (nonatomic) int playerOneRoundsWon;
@property (nonatomic) int playerTwoRoundsWon;
@property (nonatomic) double playerOnePointsPerRound;
@property (nonatomic) double playerTwoPointsPerRound;
@property (nonatomic) int playerOneTwenties;
@property (nonatomic) int playerTwoTwenties;
@property (nonatomic) int playerOneFifteens;
@property (nonatomic) int playerTwoFifteens;
@property (nonatomic) int playerOneTens;
@property (nonatomic) int playerTwoTens;
@property (nonatomic) int playerOneFives;
@property (nonatomic) int playerTwoFives;

- (id)initForGame:(Game *)aGame;

@end
