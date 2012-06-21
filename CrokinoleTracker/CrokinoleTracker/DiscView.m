//
//  DiscView.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-16.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "DiscView.h"

#import "CoreGraphicsUtilities.h"

@implementation DiscView

@synthesize value;
@synthesize fillColor;

- (id)initWithFrame:(CGRect)frame
              value:(int)aValue
          fillColor:(UIColor *)aFillColor {
    self = [super initWithFrame:frame];

    if (self) {
        [self setValue:aValue];
        [self setFillColor:aFillColor];
        [self setBackgroundColor:[UIColor clearColor]];
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);

    CGRect strokeRect = [CoreGraphicsUtilities rectForOnePixelStroke:[self bounds]];

    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeEllipseInRect(context, strokeRect);

    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextFillEllipseInRect(context, strokeRect);

    CGContextFillPath(context);
}

@end
