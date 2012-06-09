//
//  TwentiesView.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwentiesView : UIView

@property (nonatomic) int value;

@property (strong, nonatomic) UIButton *subtractButton;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UILabel *valueLabel;

- (void)updateValue:(double)aValue;

@end
