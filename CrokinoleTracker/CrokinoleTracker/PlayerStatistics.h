//
//  PlayerStatistics.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-25.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;

@interface PlayerStatistics : NSObject {
    Player *player;
    int wins;
    int losses;
    double pointsPerGame;
    double pointsPerRound;
    double twentiesPerGame;
    double twentiesPerRound;
    double roundsPerGame;
}

@property (strong, nonatomic) Player *player;
@property (nonatomic) int wins;
@property (nonatomic) int losses;
@property (nonatomic) double pointsPerGame;
@property (nonatomic) double pointsPerRound;
@property (nonatomic) double twentiesPerGame;
@property (nonatomic) double twentiesPerRound;
@property (nonatomic) double roundsPerGame;

- (id)initForPlayer:(Player *)player;

@end
