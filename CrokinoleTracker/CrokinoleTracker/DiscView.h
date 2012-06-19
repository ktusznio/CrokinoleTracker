//
//  DiscView.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-16.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscView : UIView

@property (nonatomic) int value;

- (id)initWithFrame:(CGRect)frame
              value:(int)aValue;

@end
