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
const double SEGMENT_CONTROL_HEIGHT = 30;

@implementation BoardView

@synthesize round, boardCenter, boardYInset;
@synthesize twentiesRadiusThreshold, fifteensRadiusThreshold, tensRadiusThreshold, fivesRadiusThreshold;
@synthesize twentiesCircleBounds, outerCircleBounds, middleCircleBounds, innerCircleBounds;
@synthesize playerOneStartingGameScore, playerTwoStartingGameScore;
@synthesize playerColors, lineWidth;
@synthesize activePlayerSegmentControl;

- (id)initWithFrame:(CGRect)frame
              round:(Round *)aRound {
    self = [super initWithFrame:frame];

    if (self) {
        [self setRound:aRound];
        [self setPlayerOneStartingGameScore:[[round game] playerOneScoreAtRound:round]];
        [self setPlayerTwoStartingGameScore:[[round game] playerTwoScoreAtRound:round]];

        [self setPlayerColors:[NSArray arrayWithObjects:[UIColor blackColor], [UIColor orangeColor], nil]];
        [self setLineWidth:2.0];

        // Make the background transparent.
        [self setBackgroundColor:[UIColor clearColor]];

        // Create the player activation control.
        [self setActivePlayerSegmentControl:[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"", @"", nil]]];
        [activePlayerSegmentControl setFrame:CGRectMake(0, 0, frame.size.width, SEGMENT_CONTROL_HEIGHT)];
        [activePlayerSegmentControl setSelectedSegmentIndex:0];
        [self addSubview:activePlayerSegmentControl];

        // Calculate the radius scoring thresholds.
        double boardWidth = frame.size.width;
        [self setTwentiesRadiusThreshold:DISC_RADIUS + 6.0];
        [self setFifteensRadiusThreshold:boardWidth / 6.0];
        [self setTensRadiusThreshold:boardWidth / 3.0];
        [self setFivesRadiusThreshold:boardWidth / 2.0];

        // Calculate the board's y inset, used to vertically center-align the board.
        [self setBoardYInset:(frame.size.height - (2 * fivesRadiusThreshold) + SEGMENT_CONTROL_HEIGHT) / 2.0];

        // Calculate the circle bounds.
        double outerSquareWidth = 2 * fivesRadiusThreshold;
        // The outer square needs to account for the line width so that the circle isn't clipped.
        [self setOuterCircleBounds:CGRectMake(lineWidth, boardYInset, outerSquareWidth - (2 * lineWidth), outerSquareWidth)];

        double middleSquareWidth = 2 * tensRadiusThreshold;
        double middleSquareInset = (outerSquareWidth - middleSquareWidth) / 2.0;
        [self setMiddleCircleBounds:CGRectMake(middleSquareInset, boardYInset + middleSquareInset, middleSquareWidth, middleSquareWidth)];

        double innerSquareWidth = 2 * fifteensRadiusThreshold;
        double innerSquareInset = (outerSquareWidth - innerSquareWidth) / 2.0;
        [self setInnerCircleBounds:CGRectMake(innerSquareInset, boardYInset + innerSquareInset, innerSquareWidth, innerSquareWidth)];

        double twentiesSquareWidth = 2 * twentiesRadiusThreshold;
        double twentiesSquareInset = (outerSquareWidth - twentiesSquareWidth) / 2.0;
        [self setTwentiesCircleBounds:CGRectMake(twentiesSquareInset, boardYInset + twentiesSquareInset, twentiesSquareWidth, twentiesSquareWidth)];

        // Calculate the center of the board.
        double boardCenterX = frame.size.width / 2.0;
        double boardCenterY = boardYInset + (boardWidth / 2.0);
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
    CGContextSetLineWidth(context, lineWidth);

    // Draw the board.
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);

    // First, the circles.
    CGContextAddEllipseInRect(context, outerCircleBounds);
    CGContextAddEllipseInRect(context, middleCircleBounds);
    CGContextAddEllipseInRect(context, innerCircleBounds);
    CGContextAddEllipseInRect(context, twentiesCircleBounds);

    // Next, the lines.
    // We simply need to calculate the offsets to add to and subtract from the center point.
    // Then we can draw lines using the appropriate combinations of these points.
    double boardCenterX = [self boardCenter].x;
    double boardCenterY = [self boardCenter].y;
    double outerPointOffset = sqrt([self fivesRadiusThreshold] * [self fivesRadiusThreshold] / 2);
    double innerPointOffset = sqrt([self tensRadiusThreshold] * [self tensRadiusThreshold] / 2);

    // Draw the top left line.
    CGContextMoveToPoint(context, boardCenterX - outerPointOffset, boardCenterY - outerPointOffset);
    CGContextAddLineToPoint(context, boardCenterX - innerPointOffset, boardCenterY - innerPointOffset);

    // Draw the top right line.
    CGContextMoveToPoint(context, boardCenterX + outerPointOffset, boardCenterY - outerPointOffset);
    CGContextAddLineToPoint(context, boardCenterX + innerPointOffset, boardCenterY - innerPointOffset);

    // Draw the bottom left line.
    CGContextMoveToPoint(context, boardCenterX - outerPointOffset, boardCenterY + outerPointOffset);
    CGContextAddLineToPoint(context, boardCenterX - innerPointOffset, boardCenterY + innerPointOffset);

    // Draw the bottom right line.
    CGContextMoveToPoint(context, boardCenterX + outerPointOffset, boardCenterY + outerPointOffset);
    CGContextAddLineToPoint(context, boardCenterX + innerPointOffset, boardCenterY + innerPointOffset);

    CGContextStrokePath(context);

    // Finally, draw the discs.
    for (int i = 0; i < 2; i++) {
        NSMutableArray *discPositionArray = [[round discPositions] objectAtIndex:i];
        CGContextSetFillColorWithColor(context, ((UIColor *)[[self playerColors] objectAtIndex:i]).CGColor);
        for (NSValue *discPositionValue in discPositionArray) {
            CGPoint discPosition = [discPositionValue CGPointValue];

            // Draw discs outside the 20s circle.
            if ([self valueForPoint:discPosition] < 20) {
                CGContextFillEllipseInRect(context, CGRectMake(discPosition.x - DISC_RADIUS, discPosition.y - DISC_RADIUS, DISC_RADIUS * 2, DISC_RADIUS * 2));
            }
        }
    }
}

- (double)radiusOfPosition:(CGPoint)position {
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
    CGPoint tapPosition = [sender locationInView:self];
    if ([self shouldConsiderDrawingNewDiscAtPosition:tapPosition]) {
        // Check for disc collisions.
        CGPoint adjustedDiscPosition = tapPosition;
        NSValue *collidingDiscValue = [self discThatCollidesWithDiscAtPosition:adjustedDiscPosition];
        if (collidingDiscValue) {
            // Try to adjust the new disc position to avoid the collision.
            adjustedDiscPosition = [self adjustedPositionForNewDisc:adjustedDiscPosition
                                                  collidingWithDisc:[collidingDiscValue CGPointValue]];

            // Ignore the tap if adjusting the position still causes collisions.
            if ([self discThatCollidesWithDiscAtPosition:adjustedDiscPosition]) {
                return;
            }
        }

        // Add the disc for the selected player.
        int playerIndex = [activePlayerSegmentControl selectedSegmentIndex];
        [[[round discPositions] objectAtIndex:playerIndex] addObject:[NSValue valueWithCGPoint:adjustedDiscPosition]];

        // Determine the value of the point and update the appropriate score.
        [round adjustCounter:[self valueForPoint:adjustedDiscPosition]
                 playerIndex:playerIndex
                   increment:YES];

        // Update the view.
        [self setNeedsDisplay];
    }
}

- (BOOL)shouldConsiderDrawingNewDiscAtPosition:(CGPoint)position {
    // The new disc needs to be inside the board.
    if ([self radiusOfPosition:position] >= (fivesRadiusThreshold - DISC_RADIUS)) {
        return NO;
    }

    // The tap must not be on the same point as the center of an existing disc, unless the discs are twenties which aren't drawn.
    if ([self valueForPoint:position] < 20) {
        for (int playerIndex = 0; playerIndex < 2; playerIndex++) {
            NSArray *playerDiscs = [[round discPositions] objectAtIndex:playerIndex];
            for (NSValue *discPositionValue in playerDiscs) {
                CGPoint discPosition = [discPositionValue CGPointValue];

                if (CGPointEqualToPoint(position, discPosition)) {
                    return NO;
                }
            }
        }
    }

    return YES;
}

- (NSValue *)discThatCollidesWithDiscAtPosition:(CGPoint)newDiscPosition {
    // If the disc is a 20 then it doesn't collide with other discs.
    if ([self valueForPoint:newDiscPosition] >= 20) {
        return nil;
    }

    // The given position needs to be (2 * DISC_RADIUS) + lineWidth away from all other disc positions.
    for (int playerIndex = 0; playerIndex < 2; playerIndex++) {
        NSMutableArray *playerDiscs = [[round discPositions] objectAtIndex:playerIndex];
        for (NSValue *discPositionValue in playerDiscs) {
            CGPoint discPosition = [discPositionValue CGPointValue];

            CGFloat dx = newDiscPosition.x - discPosition.x;
            CGFloat dy = newDiscPosition.y - discPosition.y;
            CGFloat distanceBetweenDiscs = sqrt(dx * dx + dy * dy);

            // To avoid imprecision when comparing doubles, we consider the difference.
            double diff = (2 * DISC_RADIUS + lineWidth) - distanceBetweenDiscs;
            if (diff > 0.1) {
                return [NSValue valueWithCGPoint:discPosition];
            }
        }
    }

    return nil;
}

- (CGPoint)adjustedPositionForNewDisc:(CGPoint)newDisc
                    collidingWithDisc:(CGPoint)existingDisc {
    // We move the new disc away from the existing disc so that they are (2 * DISC_RADIUS) + lineWidth apart.
    // To get the new disc's new center, we create a vector pointing from the existing to the new disc, normalize it, and then scale it by (2 * DISC_RADIUS) + lineWidth.
    double dx = newDisc.x - existingDisc.x;
    double dy = newDisc.y - existingDisc.y;
    double distanceBetweenDiscs = sqrt(dx * dx + dy * dy);

    // Check that the distance between discs is not zero. If it is, return newDisc without adjustment to avoid division by zero.
    if (distanceBetweenDiscs < DBL_EPSILON) {
        return newDisc;
    }

    double dxNormalized = dx / distanceBetweenDiscs;
    double dyNormalized = dy / distanceBetweenDiscs;

    CGPoint newPosition = CGPointZero;
    newPosition.x = existingDisc.x + (dxNormalized * ((2 * DISC_RADIUS) + lineWidth));
    newPosition.y = existingDisc.y + (dyNormalized * ((2 * DISC_RADIUS) + lineWidth));

    // If they seem suitable, return the new co-ordinates.
    if ([self shouldConsiderDrawingNewDiscAtPosition:newPosition]) {
        return newPosition;
    } else {
        return newDisc;
    }
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
    double radius = [self radiusOfPosition:point];

    if (radius < twentiesRadiusThreshold - DISC_RADIUS) {
        return 20;
    } else if (radius < fifteensRadiusThreshold - DISC_RADIUS) {
        return 15;
    } else if (radius < tensRadiusThreshold - DISC_RADIUS) {
        return 10;
    } else if (radius < fivesRadiusThreshold - DISC_RADIUS) {
        return 5;
    }

    return 0;
}

@end
