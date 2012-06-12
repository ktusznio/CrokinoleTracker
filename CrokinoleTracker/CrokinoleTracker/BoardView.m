//
//  BoardView.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "BoardView.h"

#import "Game.h"
#import "Player.h"
#import "Round.h"

const double DISC_RADIUS = 7.5;
const double BOARD_Y_INSET = 35;

@implementation BoardView

@synthesize round, boardCenter;
@synthesize fifteensRadiusThreshold, tensRadiusThreshold, fivesRadiusThreshold;
@synthesize playerOneStartingGameScore, playerTwoStartingGameScore;
@synthesize playerColors;
@synthesize activePlayerSegmentControl;

- (id)initWithFrame:(CGRect)frame
              round:(Round *)aRound {
    self = [super initWithFrame:frame];

    if (self) {
        [self setRound:aRound];
        [self setPlayerOneStartingGameScore:[[round game] playerOneScoreAtRound:round]];
        [self setPlayerTwoStartingGameScore:[[round game] playerTwoScoreAtRound:round]];

        [self setPlayerColors:[NSArray arrayWithObjects:[UIColor blackColor], [UIColor orangeColor], nil]];

        // Make the background transparent.
        [self setBackgroundColor:[UIColor clearColor]];

        // Create the player activation control.
        [self setActivePlayerSegmentControl:[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", @"", nil]]];
        [activePlayerSegmentControl setFrame:CGRectMake(0, 0, frame.size.width, 30)];
        [activePlayerSegmentControl setSelectedSegmentIndex:0];
        [self addSubview:activePlayerSegmentControl];

        // Calculate the radius scoring thresholds.
        double boardWidth = frame.size.width;
        [self setFifteensRadiusThreshold:boardWidth / 6.0];
        [self setTensRadiusThreshold:boardWidth / 3.0];
        [self setFivesRadiusThreshold:boardWidth / 2.0];

        // Calculate the center of the board.
        double boardCenterX = frame.size.width / 2.0;
        double boardCenterY = BOARD_Y_INSET + (boardWidth / 2.0);
        [self setBoardCenter:CGPointMake(boardCenterX, boardCenterY)];

        // Prepare a tap gesture recognizer for the board.
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(onBoardTap:)];
        [tapGestureRecognizer setDelegate:self];
        [self addGestureRecognizer:tapGestureRecognizer];
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    [self updateScores];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);

    // Draw the board.
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);

    // First, the circles.
    double outerSquareWidth = 2 * fivesRadiusThreshold;
    CGRect outerSquare = CGRectMake(0, BOARD_Y_INSET, outerSquareWidth, outerSquareWidth);
    CGContextAddEllipseInRect(context, outerSquare);

    double middleSquareWidth = 2 * tensRadiusThreshold;
    double middleSquareInset = (outerSquareWidth - middleSquareWidth) / 2.0;
    CGRect middleSquare = CGRectMake(middleSquareInset, BOARD_Y_INSET + middleSquareInset, middleSquareWidth, middleSquareWidth);
    CGContextAddEllipseInRect(context, middleSquare);

    double innerSquareWidth = 2 * fifteensRadiusThreshold;
    double innerSquareInset = (outerSquareWidth - innerSquareWidth) / 2.0;
    CGRect innerRectangle = CGRectMake(innerSquareInset, BOARD_Y_INSET + innerSquareInset, innerSquareWidth, innerSquareWidth);
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
        NSMutableArray *discPositionArray = [[round discPositions] objectAtIndex:i];
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

- (void)updateScores {
    // Calculate the round score and update the game score labels.
    int playerOneRoundScore = [round playerOneScore];
    int playerTwoRoundScore = [round playerTwoScore];
    int playerOneGameScore = playerOneStartingGameScore + playerOneRoundScore;
    int playerTwoGameScore = playerTwoStartingGameScore + playerTwoRoundScore;

    Player *playerOne = [[[round game] players] objectAtIndex:0];
    Player *playerTwo = [[[round game] players] objectAtIndex:1];
    NSString *playerOneSegmentLabel = [NSString stringWithFormat:@"%@ (%d)", [playerOne name], playerOneGameScore];
    NSString *playerTwoSegmentLabel = [NSString stringWithFormat:@"%@ (%d)", [playerTwo name], playerTwoGameScore];

    [activePlayerSegmentControl setTitle:playerOneSegmentLabel forSegmentAtIndex:0];
    [activePlayerSegmentControl setTitle:playerTwoSegmentLabel forSegmentAtIndex:1];
}

- (void)onBoardTap:(UITapGestureRecognizer *)sender {
    // If the tap is in bounds, add a disc position.
    CGPoint tapPosition = [sender locationInView:self];
    double radius = [self calculateRadiusOfPosition:tapPosition];
    if (radius < fivesRadiusThreshold - DISC_RADIUS && [self canDrawNewDiscAtPosition:tapPosition]) {
        int playerIndex = [activePlayerSegmentControl selectedSegmentIndex];
        [[[round discPositions] objectAtIndex:playerIndex] addObject:[NSValue valueWithCGPoint:tapPosition]];

        // Determine the value of the point and update the appropriate score.
        [round adjustCounter:[self valueForPoint:tapPosition]
                 playerIndex:playerIndex
                   increment:YES];

        // Update the view.
        [self setNeedsDisplay];
    }
}

- (BOOL)canDrawNewDiscAtPosition:(CGPoint)newDiscPosition {
    // The given position needs to be 2*DISC_RADIUS away from all other disc positions.
    for (int playerIndex = 0; playerIndex < 2; playerIndex++) {
        NSMutableArray *playerDiscs = [[round discPositions] objectAtIndex:playerIndex];
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
    NSMutableArray *playerDiscs = [[round discPositions] objectAtIndex:activePlayerIndex];
    if ([playerDiscs count] > 0) {
        CGPoint lastPoint = [(NSValue *)[[[round discPositions] objectAtIndex:activePlayerIndex] lastObject] CGPointValue];
        [round adjustCounter:[self valueForPoint:lastPoint]
                 playerIndex:activePlayerIndex
                   increment:NO];

        [playerDiscs removeLastObject];
        [self setNeedsDisplay];
    }
}

- (int)valueForPoint:(CGPoint)point {
    double radius = [self calculateRadiusOfPosition:point];

    if (radius < fifteensRadiusThreshold - DISC_RADIUS) {
        return 15;
    } else if (radius < tensRadiusThreshold - DISC_RADIUS) {
        return 10;
    } else if (radius < fivesRadiusThreshold - DISC_RADIUS) {
        return 5;
    }

    return 0;
}

@end
