//
//  TwentiesView.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "TwentiesView.h"

@implementation TwentiesView

@synthesize value;
@synthesize subtractButton, addButton, valueLabel;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setValue:0];

        // Add the buttons.
        UIButton *aSubtractButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
        [aSubtractButton setBackgroundColor:[UIColor redColor]];
        [aSubtractButton setTitle:@"-" forState:UIControlStateNormal];
        [aSubtractButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[aSubtractButton titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [aSubtractButton addTarget:self
                            action:@selector(onSubtractButtonTap)
                  forControlEvents:UIControlEventTouchUpInside];
        [self setSubtractButton:aSubtractButton];
        [self addSubview:[self subtractButton]];

        UIButton *anAddButton = [[UIButton alloc] initWithFrame:CGRectMake(73, 0, 21, 21)];
        [anAddButton setBackgroundColor:[UIColor greenColor]];
        [anAddButton setTitle:@"+" forState:UIControlStateNormal];
        [anAddButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[anAddButton titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [anAddButton addTarget:self
                        action:@selector(onAddButtonTap)
              forControlEvents:UIControlEventTouchUpInside];
        [self setAddButton:anAddButton];
        [self addSubview:[self addButton]];

        // Add the label.
        UILabel *aValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 0, 52, 21)];
        [aValueLabel setBackgroundColor:[UIColor whiteColor]];
        [aValueLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [aValueLabel setTextAlignment:UITextAlignmentCenter];
        [self setValueLabel:aValueLabel];
        [self addSubview:[self valueLabel]];
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    [[self valueLabel] setText:[NSString stringWithFormat:@"%d", [self value]]];
}

- (void)updateValue:(double)aValue {
    [self setValue:aValue];
    [self setNeedsDisplay];
}

- (void)onSubtractButtonTap {
    if ([self value] > 0) {
        [self setValue:[self value] - 1];
        [self setNeedsDisplay];
    }
}

- (void)onAddButtonTap {
    if ([self value] < 12) {
        [self setValue:[self value] + 1];
        [self setNeedsDisplay];
    }
}

@end
