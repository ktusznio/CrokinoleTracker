//
//  GameStatisticsViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-25.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;

@interface GameStatisticsViewController : UIViewController <UIAlertViewDelegate> {
    Game *game;
}

- (id)initForGame:(Game *)aGame;
- (IBAction)onDeleteGameButtonTap:(id)sender;

@end
