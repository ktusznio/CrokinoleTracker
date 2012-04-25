//
//  PlayerStatistics.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-25.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "PlayerStatistics.h"

@implementation PlayerStatistics

@synthesize player;
@synthesize wins;
@synthesize losses;
@synthesize pointsPerGame;
@synthesize pointsPerRound;
@synthesize twentiesPerGame;
@synthesize twentiesPerRound;

- (id)initForPlayer:(Player *)aPlayer {
    self = [super init];

    if (self) {
        [self setPlayer:aPlayer];
    }

    return self;
}

@end
