//
//  DiscCoordinates.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Round;

@interface DiscCoordinates : NSManagedObject

@property (weak, nonatomic) Round *round;
@property (nonatomic) double x;
@property (nonatomic) double y;

@end
