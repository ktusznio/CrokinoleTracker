//
//  BoardView.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "BoardView.h"

#import "AppDelegate.h"
#import "Game.h"
#import "Player.h"
#import "Round.h"

const double DISC_RADIUS = 7.5;
const double BOARD_X_INSET = 5;
const double BOARD_Y_INSET = 40;

@implementation BoardView

@synthesize round, boardCenter, discPositions;
@synthesize fifteensRadiusThreshold, tensRadiusThreshold, fivesRadiusThreshold;
@synthesize playerOneStartingGameScore, playerTwoStartingGameScore;
@synthesize playerColors;
@synthesize activePlayerSegmentControl;

- (id)initWithRound:(Round *)aRound andFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setRound:aRound];
        [self setPlayerOneStartingGameScore:[[round game] playerOneScoreAtRound:round]];
        [self setPlayerTwoStartingGameScore:[[round game] playerTwoScoreAtRound:round]];

        [self setDiscPositions:[NSMutableArray arrayWithObjects:[NSMutableArray array], [NSMutableArray array], nil]];

        [self setPlayerColors:[NSArray arrayWithObjects:[UIColor blackColor], [UIColor orangeColor], nil]];

        // Make the background transparent.
        [self setBackgroundColor:[UIColor clearColor]];

        // Create the player activation control.
        NSMutableArray *players = [(AppDelegate *)[[UIApplication sharedApplication] delegate] players];
        Player *playerOne = [players objectAtIndex:0];
        Player *playerTwo = [players objectAtIndex:1];

        NSString *playerOneSegmentLabel = [NSString stringWithFormat:@"%@ (%d)", [playerOne name], playerOneStartingGameScore];
        NSString *playerTwoSegmentLabel = [NSString stringWithFormat:@"%@ (%d)", [playerTwo name], playerTwoStartingGameScore];

        [self setActivePlayerSegmentControl:[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:playerOneSegmentLabel, playerTwoSegmentLabel, nil]]];
        [activePlayerSegmentControl setFrame:CGRectMake(0, 0, frame.size.width, 30)];
        [activePlayerSegmentControl setSelectedSegmentIndex:0];
        [self addSubview:activePlayerSegmentControl];

        // Calculate the center of the board.
        [self setBoardCenter:CGPointMake(frame.size.width / 2.0, BOARD_Y_INSET + (frame.size.width / 2.0))];

        // Calculate the radius scoring thresholds.
        double boardWidth = frame.size.width - (2 * BOARD_X_INSET);
        [self setFifteensRadiusThreshold:boardWidth / 6.0];
        [self setTensRadiusThreshold:boardWidth / 3.0];
        [self setFivesRadiusThreshold:boardWidth / 2.0];

        // Prepare a tap gesture recognizer for the board.
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(onBoardTap:)];
        [tapGestureRecognizer setDelegate:self];
        [self addGestureRecognizer:tapGestureRecognizer];
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);

    // Draw the board.
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);

    // First, the circles.
    double outerSquareWidth = 2 * fivesRadiusThreshold;
    CGRect outerSquare = CGRectMake(BOARD_X_INSET, BOARD_Y_INSET, outerSquareWidth, outerSquareWidth);
    CGContextAddEllipseInRect(context, outerSquare);

    double middleSquareWidth = 2 * tensRadiusThreshold;
    double middleSquareInset = (outerSquareWidth - middleSquareWidth) / 2.0;
    CGRect middleSquare = CGRectMake(BOARD_X_INSET + middleSquareInset, BOARD_Y_INSET + middleSquareInset, middleSquareWidth, middleSquareWidth);
    CGContextAddEllipseInRect(context, middleSquare);

    double innerSquareWidth = 2 * fifteensRadiusThreshold;
    double innerSquareInset = (outerSquareWidth - innerSquareWidth) / 2.0;
    CGRect innerRectangle = CGRectMake(BOARD_X_INSET + innerSquareInset, BOARD_Y_INSET + innerSquareInset, innerSquareWidth, innerSquareWidth);
    CGContextAddEllipseInRect(context, innerRectangle);

    // Next, the lines.
    // Did some sweet math to get these numbers.  God forbid they ever INCHWORM! GOD SPITS ON YOUR BRITTLE CODE!
    /*
    CGContextMoveToPoint(context, 40.15, 40.15);
    CGContextAddLineToPoint(context, 68.43, 68.43);

    CGContextMoveToPoint(context, 40.15, 209.85);
    CGContextAddLineToPoint(context, 68.43, 181.57);

    CGContextMoveToPoint(context, 209.85, 40.15);
    CGContextAddLineToPoint(context, 181.57, 68.43);

    CGContextMoveToPoint(context, 209.85, 209.85);
    CGContextAddLineToPoint(context, 181.57, 181.57);
    */

    CGContextStrokePath(context);

    // Finally, draw the discs.
    for (int i = 0; i < 2; i++) {
        NSMutableArray *discPositionArray = [[self discPositions] objectAtIndex:i];
        CGContextSetFillColorWithColor(context, ((UIColor *)[[self playerColors] objectAtIndex:i]).CGColor);
        for (NSValue *discPositionValue in discPositionArray) {
            CGPoint discPosition = [discPositionValue CGPointValue];
            CGContextFillEllipseInRect(context, CGRectMake(discPosition.x - DISC_RADIUS, discPosition.y - DISC_RADIUS, DISC_RADIUS * 2, DISC_RADIUS * 2));
        }
    }
}

- (double)calculateRadiusOfPosition:(CGPoint)position {
    double xSquared = (position.x - boardCenter.x) * (position.x - boardCenter.x);
    double ySquared = (position.y - boardCenter.y) * (position.y - boardCenter.y);
    return sqrt(xSquared + ySquared);
}

- (void)updateCountsForDiscWithCenterAtRadius:(double)radius
                                  playerIndex:(int)playerIndex {
    // Check the circles, starting from the inside.
    if (radius < fifteensRadiusThreshold - DISC_RADIUS) {
        if (playerIndex == 0) {
            [round setPlayerOne15s:[NSNumber numberWithInt:[[round playerOne15s] intValue] + 1]];
        } else {
            [round setPlayerTwo15s:[NSNumber numberWithInt:[[round playerTwo15s] intValue] + 1]];
        }
    } else if (radius < tensRadiusThreshold - DISC_RADIUS) {
        if (playerIndex == 0) {
            [round setPlayerOne10s:[NSNumber numberWithInt:[[round playerOne10s] intValue] + 1]];
        } else {
            [round setPlayerTwo10s:[NSNumber numberWithInt:[[round playerTwo10s] intValue] + 1]];
        }
    } else if (radius < fivesRadiusThreshold - DISC_RADIUS) {
        if (playerIndex == 0) {
            [round setPlayerOne5s:[NSNumber numberWithInt:[[round playerOne5s] intValue] + 1]];
        } else {
            [round setPlayerTwo5s:[NSNumber numberWithInt:[[round playerTwo5s] intValue] + 1]];
        }
    }

    [self updateScores];
}

- (void)updateScores {
    // Calculate the round score and update the game score labels.
    int playerOneRoundScore = 0;
    playerOneRoundScore += [[round playerOne20s] intValue] * 20;
    playerOneRoundScore += [[round playerOne15s] intValue] * 15;
    playerOneRoundScore += [[round playerOne10s] intValue] * 10;
    playerOneRoundScore += [[round playerOne5s] intValue] * 5;

    int playerTwoRoundScore = 0;
    playerTwoRoundScore += [[round playerTwo20s] intValue] * 20;
    playerTwoRoundScore += [[round playerTwo15s] intValue] * 15;
    playerTwoRoundScore += [[round playerTwo10s] intValue] * 10;
    playerTwoRoundScore += [[round playerTwo5s] intValue] * 5;

    if (playerOneRoundScore > playerTwoRoundScore) {
        playerOneRoundScore -= playerTwoRoundScore;
        playerTwoRoundScore = 0;
    } else if (playerOneRoundScore < playerTwoRoundScore) {
        playerTwoRoundScore -= playerOneRoundScore;
        playerOneRoundScore = 0;
    } else {
        playerOneRoundScore = 0;
        playerTwoRoundScore = 0;
    }

    int playerOneGameScore = playerOneStartingGameScore + playerOneRoundScore;
    int playerTwoGameScore = playerTwoStartingGameScore + playerTwoRoundScore;

    NSMutableArray *players = [(AppDelegate *)[[UIApplication sharedApplication] delegate] players];
    Player *playerOne = [players objectAtIndex:0];
    Player *playerTwo = [players objectAtIndex:1];

    NSString *playerOneSegmentLabel = [NSString stringWithFormat:@"%@ (%d)", [playerOne name], playerOneGameScore];
    NSString *playerTwoSegmentLabel = [NSString stringWithFormat:@"%@ (%d)", [playerTwo name], playerTwoGameScore];

    [activePlayerSegmentControl setTitle:playerOneSegmentLabel forSegmentAtIndex:0];
    [activePlayerSegmentControl setTitle:playerTwoSegmentLabel forSegmentAtIndex:1];
}

- (void)recreateDiscPositions:(NSMutableArray *)someDiscPositions {
    [self setDiscPositions:someDiscPositions];
    [round setPlayerOne15s:[NSNumber numberWithInt:0]];
    [round setPlayerOne10s:[NSNumber numberWithInt:0]];
    [round setPlayerOne5s:[NSNumber numberWithInt:0]];
    [round setPlayerTwo15s:[NSNumber numberWithInt:0]];
    [round setPlayerTwo10s:[NSNumber numberWithInt:0]];
    [round setPlayerTwo5s:[NSNumber numberWithInt:0]];

    for (int i = 0; i < 2; i++) {
        NSMutableArray *discPositionArray = [[self discPositions] objectAtIndex:i];
        for (NSValue *discPositionValue in discPositionArray) {
            CGPoint discPosition = [discPositionValue CGPointValue];
            [self updateCountsForDiscWithCenterAtRadius:[self calculateRadiusOfPosition:discPosition]
                                            playerIndex:i];
        }
    }
}

- (void)onBoardTap:(UITapGestureRecognizer *)sender {
    // If the tap is in bounds, add a disc position.
    CGPoint tapPosition = [sender locationInView:self];
    double radius = [self calculateRadiusOfPosition:tapPosition];
    if (radius < fivesRadiusThreshold - DISC_RADIUS && [self canDrawNewDiscAtPosition:tapPosition]) {
        int playerIndex = [activePlayerSegmentControl selectedSegmentIndex];
        [[[self discPositions] objectAtIndex:playerIndex] addObject:[NSValue valueWithCGPoint:tapPosition]];

        // Determine the value of the point and update the appropriate score.
        [self updateCountsForDiscWithCenterAtRadius:radius
                                        playerIndex:playerIndex];

        // Update the view.
        [self setNeedsDisplay];
    }
}

- (BOOL)canDrawNewDiscAtPosition:(CGPoint)newDiscPosition {
    // The given position needs to be 2*DISC_RADIUS away from all other disc positions.
    for (int playerIndex = 0; playerIndex < 2; playerIndex++) {
        NSMutableArray *playerDiscs = [[self discPositions] objectAtIndex:playerIndex];
        for (NSValue *discPositionValue in playerDiscs) {
            CGPoint discPosition = [discPositionValue CGPointValue];

            CGFloat dx = newDiscPosition.x - discPosition.x;
            CGFloat dy = newDiscPosition.y - discPosition.y;
            CGFloat distanceBetweenDiscs = sqrt(dx * dx + dy * dy);

            if (distanceBetweenDiscs < 2 * DISC_RADIUS) {
                return NO;
            }
        }
    }

    return YES;
}

- (void)removeLastDiscForActivePlayer {
    int activePlayerIndex = [activePlayerSegmentControl selectedSegmentIndex];
    NSMutableArray *playerDiscs = [[self discPositions] objectAtIndex:activePlayerIndex];
    if ([playerDiscs count] > 0) {
        [playerDiscs removeLastObject];
        [self setNeedsDisplay];
    }
}

@end
