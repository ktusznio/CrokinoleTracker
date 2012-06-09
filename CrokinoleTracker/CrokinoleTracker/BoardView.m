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
        [self setDiscPositions:[NSMutableArray array]];
        [self setPlayerOne15s:0];
        [self setPlayerOne10s:0];
        [self setPlayerOne5s:0];
        [self setPlayerTwo15s:0];
        [self setPlayerTwo10s:0];
        [self setPlayerTwo5s:0];

        // Make the background transparent.
        [self setBackgroundColor:[UIColor clearColor]];
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
    CGContextMoveToPoint(context, 40.15, 40.15);
    CGContextAddLineToPoint(context, 68.43, 68.43);

    CGContextMoveToPoint(context, 40.15, 209.85);
    CGContextAddLineToPoint(context, 68.43, 181.57);

    CGContextMoveToPoint(context, 209.85, 40.15);
    CGContextAddLineToPoint(context, 181.57, 68.43);

    CGContextMoveToPoint(context, 209.85, 209.85);
    CGContextAddLineToPoint(context, 181.57, 181.57);

    CGContextStrokePath(context);
}

- (void)recreateDiscPositions:(NSArray *)someDiscPositions {
    [self setDiscPositions:[NSMutableArray arrayWithArray:someDiscPositions]];
    [delegate boardWasTapped];
    [self setNeedsDisplay];
}

@end
