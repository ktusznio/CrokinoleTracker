//
//  BoardView.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "BoardView.h"

@implementation BoardView

@synthesize delegate;
@synthesize discPositions;
@synthesize playerOne15s, playerOne10s, playerOne5s, playerTwo15s, playerTwo10s, playerTwo5s;

- (id)initWithFrame:(CGRect)frame
           delegate:(id<BoardViewDelegate>)aDelegate {
    self = [super initWithFrame:frame];

    if (self) {
        [self setDelegate:aDelegate];
        [self setDiscPositions:[NSMutableArray arrayWithObjects:[NSMutableSet set], [NSMutableSet set], nil]];
        [self setPlayerOne15s:0];
        [self setPlayerOne10s:0];
        [self setPlayerOne5s:0];
        [self setPlayerTwo15s:0];
        [self setPlayerTwo10s:0];
        [self setPlayerTwo5s:0];

        // Make the background transparent.
        [self setBackgroundColor:[UIColor clearColor]];

        // Prepare a tap gesture recognizer.
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(onBoardTap:)];
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
    CGRect outerRectangle = CGRectMake(5, 5, 240, 240);
    CGContextAddEllipseInRect(context, outerRectangle);

    CGRect middleRectangle = CGRectMake(45, 45, 160, 160);
    CGContextAddEllipseInRect(context, middleRectangle);

    CGRect innerRectangle = CGRectMake(85, 85, 80, 80);
    CGContextAddEllipseInRect(context, innerRectangle);

    CGRect twentyRectangle = CGRectMake(116.25, 116.25, 17.5, 17.5);
    CGContextAddEllipseInRect(context, twentyRectangle);

    // Next, the lines.
    // Did some sweet math to get these numbers.  God forbid they ever have to change.
    CGContextMoveToPoint(context, 40.15, 40.15);
    CGContextAddLineToPoint(context, 68.43, 68.43);

    CGContextMoveToPoint(context, 40.15, 209.85);
    CGContextAddLineToPoint(context, 68.43, 181.57);

    CGContextMoveToPoint(context, 209.85, 40.15);
    CGContextAddLineToPoint(context, 181.57, 68.43);

    CGContextMoveToPoint(context, 209.85, 209.85);
    CGContextAddLineToPoint(context, 181.57, 181.57);

    CGContextStrokePath(context);

    // Finally, draw the discs.
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    for (NSMutableSet *discPositionSet in [self discPositions]) {
        for (NSValue *discPositionValue in discPositionSet) {
            CGPoint discPosition = [discPositionValue CGPointValue];
            CGContextFillEllipseInRect(context, CGRectMake(discPosition.x - 7.5, discPosition.y - 7.5, 15, 15));
        }
    }
}

- (void)updateCountsForDiscAtPosition:(CGPoint)position {
    // Check the circles, starting from the inside.
    double xSquared = (position.x - 125) * (position.x - 125);
    double ySquared = (position.y - 125) * (position.y - 125);
    double r = sqrt(xSquared + ySquared);
    if (r < 40 - 7.5) {
        [self setPlayerOne15s:[self playerOne15s] + 1];
    } else if (r < 80 - 7.5) {
        [self setPlayerOne10s:[self playerOne10s] + 1];
    } else if (r < 120 - 7.5) {
        [self setPlayerOne5s:[self playerOne5s] + 1];
    }
}

- (void)recreateDiscPositions:(NSMutableArray *)someDiscPositions {
    [self setDiscPositions:someDiscPositions];
    [self setPlayerOne15s:0];
    [self setPlayerOne10s:0];
    [self setPlayerOne5s:0];
    [self setPlayerTwo15s:0];
    [self setPlayerTwo10s:0];
    [self setPlayerTwo5s:0];

    for (NSMutableSet *discPositionSet in [self discPositions]) {
        for (NSValue *discPositionValue in discPositionSet) {
            CGPoint discPosition = [discPositionValue CGPointValue];
            [self updateCountsForDiscAtPosition:discPosition];
        }
    }

    [delegate boardWasRecreated];
}

- (void)onBoardTap:(UITapGestureRecognizer *)sender {
    // Add a disc position.
    CGPoint tapPosition = [sender locationInView:self];
    [[[self discPositions] objectAtIndex:0] addObject:[NSValue valueWithCGPoint:tapPosition]];

    // Determine the value of the point and update the appropriate score.
    [self updateCountsForDiscAtPosition:tapPosition];

    // Call the delegate.
    [delegate boardWasTapped:tapPosition];

    // Update the view.
    [self setNeedsDisplay];
}

@end
