//
//  Round.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-18.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "Round.h"

#import <objc/message.h>

#import "CoreDataUtilities.h"
#import "Game.h"

@implementation Round

@synthesize discPositions;
@dynamic playerOne20s;
@dynamic playerOne15s;
@dynamic playerOne10s;
@dynamic playerOne5s;
@dynamic playerTwo20s;
@dynamic playerTwo15s;
@dynamic playerTwo10s;
@dynamic playerTwo5s;
@dynamic game;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];

    if (self) {
        [self setDiscPositions:[NSMutableArray arrayWithObjects:[NSMutableArray array], [NSMutableArray array], nil]];
    }

    return self;
}

- (int)scoreForPlayer:(Player *)player {
    if ([[[self game] players] objectAtIndex:0] == player) {
        return [self playerOneScore];
    } else if ([[[self game] players] objectAtIndex:1] == player) {
        return [self playerTwoScore];
    }

    return 0;
}

- (int)playerOneScore {
    int roundScore = 0;

    // Add up the round score player one achieved.
    roundScore += [[self playerOne20s] intValue] * 20;
    roundScore += [[self playerOne15s] intValue] * 15;
    roundScore += [[self playerOne10s] intValue] * 10;
    roundScore += [[self playerOne5s] intValue] * 5;

    // Subtract the round score player two achieved.
    roundScore -= [[self playerTwo20s] intValue] * 20;
    roundScore -= [[self playerTwo15s] intValue] * 15;
    roundScore -= [[self playerTwo10s] intValue] * 10;
    roundScore -= [[self playerTwo5s] intValue] * 5;

    // If the round score is negative, player one scored zero points this round.
    if (roundScore < 0) {
        roundScore = 0;
    }

    return roundScore;
}

- (int)playerTwoScore {
    int roundScore = 0;

    // Add up the round score player two achieved.
    roundScore += [[self playerTwo20s] intValue] * 20;
    roundScore += [[self playerTwo15s] intValue] * 15;
    roundScore += [[self playerTwo10s] intValue] * 10;
    roundScore += [[self playerTwo5s] intValue] * 5;

    // Subtract the round score player one achieved.
    roundScore -= [[self playerOne20s] intValue] * 20;
    roundScore -= [[self playerOne15s] intValue] * 15;
    roundScore -= [[self playerOne10s] intValue] * 10;
    roundScore -= [[self playerOne5s] intValue] * 5;

    // If the round score is negative, player two scored zero points this round.
    if (roundScore < 0) {
        roundScore = 0;
    }

    return roundScore;
}

- (int)fivesForPlayer:(Player *)player {
    if ([[[self game] players] objectAtIndex:0] == player) {
        return [[self playerOne5s] intValue];
    } else if ([[[self game] players] objectAtIndex:1] == player) {
        return [[self playerTwo5s] intValue];
    }

    return 0;
}

- (int)tensForPlayer:(Player *)player {
    if ([[[self game] players] objectAtIndex:0] == player) {
        return [[self playerOne10s] intValue];
    } else if ([[[self game] players] objectAtIndex:1] == player) {
        return [[self playerTwo10s] intValue];
    }

    return 0;
}

- (int)fifteensForPlayer:(Player *)player {
    if ([[[self game] players] objectAtIndex:0] == player) {
        return [[self playerOne15s] intValue];
    } else if ([[[self game] players] objectAtIndex:1] == player) {
        return [[self playerTwo15s] intValue];
    }

    return 0;
}

- (int)twentiesForPlayer:(Player *)player {
    if ([[[self game] players] objectAtIndex:0] == player) {
        return [[self playerOne20s] intValue];
    } else if ([[[self game] players] objectAtIndex:1] == player) {
        return [[self playerTwo20s] intValue];
    }

    return 0;
}


- (void)adjustCounter:(int)counterValue
          playerIndex:(int)playerIndex
            increment:(BOOL)incrementFlag {
    NSString *player = (playerIndex == 0) ? @"playerOne" : @"playerTwo";

    NSString *counter;
    switch (counterValue) {
        case 20:
            counter = @"20s";
            break;
        case 15:
            counter = @"15s";
            break;
        case 10:
            counter = @"10s";
            break;
        case 5:
            counter = @"5s";
            break;
        default:
            break;
    }

    SEL getSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", player, counter]);
    SEL setSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@@", player, counter]);

    int currentValue = [(NSNumber *)objc_msgSend(self, getSelector) intValue];
    int newValue = (incrementFlag) ? currentValue + 1 : currentValue - 1;

    objc_msgSend(self, setSelector, [NSNumber numberWithInt:newValue]);
}

- (Player *)winner {
    int playerOneScore = [self playerOneScore];
    int playerTwoScore = [self playerTwoScore];

    if (playerOneScore > playerTwoScore) {
        return [[[self game] players] objectAtIndex:0];
    } else if (playerTwoScore > playerOneScore) {
        return [[[self game] players] objectAtIndex:1];
    }

    // Tie; no winner.
    return nil;
}

@end
