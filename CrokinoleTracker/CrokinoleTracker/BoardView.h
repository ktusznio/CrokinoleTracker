//
//  BoardView.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DiscCoordinates;

@protocol BoardViewDelegate

- (void)boardWasRecreated;
- (void)boardWasTappedAtX:(CGFloat)x
                        y:(CGFloat)y;

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
- (void)recreateDiscPositions:(NSOrderedSet *)someDiscPositions;

@end
