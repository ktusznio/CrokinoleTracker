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

- (id)initWithFrame:(CGRect)frame
              value:(int)aValue {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setValue:aValue];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGRect strokeRect = [CoreGraphicsUtilities rectForOnePixelStroke:[self bounds]];
    CGContextStrokeEllipseInRect(context, strokeRect);
    CGContextFillPath(context);
}

@end
