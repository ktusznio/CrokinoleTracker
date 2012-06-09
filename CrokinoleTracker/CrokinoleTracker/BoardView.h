//
//  BoardView.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BoardViewDelegate

- (void)boardWasRecreated;
- (void)boardWasTapped:(CGPoint)point;

@end

@interface BoardView : UIView

@property (weak, nonatomic) id<BoardViewDelegate> delegate;

@property (strong, nonatomic) NSMutableSet *discPositions;
@property (nonatomic) int playerOne15s;
@property (nonatomic) int playerOne10s;
@property (nonatomic) int playerOne5s;
@property (nonatomic) int playerTwo15s;
@property (nonatomic) int playerTwo10s;
@property (nonatomic) int playerTwo5s;

- (id)initWithFrame:(CGRect)frame
           delegate:(id<BoardViewDelegate>)aDelegate;
- (void)updateCountsForDiscAtPosition:(CGPoint)position;
- (void)recreateDiscPositions:(NSMutableSet *)someDiscPositions;

@end
