//
//  Player.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "Player.h"

#import "Game.h"
#import "PlayerStatistics.h"
#import "Round.h"

@implementation Player

@dynamic name;
@dynamic games;

- (PlayerStatistics *)statistics {
    return [[PlayerStatistics alloc] initForPlayer:self];
}

@end
