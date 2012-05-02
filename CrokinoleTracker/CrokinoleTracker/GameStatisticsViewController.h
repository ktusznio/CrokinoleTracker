//
//  GameStatisticsViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-25.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;
@class GameSummaryView;

@interface GameStatisticsViewController : UIViewController <UIAlertViewDelegate> {
    Game *game;
}

@property (weak, nonatomic) IBOutlet GameSummaryView *gameSummaryView;

- (id)initForGame:(Game *)aGame;
- (IBAction)onDeleteGameButtonTap:(id)sender;

@end
