//
//  CoreGraphicsUtilities.m
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-19.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import "CoreGraphicsUtilities.h"

@implementation CoreGraphicsUtilities

+ (CGRect)rectForOnePixelStroke:(CGRect)rect {
    // When Core Graphics strokes a path, it draws the stroke down the middle of the exact edge of the path.
    // This results in 0.5 pixels being drawing inside the rectangle, and 0.5 being drawn outside.
    // Since half-pixels don't exist, Core Graphics uses anti-aliasing to draw both pixels, using a lighter shade on the outside pixel.
    // To avoid this behavior, we first inset the bounds rectangle by one pixel, and then adjust for the half-pixels.
    CGRect inset = CGRectInset(rect, 1, 1);
    return CGRectMake(inset.origin.x + 0.5,
                      inset.origin.y + 0.5,
                      inset.size.width - 1,
                      inset.size.height - 1);
}

@end
