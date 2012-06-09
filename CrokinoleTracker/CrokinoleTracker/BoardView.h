//
//  BoardView.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardView : UIView

@property (strong, nonatomic) NSMutableArray *discPositions;
@property (nonatomic) int playerOne15s;
@property (nonatomic) int playerOne10s;
@property (nonatomic) int playerOne5s;
@property (nonatomic) int playerTwo15s;
@property (nonatomic) int playerTwo10s;
@property (nonatomic) int playerTwo5s;

- (void)recreateDiscPositions:(NSArray *)someDiscPositions;

@end
