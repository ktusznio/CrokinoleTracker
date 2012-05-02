//
//  GameSummaryView.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-05-01.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import "GameSummaryView.h"

@implementation GameSummaryView

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        [self loadViewFromBundle];
    }
    
    return self;
}

- (void)loadViewFromBundle {
    // Create the game summary view.
    UIView *gameSummaryView = [[[NSBundle mainBundle] loadNibNamed:@"GameSummaryView"
                                                             owner:self
                                                           options:nil] lastObject];

    CGRect outerFrame = [self frame];
    CGRect innerFrame = CGRectMake(0, 0, outerFrame.size.width, outerFrame.size.height);
    [gameSummaryView setFrame:innerFrame];
    
    [self addSubview:gameSummaryView];
}

@end
