//
//  BoardView.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "BoardView.h"

#import "PlayerActivationButton.h"

const double DISC_RADIUS = 7.5;

@implementation BoardView

@synthesize delegate;
@synthesize discPositions;
@synthesize playerOne15s, playerOne10s, playerOne5s, playerTwo15s, playerTwo10s, playerTwo5s;
@synthesize playerColors;
@synthesize playerOneActivationButton, playerTwoActivationButton;

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
        [self setPlayerColors:[NSArray arrayWithObjects:[UIColor blackColor], [UIColor orangeColor], nil]];

        // Make the background transparent.
        [self setBackgroundColor:[UIColor clearColor]];

        // Create the player activation buttons.
        [self setPlayerOneActivationButton:[[PlayerActivationButton alloc] initWithFrame:CGRectMake(10, 10, 20, 20)
                                                                                delegate:self
                                                                      initiallyActivated:YES
                                                                                   color:[[self playerColors] objectAtIndex:0]]];
        [self addSubview:[self playerOneActivationButton]];

        [self setPlayerTwoActivationButton:[[PlayerActivationButton alloc] initWithFrame:CGRectMake(220, 10, 20, 20)
                                                                                delegate:self
                                                                      initiallyActivated:NO
                                                                                   color:[[self playerColors] objectAtIndex:1]]];
        [self addSubview:[self playerTwoActivationButton]];

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
    for (int i = 0; i < 2; i++) {
        NSMutableSet *discPositionSet = [[self discPositions] objectAtIndex:i];
        CGContextSetFillColorWithColor(context, ((UIColor *)[[self playerColors] objectAtIndex:i]).CGColor);
        for (NSValue *discPositionValue in discPositionSet) {
            CGPoint discPosition = [discPositionValue CGPointValue];
            CGContextFillEllipseInRect(context, CGRectMake(discPosition.x - DISC_RADIUS, discPosition.y - DISC_RADIUS, DISC_RADIUS * 2, DISC_RADIUS * 2));
        }
    }
}

+ (double)calculateRadiusOfPosition:(CGPoint)position {
    double xSquared = (position.x - 125) * (position.x - 125);
    double ySquared = (position.y - 125) * (position.y - 125);
    return sqrt(xSquared + ySquared);
}

- (void)updateCountsForDiscWithCenterAtRadius:(double)radius
                                  playerIndex:(int)playerIndex {
    // Check the circles, starting from the inside.
    if (radius < 40 - DISC_RADIUS) {
        if (playerIndex == 0) {
            [self setPlayerOne15s:[self playerOne15s] + 1];
        } else {
            [self setPlayerTwo15s:[self playerTwo15s] + 1];
        }
    } else if (radius < 80 - DISC_RADIUS) {
        if (playerIndex == 0) {
            [self setPlayerOne10s:[self playerOne10s] + 1];
        } else {
            [self setPlayerTwo10s:[self playerTwo10s] + 1];
        }
    } else if (radius < 120 - DISC_RADIUS) {
        if (playerIndex == 0) {
            [self setPlayerOne5s:[self playerOne5s] + 1];
        } else {
            [self setPlayerTwo5s:[self playerTwo5s] + 1];
        }
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

    for (int i = 0; i < 2; i++) {
        NSMutableSet *discPositionSet = [[self discPositions] objectAtIndex:i];
        for (NSValue *discPositionValue in discPositionSet) {
            CGPoint discPosition = [discPositionValue CGPointValue];
            [self updateCountsForDiscWithCenterAtRadius:[BoardView calculateRadiusOfPosition:discPosition]
                                            playerIndex:i];
        }
    }

    [delegate boardWasRecreated];
}

- (void)onBoardTap:(UITapGestureRecognizer *)sender {
    // If the tap is in bounds, add a disc position.
    CGPoint tapPosition = [sender locationInView:self];
    double radius = [BoardView calculateRadiusOfPosition:tapPosition];
    if (radius < 120 - DISC_RADIUS) {
        int playerIndex = ([playerOneActivationButton isActivated]) ? 0 : 1;
        [[[self discPositions] objectAtIndex:playerIndex] addObject:[NSValue valueWithCGPoint:tapPosition]];

        // Determine the value of the point and update the appropriate score.
        [self updateCountsForDiscWithCenterAtRadius:radius
                                        playerIndex:playerIndex];

        // Call the delegate.
        [delegate boardWasTapped:tapPosition
                     playerIndex:playerIndex];

        // Update the view.
        [self setNeedsDisplay];
    }
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    // Ignore the tap if it's in one of the activation buttons.
    return ![[touch view] isKindOfClass:[PlayerActivationButton class]];
}

#pragma mark PlayerActivationButtonDelegate

- (void)buttonWasPressed:(id)sender {
    // When a button is pressed, we need to update both buttons, since only one can be selected.
    if (sender == [self playerOneActivationButton]) {
        [playerOneActivationButton setIsActivated:YES];
        [playerTwoActivationButton setIsActivated:NO];
    } else if (sender == [self playerTwoActivationButton]) {
        [playerOneActivationButton setIsActivated:NO];
        [playerTwoActivationButton setIsActivated:YES];
    }

    [playerOneActivationButton setNeedsDisplay];
    [playerTwoActivationButton setNeedsDisplay];
}

@end
