//
//  VisualScorekeepingViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-06-08.
//  Copyright (c) 2012 Lost City Studios Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BoardView.h"
#import "TwentiesView.h"

@class Round;

@interface VisualScorekeepingViewController : UIViewController

@property (weak, nonatomic) Round *round;

@property (strong, nonatomic) BoardView *boardView;
@property (strong, nonatomic) UIButton *quitButton;
@property (strong, nonatomic) UIButton *undoButton;
@property (strong, nonatomic) UIButton *nextRoundButton;

- (id)initForRound:(Round *)aRound;

- (void)onQuitButtonTap:(id)sender;
- (void)onUndoButtonTap:(id)sender;
- (void)onNextRoundButtonTap:(id)sender;

@end
