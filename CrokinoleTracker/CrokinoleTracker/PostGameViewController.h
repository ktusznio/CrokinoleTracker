//
//  PostGameViewController.h
//  CrokinoleTracker
//
//  Created by Kamil Tusznio and Maxwell Woghiren on 12-04-23.
//  Copyright (c) 2012 KMSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;
@class GameSummaryView;

@interface PostGameViewController : UIViewController {
    Game *game;
}

@property (weak, nonatomic) IBOutlet GameSummaryView *gameSummaryView;

- (id)initForGame:(Game *)aGame;
- (IBAction)onMainMenuButtonTap:(id)sender;
- (IBAction)onRematchButtonTap:(id)sender;

@end
