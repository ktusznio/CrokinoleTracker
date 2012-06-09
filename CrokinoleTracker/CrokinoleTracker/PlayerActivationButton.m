//
//  PlayerActivationButton.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-09.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "PlayerActivationButton.h"

@implementation PlayerActivationButton

@synthesize delegate;
@synthesize isActivated, color;

- (id)initWithFrame:(CGRect)frame
           delegate:(id<PlayerActivationButtonDelegate>)aDelegate
 initiallyActivated:(BOOL)anIsActivated
              color:(UIColor *)aColor {
    self = [super initWithFrame:frame];

    if (self) {
        [self setDelegate:aDelegate];
        [self setIsActivated:anIsActivated];
        [self setColor:aColor];

        // Style the button.
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[self titleLabel] setTextAlignment:UITextAlignmentCenter];
        [[self titleLabel] setFont:[UIFont fontWithName:@"Helvetica"
                                                   size:8]];
        
        // Set up the handler.
        [self addTarget:self
                 action:@selector(onButtonTap)
       forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    
    // Draw the selection disc.
    CGContextSetFillColorWithColor(context, [self color].CGColor);
    CGContextFillEllipseInRect(context, rect);
    
    // If this button is activated, make that clear.
    if ([self isActivated]) {
        [self setTitle:@"O" forState:UIControlStateNormal];
    } else {
        [self setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)onButtonTap {
    [delegate buttonWasPressed:self];
}

@end
